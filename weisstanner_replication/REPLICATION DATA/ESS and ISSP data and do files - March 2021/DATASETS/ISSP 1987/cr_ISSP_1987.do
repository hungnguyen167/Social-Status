use "DATASETS/ISSP 1987/ZA1680.dta", clear
 append using "DATASETS/ISSP 1987/ZA1306_v1-0-0.dta"
	gen wave = 1987
		gen survey = "ISSP"
		gen year = wave
		gen weight = v107 // No weighting for Ireland, all = 1 
		
	recode v3 (1=1 "Australia") (2=2 "Germany") (3=3 "United Kingdom") (4=4 "USA") ///
		(5=5 "Austria") (6=6 "Hungary") (7=7 "Netherlands") (8=8 "Italy") ///
		(9=9 "Ireland") (11=11 "Switzerland") (12=12 "Poland"), gen(cn_issp)
		decode cn_issp, gen(country)
	merge m:m country using Countrynames.dta, nogen keep(match)
		keep if inlist(iso, "AUS","AUT","BEL","CAN","CHE","CZE","DEU","DNK","ESP") | ///
				inlist(iso, "EST","FIN","FRA","GBR","GRC","HUN","IRL","ISL","ITA") | ///
				inlist(iso, "JPN","LTU","LUX","LVA","NLD","NOR","NZL","POL","PRT") | ///
				inlist(iso, "SVK","SVN","SWE","USA")
	replace year = 1988 if inlist(country, "Austria")
	replace year = 1989 if inlist(country, "Ireland")
	* POL: too many missing data (family income, CPI, unemployment) --> add entirely to missing.
	drop if iso == "POL"
	merge m:m country year using "Data Reference materials/CPI_PPPEuroconversion_January.dta", nogen keep(match)

********************************************************************************
*** REDISTRIBUTION
********************************************************************************

	recode v49 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9 =.), gen(redist3)
	recode v48 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9 =.), gen(incdiff)

	gen resp_unemp_4pt = .
	recode v53 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (0 8 9 =.), gen(resp_unemp_5pt)
	
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
	replace month=12  if iso == "AUS"   //Survey conduced 87-88 - last month of 87 chosen 
	replace month=7   if iso == "AUT"   //June-July 
	replace month=11  if iso == "CHE"   //October -December 
	replace month=10  if iso == "DEU"   //Sep and Oct 87 
	replace month=5   if iso == "GBR"   //intervieews March and April - self-completion until July 
	replace month=5   if iso == "HUN"   //April-May 
	replace month=4   if iso == "ITA"   //March - April 
	replace month=6   if iso == "IRL"   //Survey conducted in 1989 - middle month chosen
	replace month=11  if iso == "NLD"   //Sep -Dec 
	replace month=3   if iso == "USA"   //Feb-April 

*** AGE (IN YEARS)

	gen age = v82
	recode age (99 = .)
	recode age (1=21) (2=30) (3=40) (4=50) (5=60) (6=70) if iso == "ITA"


***	GENDER (1=FEMALE, 0=MALE)

	gen female = v83
	recode female (2=1) (1=0) (9 = .)

***	HOUSEHOLD COMPOSITION (NUMBER OF HOUSEHOLD MEMBERS)

	gen nhhmem = v86
		recode nhhmem (99 0 = .)
		recode nhhmem (1=1) (2 3 4 6=2) (5 7 8=3) if iso == "NLD"
		replace nhhmem = 2 if v85 == 1 & missing(nhhmem)
		replace nhhmem = 1 if (inrange(v85,2,5)|(v101 == 0 & !inlist(iso,"AUS"))) & missing(nhhmem) 

