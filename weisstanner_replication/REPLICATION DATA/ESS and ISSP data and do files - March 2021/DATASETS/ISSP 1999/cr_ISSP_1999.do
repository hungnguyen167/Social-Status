use "DATASETS/ISSP 1999/ZA3430.dta", clear
append using "DATASETS/ISSP 1999/ZA3297_v1-0-0.dta"
append using "DATASETS/ISSP 1999/ZA3562_v1-0-0.dta"
append using "DATASETS/ISSP 1999/ZA3613_v1-0-0.dta"
append using "DATASETS/ISSP 1999/ZA3293_v1-0-0.dta"
	gen wave = 1999
		gen survey = "ISSP"
		gen year = wave
		rename weight weight 
	recode v3 (1=1 "Australia") (2 3=2 "Germany") (4=4 "United Kingdom") (6=6 "USA") ///
		(7=7 "Austria") (8=8 "Hungary") (10=10 "Ireland") (11=11 "Netherlands") (12=12 "Norway") ///
		(13=13 "Sweden") (14=14 "Czech Republic") (15=15 "Slovenia") (16=16 "Poland") (17=17 "Bulgaria") ///
		(19=19 "New Zealand") (20=20 "Canada") (24=24 "Japan") (25=25 "Spain") (26=26 "Latvia") ///
		(27=27 "France") (28=28 "Cyprus") (29=29 "Portugal") (32=32 "Denmark") (33=33 "Slovakia") ///
		(34=34 "Switzerland"), gen(cn_issp)
		decode cn_issp, gen(country)
	merge m:m country using Countrynames.dta, nogen keep(match)
		keep if inlist(iso, "AUS","AUT","BEL","CAN","CHE","CZE","DEU","DNK","ESP") | ///
				inlist(iso, "EST","FIN","FRA","GBR","GRC","HUN","IRL","ISL","ITA") | ///
				inlist(iso, "JPN","LTU","LUX","LVA","NLD","NOR","NZL","POL","PRT") | ///
				inlist(iso, "SVK","SVN","SWE","USA")
	replace year = 2000 if inlist(country, "Australia", "Austria", "Canada", "Germany",  "USA")
	replace year = 1998 if inlist(country, "Hungary","Slovenia")
	replace year = 2001 if inlist(country, "Slovakia","Denmark","Ireland")
	replace weight = 1 if inlist(iso,"DNK","NLD") // No weight variable for these countries
	merge m:m country year using "Data Reference materials/CPI_PPPEuroconversion_January.dta", nogen keep(match)

********************************************************************************
*** REDISTRIBUTION
********************************************************************************

	replace v35 = . if iso == "DNK"
	replace v35 = v57 if iso == "DNK"
	
	recode v35 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9 .a .b .c=.), gen(redist3)
    recode v34 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9 .a .b .c=.), gen(incdiff)
	
	gen resp_unemp_4pt = .
	gen resp_unemp_5pt = .
	
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
		replace month = 1  if iso == "AUS"
		replace month = 11 if iso == "AUT"
		replace month = 1  if iso == "CAN"
		replace month = 9  if iso == "CHE"
		replace month = 2  if iso == "CZE"
		replace month = 4  if iso == "DEU"
		replace month = 3  if iso == "DNK"
		replace month = 11 if iso == "ESP"
		replace month = 10 if iso == "FRA"
		replace month = 9  if iso == "GBR"
		replace month = 11 if iso == "HUN"
		replace month = 12 if iso == "JPN"
		replace month = 8  if iso == "IRL"
		replace month = 12 if iso == "LVA"
		replace month = 11 if iso == "NLD"
		replace month = 10 if iso == "NOR"
		replace month = 7  if iso == "NZL"
		replace month = 12 if iso == "POL"
		replace month = 6  if iso == "PRT"
		replace month = 9  if iso == "SVK"
		replace month = 10 if iso == "SVN"
		replace month = 4  if iso == "SWE"
		replace month = 4  if iso == "USA"
	
		
*** AGE (IN YEARS)

	rename age age // just for the record that this was already there
	recode age (99=.) if iso == "IRL"

***	GENDER (1=FEMALE, 0=MALE)

	gen female = sex
		recode female (2=1) (1=0) (9=.)

***	HOUSEHOLD COMPOSITION (NUMBER OF HOUSEHOLD MEMBERS)

	gen nhhmem = hompop
		recode nhhmem (0 99 .d =.) (13/25=12)
		recode nhhmem (9 =.) if iso == "DNK"
		recode hhcycle (1=1) (2 5=2) (3 6 9=3) (4 7 10 11 = 4) (8 12 13 = 5) (14 15 =6) ///
					   (16 17=7) (18 19=8) (20 21 =9) (29 30 95 = 10) (97 99 =.)
		replace nhhmem = hhcycle if missing(nhhmem) 
		replace nhhmem = 2 if (cohab == 1 | marital == 1 ) & missing(nhhmem)
		replace nhhmem = 1 if (cohab == 2 | inrange(marital,2,5) | spwrkst == 0) & missing(nhhmem)
		replace nhhmem = 2 if inrange(spwrkst,1,99) & missing(nhhmem)


