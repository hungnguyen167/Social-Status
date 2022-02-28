use "DATASETS/ISSP 1992/ZA2310.dta", clear
	gen wave = 1992
		gen survey = "ISSP"
		gen year = wave
		gen weight = v176
	recode v3 (1=1 "Australia") (2 3=2 "Germany") (4=4 "United Kingdom") (5=5 "USA") ///
		(6=6 "Austria") (7=7 "Hungary") (8=8 "Italy") (9=9 "Norway") (10=10 "Sweden") ///
		(11=11 "Czech Republic") (12=12 "Slovenia") (13=13 "Poland") (14=14 "Bulgaria") (16=16 "New Zealand") ///
		(17=17 "Canada"), gen(cn_issp)
	    recode v3 (2 = 1 "West Germany") (3 = 2 "East Germany") (1 4/18=.), gen(germanyWE)
		decode cn_issp, gen(country)
	*Czechoslovakia: separate CZE and SVK
		replace country = "Slovakia" if country == "Czech Republic" & inrange(cz126, 9, 12)
	merge m:m country using Countrynames.dta, nogen keep(match)
		keep if inlist(iso, "AUS","AUT","BEL","CAN","CHE","CZE","DEU","DNK","ESP") | ///
				inlist(iso, "EST","FIN","FRA","GBR","GRC","HUN","IRL","ISL","ITA") | ///
				inlist(iso, "JPN","LTU","LUX","LVA","NLD","NOR","NZL","POL","PRT") | ///
				inlist(iso, "SVK","SVN","SWE","USA")
	replace year = 1991 if inlist(country, "Sweden")
	replace year = 1993 if inlist(country, "Australia", "Austria", "Bulgaria")

	merge m:m country year using "Data Reference materials/CPI_PPPEuroconversion_January.dta", nogen keep(match)
	

********************************************************************************
*** REDISTRIBUTION
********************************************************************************

	recode v57 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9=.), gen(redist3)
    recode v56 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9=.), gen(incdiff)
	
	gen resp_unemp_4pt = .
	recode v61 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (0 8 9=.), gen(resp_unemp_5pt)

	gen cut_spending = .
	
	gen stfeco = .
	gen hincfel = .
	gen tax_mid_toohigh = .
	
********************************************************************************
*** HIGH-PRIORITY CONTROL VARIABLES
********************************************************************************

*** Interview year/month

	*replace year = ...
	gen month = .
		replace month = 5  if iso == "AUS" //Mar - Jul
		replace month = 3  if iso == "AUT" //Feb - Mar
		replace month = 3  if iso == "BGR" //March 
		replace month = .  if iso == "CAN" //no information
		replace month = 11 if iso == "CZE" //Oct - Nov
		replace month = 11 if iso == "SVK" //Oct - Nov
		replace month = 6  if iso == "DEU" //May - Jun
		replace month = 8  if iso == "GBR" //Jun - Sep
		replace month = 10 if iso == "HUN" //Oct
		replace month = 7  if iso == "ITA" //info taken from ref do file not from codebook - I could not find in the codebook
		replace month = 9  if iso == "NZL" //Aug-Sep
		replace month = 4  if iso == "NOR" //Feb-Jun
		replace month = .  if iso == "POL" //no information
		replace month = 2  if iso == "SVN" //Feb
		replace month = 3  if iso == "SWE" //Feb- Apr
		replace month = 3  if iso == "USA" //Feb Apr


*** AGE (IN YEARS)

	gen age = v100 
		recode age (99 0 = .)
		replace age = i100 if iso == "ITA"
		recode age (1=21) (2=30) (3=40) (4=50) (5=60) (6=70) if iso == "ITA"

***	GENDER (1=FEMALE, 0=MALE)

	gen female = v99
		recode female (2=1) (1=0) (9 =.)