*** HOUSEHOLD INCOME MIDPOINTS / INCOME QUINTILES
	recode v92 (999997/999999 = .)
	recode v93 (97/99 = .)
	recode v94 (999997/999999 = .)
	recode v95 (97/99 = .)

	gen hinc = .
		replace hinc = v92 				if iso == "AUS" // Gross annual household income (AUS$)
		replace hinc = v93 				if iso == "AUT" // Net monthly household income (ATS-Schilling)
		replace hinc = v93 				if iso == "CHE" // Net monthly household income (CHF)
		replace hinc = v92 				if iso == "DEU" // Net monthly household income (DM)
		recode  hinc (99997/99999=.) 	if iso == "DEU"
		replace hinc = v93 				if iso == "DEU" & missing(hinc)
		replace hinc = v93 				if iso == "GBR" // Gross annual household income (GBP)
		replace hinc = v92 				if iso == "HUN" // Gross monthly household income (HUF)
		replace hinc = v93 				if iso == "IRL" // Gross annual household income (Irish Pound) - in 1989 Work Orientations Q (these surveys were fielded together)
		replace hinc = v93 				if iso == "ITA" // Net monthly household income (Lire) (estimation by the interviewer because no reliable information was given) (Lire)
		replace hinc = v92 				if iso == "NLD" // Net annual household income (Gld)
		replace hinc = v93 				if iso == "NLD" & missing(hinc)
		replace hinc = v93 				if iso == "USA" // Gross annual household income (US$)
			recode hinc (5000 = 2500) if iso == "AUS" 
			recode hinc (1=2000) (2=5000) (3=7000) (4=9000) (5=11000) (6=13000) (7=15000) ///
						(8=17000) (9=19000) (10=21000) (11=23000) (12=25000) (13=27000) (14=29000) ///
						(15=31000) (16=33000) (17=35000) (18=37000) (19=39000) (20=42000) if iso == "AUT" 
			recode hinc (1=250) (2=750) (3=1250) (4=1750) (5=2250) (6=2750) (7=3500) (8=4500) (9=5500) ///
						(10=8000) (11=15000) (12=30000) if iso == "CHE" 
			recode hinc (1=  200) (2=  500) (3=  700) (4=  900) (5= 1125) (6= 1375) (7= 1625) (8= 1875) ///
						(9= 2125) (10= 2375) (11= 2625) (12= 2875) (13= 3250) (14= 3750) (15= 4250) ///
						(16= 4750) (17= 5250) (18= 5750) (19= 7000) (20= 9000) (21=12500) (22=20000) if iso== "DEU"
			recode hinc (1=1000) (2=2500) (3=3500) (4=4500) (5=5500) (6=6500) (7=7500) (8=9000) ///
						(9=11000) (10=13500) (11=16500) (12=19000) (13=22000) if iso == "GBR"
			recode hinc (1=150000) (2=450000) (3=750000) (4=1050000) (5=1350000) (6=1650000) ///
						(7=1950000) (8=2250000) (9=2550000) (10=2850000) (11=3150000) (12=3450000) ///
						(13=3750000) (14=4050000) (15=4350000) (16=4650000) (17=4950000) (18=5400000) if iso == "ITA"
			recode hinc (1= 1375) (2= 3625) (3= 5000) (4= 6500) (5= 8500) (6=10750) (7=13500) ///
						(8=17000) (9=22500) (10=33000)  if iso== "IRL" 
			recode hinc (1=  3000) (2=  9000) (3= 15000) (4= 21000) (5= 27000) (6= 35000) (7= 45000) (8= 55000) (9= 70000) (10=100000) if iso== "NLD" 
			recode hinc (1=500) (2=2000) (3=3500) (4=4500) (5=5500) (6=6500) (7=7500) (8=9000) ///
						(9=11250) (10=13750) (11=16250) (12=18750) (13=21250) (14=23750) (15=27500) ///
						(16=32500) (17=37500) (18=45000) (19=55000) (20=70000)  if iso == "USA" 			
		replace hinc = hinc*12 if inlist(iso,"AUT","CHE","DEU","HUN","ITA")
		replace hinc = hinc / euro_conversion if inlist(iso,"AUT","DEU","ITA","IRL","NLD")

	gen rinc = .
		replace rinc = v94 			if iso == "AUS" // gross, annual
		replace rinc = v95 			if iso == "AUT" // net, monthly 
		replace rinc = v95 			if iso == "CHE" // net, monthly 
		replace rinc = v94			if iso == "DEU" // net, monthly
		recode  rinc (99997/99999=.)if iso == "DEU"
		replace rinc = v95			if iso == "DEU" & missing(hinc)
		replace rinc = v95 			if iso == "GBR" // gross, annual
		replace rinc = v94 			if iso == "HUN" // - , monthly
		replace rinc = v95	 		if iso == "IRL" // gross, annual
		replace rinc = v94*10000 	if iso == "ITA" // net, monthly
		replace rinc = v95 			if iso == "USA" // gross, annual
			recode rinc (5000 = 2500) if iso =="AUS"
			recode rinc (1=2000) (2=5000) (3=7000) (4=9000) (5=11000) (6=13000) (7=15000) ///
						(8=17000) (9=19000) (10=21000) (11=23000) (12=25000) (13=27000) (14=29000) ///
						(15=31000) (16=33000) (17=35000) (18=37000) (19=39000) (20=42000) if iso == "AUT"		
			recode rinc (1=250) (2=750) (3=1250) (4=1750) (5=2250) (6=2750) (7=3500) (8=4500) (9=5500) ///
						(10=8000) (11=15000) (12=30000) if iso == "CHE"
			recode rinc (1=  200) (2=  500) (3=  700) (4=  900) (5= 1125) (6= 1375) (7= 1625) (8= 1875) ///
						(9= 2125) (10= 2375) (11= 2625) (12= 2875) (13= 3250) (14= 3750) (15= 4250) ///
						(16= 4750) (17= 5250) (18= 5750) (19= 7000) (20= 9000) (21=12500) (22=20000) if iso== "DEU"
			recode rinc (1=1000) (2=2500) (3=3500) (4=4500) (5=5500) (6=6500) (7=7500) (8=9000) ///
						(9=11000) (10=13500) (11=16500) (12=19000) (13=22000) if iso == "GBR" 
			recode rinc (1= 1375) (2= 3625) (3= 5000) (4= 6500) (5= 8500) (6=10750) (7=13500) ///
						(8=17000) (9=22500) (10=33000) (99=.) if iso== "IRL" 
			recode rinc (1=500) (2=2000) (3=3500) (4=4500) (5=5500) (6=6500) (7=7500) (8=9000) ///
						(9=11250) (10=13750) (11=16250) (12=18750) (13=21250) (14=23750) (15=27500) ///
						(16=32500) (17=37500) (18=45000) (19=55000) (20=70000) if iso == "USA" 
		replace rinc = rinc*12 if inlist(iso,"AUT","CHE","DEU","HUN","ITA")
		replace rinc = rinc / euro_conversion if inlist(iso,"AUT","DEU","ITA","IRL","NLD")

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
	replace hinc = hinc / sqrt(nhhmem)
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
	gen gross_inc  	= (inlist(iso,"AUS","GBR","USA","HUN","IRL")) 
	gen net_inc		= (inlist(iso,"AUT","CHE","DEU","ITA","NLD")) 