*** HOUSEHOLD INCOME MIDPOINTS / INCOME QUINTILES

	gen hinc = income
		recode hinc (999997/999999=.) 							if iso == "AUS" // Gross annual household income (AUS$)
		recode hinc (4000 5000=2500) (37500=40000) (999999=.) 	if iso == "AUT" // Net monthly household income (ATS)
		recode hinc (1=7500) (2=20000) (3=30000) (4=40000) (5=50000) (6=60000) ///
					(7=70000) (8=85000) (9=.) 		 			if iso == "CAN" // Gross annual household income (CAN$)
		recode hinc (. = .) 									if iso == "CHE" // Net monthly household income (CHF)
		recode hinc (999997/999999 = .) 						if iso == "CZE" // Net monthly household income (CZK)
		recode hinc (999997/999999 = .) 						if iso == "DEU" // Net monthly household income (DM)
		recode hinc (1=  50000) (2= 125000) (3= 175000) (4= 225000) (5= 275000) (6= 350000) ///
					(7= 450000) (8= 550000) (9= 650000) (10= 750000) (11= 850000) (12= 950000) ///
					(13=1100000) (96/99=.) 						if iso == "DNK"  // Gross annual household income (DKK)
		recode hinc (0=25000) (1=62500) (2=87500) (3=125000) (4=175000) (5=237500) (6=312500) (7=425000) ///
					(8=650000) (999997/999999=.) 				if iso == "ESP" // - Monthly household income (PTA)
		recode hinc (1=1500) (2=4000) (3=6250) (4=8500) (5=12500) (6=17500) (7=22500) (8=27500) (9=35000) ///
					(10=45000) (11=60000) (999997/999999=.)		if iso == "FRA" // - Monthly household income (FRF)
		recode hinc (999997/999999=.) 							if iso == "GBR" // Gross annual household income (GBP)
		recode hinc (999997/999999= .)							if iso == "HUN" // Net(?) monthly household income (HUF)
		recode hinc (36400=46800) (999997/999999=.) 			if iso == "IRL" // Gross annual household income (IEP)
		recode hinc (20000=18000) (999997/999999=.) 			if iso == "JPN" // - Annual household income (Yen)
					replace hinc = hinc*1000 					if iso == "JPN"
		recode hinc (999997/999999 . = .) 						if iso == "LVA" // Net monthly household income (LVL)
		recode hinc (123000=147000) (999997/999999=.) 			if iso == "NLD" // Gross annual household income (Gld)
		recode hinc (999997/999999 . = .) 						if iso == "NOR" // Gross annual household income (NKR)
					replace hinc = hinc*1000 					if iso == "NOR" 
		recode hinc (150000=120000) (999997/999999=.) 			if iso == "NZL" // Gross annual household income (NZ$)
		recode hinc (999997/999999=.) 							if iso == "POL" // Net monthly  household income (PLN)
		recode hinc (1=15000) (2=45000) (3=80000) (4=130000) (5=230000) ///
					(6=440000) (999997/999999=.) 				if iso == "PRT" // Net monthly household income (PTE)
		recode hinc (999997/999999=.) 							if iso == "SVK" // Net monthly household income (SKK)
		recode hinc (999997/999999 = .) 						if iso == "SVN" // Net monthly household income (SIT)
					replace hinc = hinc*1000					if iso == "SVN" 
		recode hinc (999997/999999 = .) 						if iso == "SWE" // Gross monthly household income (Skr)
		recode hinc (999996=130000) (999997/999999 =.) 			if iso == "USA" // Gross annual household income (US$)
		replace hinc = hinc*12 if inlist(iso,"AUT","CHE","CZE","DEU","ESP","FRA") | ///
								  inlist(iso,"HUN","LVA","POL","PRT","SVK","SVN","SWE") 
		replace hinc = hinc / euro_conversion if inlist(iso,"AUT","DEU","ESP","FRA","IRL") | ///
												 inlist(iso,"NLD","PRT","LVA","SVK","SVN")			
		
	gen rinc = rincome 
		recode rinc (999997/999999 = .) 								if iso == "AUS" // gross, annual
		recode rinc (4000 = 2500) (32500 = 35000) (999997/999999=.) 	if iso == "AUT" // net, monthly
		recode rinc (1=7500) (2=20000) (3=30000) (4=40000) (5=50000) (6=60000) ///
					(7=70000) (8=85000) (9=.) 							if iso == "CAN"	// gross, annual
		recode rinc (. = .)												if iso == "CHE" // net, monthly
		recode rinc (999997/999999 = .)									if iso == "CZE" // net, monthly
		recode rinc (999997/999999 = .)									if iso == "DEU" // net, monthly
		recode rinc (1=  50000) (2= 125000) (3= 175000) (4= 225000) (5= 275000) (6= 350000) (7= 450000) (8= 550000) (9= 700000) ///
					(96/99=.) 											if iso == "DNK"	// gross, annual	
		recode rinc (0=25000) (1=62500) (2=87500) (3=125000) (4=175000) (5=237500) (6=312500) (7=425000) ///
					(8=650000) (999997/999999 = .)						if iso == "ESP" // -, monthly
		recode rinc	(1=1500) (2=4000) (3=6250) (4=8500) (5=12500) (6=17500) (7=22500) (8=27500) (9=35000) (10=45000) ///
					(11=60000)(999997/999999 = .)						if iso == "FRA" // - , monthly
		recode rinc (999997/999999 = .)									if iso == "GBR" // gross, annual	
		recode rinc (999997/999999 = .)									if iso == "HUN" // net, monthly
		recode rinc (36400=46800) (999997/999999 = .)					if iso == "IRL" // gross, annual
		recode rinc (20000=18000) (999997/999999 = .)					if iso == "JPN" // - , annual
					replace rinc = rinc*1000							if iso == "JPN"
		recode rinc (999997/999999 = .)									if iso == "LVA" // net, monthly
		recode rinc (999997/999999 = .)									if iso == "NOR" // gross, annual
					replace rinc = rinc*1000 							if iso == "NOR"
		recode rinc (. = .)												if iso == "NZL" // gross, annual
		recode rinc (999997/999999 = .)									if iso == "POL" // net, monthly
		recode rinc (1=15000) (2=45000) (3=80000) (4=130000) (5=230000) ///
					(6=440000) (999997/999999 = .)						if iso == "PRT" // net, monthly
		recode rinc (. = .)												if iso == "SVK" // net, monthly
		recode rinc (999997/999999 = .)									if iso == "SVN" // net, monthly
					replace rinc = rinc*1000							if iso == "SVN" 
		recode rinc (999997/999999 = .)									if iso == "SWE" // gross, monthly
		recode rinc (999996=130000) (999997/999999 =.)					if iso == "USA" // gross, annual
		replace rinc = rinc*12 if inlist(iso,"AUT","CHE","CZE","DEU","ESP","FRA") | ///
								  inlist(iso,"HUN","LVA","POL","PRT","SVK","SVN","SWE") 
		replace rinc = rinc / euro_conversion if inlist(iso,"AUT","DEU","ESP","FRA","IRL") | ///
												 inlist(iso,"NLD","PRT","LVA","SVK","SVN")	
												 
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
	gen gross_inc  	= (inlist(iso,"CAN","DNK","GBR","IRL","NOR","NLD","NZL","SWE","USA")) 
	gen net_inc		= (inlist(iso,"AUT","CZE","CHE","HUN","LVA","SVK","PRT","SVN")) 