***	HOUSEHOLD COMPOSITION (NUMBER OF HOUSEHOLD MEMBERS)

	gen nhhmem = v119 
		recode nhhmem (0 97/99 .d =.) (13/25=12)
		recode v120 (1=1) (2 5=2) (3 6 9=3) (4 7 10 11 = 4) (8 12 13 = 5) (99 0 =.)
		replace nhhmem = v120 if missing(nhhmem)	
	gen nhhmem_alt2 = .
			qui foreach num of numlist 2/11 { 
					local num2 = `num'-1
					local x : word `num2' of v151 v153 v155 v157 v159 v161 v163 v165 v167 v169
					local y : word `num2' of v152 v154 v156 v158 v160 v162 v164 v166 v168 v170
					
					replace nhhmem_alt2 = `num' if (!inlist(`x',0,9)|!inlist(`y',0,99)) & missing(nhhmem)
			}
	gen nhhmem_alt = 2 if (v129 == 1 | v101 == 1) & missing(nhhmem)
		replace nhhmem_alt = 1 if (v129 == 2 | inrange(v101,2,5)|(v113==0&!inlist(iso,"SWE","HUN"))) & missing(nhhmem)
		replace nhhmem_alt = nhhmem_alt2 if (nhhmem_alt<nhhmem_alt2|missing(nhhmem_alt)) & !missing(nhhmem_alt2)
	replace nhhmem = nhhmem_alt if missing(nhhmem)

*** HOUSEHOLD INCOME MIDPOINTS / INCOME QUINTILES

	qui foreach var of varlist aus115-pl115 {
	recode `var' (999997/999999 =.)
	}
	qui foreach var of varlist aus116-cdn116 {
	recode `var' (97/99 =.)
	}
	qui foreach var of varlist aus117-pl117 {
	recode `var' (999997/999999 =.)
	}
	qui foreach var of varlist aus118-cdn118 {
	recode `var' (97/99 =.)
	}
	gen hinc = .
		replace hinc = aus115 		if iso == "AUS" // Gross annual household income (AUS$)   
		replace hinc = a116 		if iso == "AUT" // Net monthly household income (ATS)
		replace hinc = cdn116 		if iso == "CAN" // Gross annual household income (CAN$)
		replace hinc = cz115 		if iso == "CZE" // Net monthly household income (CZK)
		replace hinc = d115 		if iso == "DEU" // Net monthly household income (DM)
		replace hinc = d116 		if iso == "DEU" & missing(hinc)
		replace hinc = gb116 		if iso == "GBR" // Gross annual household income (GBP)
		replace hinc = h115*1000 	if iso == "HUN" // Net(?) monthly household income (HUF) [Gross household income from all sources [...] - net income monthly average] -- variable is in thousands - this is changed here
		replace hinc = i116 		if iso == "ITA" // Net monthly household income (Lira)
		replace hinc = n116 		if iso == "NOR" // Gross annual household income (NKR)
		replace hinc = nz116 		if iso == "NZL" // Gross annual household income (NZ$)
		replace hinc = pl115*1000 	if iso == "POL" // Net monthly income all members (in thds of (old) Zlotys)
		replace hinc = hinc/10000	if iso == "POL" // into new zlotys PLZ -> PLN
		replace hinc = slo115 		if iso == "SVN" // Net monthly household income (Tolar)
		replace hinc = cz115 		if iso == "SVK" // Net monthly household income (CZK)
		replace hinc = s117 		if iso == "SWE" // Gross monthly personal income (Skr)
		replace hinc = usa116 		if iso == "USA" // Gross annual household income (US$)
			recode hinc (0 1=2000) (2=5000) (3=7000) (4=9000) (5=11000) (6=13000) (7=15000) ///
						(8=17000) (9=19000) (10=21000) (11=23000) (12=25000) (13=27000) (14=29000) ///
						(15=31000) (16=33000) (17=35000) (18=37000) (19=39000) (20=42000) if iso == "AUT"
			recode hinc (1=7500) (2=20000) (3=30000) (4=40000) (5=50000) ///
						(6=60000) (7=70000) (8=85000)  if iso == "CAN"
			recode hinc (1=  200) (2=  500) (3=  700) (4=  900) (5= 1125) (6= 1375) (7= 1625) (8= 1875) ///
						(9= 2125) (10= 2375) (11= 2625) (12= 2875) (13= 3250) (14= 3750) (15= 4250) ///
						(16= 4750) (17= 5250) (18= 5750) (19= 7000) (20= 9000) (21=12500) (22=20000) if iso== "DEU"
			recode hinc (3=1500) (5=5000) (7=7000) (8=9000) (9=11000) (10=13500) (11=16500) (12=19000) ///
						(13=21500) (14=24500) (15=27500) (16=30500) (17=33500) (18=38000) if iso == "GBR"
			recode hinc (1=150000) (2=450000) (3=750000) (4=1050000) (5=1350000) (6=1650000) ///
						(7=1950000) (8=2250000) (9=2550000) (10=2850000) (11=3150000) (12=3450000) ///
						(13=3750000) (14=4050000) (15=4350000) (16=4650000) (17=4950000) (18=5400000) ///
						(99=.) if iso == "ITA"
			recode hinc (1=25000) (2=75000) (3=125000) (4=175000) (5=225000) ///
						(6=275000) (7=350000) (8=450000) (9=600000) (99=.) if iso == "NOR"
			recode hinc (1=5000) (2=12500) (3=17500) (4=22500) (5=27500) (6=35000) (7=45000) ///
						(8=60000) (9=90000) (99=.) if iso == "NZL"
			recode hinc (1=500) (2=2000) (3=3500) (4=4500) (5=5500) (6=6500) (7=7500) (8=9000) ///
						(9=11250) (10=13750) (11=16250) (12=18750) (13=21250) (14=23750) (15=27500) ///
						(16=32500) (17=37500) (18=45000) (19=55000) (20=67500) (21=90000) ///
						(97/99=.) if iso == "USA" 			
		replace hinc = hinc*12 if inlist(iso,"AUT","CZE","DEU","HUN","ITA","POL","SVN","SVK")
		replace hinc = hinc / euro_conversion if inlist(iso,"AUT","DEU","ITA","SVN","SVK")
	
	gen rinc = . 
		replace rinc = aus117 		if iso == "AUS" // gross, yearly
		replace rinc = a118 		if iso == "AUT" // net, monthly
		replace rinc = cdn118 		if iso == "CDN" // gross, yearly
		replace rinc = cz117 		if iso == "CZE" // net, monthly
		replace rinc = d117			if iso == "DEU" // net, monthly
		replace rinc = d118 		if iso == "DEU" & missing(rinc)
		replace rinc = gb118 		if iso == "GBR" // gross, yearly
		replace rinc = h117*1000 	if iso == "HUN" // net, monthly
		replace rinc = i118 		if iso == "ITA" // net, monthly
		replace rinc = n118 		if iso == "NOR" // gross, yearly
		replace rinc = nz118 		if iso == "NZL" // gross, yearly
		replace rinc = pl117*1000	if iso == "POL" // net, monthly
		replace rinc = rinc/10000	if iso == "POL" // into new zlotys PLZ -> PLN
		replace rinc = cz117 		if iso == "SVK" // net, monthly
		replace rinc = slo117		if iso == "SVN" // - , monthly
		replace rinc = s117 		if iso == "SWE" // gross, yearly
		replace rinc = usa118		if iso == "USA" // gross, yearly
			recode rinc (1=2000) (2=5000) (3=7000) (4=9000) (5=11000) (6=13000) (7=15000) ///
						(8=17000) (9=19000) (10=21000) (11=23000) (12=25000) (13=27000) (14=29000) ///
						(15=31000) (16=33000) (17=35000) (18=37000) (19=39000) (20=42000)  if iso == "AUT"
			recode rinc (1=7500) (2=20000) (3=30000) (4=40000) (5=50000) (6=60000) (7=70000) (8=85000) if iso == "CAN"
			recode rinc (1=  200) (2=  500) (3=  700) (4=  900) (5= 1125) (6= 1375) (7= 1625) (8= 1875) ///
						(9= 2125) (10= 2375) (11= 2625) (12= 2875) (13= 3250) (14= 3750) (15= 4250) ///
						(16= 4750) (17= 5250) (18= 5750) (19= 7000) (20= 9000) (21=12500) (22=20000) if iso== "DEU"
			recode rinc (3=1500) (5=5000) (7=7000) (8=9000) (9=11000) (10=13500) (11=16500) (12=19000) ///
						(13=21500) (14=24500) (15=27500) (16=30500) (17=33500) (18=38000) if iso == "GBR"
			recode rinc (1=150000) (2=450000) (3=750000) (4=1050000) (5=1350000) (6=1650000) ///
						(7=1950000) (8=2250000) (9=2550000) (10=2850000) (11=3150000) (12=3450000) ///
						(13=3750000) (14=4050000) (15=4350000) (16=4650000) (17=4950000) (18=5400000) if iso == "ITA"
			recode rinc (1=25000) (2=75000) (3=125000) (4=175000) (5=225000)(6=275000) (7=350000) (8=450000) (9=600000) if iso == "NOR"
			recode rinc (1=5000) (2=12500) (3=17500) (4=22500) (5=27500) (6=35000) (7=45000) (8=60000) (9=90000)  if iso == "NZL"
			recode rinc (1=500) (2=2000) (3=3500) (4=4500) (5=5500) (6=6500) (7=7500) (8=9000) ///
						(9=11250) (10=13750) (11=16250) (12=18750) (13=21250) (14=23750) (15=27500) ///
						(16=32500) (17=37500) (18=45000) (19=55000) (20=67500) (21=90000) if iso == "USA" 					
		replace rinc = rinc*12 if inlist(iso,"AUT","CZE","DEU","HUN","ITA","POL","SVN","SVK")
		replace rinc = rinc / euro_conversion if inlist(iso,"AUT","DEU","ITA","SVN","SVK")
		
	****** Top coding of income
	qui levelsof iso, local(cn)
	qui foreach c in `cn' {
		sum hinc [weight=weight] if iso == "`c'", d
		replace hinc =  10*r(p50) if hinc >  10*r(p50)  & !missing(hinc) & iso == "`c'"
		sum rinc [weight=weight] if iso == "`c'" & rinc >0 ,d
		replace rinc =  10*r(p50) if rinc >  10*r(p50)  & !missing(rinc) & iso == "`c'"
	}

	gen hinc_raw = hinc
	replace hinc_raw = rinc if (missing(hinc_raw) & !missing(rinc) & rinc!=0) | (hinc_raw==0 & rinc !=0 & !missing(rinc))	
	replace hinc_raw = hinc / (cpi / 100)
	gen rinc2 = rinc / (cpi / 100)
	replace hinc = hinc / sqrt(nhhmem) if iso != "SWE"
	replace hinc = rinc if (missing(hinc) & !missing(rinc) & rinc!=0) | (hinc==0 & rinc !=0 & !missing(rinc))	
	replace hinc = hinc / (cpi / 100)

	gen hinc_ppp = hinc / ppp15
	gen rinc2_ppp = rinc2 / ppp15
	gen hinc_raw_ppp = hinc_raw / ppp15

	****** Quintiles
	qui levelsof iso, local(cn)
	qui foreach country in `cn' {
		fastxtile q5_`country' = hinc if iso == "`country'" [aw=weight], nq(5)		
	}
	egen hinc_quint = rowtotal(q5_*), miss
	gen gross_inc  	= (inlist(iso,"AUS","CDN","GBR","NOR","NZL","SWE","HUN","USA")) 
	gen net_inc		= (inlist(iso,"AUT","CZE","DEU","ITA","POL","SVN")) 
	