***	EMPLOYMENT STATUS (DUMMIES FOR UNEMPLOYED, RETIRED, FULL-TIME EMPLOYED, PART-TIME EMPLOYED, NON-EMPLOYED)
	
	recode v72 (9= .)
	recode v74 (9= .) 
	
	gen unemployed = (v74 == 1)
	gen retired    = (!inlist(v74, 1, 2) & inrange(age, 66, 99))
	gen fulltime   = ((v72 == 1 | v72 == 2 | v74 == 2) & inrange(v73, 30, 96)) & !unemployed & !retired
	gen parttime   = ((v72 == 1 | v72 == 2 | v74 == 2) & inrange(v73, 1, 29)) & !unemployed & !retired
	gen nonemp     = (retired == 1 | v74 == 8 | v72 == 0) & !unemployed & !parttime & !fulltime

***	EDUCATION (TERTIARY EDUCATION=1, ISCED CATEGORIES, EDUCATION YEARS)
	rename v88 educ
	recode educ (0=.)
		recode educ (9=.) if iso == "GBR"
	
	*University Education
		gen educ_tert = 1 		if iso == "AUS" & inrange(educ, 8, 9)
		replace educ_tert = 0 	if iso == "AUS" & inrange(educ, 1, 7)
		replace educ_tert = 1 	if iso == "DEU" & inrange(educ, 9, 9)
		replace educ_tert = 0 	if iso == "DEU" & inrange(educ, 1, 8)
		replace educ_tert = 1 	if iso == "GBR" & inrange(educ, 8, 8)
		replace educ_tert = 0 	if iso == "GBR" & inrange(educ, 1, 7)
		replace educ_tert = 1 	if iso == "USA" & inrange(educ, 5, 6)
		replace educ_tert = 0 	if iso == "USA" & inrange(educ, 1, 4)
		replace educ_tert = 1 	if iso == "AUT" & inrange(educ, 8, 8)
		replace educ_tert = 0 	if iso == "AUT" & inrange(educ, 1, 7)
		replace educ_tert = 1 	if iso == "NLD" & inrange(educ, 8, 8)
		replace educ_tert = 0 	if iso == "NLD" & inrange(educ, 1, 7)
		replace educ_tert = 1 	if iso == "ITA" & inrange(educ, 8, 9)
		replace educ_tert = 0 	if iso == "ITA" & inrange(educ, 1, 7)
		replace educ_tert = 1 	if iso == "IRL" & inrange(educ, 8, 9)
		replace educ_tert = 0 	if iso == "IRL" & inrange(educ, 1, 7)
		replace educ_tert = 1 	if iso == "CHE" & inrange(educ, 9, 9)
		replace educ_tert = 0 	if iso == "CHE" & inrange(educ, 1, 8)
		replace educ_tert = 1 	if iso == "HUN" & inrange(educ, 7, 7)
		replace educ_tert = 0 	if iso == "HUN" & inrange(educ, 1, 6)

	gen educ_isced = .
	recode v87 (26/89=25) (90/9999=.), gen(educ_years)