***	EMPLOYMENT STATUS (DUMMIES FOR UNEMPLOYED, RETIRED, FULL-TIME EMPLOYED, PART-TIME EMPLOYED, NON-EMPLOYED)
	gen unemployed =	(wrkst == 5)
	gen retired    =    (wrkst == 7)
	gen fulltime   =	(wrkst == 1)
	gen parttime   = 	(wrkst == 2 | wrkst == 3) 
	gen nonemp 	   =	(inlist(wrkst, 4, 6, 7, 8, 9, 10))
		
***	EDUCATION (TERTIARY EDUCATION=1, ISCED CATEGORIES, EDUCATION YEARS)

	gen educ_tert =  (inlist(degree, 7 ) | (inlist(degree,4) & iso =="CHE"))
	gen educ_isced = .
	recode educyrs (26/89=25) (90/96 98/9999=.) (97=0), gen(educ_years)

********************************************************************************
*** PARTY SUPPORT & VOTING
********************************************************************************

*** RETROSPECTIVE VOTING

gen vote_re = "NA_________; NA; .c; Not asked" if !inlist(iso, "AUS", "DNK", "ESP", "LVA", "NZL", "POL", "SVN") // Only asked in: AUS, DNK, ESP, LVA, NZL, POL, SVN

replace vote_re = "majorright__; LPA; 1411; Liberal Party of Australia" 								if x_prty == 101 & iso == "AUS" 
replace vote_re = "majorleft___; ALP; 1253; Australian Labor Party" 									if x_prty == 102 & iso == "AUS" 
replace vote_re = "other_______; NCP|NPA; 184; National (Country) Party | National Party of Australia" 	if x_prty == 103 & iso == "AUS" 
replace vote_re = "other_______; AD; 120; Australian Democrats"											if x_prty == 104 & iso == "AUS" 
replace vote_re = "other_______; AG; 751; Australian Greens"											if x_prty == 105 & iso == "AUS" 
replace vote_re = "radright____; ONP; 386; One Nation Party"											if x_prty == 106 & iso == "AUS" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(x_prty, 107) & iso == "AUS"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(x_prty, 109, .) & iso == "AUS" 

replace vote_re = "majorleft___; Sd; 1629; Social Democrats"	 						if dk_prty == 1 & iso == "DNK" 
replace vote_re = "other_______; RV; 211; Danish Social Liberal Party"	 				if dk_prty == 2 & iso == "DNK" 
replace vote_re = "other_______; KF; 590; Conservatives"				 				if dk_prty == 3 & iso == "DNK" 
replace vote_re = "other_______; CD; 1324; Centre Democrats"			 				if dk_prty == 4 & iso == "DNK" 
replace vote_re = "radleft_____; SF; 1644; Socialist Peoples Party"	 					if dk_prty == 5 & iso == "DNK" 
replace vote_re = "radright____; DF; 1418; Danish Peoples Party"		 				if dk_prty == 6 & iso == "DNK" 
replace vote_re = "other_______; KrF; 1331; Christian People's Party"	 				if dk_prty == 7 & iso == "DNK" 
replace vote_re = "majorright__; V; 1605; Liberal Party"	 							if dk_prty == 9 & iso == "DNK" 
replace vote_re = "radright____; FrP; 978; Progress Party"		 						if dk_prty == 10 & iso == "DNK" 
replace vote_re = "radleft_____; En-O; 306; Red-Green Alliance"	 						if dk_prty == 11 & iso == "DNK" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(dk_prty, 12) & iso == "DNK" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(dk_prty, 13) & iso == "DNK"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(dk_prty,14,97,98,99,.) & iso == "DNK" 

replace vote_re = "majorright__; PP; 645; People's Party" 								if x_vote == 2501 & iso == "ESP" 
replace vote_re = "majorleft___; PSOE; 902; Spanish Socialist Workers Party" 			if x_vote == 2503 & iso == "ESP" 
replace vote_re = "radleft_____; IU; 118; United Left" 									if x_vote == 2504 & iso == "ESP" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(x_vote, 2505, 2506, 2507) & iso == "ESP" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_vote, 2510, 2511) & iso == "ESP"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_vote, 2508, 2509, .) & iso == "ESP"