***	EMPLOYMENT STATUS (DUMMIES FOR UNEMPLOYED, RETIRED, FULL-TIME EMPLOYED, PART-TIME EMPLOYED, NON-EMPLOYED)
	gen unemployed = (v104 == 5)
	gen retired    = (v104 == 7)
		replace retired = 1 if iso == "SWE" & inrange(age, 66, 99)
	gen fulltime   = (v104 == 1)
	gen parttime   = (v104 == 2) | (v104 == 3)
	gen nonemp 	   = (inlist(v104, 4, 6, 7, 8, 9, 10) | (v109==0 & iso =="SWE"))

***	EDUCATION (TERTIARY EDUCATION=1, ISCED CATEGORIES, EDUCATION YEARS)
	qui foreach var of varlist v103-cdn103 {
	recode `var' (99 = .)
	}
	
	rename v103 educ
		recode d103 (7=.)
		replace educ = d103   if iso == "DEU"
			recode gb103 (7=.)
		replace educ = gb103  if iso == "GBR"
		replace educ = usa103 if iso == "USA"
		replace educ = a103   if iso == "AUT"
		replace educ = i103   if iso == "ITA"
		replace educ = n103   if iso == "NOR"
		replace educ = nz103  if iso == "NZL"
		replace educ = s103   if iso == "SWE"
		replace educ = cdn103 if iso == "CAN"
		replace educ = h103   if iso == "HUN"
		replace educ = slo103 if iso == "SVN"
		replace educ = h103   if iso == "HUN"
		replace educ = rus103 if iso == "RUS"


	gen educ_tert = 1 if iso == "AUS" & inrange(educ, 9, 9)
			replace educ_tert = 0 if iso == "AUS" & inrange(educ, 1, 5)
		replace educ_tert = 1 if iso == "AUT" & inrange(a103, 8, 8)
			replace educ_tert = 0 if iso == "AUT" & inrange(a103, 3, 7)
		replace educ_tert = 1 if iso == "CAN" & inrange(cdn103, 7, 8)
			replace educ_tert = 0 if iso == "CAN" & inrange(cdn103, 1, 6)
		replace educ_tert = 1 if iso == "DEU" & inrange(d103, 6, 6)
			replace educ_tert = 0 if iso == "DEU" & inrange(d103, 1, 5)
		replace educ_tert = 1 if iso == "GBR" & inrange(gb103, 6, 6)
			replace educ_tert = 0 if iso == "GBR" & inrange(gb103, 1, 5)
		replace educ_tert = 1 if iso == "ITA" & inrange(i103, 9, 9)
			replace educ_tert = 0 if iso == "ITA" & inrange(i103, 1, 8)
		replace educ_tert = 1 if iso == "NOR" & inrange(n103, 9, 9)
			replace educ_tert = 0 if iso == "NOR" & inrange(n103, 1, 8)
		replace educ_tert = 1 if iso == "NZL" & inrange(nz103, 7, 7)
			replace educ_tert = 0 if iso == "NZL" & inrange(nz103, 1, 6)
		replace educ_tert = 1 if iso == "SWE" & inrange(s103, 4, 4)
			replace educ_tert = 0 if iso == "SWE" & inrange(s103, 1, 3)
		replace educ_tert = 1 if iso == "USA" & inrange(usa103, 6, 7)
			replace educ_tert = 0 if iso == "USA" & inrange(usa103, 1, 5)
		*Added
		replace educ_tert = 1 if iso == "HUN" & inrange(h103, 8, 8)
			replace educ_tert = 0 if iso == "HUN" & inrange(h103, 1, 7)
		replace educ_tert = 1 if iso == "SVN" & inrange(slo103, 9, 9)
			replace educ_tert = 0 if iso == "SVN" & inrange(slo103, 1, 8)
		replace educ_tert = 1 if iso == "RUS" & inrange(rus103, 9, 9)
			replace educ_tert = 0 if iso == "RUS" & inrange(rus103, 1, 8)
		replace educ_tert = 1 if iso == "POL" & inrange(educ, 9, 9)
			replace educ_tert = 0 if iso == "POL" & inrange(educ, 1, 8)
		*Bulgaria and Czechia no observations
		
		
	gen educ_isced = .
	recode v102 (26/89=25) (90/9999=.), gen(educ_years)
		replace educ_years = i102 if iso=="ITA"
		recode educ_years (1=5) (2=7) (3=8) (4=11) (5=13) (6=16) (7=18) (8=20) (99=.) if iso == "ITA" //chose the higher year - then 20 for above 18

********************************************************************************
*** PARTY SUPPORT & VOTING
********************************************************************************

*** RETROSPECTIVE VOTING

gen vote_re = "NA_________; NA; .c; Not asked" if inlist(iso, "AUT", "GBR", "HUN", "NOR", "SWE") // not asked in: AUT, GBR, HUN, NOR, SWE

replace vote_re = "majorright__; LPA; 1411; Liberal Party of Australia" 								if aus134 == 1 & iso == "AUS" 
replace vote_re = "majorleft___; ALP; 1253; Australian Labor Party" 									if aus134 == 2 & iso == "AUS" 
replace vote_re = "other_______; NCP|NPA; 184; National (Country) Party | National Party of Australia" 	if aus134 == 3 & iso == "AUS" 
replace vote_re = "other_______; AD; 120; Australian Democrats"											if aus134 == 4 & iso == "AUS" 
replace vote_re = "other_______; AG; 751; Australian Greens"											if aus134 == 5 & iso == "AUS" 
replace vote_re = "other_______; others; -90; Other parties, independents"								if inlist(aus134, 6, 95) & iso == "AUS" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(aus134, 0) & iso == "AUS" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(aus134, ., 97, 98, 99) & iso == "AUS" 

replace vote_re = "majorright__; PCP; 794; Progressive Conservative Party of Canada" 	if cdn134 == 1 & iso == "CAN" 
replace vote_re = "majorleft___; LP; 368; Liberal Party of Canada" 						if cdn134 == 2 & iso == "CAN"
replace vote_re = "other_______; NDP; 296; New Democratic Party" 						if cdn134 == 3 & iso == "CAN"
replace vote_re = "other_______; BQ; 448; Quebec Bloc" 									if cdn134 == 4 & iso == "CAN"
replace vote_re = "radright____; RPC; 897; Reform Party of Canada"				 		if cdn134 == 5 & iso == "CAN" 
replace vote_re = "radleft_____; CP; 556; Communist Party"								if cdn134 == 8 & iso == "CAN"
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(cdn134, 6, 7, 11, 95) & iso == "CAN" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(cdn134, 0) & iso == "CAN" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(cdn134, ., 97, 98, 99) & iso == "CAN" 

replace vote_re = "other_______; ODA; 1123; Civic Democratic Alliance" 					if cz134 == 1 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "majorleft___; CSSD; 789; Czech Social Democratic Party" 				if cz134 == 3 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; HSD-SMS; 19; Movement for Self-Governing Democracy -- Society for Moravia and Silesia" 	if cz134 == 4 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "majorright__; HZDS; 1142; Movement for a Democratic Slovakia"		if cz134 == 7 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "majorleft___; SDL; 1415; Party of the Democratic Left"				if cz134 == 8 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; CNSP; 29; Czech National Social(ist) Party"			if cz134 == 10 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; SSL; 2232; Freedom Party"								if cz134 == 12 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; MK; 559; Hungarian Coalition"							if cz134 == 15 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; KSU; 936; Christian Social Union"						if cz134 == 16 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; KDU-CSL; 1245; Christian Democratic Union -- People's Party"	if cz134 == 17 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; LSU; 1218; Liberal Social Union"						if cz134 == 22 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; SZ; 196; Green Party"									if cz134 == 23 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; OH|SD; 574; Civic Movement | Free Democrats"			if cz134 == 24 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; KDH; 1432; Christian Democratic Movement"				if cz134 == 25 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; ODU; 1061; Civic Democratic Union"						if cz134 == 26 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "radright____; SPR-RSC; 872; Rally for the Republic -- Republican Party of Czechoslovakia"  if cz134 == 28 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; SZ; 196; Green Party"									if cz134 == 30 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; KAN; 2220; Club of committed Non-Party Members"		if cz134 == 31 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "radleft_____; KSCM; 1173; Communist Party of Bohemia and Moravia (with Left Bloc)"	if cz134 == 33 & inlist(iso, "CZE", "SVK")	
replace vote_re = "other_______; SDSS; 1651; Social Democratic Party of Slovakia"		if cz134 == 34 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "radleft_____; KSS; 44; Communist Party of Slovakia"					if cz134 == 35 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "majorright__; ODS; 829; Civic Democratic Party"						if cz134 == 36 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "radright____; SNS; 1072; Slovak National Party"  					if cz134 == 37 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; MOS; 2246; Hungarian Civic Party"						if cz134 == 40 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "majorright__; ODS; 829; Civic Democratic Party (with KDS)"			if cz134 == 42 & (inlist(iso, "CZE", "SVK"))
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(cz134, 5, 6, 9, 11, 13, 14, 19, 21, 29, 32, 38, 39, 41, 95) & (inlist(iso, "CZE", "SVK")) 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(cz134, 0) & (inlist(iso, "CZE", "SVK")) 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(cz134, ., 97, 98, 99) & (inlist(iso, "CZE", "SVK")) 

replace vote_re = "majorright__; CDU+CSU; 1727; Christian Democratic Union / Christian Social Union" 	if d134 == 1 & iso == "DEU" 
replace vote_re = "majorleft___; SPD; 558; Social Democratic Party of Germany" 							if d134 == 2 & iso == "DEU" 
replace vote_re = "other_______; FDP; 543; Free Democratic Party" 										if d134 == 3 & iso == "DEU" 
replace vote_re = "other_______; B90/Gru; 772; Alliance 90 / Greens"									if d134 == 4 & iso == "DEU" 
replace vote_re = "radright____; NPD; 1537; National Democratic Party"									if d134 == 5 & iso == "DEU" 
replace vote_re = "radleft_____; KPD; 649; Communist Party of Germany"									if d134 == 6 & iso == "DEU" 
replace vote_re = "radright____; Rep; 524; The Republicans"												if d134 == 7 & iso == "DEU" 
replace vote_re = "radleft_____; PDS|Li; 791; PDS | The Left"											if d134 == 8 & iso == "DEU" 
replace vote_re = "other_______; others; -90; Other parties, independents"								if inlist(d134, 95) & iso == "DEU" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(d134, 0) & iso == "DEU" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(d134, 96, 97, 98, 99, .) & iso == "DEU" 

replace vote_re = "radright____; MSI; 831; Italian Social Movement" 					if i134 == 1 & iso == "ITA" 
replace vote_re = "other_______; PLI; 487; Italian Liberal Party"	 					if i134 == 2 & iso == "ITA" 
replace vote_re = "majorright__; DC; 1633; Christian Democrats"	 						if i134 == 3 & iso == "ITA" 
replace vote_re = "other_______; PRI; 93; Republican Party"	 							if i134 == 4 & iso == "ITA" 
replace vote_re = "other_______; PSDI; 242; Italian Democratic Socialist Party"			if i134 == 5 & iso == "ITA" 
replace vote_re = "majorleft___; PSI; 1475; Italian Socialist Party"					if i134 == 6 & iso == "ITA" 
replace vote_re = "other_______; R; 1296; Radicals"										if i134 == 7 & iso == "ITA" 
replace vote_re = "other_______; FdLV; 1304; Green Lists"								if i134 == 8 & iso == "ITA" 
replace vote_re = "majorleft___; DS; 809; Democrats of the Left"						if i134 == 9 & iso == "ITA" 
replace vote_re = "radleft_____; PRC; 1321; Communist Refoundation Party"				if i134 == 10 & iso == "ITA" 
replace vote_re = "radright____; LN; 1436; North League" 								if i134 == 11 & iso == "ITA" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(i134, 95) & iso == "ITA" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(i134, 0) & iso == "ITA" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(i134, ., 97, 98, 99) & iso == "ITA" 

replace vote_re = "other_______; Greens; 1171; Green Party"		 						if nz134 == 1 & iso == "NZL" 
replace vote_re = "majorleft___; LP; 878; Labour Party"		 							if nz134 == 2 & iso == "NZL" 
replace vote_re = "majorright__; NP; 997; National Party"		 						if nz134 == 3 & iso == "NZL" 
replace vote_re = "other_______; NLP; 930; New Labour Party"		 					if nz134 == 4 & iso == "NZL" 
replace vote_re = "other_______; SC|DP; 1636; Social Credit | Democratic Party"			if nz134 == 5 & iso == "NZL" 
replace vote_re = "other_______; SDP; 2549; Social Democratic Party" 					if nz134 == 6 & iso == "NZL" 
replace vote_re = "other_______; NZP; 2075; New Zealand Party"		 					if nz134 == 8 & iso == "NZL" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(nz134, 7, 95) & iso == "NZL" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(nz134, 0) & iso == "NZL" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(nz134, ., 97, 98, 99) & iso == "NZL" 

replace vote_re = "majorright__; UD; 1104; Democratic Union"		 					if pl134 == 1 & iso == "POL"
replace vote_re = "majorleft___; SLD; 629; Democratic Left Alliance"		 			if pl134 == 2 & iso == "POL"
replace vote_re = "other_______; ZChN; 1758; Christian National Union"			 		if pl134 == 3 & iso == "POL"
replace vote_re = "other_______; PSL; 664; Polish People's Party"			 			if pl134 == 4 & iso == "POL"
replace vote_re = "other_______; KPN; 548; Confederation for Independent Poland"		if pl134 == 5 & iso == "POL"
replace vote_re = "other_______; PC; 369; Centre Agreement"								if pl134 == 6 & iso == "POL"
replace vote_re = "other_______; KLD; 1544; Liberal Democratic Congress"				if pl134 == 7 & iso == "POL"
replace vote_re = "other_______; PL; 619; Peasants Agreement"							if pl134 == 8 & iso == "POL"
replace vote_re = "other_______; S; 108; Solidarnosc"									if pl134 == 9 & iso == "POL"
replace vote_re = "other_______; PPG; 1691; Polish Economic Program [Large Beer]"		if pl134 == 10 & iso == "POL"
replace vote_re = "other_______; MN; 900; German minority"								if pl134 == 11 & iso == "POL"
replace vote_re = "other_______; ChD; 334; Christian Democracy"							if pl134 == 12 & iso == "POL"
replace vote_re = "other_______; PCD; 696; Party of Christian Democrats"				if pl134 == 13 & iso == "POL"
replace vote_re = "other_______; SoPr; 18; Labour Solidarity"							if pl134 == 14 & iso == "POL"
replace vote_re = "radright____; UPR; 1549; Union of Real Politics"						if pl134 == 15 & iso == "POL"
replace vote_re = "radright____; X; 181; Party X"										if pl134 == 16 & iso == "POL"
replace vote_re = "other_______; RAS; 1208; Movement for Silesian Autonomy"				if pl134 == 17 & iso == "POL"
replace vote_re = "radleft_____; SD; 1216; Democratic Party"							if pl134 == 18 & iso == "POL"
replace vote_re = "radleft_____; PZZ; 1074; Polish Western Union"						if pl134 == 21 & iso == "POL"
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(pl134, 19, 20, 22, 23) & iso == "POL" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(pl134, 0) & iso == "POL" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(pl134, ., 97, 98, 99) & iso == "POL" 

replace vote_re = "radleft_____; SSS; 317; Socialist Party of Slovenia"					if slo134 == 1 & iso == "SVN"
replace vote_re = "majorleft___; SDP; 706; Social Democratic Renewal (later ZL-SD)"		if slo134 == 2 & iso == "SVN"
replace vote_re = "majorleft___; LDS; 1252; Liberal Democracy of Slovenia"				if slo134 == 3 & iso == "SVN"
replace vote_re = "other_______; SDZ; 1371; Slovenian Democratic Union"					if slo134 == 4 & iso == "SVN"
replace vote_re = "other_______; SDS; 179; Slovenian Democratic Party"					if slo134 == 5 & iso == "SVN"
replace vote_re = "majorright__; SKD; 1047; Slovenian Christian Democrats (later NSI)"	if slo134 == 6 & iso == "SVN"
replace vote_re = "other_______; SLS; 16; Slovenian People's Party"						if slo134 == 7 & iso == "SVN"
replace vote_re = "other_______; ZS; 1619; Greens of Slovenia"							if slo134 == 8 & iso == "SVN"
replace vote_re = "other_______; SOPS; 2275; Slovenian Craftsmen and Entreprenerial Party" 	if slo134 == 9 & iso == "SVN"
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(slo134, 10, 95) & iso == "SVN" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(slo134, 0) & iso == "SVN" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(slo134, ., 97, 98, 99) & iso == "SVN" 

replace vote_re = "majorleft___; Dem; -1; Democratic Party" 			if usa134 == 1 & iso == "USA" 
replace vote_re = "majorright__; Rep; -2; Republican Party" 			if usa134 == 2 & iso == "USA" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(usa134, 0) & iso == "USA" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(usa134, 95, 96, 97, 98, 99, .) & iso == "USA" // USA: Independents and other parties as "abstain" (here: missing, because there is no abstain category)

***	PROSPECTIVE VOTING

gen vote_pro = "NA_________; NA; .c; Not asked" if !inlist(iso, "DEU", "HUN", "NOR", "SVN")	// Only asked in DEU, HUN, NOR, SVN

replace vote_pro = "majorright__; CDU+CSU; 1727; Christian Democratic Union / Christian Social Union" 	if d122 == 1 & iso == "DEU" 
replace vote_pro = "majorleft___; SPD; 558; Social Democratic Party of Germany" 						if d122 == 2 & iso == "DEU" 
replace vote_pro = "other_______; FDP; 543; Free Democratic Party" 										if d122 == 3 & iso == "DEU" 
replace vote_pro = "other_______; B90/Gru; 772; Alliance 90 / Greens"									if d122 == 4 & iso == "DEU" 
replace vote_pro = "radright____; NPD; 1537; National Democratic Party"									if d122 == 5 & iso == "DEU" 
replace vote_pro = "radleft_____; KPD; 649; Communist Party of Germany"									if d122 == 6 & iso == "DEU" 
replace vote_pro = "radright____; Rep; 524; The Republicans"											if d122 == 7 & iso == "DEU" 
replace vote_pro = "radleft_____; PDS|Li; 791; PDS | The Left"											if d122 == 8 & iso == "DEU" 
replace vote_pro = "other_______; others; -90; Other parties, independents"								if inlist(d122, 95) & iso == "DEU" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(d122, 96) & iso == "DEU"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(d122, ., 97, 98, 99) & iso == "DEU"

replace vote_pro = "majorright__; MDF; 546; Hungarian Democratic Forum" 				if h122 == 1 & iso == "HUN" 
replace vote_pro = "other_______; SzDSz; 1426; Alliance of Free Democrats" 				if h122 == 2 & iso == "HUN" 
replace vote_pro = "other_______; FKgP; 870; Independent Small Holders Party" 			if h122 == 3 & iso == "HUN" 
replace vote_pro = "majorleft___; MSZP; 1591; Hungarian Socialist Party" 				if h122 == 4 & iso == "HUN" 
replace vote_pro = "other_______; Fi-MPSz; 921; Fidesz -- Hungarian Civic Union" 		if h122 == 5 & iso == "HUN" 
replace vote_pro = "radright____; KDNP; 434; Christian Democratic People's Party" 		if h122 == 6 & iso == "HUN" 
replace vote_pro = "radleft_____; MMP; 1202; Hungarian Workers' Party" 					if h122 == 7 & iso == "HUN" 
replace vote_pro = "other_______; MSzDP; 418; Social Democratic Party" 					if h122 == 8 & iso == "HUN" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(h122, 95) & iso == "HUN" 
//	replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(h122, 0) & iso == "HUN" 
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(h122, ., 97, 98, 99) & iso == "HUN"

replace vote_pro = "radleft_____; RV; 1638; Red Electoral Alliance" 					if n122 == 1 & iso == "NOR" 
replace vote_pro = "majorleft___; DNA; 104; Norwegian Labour Party" 					if n122 == 2 & iso == "NOR" 
replace vote_pro = "radright____; Fr; 351; Progress Party" 								if n122 == 3 & iso == "NOR" 
replace vote_pro = "majorright__; H; 1435; Conservative Party" 							if n122 == 4 & iso == "NOR" 
replace vote_pro = "other_______; KrF; 1538; Christian Democratic Party" 				if n122 == 5 & iso == "NOR" 
replace vote_pro = "other_______; Sp; 702; Centre Party" 								if n122 == 6 & iso == "NOR" 
replace vote_pro = "radleft_____; SV; 81; Socialist Left Party" 						if n122 == 7 & iso == "NOR" 
replace vote_pro = "other_______; V; 647; Liberal Party of Norway" 						if n122 == 8 & iso == "NOR" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(n122, 95) & iso == "NOR" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(n122, 96) & iso == "NOR"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(n122, ., 97, 98, 99) & iso == "NOR"

replace vote_pro = "other_______; DS; 143; Democratic Party"							if slo122 == 1 & iso == "SVN"
replace vote_pro = "other_______; KS; 2241; Christian Socialists"						if slo122 == 2 & iso == "SVN"
replace vote_pro = "majorleft___; LDS; 1252; Liberal Democracy of Slovenia"				if slo122 == 3 & iso == "SVN"
replace vote_pro = "other_______; LDSS; 2243; Liberal Democratic Party of Slovenia"		if slo122 == 4 & iso == "SVN"
replace vote_pro = "other_______; SDZ; 1371; Slovenian Democratic Union"				if slo122 == 5 & iso == "SVN"
replace vote_pro = "other_______; SDS; 179; Social Democratic Union of Slovenia"		if slo122 == 6 & iso == "SVN"
replace vote_pro = "other_______; SDZ; 1371; Slovenian Democratic Union"				if slo122 == 7 & iso == "SVN"
replace vote_pro = "radleft_____; SSS; 317; Socialist Party of Slovenia"				if slo122 == 8 & iso == "SVN"
replace vote_pro = "other_______; SLS; 16; Slovenian People's Party"					if slo122 == 9 & iso == "SVN"
replace vote_pro = "majorright__; SKD; 1047; Slovenian Christian Democrats (later NSI)"	if slo122 == 10 & iso == "SVN"
replace vote_pro = "majorleft___; SDP; 706; Social Democratic Renewal (later ZL-SD)"	if slo122 == 11 & iso == "SVN"
replace vote_pro = "other_______; ZS; 1619; Greens of Slovenia"							if slo122 == 12 & iso == "SVN"
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(slo122, 95) & iso == "SVN" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(slo122, 96) & iso == "SVN"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(slo122, ., 97, 98, 99) & iso == "SVN"

*** PARTY AFFILIATION

gen aff = "NA_________; NA; .c; Not asked" if !inlist(iso, "AUS", "AUT", "GBR", "NZL", "SWE", "USA") // Only asked in AUS, AUT, GBR, NZL, SWE, USA

replace aff = "majorright__; LPA; 1411; Liberal Party of Australia" 								if aus122 == 1 & iso == "AUS" 
replace aff = "majorleft___; ALP; 1253; Australian Labor Party" 									if aus122 == 2 & iso == "AUS" 
replace aff = "other_______; NCP|NPA; 184; National (Country) Party | National Party of Australia" 	if aus122 == 3 & iso == "AUS" 
replace aff = "other_______; AD; 120; Australian Democrats"											if aus122 == 4 & iso == "AUS" 
replace aff = "other_______; AG; 751; Australian Greens"											if aus122 == 5 & iso == "AUS" 
replace aff = "other_______; others; -90; Other parties, independents"								if inlist(aus122, 6) & iso == "AUS" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(aus122, 95) & iso == "AUS" // large share of "other parties" indicates that these probably include "no party" (abstain)
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(aus122, ., 97, 98, 99) & iso == "AUS" 

replace aff = "majorleft___; SPO; 973; Social Democratic Party of Austria" 			if a122 == 1 & iso == "AUT" 
replace aff = "majorright__; OVP; 1013; Austrian People's Party" 					if a122 == 2 & iso == "AUT" 
replace aff = "radright____; FPO; 50; Freedom Party of Austria"						if a122 == 3 & iso == "AUT" 
replace aff = "other_______; Gruene; 1429; The Greens -- The Green Alternative"		if a122 == 4 & iso == "AUT" 
replace aff = "radleft_____; KPO; 769; Communist Party of Austria"					if a122 == 6 & iso == "AUT" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(a122, 5, 95) & iso == "AUT" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(a122, 96) & iso == "AUT"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(a122, ., 97, 98, 99) & iso == "AUT" 

replace aff = "majorright__; Con; 773; Conservatives" 								if gb122 == 1 & iso == "GBR" 
replace aff = "majorleft___; Lab; 1556; Labour" 									if gb122 == 2 & iso == "GBR" 
replace aff = "other_______; Lib; 659; Liberals" 									if gb122 == 3 & iso == "GBR" 
replace aff = "other_______; SNP; 1284; Scottish National Party" 					if gb122 == 6 & iso == "GBR" 
replace aff = "other_______; Plaid; 311; Plaid Cymru" 								if gb122 == 7 & iso == "GBR" 
replace aff = "other_______; GP; 467; Green Party" 									if gb122 == 8 & iso == "GBR" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(gb122, 93, 95) & iso == "GBR" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(gb122, 96) & iso == "GBR"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(gb122, ., 97, 98, 99) & iso == "GBR"

replace aff = "other_______; Greens; 1171; Green Party"		 						if nz122 == 1 & iso == "NZL" 
replace aff = "majorleft___; LP; 878; Labour Party"		 							if nz122 == 2 & iso == "NZL" 
replace aff = "majorright__; NP; 997; National Party"		 						if nz122 == 3 & iso == "NZL" 
replace aff = "other_______; NLP; 930; New Labour Party"		 					if nz122 == 4 & iso == "NZL" 
replace aff = "other_______; SC|DP; 1636; Social Credit | Democratic Party"			if nz122 == 5 & iso == "NZL" 
replace aff = "other_______; SDP; 2549; Social Democratic Party" 					if nz122 == 6 & iso == "NZL"
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(nz122, 95) & iso == "NZL" // large share of "other parties" indicates that these probably include "no party" (abstain)
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(nz122, ., 97, 98, 99) & iso == "NZL" 

replace aff = "other_______; C; 1461; Centre Party"									if s122 == 1 & iso == "SWE"
replace aff = "other_______; FP; 892; Liberal People's Party"						if s122 == 2 & iso == "SWE"
replace aff = "other_______; KD; 282; Christian Democrats"							if s122 == 3 & iso == "SWE"
replace aff = "other_______; MP; 1154; Greens"										if s122 == 4 & iso == "SWE"
replace aff = "majorright__; M; 657; Moderate Party"								if s122 == 5 & iso == "SWE"
replace aff = "majorleft___; SAP; 904; Social Democrats"							if s122 == 6 & iso == "SWE"
replace aff = "radleft_____; V; 882; Left Party"									if s122 == 7 & iso == "SWE"
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(s122, 95) & iso == "SWE" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(s122, 96) & iso == "SWE"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(s122, ., 97, 98, 99) & iso == "SWE"

replace aff = "majorleft___; Dem; -1; Democratic Party" 			if inlist(usa122, 1, 2, 3) & iso == "USA" 
replace aff = "majorright__; Rep; -2; Republican Party" 			if inlist(usa122, 5, 6, 7) & iso == "USA" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(usa122, 4, 95) & iso == "USA" // USA: Independents and other parties as "abstain"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(usa122, ., 97, 98, 99) & iso == "USA" 

qui foreach party in vote_re vote_pro aff {
	split `party', p("; ") destring
	replace `party'1 = subinstr(`party'1,"_","",.)
	rename `party'3 party_id
		merge m:m party_id using "Data Reference materials/Parlgov_party_database_20210212.dta", nogen keep(match master)
	rename party_id party_id_`party'
	noisily tab iso `party'1, miss
}

foreach p in majorright majorleft radright radleft popcentre other abstain {
	gen `p'_vote_re = (vote_re1 == "`p'") if vote_re1 != "NA" & vote_re1 != "missing"
	gen `p'_vote_pro = (vote_pro1 == "`p'") if vote_pro1 != "NA" & vote_pro1 != "missing"
	gen `p'_aff = (aff1 == "`p'") if aff1 != "NA" & aff1 != "missing"	
}

********************************************************************************
***  CONTROL VARIABLES
********************************************************************************
	
	gen class = .
	gen union = .
	gen region = .
	gen urban = .