********************************************************************************
*** PARTY SUPPORT & VOTING
********************************************************************************

*** RETROSPECTIVE VOTING

replace v106 = . if inlist(v106, 97, 98, 99)

gen vote_re = "NA_________; NA; .c; Not asked" if inlist(iso, "AUT", "HUN", "ITA", "IRL", "NLD")	// Not asked in AUT, HUN, ITA, IRL, NLD

replace vote_re = "majorright__; LPA; 1411; Liberal Party of Australia" 								if v106 == 1 & iso == "AUS" 
replace vote_re = "majorleft___; ALP; 1253; Australian Labor Party" 									if v106 == 2 & iso == "AUS" 
replace vote_re = "other_______; NCP|NPA; 184; National (Country) Party | National Party of Australia" 	if v106 == 3 & iso == "AUS" 
replace vote_re = "other_______; AD; 120; Australian Democrats"											if v106 == 4 & iso == "AUS" 
replace vote_re = "other_______; DLP; 1306; Democratic Labour Party"									if v106 == 5 & iso == "AUS" 
replace vote_re = "other_______; others; -90; Other parties, independents"								if inlist(v106, 6, 8, 95) & iso == "AUS" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(v106, 96) & iso == "AUS" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(v106, .) & iso == "AUS" 

replace vote_re = "majorright__; FDP-PRD; 26; Radical Democratic Party" 				if v106 == 1 & iso == "CHE" 
replace vote_re = "majorright__; KK/CVP; 531; Christian Democratic Peoples Party"		if v106 == 2 & iso == "CHE" 
replace vote_re = "majorleft___; SP-PS; 35; Social Democratic Party of Switzerland"		if v106 == 3 & iso == "CHE" 
replace vote_re = "other_______; SVP-UDC; 750; Swiss People's Party"					if v106 == 4 & iso == "CHE" 
replace vote_re = "other_______; LdU-ADI; 1264; Independents Alliance"					if v106 == 5 & iso == "CHE" 
replace vote_re = "other_______; LPS; 458; Liberal Party of Switzerland"				if v106 == 6 & iso == "CHE" 
replace vote_re = "other_______; EVP-PEP; 602; Protestant Peoples Party"				if v106 == 7 & iso == "CHE" 
replace vote_re = "radleft_____; PdA; 1167; Swiss Party of Labour"						if v106 == 8 & iso == "CHE" 
replace vote_re = "radleft_____; POCH; 964; Progressive Organisations of Switzerland"	if v106 == 9 & iso == "CHE" 
replace vote_re = "other_______; Grue; 141; Greens"										if v106 == 10 & iso == "CHE" 
replace vote_re = "radright____; NA|SD; 628; National Action -- Swiss Democrats"		if v106 == 11 & iso == "CHE" 
replace vote_re = "other_______; CsP-PCS; 1012; Christian Social Party"					if v106 == 12 & iso == "CHE" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(v106, 95) & iso == "CHE" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v106, 0, 96) & iso == "CHE" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v106, .) & iso == "CHE"