replace vote_re = "majorright__; LC; 526; Latvian Way" 									if x_vote == 2604 & iso == "LVA" 
replace vote_re = "majorleft___; TSP; 32; National Harmony Party" 						if x_vote == 2606 & iso == "LVA" 
replace vote_re = "other_______; JP; 550; New Era Party" 								if x_vote == 2607 & iso == "LVA" 
replace vote_re = "other_______; LZS; 1368; Farmers Union of Latvia" 					if x_vote == 2609 & iso == "LVA" 
replace vote_re = "other_______; DPS; 759; Democratic Party Saimnieks"					if x_vote == 2610 & iso == "LVA" 
replace vote_re = "radright____; TKL-ZP; 267; People's Movement for Latvia -- Siegerist Party" if x_vote == 2611 & iso == "LVA" 
replace vote_re = "other_______; TP; 811; People's Party"								if x_vote == 2614 & iso == "LVA" 
replace vote_re = "other_______; LSDSP; 1656; Latvian Social Democratic Workers' Party"	if x_vote == 2615 & iso == "LVA" 
replace vote_re = "radleft_____; LVP; 1042; Latvian Unity Party" 						if x_vote == 2616 & iso == "LVA" 
replace vote_re = "radright____; TB; 203; For Fatherland and Freedom" 					if x_vote == 2617 & iso == "LVA" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(x_vote, 2601, 2602, 2603, 2608, 2613, 2618) & iso == "LVA" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_vote, 2696) & iso == "LVA"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_vote, 2697, 2698, 2699, .) & iso == "LVA"

replace vote_re = "other_______; ACT; 617; ACT New Zealand"		 						if x_prty == 1901 & iso == "NZL" 
replace vote_re = "other_______; A; 1444; Alliance"				 						if x_prty == 1902 & iso == "NZL"
replace vote_re = "other_______; CD/FNZ; 774; Christian Democrat Party / Future New Zealand"	if x_prty == 1903 & iso == "NZL" 
replace vote_re = "majorleft___; LP; 878; Labour Party"		 							if x_prty == 1904 & iso == "NZL" 
replace vote_re = "majorright__; NP; 997; National Party"		 						if x_prty == 1905 & iso == "NZL" 
replace vote_re = "radright____; NZFP; 891; New Zealand First Party"					if x_prty == 1906 & iso == "NZL" 
replace vote_re = "other_______; UNZ; 917; United New Zealand"		 					if x_prty == 1907 & iso == "NZL" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 1908) & iso == "NZL" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 1911) & iso == "NZL"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 1909, 1910, .) & iso == "NZL" 

replace vote_re = "other_______; UP; 838; Labour Union"					 				if x_vote == 1601 & iso == "POL"
replace vote_re = "other_______; NCD -BdP; 1712; National Christian Democratic -- Block for Poland"	if x_vote == 1602 & iso == "POL"
replace vote_re = "other_______; KPEiR-RP; 1275; National Agreement of Pensioners and Retired of the Republic Poland"	if x_vote == 1603 & iso == "POL"
replace vote_re = "other_______; D|W|U; 1104; Democratic | Freedom | Union"				if x_vote == 1604 & iso == "POL"
replace vote_re = "majorright__; AWS; 1355; Solidarity Electoral Action"		 		if x_vote == 1605 & iso == "POL"
replace vote_re = "majorleft___; SLD; 629; Democratic Left Alliance"		 			if x_vote == 1606 & iso == "POL"
replace vote_re = "other_______; PSL; 664; Polish People's Party"			 			if x_vote == 1607 & iso == "POL"
replace vote_re = "radright____; UPR; 1549; Union of Real Politics"						if x_vote == 1608 & iso == "POL"
replace vote_re = "other_______; ROP; 148; Movement for the Reconstruction of Poland"	if x_vote == 1609 & iso == "POL"
replace vote_re = "other_______; KPEiR; 109; National Party of Pensioners and Retired"	if x_vote == 1610 & iso == "POL"
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_vote, 1696) & iso == "POL"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_vote, 1698, 1699, .) & iso == "POL" 

replace vote_re = "other_______; DS; 143; Democratic Party"								if x_vote == 1501 & iso == "SVN"
replace vote_re = "majorleft___; LDS; 1252; Liberal Democracy of Slovenia"				if x_vote == 1502 & iso == "SVN"
replace vote_re = "other_______; SLS; 16; Slovenian People's Party"						if x_vote == 1503 & iso == "SVN"
replace vote_re = "radright____; SNS; 981; Slovenian National Party"					if x_vote == 1504 & iso == "SVN"
replace vote_re = "majorright__; SDS; 179; Slovenian Democratic Party"					if x_vote == 1505 & iso == "SVN"
replace vote_re = "majorright__; SKD; 1047; Slovenian Christian Democrats (later NSI)"	if x_vote == 1506 & iso == "SVN"
replace vote_re = "majorleft___; ZLSD; 706; United List Social Democrats (previously SDP)"	if x_vote == 1507 & iso == "SVN"
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(x_vote, 1595) & iso == "SVN" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_vote, 1596) & iso == "SVN"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_vote, 1598, 1599, .) & iso == "SVN" 

***	PROSPECTIVE VOTING

gen vote_pro = "NA_________; NA; .c; Not asked" if inlist(iso, "AUS", "CAN", "CHE", "DNK", "FRA", "JPN", "LVA", "NZL") | inlist(iso, "PRT", "SWE", "USA") // Not asked in: AUS, CAN, CHE, DNK, FRA, JPN, LVA, NZL, PRT, SWE, USA

replace vote_pro = "majorleft___; SPO; 973; Social Democratic Party of Austria" 		if x_prty == 701 & iso == "AUT" 
replace vote_pro = "majorright__; OVP; 1013; Austrian People's Party" 					if x_prty == 702 & iso == "AUT" 
replace vote_pro = "radright____; FPO; 50; Freedom Party of Austria"					if x_prty == 703 & iso == "AUT" 
replace vote_pro = "other_______; Gruene; 1429; The Greens -- The Green Alternative"	if x_prty == 704 & iso == "AUT" 
replace vote_pro = "other_______; LIF; 955; Liberal Forum"								if x_prty == 705 & iso == "AUT" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 795) & iso == "AUT" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 796) & iso == "AUT"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 799, .) & iso == "AUT" 

replace vote_pro = "other_______; KDU-CSL; 1245; Christian Democratic Union -- People's Party"	if x_prty == 1401 & iso == "CZE"
replace vote_pro = "other_______; DU; 1616; Democratic Union" 							if x_prty == 1404 & iso == "CZE"
replace vote_pro = "majorright__; ODS; 829; Civic Democratic Party"						if x_prty == 1405 & iso == "CZE"
replace vote_pro = "majorleft___; CSSD; 789; Czech Social Democratic Party" 			if x_prty == 1407 & iso == "CZE"
replace vote_pro = "radleft_____; KSCM; 1173; Communist Party of Bohemia and Moravia"	if x_prty == 1409 & iso == "CZE"
replace vote_pro = "radright____; SPR-RSC; 872; Rally for the Republic -- Republican Party of Czechoslovakia"  if x_prty == 1410 & iso == "CZE"
replace vote_pro = "other_______; US; 688; Freedom Union" 								if x_prty == 1411 & iso == "CZE"
replace vote_pro = "other_______; DZJ; 77; Pensioners for a Secure Living" 				if x_prty == 1412 & iso == "CZE"
replace vote_pro = "other_______; CNSP; 29; Czech National Social(ist) Party" 			if x_prty == 1413 & iso == "CZE"
replace vote_pro = "other_______; ODA; 1123; Civic Democratic Alliance" 				if x_prty == 1417 & iso == "CZE"
replace vote_pro = "other_______; SZ; 196; Green Party" 								if x_prty == 1418 & iso == "CZE"
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 1402, 1403, 1406, 1408, 1495) & iso == "CZE" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 1496) & iso == "CZE"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 1497, 1498, 1499, .) & iso == "CZE" 

replace vote_pro = "majorright__; CDU+CSU; 1727; Christian Democratic Union / Christian Social Union" 	if inlist(x_prty, 201, 301) & iso == "DEU" 
replace vote_pro = "majorleft___; SPD; 558; Social Democratic Party of Germany" 						if inlist(x_prty, 202, 302) & iso == "DEU" 
replace vote_pro = "other_______; FDP; 543; Free Democratic Party" 										if inlist(x_prty, 203, 303) & iso == "DEU" 
replace vote_pro = "other_______; B90/Gru; 772; Alliance 90 / Greens"									if inlist(x_prty, 204, 304) & iso == "DEU" 
replace vote_pro = "radright____; Rep; 524; The Republicans"											if inlist(x_prty, 207, 307) & iso == "DEU" 
replace vote_pro = "radleft_____; PDS|Li; 791; PDS | The Left"											if inlist(x_prty, 208, 308) & iso == "DEU" 
replace vote_pro = "other_______; others; -90; Other parties, independents"								if inlist(x_prty, 295, 395) & iso == "DEU" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"					if inlist(x_prty, 296, 396) & iso == "DEU"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"						if inlist(x_prty, 200, 297, 298, 300, 397, 398, .) & iso == "DEU"

replace vote_pro = "majorright__; PP; 645; People's Party" 								if x_prty == 2501 & iso == "ESP" 
replace vote_pro = "majorleft___; PSOE; 902; Spanish Socialist Workers Party" 			if x_prty == 2503 & iso == "ESP" 
replace vote_pro = "radleft_____; IU; 118; United Left" 								if x_prty == 2504 & iso == "ESP" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 2505, 2506, 2507, 2508, 2513) & iso == "ESP" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 2509, 2510) & iso == "ESP"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 2511, 2512, .) & iso == "ESP"

replace vote_pro = "majorright__; Con; 773; Conservatives" 								if x_prty == 401 & iso == "GBR" 
replace vote_pro = "majorleft___; Lab; 1556; Labour" 									if x_prty == 402 & iso == "GBR" 
replace vote_pro = "other_______; Lib; 659; Liberals" 									if x_prty == 403 & iso == "GBR" 
replace vote_pro = "other_______; SNP; 1284; Scottish National Party" 					if x_prty == 406 & iso == "GBR" 
replace vote_pro = "other_______; Plaid; 311; Plaid Cymru" 								if x_prty == 407 & iso == "GBR" 
replace vote_pro = "other_______; GP; 467; Green Party" 								if x_prty == 408 & iso == "GBR" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 493, 495) & iso == "GBR" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 496) & iso == "GBR"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 497, 498, .) & iso == "GBR"

replace vote_pro = "majorleft___; MSZP; 1591; Hungarian Socialist Party" 				if x_prty == 801 & iso == "HUN" 
replace vote_pro = "other_______; SzDSz; 1426; Alliance of Free Democrats" 				if x_prty == 802 & iso == "HUN" 
replace vote_pro = "majorright__; MDF; 546; Hungarian Democratic Forum" 				if x_prty == 803 & iso == "HUN" 
replace vote_pro = "majorright__; Fi-MPSz; 921; Fidesz -- Hungarian Civic Union" 		if x_prty == 804 & iso == "HUN" 
replace vote_pro = "radright____; KDNP; 434; Christian Democratic People's Party" 		if x_prty == 805 & iso == "HUN" 
replace vote_pro = "other_______; FKgP; 870; Independent Small Holders Party" 			if x_prty == 806 & iso == "HUN" 
replace vote_pro = "radleft_____; MMP; 1202; Hungarian Workers' Party" 					if x_prty == 808 & iso == "HUN" 
replace vote_pro = "radright____; MIEP; 95; Hungarian Justice and Life Party" 			if x_prty == 810 & iso == "HUN" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 895) & iso == "HUN" 
//	replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 0) & iso == "HUN" // not available -> missing category
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 897, .) & iso == "HUN"