replace vote_re = "majorright__; CDU+CSU; 1727; Christian Democratic Union / Christian Social Union" 	if v106 == 1 & iso == "DEU" 
replace vote_re = "majorleft___; SPD; 558; Social Democratic Party of Germany" 							if v106 == 2 & iso == "DEU" 
replace vote_re = "other_______; FDP; 543; Free Democratic Party" 										if v106 == 3 & iso == "DEU" 
replace vote_re = "other_______; B90/Gru; 772; Alliance 90 / Greens"									if v106 == 4 & iso == "DEU" 
replace vote_re = "radright____; NPD; 1537; National Democratic Party"									if v106 == 5 & iso == "DEU" 
replace vote_re = "radleft_____; KPD; 649; Communist Party of Germany"									if v106 == 6 & iso == "DEU" 
replace vote_re = "other_______; others; -90; Other parties, independents"								if inlist(v106, 95) & iso == "DEU" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(v106, 0) & age > 17 & iso == "DEU" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(v106, 96, .)|(v106 == 0 & age < 18) & iso == "DEU" 

replace vote_re = "majorright__; Con; 773; Conservatives" 								if v106 == 1 & iso == "GBR" 
replace vote_re = "majorleft___; Lab; 1556; Labour" 									if v106 == 2 & iso == "GBR" 
replace vote_re = "other_______; Lib; 659; SDP–Liberal Alliance" 						if v106 == 3 & iso == "GBR" 
replace vote_re = "other_______; Lib; 659; Liberals" 									if v106 == 4 & iso == "GBR" 
replace vote_re = "other_______; SDP; 1547; Social Democratic Party" 					if v106 == 5 & iso == "GBR" 
replace vote_re = "other_______; SNP; 1284; Scottish National Party" 					if v106 == 6 & iso == "GBR" 
replace vote_re = "other_______; Plaid; 311; Plaid Cymru" 								if v106 == 7 & iso == "GBR" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(v106, 95, 96) & iso == "GBR" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v106, 0) & iso == "GBR" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v106, .) & iso == "GBR"

replace vote_re = "majorleft___; Dem; -1; Democratic Party" 			if v106 == 1 & iso == "USA" 
replace vote_re = "majorright__; Rep; -2; Republican Party" 			if v106 == 2 & iso == "USA" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if (inlist(v106, 95) |(v106 == 0 & age > 17)) & iso == "USA" 
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if (inlist(v106, 95, 96, .)|(v106 == 0 & age < 18)) & iso == "USA" // USA: Independents and other parties as "abstain" 

*** PROSPECTIVE VOTING

gen vote_pro = "NA_________; NA; .c; Not asked" if !inlist(iso, "AUS", "IRL", "NLD")	// Asked only in AUS, IRL, NLD

replace vote_pro = "majorright__; LPA; 1411; Liberal Party of Australia" 								if v97 == 1 & iso == "AUS" 
replace vote_pro = "majorleft___; ALP; 1253; Australian Labor Party" 									if v97 == 2 & iso == "AUS" 
replace vote_pro = "other_______; NCP|NPA; 184; National (Country) Party | National Party of Australia" if v97 == 3 & iso == "AUS" 
replace vote_pro = "other_______; AD; 120; Australian Democrats"										if v97 == 4 & iso == "AUS" 
replace vote_pro = "other_______; DLP; 1306; Democratic Labour Party"									if v97 == 5 & iso == "AUS" 
replace vote_pro = "other_______; others; -90; Other parties, independents"								if inlist(v97, 6, 95, 96) & iso == "AUS" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(v97, 97) & iso == "AUS"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(v97, ., 98, 99) & iso == "AUS" 

replace vote_pro = "majorright__; FF; 280; Fianna Fail" 								if v97 == 1 & iso == "IRL" 
replace vote_pro = "majorright__; FG; 1393; Fine Gael (Familiy of the Irish)" 			if v97 == 2 & iso == "IRL" 
replace vote_pro = "majorleft___; Lab; 318; Labour Party" 								if v97 == 3 & iso == "IRL" 
replace vote_pro = "radleft_____; TWP; 433; The Workers' Party" 						if v97 == 4 & iso == "IRL" 
replace vote_pro = "other_______; PD; 651; Progressive Democrats" 						if v97 == 5 & iso == "IRL" 
replace vote_pro = "other_______; Green; 1573; Green Party" 							if v97 == 6 & iso == "IRL" 
replace vote_pro = "radleft_____; SF; 2217; Sinn Fein" 									if v97 == 7 & iso == "IRL" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(v97, 95) & iso == "IRL" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v97, 97) & iso == "IRL"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v97, ., 98, 99) & iso == "IRL" 

replace vote_pro = "radleft_____; (-); -871; 'far left' (recode)"					 	if v96 == 1 & iso == "NLD" 
replace vote_pro = "majorleft___; (-); -872; 'left' (recode)" 							if v96 == 2 & iso == "NLD" 
replace vote_pro = "majorright__; (-); -873; 'center' (recode)" 						if v96 == 3 & iso == "NLD" 
replace vote_pro = "other_______; (-); -874; 'right' (recode)" 							if v96 == 4 & iso == "NLD" 
replace vote_pro = "radright____; (-); -875; 'far right' (recode)" 						if v96 == 5 & iso == "NLD" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v96, 7) & iso == "NLD"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v96, ., 8, 9) & iso == "NLD" 

*** AFFILIATION

gen aff = "NA_________; NA; .c; Not asked" if inlist(iso, "AUS", "HUN", "ITA", "IRL", "NLD", "POL")	// Not asked in AUS, HUN, ITA, IRL, NLD, POL

replace aff = "majorleft___; SPO; 973; Social Democratic Party of Austria" 			if v97 == 1 & iso == "AUT" 
replace aff = "majorright__; OVP; 1013; Austrian People's Party" 					if v97 == 2 & iso == "AUT" 
replace aff = "radright____; FPO; 50; Freedom Party of Austria"						if v97 == 3 & iso == "AUT" 
replace aff = "radleft_____; KPO; 769; Communist Party of Austria"					if v97 == 4 & iso == "AUT" 
replace aff = "other_______; VGO; 1740; United Greens Austria"						if v97 == 5 & iso == "AUT" 
replace aff = "other_______; ALO; 1739; Alternative List Austria"					if v97 == 6 & iso == "AUT" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v97, 97) & iso == "AUT"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v97, ., 98, 99) & iso == "AUT" 