replace vote_pro = "majorright__; FF; 280; Fianna Fail" 								if irl_prty == 1 & iso == "IRL" 
replace vote_pro = "majorright__; FG; 1393; Fine Gael (Familiy of the Irish)" 			if irl_prty == 2 & iso == "IRL" 
replace vote_pro = "majorleft___; Lab; 318; Labour Party" 								if irl_prty == 3 & iso == "IRL" 
replace vote_pro = "radleft_____; TWP; 433; The Workers' Party" 						if irl_prty == 4 & iso == "IRL" 
replace vote_pro = "other_______; PD; 651; Progressive Democrats" 						if irl_prty == 5 & iso == "IRL" 
replace vote_pro = "other_______; Green; 1573; Green Party" 							if irl_prty == 6 & iso == "IRL" 
replace vote_pro = "radleft_____; SF; 2217; Sinn Fein" 									if irl_prty == 7 & iso == "IRL" 
replace vote_pro = "other_______; DLP; 1580; Democratic Left" 							if irl_prty == 8 & iso == "IRL" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(irl_prty, 9,95) & iso == "IRL" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(irl_prty, 96) & iso == "IRL"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(irl_prty, 97,98,.) & iso == "IRL"

replace vote_pro = "majorleft___; PvdA; 742; Social Democratic Workers' Party"			if nl_prty == 1 & iso == "NLD" 
replace vote_pro = "majorright__; VVD; 1409; People's Party for Freedom and Democracy"	if nl_prty == 2 & iso == "NLD" 
replace vote_pro = "majorright__; CDA; 235; Christian Democratic Appeal" 				if nl_prty == 6 & iso == "NLD" 
replace vote_pro = "other_______; D66; 345; Democrats 66"								if nl_prty == 8 & iso == "NLD" 
replace vote_pro = "other_______; SGP; 1251; Social Reformed Party"						if nl_prty == 13 & iso == "NLD" 
replace vote_pro = "other_______; RPF; 212; Reformatory Political Federation"			if nl_prty == 15 & iso == "NLD" 
replace vote_pro = "other_______; GL; 756; GreenLeft"									if nl_prty == 25 & iso == "NLD" 
replace vote_pro = "radright____; CD; 209; Centre Democrats"							if nl_prty == 28 & iso == "NLD" 
replace vote_pro = "radleft_____; SP; 357; Socialist Party"								if nl_prty == 29 & iso == "NLD" 
replace vote_pro = "other_______; AOV; 112; General Senior Union"						if nl_prty == 31 & iso == "NLD" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(nl_prty, 21, 30) & iso == "NLD" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(nl_prty, 19) & iso == "NLD"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(nl_prty, 20,98,.) & iso == "NLD"

replace vote_pro = "radleft_____; RV; 1638; Red Electoral Alliance" 					if x_prty == 1201 & iso == "NOR" 
replace vote_pro = "majorleft___; DNA; 104; Norwegian Labour Party" 					if x_prty == 1202 & iso == "NOR" 
replace vote_pro = "radright____; Fr; 351; Progress Party" 								if x_prty == 1203 & iso == "NOR" 
replace vote_pro = "majorright__; H; 1435; Conservative Party" 							if x_prty == 1204 & iso == "NOR" 
replace vote_pro = "other_______; KrF; 1538; Christian Democratic Party" 				if x_prty == 1205 & iso == "NOR" 
replace vote_pro = "other_______; Sp; 702; Centre Party" 								if x_prty == 1206 & iso == "NOR" 
replace vote_pro = "radleft_____; SV; 81; Socialist Left Party" 						if x_prty == 1207 & iso == "NOR" 
replace vote_pro = "other_______; V; 647; Liberal Party of Norway" 						if x_prty == 1208 & iso == "NOR" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 1295) & iso == "NOR" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 1296) & iso == "NOR"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 1298, 1299, .) & iso == "NOR"

replace vote_pro = "majorright__; AWS; 1355; Solidarity Electoral Action"		 		if x_prty == 1601 & iso == "POL"
replace vote_pro = "other_______; NCD -BdP; 1712; National Christian Democratic -- Block for Poland"	if x_prty == 1602 & iso == "POL"
replace vote_pro = "other_______; KPEiR; 109; National Party of Pensioners and Retired"	if x_prty == 1603 & iso == "POL"
replace vote_pro = "other_______; KPEiR-RP; 1275; National Agreement of Pensioners and Retired of the Republic Poland"	if x_prty == 1604 & iso == "POL"
replace vote_pro = "other_______; PSL; 664; Polish People's Party"			 			if x_prty == 1605 & iso == "POL"
replace vote_pro = "other_______; ROP; 148; Movement for the Reconstruction of Poland"	if x_prty == 1607 & iso == "POL"
replace vote_pro = "majorleft___; SLD; 629; Democratic Left Alliance"		 			if x_prty == 1608 & iso == "POL"
replace vote_pro = "radright____; UPR; 1549; Union of Real Politics"					if x_prty == 1609 & iso == "POL"
replace vote_pro = "other_______; UP; 838; Labour Union"					 			if x_prty == 1610 & iso == "POL"
replace vote_pro = "other_______; D|W|U; 1104; Democratic | Freedom | Union"			if x_prty == 1611 & iso == "POL"
replace vote_pro = "radright____; SRP; 207; Self-Defense of the Republic Poland"		if x_prty == 1612 & iso == "POL"
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 1606, 1695) & iso == "POL" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 1696) & iso == "POL"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 1698, 1699, .) & iso == "POL" 