replace aff = "majorright__; FDP-PRD; 26; Radical Democratic Party" 				if v97 == 1 & iso == "CHE" 
replace aff = "majorright__; CVP; 531; Christian Democratic Peoples Party"			if v97 == 2 & iso == "CHE" 
replace aff = "majorleft___; SP-PS; 35; Social Democratic Party of Switzerland"		if v97 == 3 & iso == "CHE" 
replace aff = "other_______; SVP-UDC; 750; Swiss People's Party"					if v97 == 4 & iso == "CHE" 
replace aff = "other_______; LdU-ADI; 1264; Independents Alliance"					if v97 == 5 & iso == "CHE" 
replace aff = "other_______; LPS; 458; Liberal Party of Switzerland"				if v97 == 6 & iso == "CHE" 
replace aff = "other_______; EVP-PEP; 602; Protestant Peoples Party"				if v97 == 7 & iso == "CHE" 
replace aff = "radleft_____; PdA; 1167; Swiss Party of Labour"						if v97 == 8 & iso == "CHE" 
replace aff = "radleft_____; POCH; 964; Progressive Organisations of Switzerland"	if v97 == 9 & iso == "CHE" 
replace aff = "other_______; Grue; 141; Greens"										if v97 == 10 & iso == "CHE" 
replace aff = "radright____; NA|SD; 628; National Action -- Swiss Democrats"		if v97 == 11 & iso == "CHE" 
replace aff = "other_______; CsP-PCS; 1012; Christian Social Party"					if v97 == 12 & iso == "CHE" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(v97, 95, 96) & iso == "CHE" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v97, 97) & iso == "CHE"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v97, ., 98, 99) & iso == "CHE" 

replace aff = "majorleft___; SPD; 558; Social Democratic Party of Germany" 			if v97 == 1 & iso == "DEU" 
replace aff = "majorright__; CDU; 808; Christian Democratic Union" 					if v97 == 2 & iso == "DEU" 
replace aff = "majorright__; CSU; 1180; Christian Social Union" 					if v97 == 3 & iso == "DEU" 
replace aff = "other_______; FDP; 543; Free Democratic Party" 						if v97 == 4 & iso == "DEU" 
replace aff = "other_______; B90/Gru; 772; Alliance 90 / Greens"					if v97 == 5 & iso == "DEU" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(v97, 95) & iso == "DEU" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v97, 97) & iso == "DEU"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v97, ., 98, 99) & iso == "DEU" 

replace aff = "majorright__; Con; 773; Conservatives" 								if v97 == 1 & iso == "GBR" 
replace aff = "majorleft___; Lab; 1556; Labour" 									if v97 == 2 & iso == "GBR" 
replace aff = "other_______; Lib; 659; Liberals" 									if v97 == 3 & iso == "GBR" 
replace aff = "other_______; SDP; 1547; Social Democratic Party" 					if v97 == 4 & iso == "GBR" 
replace aff = "other_______; Lib; 659; SDP–Liberal Alliance" 						if v97 == 5 & iso == "GBR" 
replace aff = "other_______; SNP; 1284; Scottish National Party" 					if v97 == 6 & iso == "GBR" 
replace aff = "other_______; Plaid; 311; Plaid Cymru" 								if v97 == 7 & iso == "GBR" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(v97, 95, 96) & iso == "GBR" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v97, 97) & iso == "GBR"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v97, ., 98, 99) & iso == "GBR" 

replace aff = "majorleft___; Dem; -1; Democratic Party" 			if inlist(v97, 1, 2, 3) & iso == "USA" 
replace aff = "majorright__; Rep; -2; Republican Party" 			if inlist(v97, 5, 6, 7) & iso == "USA" 	
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(v97, 4, 95) & iso == "USA" // USA: Independents and other parties as "abstain"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(v97, ., 98, 99) & iso == "USA" 

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