replace vote_pro = "popcentre___; ANO; 1200; Alliance of the New Citizen"				if x_prty == 3301 & iso == "SVK" 
replace vote_pro = "other_______; DS; 1000; Democratic Party"							if x_prty == 3302 & iso == "SVK" 
replace vote_pro = "majorright__; HZDS; 1142; Movement for a Democratic Slovakia"		if x_prty == 3303 & iso == "SVK" 
replace vote_pro = "radleft_____; KSS; 44; Communist Party of Slovakia"					if x_prty == 3304 & iso == "SVK" 
replace vote_pro = "other_______; KDH; 1432; Christian Democratic Movement"				if x_prty == 3305 & iso == "SVK" 
replace vote_pro = "majorright__; SDKU; 131; Slovak Democratic and Christian Union"		if x_prty == 3307 & iso == "SVK" 
replace vote_pro = "radright____; SNS; 1072; Slovak National Party"						if x_prty == 3308 & iso == "SVK" 
replace vote_pro = "popcentre___; Smer; 220; Direction -- Social Democracy"				if x_prty == 3309 & iso == "SVK" 
replace vote_pro = "other_______; SDSS; 1651; Social Democratic Party of Slovakia"		if x_prty == 3310 & iso == "SVK" 
replace vote_pro = "majorleft___; SDL; 1415; Party of the Democratic Left"				if x_prty == 3312 & iso == "SVK" 
replace vote_pro = "other_______; SMK-MKP; 559; Party of the Hungarian Coalition"		if x_prty == 3313 & iso == "SVK" 
replace vote_pro = "other_______; SOP; 1016; Party of Civic Understanding"				if x_prty == 3314 & iso == "SVK" 
replace vote_pro = "other_______; SZS; 874; Green Party"								if x_prty == 3315 & iso == "SVK" 
replace vote_pro = "radleft_____; ZRS; 1563; Association of Workers of Slovakia"		if x_prty == 3316 & iso == "SVK" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 3311, 3317) & iso == "SVK" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 3318) & iso == "SVK"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 3319, .) & iso == "SVK" 

replace vote_pro = "other_______; DS; 143; Democratic Party"							if x_prty == 1501 & iso == "SVN"
replace vote_pro = "other_______; DeSUS; 1587; Democratic Party of Pensioners of Slovenia"	if x_prty == 1502 & iso == "SVN"
replace vote_pro = "majorleft___; LDS; 1252; Liberal Democracy of Slovenia"				if x_prty == 1503 & iso == "SVN"
replace vote_pro = "other_______; SLS; 16; Slovenian People's Party"					if x_prty == 1504 & iso == "SVN"
replace vote_pro = "radright____; SNS; 981; Slovenian National Party"					if x_prty == 1505 & iso == "SVN"
replace vote_pro = "majorright__; SDS; 179; Slovenian Democratic Party"					if x_prty == 1506 & iso == "SVN"
replace vote_pro = "majorright__; SKD; 1047; Slovenian Christian Democrats (later NSI)"	if x_prty == 1507 & iso == "SVN"
replace vote_pro = "majorleft___; ZLSD; 706; United List Social Democrats (previously SDP)"	if x_prty == 1508 & iso == "SVN"
replace vote_pro = "other_______; ZS; 1619; Greens of Slovenia"							if x_prty == 1509 & iso == "SVN"
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 1595) & iso == "SVN" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 1596) & iso == "SVN"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 1598, .) & iso == "SVN" 

*** PARTY AFFILIATION

gen aff = "NA_________; NA; .c; Not asked" if !inlist(iso, "CAN", "CHE", "FRA", "JPN", "LVA", "PRT", "SWE", "USA") // Only asked in CAN, CHE, FRA, JPN, LVA, PRT, SWE, USA

replace aff = "radright____; RPC; 897; Reform Party of Canada"				 		if x_prty == 2001 & iso == "CAN" 
replace aff = "majorright__; PCP; 794; Progressive Conservative Party of Canada" 	if x_prty == 2002 & iso == "CAN" 
replace aff = "majorleft___; LP; 368; Liberal Party of Canada" 						if x_prty == 2003 & iso == "CAN"
replace aff = "other_______; NDP; 296; New Democratic Party" 						if x_prty == 2004 & iso == "CAN"
replace aff = "other_______; BQ; 448; Quebec Bloc" 									if x_prty == 2005 & iso == "CAN"
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 2006) & iso == "CAN" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 2008) & iso == "CAN"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 2009, .) & iso == "CAN" 

replace aff = "majorright__; FDP-PRD; 26; Radical Democratic Party" 				  		if ch_prty == 1 & iso == "CHE" 
replace aff = "majorright__; CVP; 531; Christian Democratic Peoples Party"			  		if ch_prty == 2 & iso == "CHE" 
replace aff = "other_______; CsP-PCS; 1012; Christian Social Party"					  		if ch_prty == 3 & iso == "CHE" 
replace aff = "radright____; SVP-UDC; 750; Swiss People's Party"					  		if ch_prty == 4 & iso == "CHE" 
replace aff = "majorleft___; SP-PS; 35; Social Democratic Party of Switzerland"		  		if ch_prty == 5 & iso == "CHE" 
replace aff = "other_______; LPS; 458; Liberal Party of Switzerland"				  		if ch_prty == 6 & iso == "CHE" 
replace aff = "other_______; EVP-PEP; 602; Protestant Peoples Party"				  		if ch_prty == 7 & iso == "CHE" 
replace aff = "other_______; LdU-ADI; 1264; Independents Alliance"							if ch_prty == 8 & iso == "CHE" 
replace aff = "other_______; Grue; 141; Greens"												if ch_prty == 9 & iso == "CHE" 
replace aff = "radleft_____; PdA; 1167; Swiss Party of Labour"								if ch_prty == 11 & iso == "CHE" 
replace aff = "radright____; FPS; 1602; Automobile Party | Freedom Party of Switzerland"	if ch_prty == 12 & iso == "CHE" 
replace aff = "radright____; SD; 628; Swiss Democrats"										if ch_prty == 13 & iso == "CHE" 
replace aff = "other_______; EDU-UDF; 1318; Federal Democratic Union of Switzerland"		if ch_prty == 14 & iso == "CHE" 
replace aff = "radright____; LdT; 1500; Ticino League"										if ch_prty == 15 & iso == "CHE" 
replace aff = "other_______; others; -90; Other parties, independents"						if inlist(ch_prty, 16) & iso == "CHE" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"			if inlist(ch_prty, 97) & iso == "CHE"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"				if inlist(ch_prty, .,.a) & iso == "CHE" 

replace aff = "radleft_____; PCF; 686; French Communist Party" 						if x_prty == 2701 & iso == "FRA" 
replace aff = "radleft_____; LO; 1176; Workers' Struggle" 							if x_prty == 2702 & iso == "FRA" 
replace aff = "majorleft___; PS; 1539; Socialist Party" 							if x_prty == 2703 & iso == "FRA" 
replace aff = "other_______; V; 873; Greens" 										if x_prty == 2704 & iso == "FRA" 
replace aff = "other_______; UDF; 509; Union for French Democracy" 					if x_prty == 2705 & iso == "FRA" 
replace aff = "majorright__; RPR; 138; Rally for the Republic" 						if x_prty == 2706 & iso == "FRA"
replace aff = "radright____; FN; 270; National Front" 								if x_prty == 2707 & iso == "FRA" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 2708) & iso == "FRA" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 2709) & iso == "FRA"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 2700, .) & iso == "FRA"

replace aff = "majorright__; LDP; 1193; Liberal Democratic Party" 					if x_prty == 2401 & iso == "JPN" 
replace aff = "majorleft___; DPJ; 439; Democratic Party of Japan" 					if x_prty == 2402 & iso == "JPN" 
replace aff = "other_______; LP; 462; Liberal Party"		 						if x_prty == 2403 & iso == "JPN" 
replace aff = "other_______; K; 837; Komeito Party"			 						if x_prty == 2404 & iso == "JPN" 
replace aff = "radleft_____; JCP; 1540; Japan Communist Party" 						if x_prty == 2405 & iso == "JPN" 
replace aff = "majorleft___; JSP; 940; Japan Socialist Party" 						if x_prty == 2406 & iso == "JPN" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 2407, 2408) & iso == "JPN" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 2409) & iso == "JPN"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 2499, .) & iso == "JPN"

replace aff = "other_______; K; 1351; Conservative Party" 							if x_prty == 2603 & iso == "LVA" 
replace aff = "majorright__; LC; 526; Latvian Way" 									if x_prty == 2604 & iso == "LVA" 
replace aff = "majorleft___; TSP; 32; National Harmony Party" 						if x_prty == 2606 & iso == "LVA" 
replace aff = "other_______; JP; 550; New Era Party" 								if x_prty == 2607 & iso == "LVA" 
replace aff = "other_______; LZS; 1368; Farmers Union of Latvia" 					if x_prty == 2609 & iso == "LVA" 
replace aff = "other_______; DPS; 759; Democratic Party Saimnieks"					if x_prty == 2610 & iso == "LVA" 
replace aff = "radright____; TKL-ZP; 267; People's Movement for Latvia -- Siegerist Party" if x_prty == 2611 & iso == "LVA" 
replace aff = "other_______; TP; 811; People's Party"								if x_prty == 2614 & iso == "LVA" 
replace aff = "other_______; LSDSP; 1656; Latvian Social Democratic Workers' Party"	if x_prty == 2615 & iso == "LVA" 
replace aff = "radleft_____; LVP; 1042; Latvian Unity Party" 						if x_prty == 2616 & iso == "LVA" 
replace aff = "radright____; TB/LNNK; 521; For Fatherland and Freedom / LNNK" 		if x_prty == 2617 & iso == "LVA" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 2601, 2605, 2608, 2618, 2619, 2620) & iso == "LVA" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 2697) & iso == "LVA"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 2698, 2699, .) & iso == "LVA"

replace aff = "radleft_____; BE; 557; Bloc of the Left"		 						if x_prty == 2901 & iso == "PRT" 
replace aff = "other_______; CDS-PP; 251; Democratic and Social Centre -- People's Party"	if x_prty == 2902 & iso == "PRT" 
replace aff = "radleft_____; CDU; 1295; Unified Democratic Coalition"				if x_prty == 2903 & iso == "PRT" 
replace aff = "majorright__; PSD; 1273; Social Democratic Party"					if x_prty == 2905 & iso == "PRT" 
replace aff = "majorleft___; PS; 725; Socialist Party"								if x_prty == 2906 & iso == "PRT" 
replace aff = "radleft_____; PSR; 998; Revolutionary Socialist Party"				if x_prty == 2907 & iso == "PRT" 
replace aff = "radleft_____; UDP; 260; Popular Democratic Union"					if x_prty == 2908 & iso == "PRT" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 2909) & iso == "PRT" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 2910) & iso == "PRT"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 2998, 2999, .) & iso == "PRT" 

replace aff = "other_______; C; 1461; Centre Party"									if x_prty == 1301 & iso == "SWE"
replace aff = "other_______; FP; 892; Liberal People's Party"						if x_prty == 1302 & iso == "SWE"
replace aff = "other_______; KD; 282; Christian Democrats"							if x_prty == 1303 & iso == "SWE"
replace aff = "other_______; MP; 1154; Greens"										if x_prty == 1304 & iso == "SWE"
replace aff = "majorright__; M; 657; Moderate Party"								if x_prty == 1305 & iso == "SWE"
replace aff = "majorleft___; SAP; 904; Social Democrats"							if x_prty == 1306 & iso == "SWE"
replace aff = "radleft_____; V; 882; Left Party"									if x_prty == 1307 & iso == "SWE"
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(x_prty, 1395) & iso == "SWE" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 1396) & iso == "SWE"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 1399, .) & iso == "SWE"

replace aff = "majorleft___; Dem; -1; Democratic Party" 			if inlist(x_prty, 601, 602, 603) & iso == "USA" 
replace aff = "majorright__; Rep; -2; Republican Party" 			if inlist(x_prty, 605, 606, 607) & iso == "USA" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(x_prty, 604, 695) & iso == "USA" // USA: Independents and other parties as "abstain"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(x_prty, 600, .) & iso == "USA" 

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
	
	rename class subjclass
	gen class = .
	recode union (1=1) (2=0) (-9 9=.)
	gen region = .
	gen urban = .
