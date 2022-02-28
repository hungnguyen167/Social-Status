use "DATASETS/ISSP 2009/ZA5400_v4-0-0.dta", clear
append using "DATASETS/ISSP 2009/ZA5389_v1-0-0.dta"
append using "DATASETS/ISSP 2009/ZA5995_v1-0-0.dta"
	gen wave = 2009
		gen survey = "ISSP"
		gen year = wave
		gen weight = WEIGHT
	rename V5 iso3n
	merge m:m iso3n using Countrynames.dta, nogen keep(match)
		keep if inlist(iso, "AUS","AUT","BEL","CAN","CHE","CZE","DEU","DNK","ESP") | ///
				inlist(iso, "EST","FIN","FRA","GBR","GRC","HUN","IRL","ISL","ITA") | ///
				inlist(iso, "JPN","LTU","LUX","LVA","NLD","NOR","NZL","POL","PRT") | ///
				inlist(iso, "SVK","SVN","SWE","USA")
	replace year = 2008 if inlist(country, "Switzerland", "Czech Republic")
	replace year = 2010 if inlist(country, "Australia", "Austria", "Germany","Iceland","Norway", "USA", "Poland","Estonia")
	replace year = 2011 if inlist(country, "Italy", "Lithuania")
	replace year = 2013 if inlist(country, "Netherlands")
	replace weight = 1 if iso == "CAN"
	
	merge m:m country year using "Data Reference materials/CPI_PPPEuroconversion_January.dta", nogen keep(match)

********************************************************************************
*** REDISTRIBUTION
********************************************************************************

	recode V33 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9 .a .b .c=.), gen(redist3)
    recode V32 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9 .a .b .c=.), gen(incdiff)
	
	gen resp_unemp_4pt = .
	recode V34 (1=5 "Strongly agree") (2=4 "Agree") (3=3 "Neither nor") (4=2 "Disagree") (5=1 "Strongly disagree") (8 9 .a .b .c=.), gen(resp_unemp_5pt)

	gen cut_spending = .
	
	gen stfeco = .
	gen hincfel = .
	gen tax_mid_toohigh = .
	
********************************************************************************
*** HIGH-PRIORITY CONTROL VARIABLES
********************************************************************************

*** Interview year/month

	*replace year = ...
	gen month = DATEMO
		replace month = 1  if iso == "AUS" 
		replace month = 8  if iso == "AUT" 
		replace month = 5  if iso == "BEL" 
		replace month = 12 if iso == "CAN" 
		replace month = 12 if iso == "CHE" 
		replace month = 9  if iso == "CZE" 
		replace month = 8  if iso == "DEU" 
		replace month = 11 if iso == "DNK" 
		replace month = 11 if iso == "ESP" 
		replace month = 7  if iso == "EST" 
		replace month = 11 if iso == "FIN" 
		replace month = 6  if iso == "FRA" 
		replace month = 9  if iso == "GBR" 
		replace month = 11 if iso == "HUN" 
		replace month = 2  if iso == "ISL" 
		replace month = 10 if iso == "ITA" 
		replace month = 11 if iso == "JPN" 
		replace month = 1  if iso == "LTU" 
		replace month = 7  if iso == "LVA" 
		replace month = 4  if iso == "NLD" & missing(month) // all in DATEMO
		replace month = 2  if iso == "NOR" 
		replace month = 9  if iso == "NZL" 
		replace month = 7  if iso == "POL"  
		replace month = 9  if iso == "PRT" 
		replace month = 10 if iso == "SVK" 
		replace month = 5  if iso == "SVN" 
		replace month = 4  if iso == "SWE" 
		replace month = 6  if iso == "USA" 
		
	gen majorityyear = .
	gen majorityyear_dum = .
	levelsof iso, local(c1)
	qui foreach c in `c1' {		// logic: if more than 75% of respondents in one year, assign those to the "majority year"
		su year if iso == "`c'", d
		replace majorityyear = r(p50) if iso == "`c'"
		replace majorityyear_dum = (year == majorityyear) if iso == "`c'"
		su majorityyear_dum if iso == "`c'"
		replace year = majorityyear if inrange(r(mean), 0.75, 1) & iso == "`c'"
	}

*** AGE (IN YEARS)

	gen age = AGE

***	GENDER (1=FEMALE, 0=MALE)

	gen female = SEX
		recode female (2=1) (1=0) (9=.)

***	HOUSEHOLD COMPOSITION (NUMBER OF HOUSEHOLD MEMBERS)

	gen nhhmem = HOMPOP
		recode nhhmem (0 98 99=.) (13/90=12)
		recode HHCYCLE  (0 99=.) (1=1) (2 5 = 2) (6 9 =3) (11=4) (13=5) (7 95=7) // HHTODD & HHCHILDR missing for all remaining missing values for nhhmem
		replace nhhmem = HHCYCLE if missing(nhhmem) 
		replace nhhmem = 2 if (MARITAL == 1| COHAB == 1) & missing(nhhmem)
		replace nhhmem = 1 if (inrange(MARITAL,2,5) | COHAB == 2) & missing(nhhmem)
		replace nhhmem = 2 if (inrange(SPWRKST,1,10)|inrange(SPWRKTYP,1,8)|inrange(SPISCO88,1,9996)) & missing(nhhmem)
		replace nhhmem = 1 if (SPWRKST == 0|SPISCO88 == 0|SPWRKTYP==0) & missing(nhhmem)


*** HOUSEHOLD INCOME MIDPOINTS / INCOME QUINTILES

	gen hinc = .
		replace hinc = AU_INC     									if iso == "AUS" // Gross annual household income (AUS$)
			recode hinc (104000=130000) (999990/999999=.) 			if iso == "AUS"
		replace hinc = AT_INC 										if iso == "AUT" // Net monthly household income (EUR)
			recode hinc (4000=5000) (999990/999999=.) 				if iso == "AUT"
		replace hinc = BE_INC 										if iso == "BEL" // Net monthly household income (EUR)
			recode hinc (10450=12950) (999990/999999=.) 			if iso == "BEL"
		replace hinc = CA_INC 										if iso == "CAN" // Gross annual household income (Can$)
		replace hinc = CH_INC 										if iso == "CHE" // Net monthly household income (CHF)
			recode hinc (13000=14800) (999990/999999=.) 			if iso == "CHE"
		replace hinc = DE_INC 										if iso == "DEU" // Net monthly household income (EUR)
			recode hinc (999990/999999=.) 							if iso == "DEU"
		replace hinc = DK_INC 										if iso == "DNK" // Gross annual household income (DKK)
			recode hinc (1050000=1100000) (9999990/9999999=.) 		if iso == "DNK"
		replace hinc = ES_INC 										if iso == "ESP" // Net monthly household income (EUR)
			recode hinc (3000=3900) (999990/999999=.) 				if iso == "ESP"
		replace hinc = FI_INC 										if iso == "FIN" // Gross monthly household income (EUR)
			recode hinc (999990/999999=.) 							if iso == "FIN"
		replace hinc = FR_INC 										if iso == "FRA" // ? monthly household income (EUR)	
			recode hinc (8250=9000) (999990/999999=.) 				if iso == "FRA"
		replace hinc = GB_INC 										if iso == "GBR" // Gross annual household income (GBP)
			recode hinc (59000=62000) (999990/999999=.) 			if iso == "GBR"
		replace hinc = IS_INC 										if iso == "ISL" // Gross monthly household income (ISK)
			recode hinc (1300000=1400000) (9999990/9999999=.) 		if iso == "ISL"
		replace hinc = IT_INC 										if iso == "ITA" // Net monthly household income (EUR)
			recode hinc (400=375) (2400=2375) (2750=2775) ///
						(3500=3425) (4500=4425) ///
						(5500=6000) (999990/999999=.) 				if iso == "ITA"
		replace hinc = JP_INC 										if iso == "JPN" // Net? annual household income (JPY)
			recode hinc (20000000=18000000) (99999990/99999999=.) 	if iso == "JPN"
		replace hinc = NL_INC 										if iso == "NLD" // Net monthly household income (EUR)
			recode hinc (5500 = 6000) (999990/999999 = . ) 			if iso == "NLD"
		replace hinc = NO_INC 										if iso == "NOR" // Gross annual household income (NOK)
			recode hinc (99999990/99999999=.) 						if iso == "NOR"
		replace hinc = NZ_INC 										if iso == "NZL" // Gross annual household income (Nz$)
			recode hinc (999990/999999=.) 							if iso == "NZL"
		replace hinc = PT_INC 										if iso == "PRT" // Net monthly household income (EUR)
			recode hinc (2500=3500) (999990/999999=.) 				if iso == "PRT"
		replace hinc = SE_INC 										if iso == "SWE" // Gross monthly household income (SEK)
			recode hinc (999990/999999=.) 							if iso == "SWE"
		replace hinc = US_INC 										if iso == "USA" // Gross annual household income (US$)
			recode hinc (160000=170000) (999990/999999=.) 			if iso == "USA"
			
		replace hinc = EE_INC 										if iso == "EST" // Net monthly household income (EEK) 
			recode hinc (999990/999999=.) 							if iso == "EST"	
		replace hinc = CZ_INC 										if iso == "CZE" // Net monthly household income (CZK) 
			recode hinc (999990/999999=.) (97500=100000) 			if iso == "CZE" 
		replace hinc = PL_INC 										if iso == "POL" // Net monthly household income (PLN)
			recode hinc (999990/999999=.) 							if iso == "POL"
		replace hinc = HU_INC 										if iso == "HUN" // Net monthly household income (HUF) 
			recode hinc (9999990/9999999=.)  						if iso == "HUN"
		replace hinc = LV_INC 										if iso == "LVA" // Net monthly household income (LVL)
			recode hinc (999990/999999=.)    						if iso == "LVA"
		replace hinc = LT_INC 										if iso == "LTU" // Gross monthly household income (LTL)
			recode hinc (999990/999999=.)    						if iso == "LTU"		
		replace hinc = SK_INC 										if iso == "SVK" // Net monthly household income (EUR)
			recode hinc (999990/999999=.) (3000=4000)    			if iso == "SVK"
		replace hinc = SI_INC 										if iso == "SVN" // Net monthly household income (EUR)
			recode hinc (999990/999999=.) 							if iso == "SVN"
		replace hinc = hinc*12 if iso == "AUT" | iso == "BEL" | iso == "CHE" | iso == "DEU" | iso == "ESP" | iso == "FIN" | iso == "FRA" | iso == "ITA" | iso == "ISL" | iso == "PRT" | iso == "SWE"
		replace hinc = hinc*12 if iso == "EST" | iso == "CZE" | iso == "POL" | iso == "HUN" | iso == "LVA" | iso == "LTU" | iso == "POL" | iso == "SVK" | iso == "SVN" | iso =="NLD"
		replace hinc = hinc / euro_conversion if inlist(iso, "EST","LVA","LTU") 
		
	gen rinc = .
		replace rinc = AU_RINC     									if iso == "AUS" // Gross annual personal income (AUS$)
			recode rinc (104000=130000) (999990/999999=.) 			if iso == "AUS"
		replace rinc = AT_RINC 										if iso == "AUT" // Net monthly personal income (EUR)
			recode rinc (4000=5000) (999990/999999=.) 				if iso == "AUT"
		replace rinc = BE_RINC 										if iso == "BEL" // Net monthly personal income (EUR)
			recode rinc (10450=12950) (999990/999999=.) 			if iso == "BEL"
		replace rinc = CA_RINC 										if iso == "CAN" // Gross annual personal income (Can$)
		replace rinc = CH_RINC 										if iso == "CHE" // Net monthly personal income (CHF)
			recode rinc (9500=11700) (999990/999999=.) 				if iso == "CHE"
		replace rinc = DE_RINC 										if iso == "DEU" // Net monthly personal income (EUR)
			recode rinc (999990/999999=.) 							if iso == "DEU"
		replace rinc = DK_RINC 										if iso == "DNK" // Gross annual personal income (DKK)
			recode rinc (650000=700000) (999990/999999=.) 			if iso == "DNK"
		replace rinc = ES_RINC 										if iso == "ESP" // Net monthly personal income (EUR)
			recode rinc (3000=3900) (999990/999999=.) 				if iso == "ESP"
		replace rinc = FI_RINC 										if iso == "FIN" // Gross monthly personal income (EUR)
			recode rinc (999990/999999=.) 							if iso == "FIN"
		replace rinc = FR_RINC 										if iso == "FRA" // ? monthly personal income (EUR)	
			recode rinc (8250=9000) (999990/999999=.) 				if iso == "FRA"
		replace rinc = GB_RINC 										if iso == "GBR" // Gross annual personal income (GBP)
			recode rinc (59000=62000) (999990/999999=.) 			if iso == "GBR"
		replace rinc = IS_RINC 										if iso == "ISL" // Gross monthly personal income (ISK)
			recode rinc (1100000=1200000) (9999990/9999999=.) 		if iso == "ISL"
		replace rinc = IT_RINC 										if iso == "ITA" // Net monthly personal income (EUR)
			recode rinc (700=675) (1100=1125) (1300=1325) ///
						(2300=2275) (3000=2950) (3700=3650) ///
						(5000=4700) (999990/999999=.) 				if iso == "ITA"
		replace rinc = JP_RINC 										if iso == "JPN" // Net? annual personal income (JPY)
			recode rinc (20000000=18000000) (99999990/99999999=.) 	if iso == "JPN"
		replace rinc = NL_RINC 										if iso == "NLD" // Net monthly personal income (EUR)
			recode rinc (5500 = 6000) (999990/999999 = . ) 			if iso == "NLD"
		replace rinc = NO_RINC 										if iso == "NOR" // Gross annual personal income (NOK)
			recode rinc (99999990/99999999=.) 						if iso == "NOR"
		replace rinc = NZ_RINC 										if iso == "NZL" // Gross annual personal income (Nz$)
			recode rinc (120000= 130000) (999990/999999=.) 			if iso == "NZL"
		replace rinc = PT_RINC 										if iso == "PRT" // Net monthly personal income (EUR)
			recode rinc (2500=3500) (999990/999999=.) 				if iso == "PRT"
		replace rinc = SE_RINC 										if iso == "SWE" // Gross monthly personal income (SEK)
			recode rinc (999990/999999=.) 							if iso == "SWE"
		replace rinc = US_RINC 										if iso == "USA" // Gross annual personal income (US$)
			recode rinc (160000=170000) (999990/999999=.) 			if iso == "USA"
			
		replace rinc = EE_RINC 										if iso == "EST" // Net monthly personal income (EEK) 
			recode rinc (999990/999999=.) 							if iso == "EST"	
		replace rinc = CZ_RINC 										if iso == "CZE" // Net monthly personal income (CZK) 
			recode rinc (77500=90000) (999990/999999=.) 			if iso == "CZE" 
		replace rinc = PL_RINC 										if iso == "POL" // Net monthly personal income (PLN)
			recode rinc (999990/999999=.) 							if iso == "POL"
		replace rinc = HU_RINC 										if iso == "HUN" // Net monthly personal income (HUF) 
			recode rinc (999990/999999=.)  							if iso == "HUN"
		replace rinc = LV_RINC 										if iso == "LVA" // Net monthly personal income (LVL)
			recode rinc (999990/999999=.)    						if iso == "LVA"
		replace rinc = LT_RINC 										if iso == "LTU" // Gross monthly personal income (LTL)
			recode rinc (999990/999999=.)    						if iso == "LTU"		
		replace rinc = SK_RINC 										if iso == "SVK" // Net monthly personal income (EUR)
			recode rinc (999990/999999=.) (3000=4000)    			if iso == "SVK"
		replace rinc = SI_RINC 										if iso == "SVN" // Net monthly personal income (EUR)
			recode rinc (999990/999999=.) 							if iso == "SVN"
		replace rinc = rinc*12 if iso == "AUT" | iso == "BEL" | iso == "CHE" | iso == "DEU" | iso == "ESP" | iso == "FIN" | iso == "FRA" | iso == "ITA" | iso == "ISL" | iso == "PRT" | iso == "SWE"
		replace rinc = rinc*12 if iso == "EST" | iso == "CZE" | iso == "POL" | iso == "HUN" | iso == "LVA" | iso == "LTU" | iso == "POL" | iso == "SVK" | iso == "SVN" | iso =="NLD"
		replace rinc = rinc / euro_conversion if inlist(iso, "EST","LVA","LTU") 

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
	gen gross_inc  	= (inlist(iso,"AUS","CAN","DNK","FIN","GBR","ISL","NOR","NZL","SWE") | inlist(iso,"USA","LTU")) 
	gen net_inc		= (inlist(iso,"AUT","BEL","CHE","DEU","ESP","HUN","JPN","NLD","POL") | inlist(iso,"PRT","EST","CZE","LVA","SVK","SVN")) 
	
***	EMPLOYMENT STATUS (DUMMIES FOR UNEMPLOYED, RETIRED, FULL-TIME EMPLOYED, PART-TIME EMPLOYED, NON-EMPLOYED)
	
	gen unemployed = (WRKST == 5)
	gen retired    = (WRKST == 7)
	gen fulltime   = (WRKST == 1)
	gen parttime   = (WRKST == 2) | (WRKST == 3)
	gen nonemp	   = (inlist(WRKST, 4, 6, 7, 8, 9, 10))

***	EDUCATION (TERTIARY EDUCATION=1, ISCED CATEGORIES, EDUCATION YEARS)

	gen educ_tert = (inlist(DEGREE, 5,6))
	gen educ_isced = .
	recode EDUCYRS (26/89=25) (90/96 98/9999=.) (97=0), gen(educ_years)

********************************************************************************
*** PARTY SUPPORT & VOTING
********************************************************************************

*** RETROSPECTIVE VOTING

gen vote_re = "NA_________; NA; .c; Not asked" if !inlist(iso, "DNK", "ESP", "NLD", "NZL") // Only asked in: DNK, ESP, NLD, NZL

replace vote_re = "majorleft___; Sd; 1629; Social Democrats"	 						if DK_PRTY == 1 & iso == "DNK" 
replace vote_re = "other_______; RV; 211; Danish Social Liberal Party"	 				if DK_PRTY == 2 & iso == "DNK" 
replace vote_re = "other_______; KF; 590; Conservatives"				 				if DK_PRTY == 3 & iso == "DNK" 
replace vote_re = "radleft_____; SF; 1644; Socialist Peoples Party"	 					if DK_PRTY == 4 & iso == "DNK" 
replace vote_re = "other_______; CD; 1324; Centre Democrats"			 				if DK_PRTY == 5 & iso == "DNK" 
replace vote_re = "radright____; DF; 1418; Danish Peoples Party"		 				if DK_PRTY == 6 & iso == "DNK" 
replace vote_re = "majorright__; V; 1605; Liberal Party"	 							if DK_PRTY == 7 & iso == "DNK" 
replace vote_re = "other_______; LA; 376; Liberal Alliance"	 							if DK_PRTY == 8 & iso == "DNK" 
replace vote_re = "radleft_____; En-O; 306; Red-Green Alliance"	 						if DK_PRTY == 9 & iso == "DNK" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(DK_PRTY, 96) & iso == "DNK"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(DK_PRTY, 0, 98, 99, .) & iso == "DNK" 

replace vote_re = "majorright__; PP; 645; People's Party" 								if ES_PRTY == 1 & iso == "ESP" 	
replace vote_re = "majorleft___; PSOE; 902; Spanish Socialist Workers Party" 			if ES_PRTY == 2 & iso == "ESP" 
replace vote_re = "radleft_____; IU; 118; United Left" 									if ES_PRTY == 3 & iso == "ESP" 
replace vote_re = "other_______; UPyD; 551; Union, Progress and Democracy"	 			if ES_PRTY == 4 & iso == "ESP" 
replace vote_re = "other_______; CiU; 894; Convergence and Union"	 					if ES_PRTY == 5 & iso == "ESP" 
replace vote_re = "other_______; PNV; 1361; Basque Nationalist Party" 					if ES_PRTY == 6 & iso == "ESP" 
replace vote_re = "other_______; ERC; 757; Republican Left of Catalonia"	 			if ES_PRTY == 8 & iso == "ESP" 
replace vote_re = "radleft_____; BNG; 520; Galician Nationalist Bloc"					if ES_PRTY == 9 & iso == "ESP"
replace vote_re = "other_______; NaBai; 385; Navarre Yes"								if ES_PRTY == 10 & iso == "ESP"
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(ES_PRTY, 95) & iso == "ESP" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(ES_PRTY, 96) & iso == "ESP"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(ES_PRTY, 94, 98, 99, .) & iso == "ESP"

replace vote_re = "majorright__; VVD; 1409; People's Party for Freedom and Democracy"	if NL_PRTY == 1 & iso == "NLD" 
replace vote_re = "majorleft___; PvdA; 742; Social Democratic Workers' Party"			if NL_PRTY == 2 & iso == "NLD" 
replace vote_re = "radright____; PVV; 1501; Party for Freedom"							if NL_PRTY == 3 & iso == "NLD" 
replace vote_re = "majorright__; CDA; 235; Christian Democratic Appeal" 				if NL_PRTY == 4 & iso == "NLD" 
replace vote_re = "radleft_____; SP; 357; Socialist Party"								if NL_PRTY == 5 & iso == "NLD" 
replace vote_re = "other_______; D66; 345; Democrats 66"								if NL_PRTY == 6 & iso == "NLD" 
replace vote_re = "other_______; GL; 756; GreenLeft"									if NL_PRTY == 7 & iso == "NLD" 
replace vote_re = "other_______; CU; 1206; Christian Union"								if NL_PRTY == 8 & iso == "NLD" 
replace vote_re = "other_______; SGP; 1251; Social Reformed Party"						if NL_PRTY == 9 & iso == "NLD" 
replace vote_re = "other_______; PvdD; 990; Party for the Animals"						if NL_PRTY == 10 & iso == "NLD" 
replace vote_re = "other_______; 50+; 2109; 50PLUS"										if NL_PRTY == 14 & iso == "NLD" 	
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(NL_PRTY, 11) & iso == "NLD" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(NL_PRTY, 0) & iso == "NLD"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(NL_PRTY, 99, .) & iso == "NLD"

replace vote_re = "other_______; ACT; 617; ACT New Zealand"		 						if NZ_PRTY == 1 & iso == "NZL" 
replace vote_re = "other_______; A; 1444; Alliance"				 						if NZ_PRTY == 2 & iso == "NZL"
replace vote_re = "other_______; Greens; 1171; Green Party"								if NZ_PRTY == 4 & iso == "NZL"
replace vote_re = "majorleft___; LP; 878; Labour Party"		 							if NZ_PRTY == 5 & iso == "NZL" 
replace vote_re = "other_______; MP; 114; Maori Party"									if NZ_PRTY == 6 & iso == "NZL" 
replace vote_re = "majorright__; NP; 997; National Party"		 						if NZ_PRTY == 7 & iso == "NZL" 
replace vote_re = "radright____; NZFP; 891; New Zealand First Party"					if NZ_PRTY == 8 & iso == "NZL" 
replace vote_re = "other_______; PP; 354; Progressive Party"		 					if NZ_PRTY == 9 & iso == "NZL" 
replace vote_re = "other_______; UFNZ; 1313; United Future New Zealand"					if NZ_PRTY == 10 & iso == "NZL" 
replace vote_re = "other_______; others; -90; Other parties, independents"				if inlist(NZ_PRTY, 3, 95) & iso == "NZL" 
replace vote_re = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(NZ_PRTY, 96) & iso == "NZL"
replace vote_re = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(NZ_PRTY, 98, 99, .) & iso == "NZL" 

*** PROSPECTIVE VOTING

gen vote_pro = "NA_________; NA; .c; Not asked" if !inlist(iso, "AUT", "BEL", "CZE", "DEU", "FIN", "GBR", "HUN", "ITA", "NOR") & !inlist(iso, "SVK", "SVN") // Only asked in: AUT, BEL, CZE, DEU, FIN, GBR, HUN, ITA, NOR, SVK, SVN

replace vote_pro = "majorright__; OVP; 1013; Austrian People's Party" 					if AT_PRTY == 1 & iso == "AUT" 
replace vote_pro = "majorleft___; SPO; 973; Social Democratic Party of Austria" 		if AT_PRTY == 2 & iso == "AUT" 
replace vote_pro = "radright____; FPO; 50; Freedom Party of Austria"					if AT_PRTY == 3 & iso == "AUT" 
replace vote_pro = "other_______; Gruene; 1429; The Greens -- The Green Alternative"	if AT_PRTY == 4 & iso == "AUT" 
replace vote_pro = "radright____; BZO; 1536; Alliance for the Future of Austria"		if AT_PRTY == 5 & iso == "AUT" 
replace vote_pro = "radleft_____; KPO; 769; Communist Party of Austria"					if AT_PRTY == 6 & iso == "AUT" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(AT_PRTY, 95) & iso == "AUT" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(AT_PRTY, 96) & iso == "AUT"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(AT_PRTY, 0, 98, 99, .) & iso == "AUT" 

replace vote_pro = "majorright__; CD&V; 723; Christian Democrats & Flemish (before: CVP)"	if BE_PRTY == 1 & iso == "BEL" 
replace vote_pro = "other_______; Groen; 1594; Green!"				 					if BE_PRTY == 2 & iso == "BEL" 
replace vote_pro = "popcentre___; LD|LDD; 221; List Dedecker | Libertarian, Direct, Democratic"	if BE_PRTY == 3 & iso == "BEL" 
replace vote_pro = "other_______; N-VA; 501; New Flemish Alliance"						if BE_PRTY == 4 & iso == "BEL" 
replace vote_pro = "majorright__; O-VLD; 1110; Open Flemish Liberals and Democrats"		if BE_PRTY == 5 & iso == "BEL" 
replace vote_pro = "other_______; SLP; 1487; Social Liberal Party"						if BE_PRTY == 6 & iso == "BEL" 
replace vote_pro = "majorleft___; SPa; 1113; Socialist Party Different"					if BE_PRTY == 7 & iso == "BEL" 
replace vote_pro = "radright____; VB; 993; Flemish Block"								if BE_PRTY == 8 & iso == "BEL" 
replace vote_pro = "majorright__; CDH; 1192; Humanist Democratic Centre"				if BE_PRTY == 11 & iso == "BEL" 
replace vote_pro = "majorleft___; PS; 1378; Socialist Party [Francophone]"				if BE_PRTY == 13 & iso == "BEL" 
replace vote_pro = "majorright__; MR; 915; Reformist Movement"							if BE_PRTY == 14 & iso == "BEL" 
replace vote_pro = "radleft_____; PA-PTB; 256; Workers' Party of Belgium (PVDA+)"		if BE_PRTY == 15 & iso == "BEL" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(BE_PRTY, 12, 95) & iso == "BEL" 
replace vote_pro = "abstain_____; abstain; -91; Abstain (did not aff/no affiliation)"	if inlist(BE_PRTY, 10, 96) & iso == "BEL" 
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(BE_PRTY, 0, 98, 99, .) & iso == "BEL" 

replace vote_pro = "radright____; SZR; -30; Party of Common Sense"						if CZ_PRTY == 1 & iso == "CZE"
replace vote_pro = "majorright__; ODS; 829; Civic Democratic Party"						if CZ_PRTY == 9 & iso == "CZE"
replace vote_pro = "majorleft___; CSSD; 789; Czech Social Democratic Party" 			if CZ_PRTY == 10 & iso == "CZE"
replace vote_pro = "other_______; SNK-ED; 1532; SNK European Democrats" 				if CZ_PRTY == 11 & iso == "CZE"
replace vote_pro = "other_______; US; 688; Freedom Union" 								if CZ_PRTY == 12 & iso == "CZE"
replace vote_pro = "radright____; PB; 2033; Right Bloc" 								if CZ_PRTY == 14 & iso == "CZE"
replace vote_pro = "other_______; CNSP; 29; Czech National Social(ist) Party" 			if CZ_PRTY == 16 & iso == "CZE"
replace vote_pro = "other_______; SZ; 196; Green Party" 								if CZ_PRTY == 18 & iso == "CZE"
replace vote_pro = "radleft_____; KSCM; 1173; Communist Party of Bohemia and Moravia"	if CZ_PRTY == 20 & iso == "CZE"
replace vote_pro = "other_______; KDU-CSL; 1245; Christian Democratic Union -- People's Party"	if CZ_PRTY == 24 & iso == "CZE"
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(CZ_PRTY, 3, 5, 6, 7, 8, 13, 17, 19, 22, 25, 95) & iso == "CZE" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(CZ_PRTY, 96) & iso == "CZE"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(CZ_PRTY, 97, 98, 99, .) & iso == "CZE" 

replace vote_pro = "majorright__; CDU+CSU; 1727; Christian Democratic Union / Christian Social Union" 	if DE_PRTY == 1 & iso == "DEU" 
replace vote_pro = "majorleft___; SPD; 558; Social Democratic Party of Germany" 		if DE_PRTY == 2 & iso == "DEU" 
replace vote_pro = "other_______; FDP; 543; Free Democratic Party" 						if DE_PRTY == 3 & iso == "DEU" 
replace vote_pro = "radleft_____; PDS|Li; 791; PDS | The Left"							if DE_PRTY == 4 & iso == "DEU" 
replace vote_pro = "other_______; B90/Gru; 772; Alliance 90 / Greens"					if DE_PRTY == 5 & iso == "DEU" 
replace vote_pro = "radright____; NPD; 1537; National Democratic Party"					if DE_PRTY == 6 & iso == "DEU" 
replace vote_pro = "popcentre___; Pi; 865; German Pirate Party"							if DE_PRTY == 7 & iso == "DEU" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(DE_PRTY, 95) & iso == "DEU" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(DE_PRTY, 96) & iso == "DEU"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(DE_PRTY, 94, 97, 98, 99, .) & iso == "DEU"

replace vote_pro = "majorleft___; SSDP; 395; Social Democratic Party of Finland" 		if FI_PRTY == 1 & iso == "FIN" 
replace vote_pro = "majorright__; KESK; 94; Centre Party" 								if FI_PRTY == 2 & iso == "FIN" 
replace vote_pro = "majorright__; KOK; 1118; National Coalition Party" 					if FI_PRTY == 3 & iso == "FIN" 
replace vote_pro = "radleft_____; VAS; 1292; Left Alliance" 							if FI_PRTY == 4 & iso == "FIN" 
replace vote_pro = "other_______; RKP-SFP; 585; Swedish People's Party" 				if FI_PRTY == 5 & iso == "FIN" 
replace vote_pro = "other_______; VIHR; 1062; Green League" 							if FI_PRTY == 6 & iso == "FIN" 
replace vote_pro = "other_______; KD; 1463; Christian Democrats" 						if FI_PRTY == 7 & iso == "FIN" 
replace vote_pro = "radright____; Ps; 200; True Finns" 									if FI_PRTY == 8 & iso == "FIN" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(FI_PRTY, 95) & iso == "FIN" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(FI_PRTY, 96) & iso == "FIN"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(FI_PRTY, 97, 98, 99, .) & iso == "FIN"

replace vote_pro = "majorright__; Con; 773; Conservatives" 								if GB_PRTY == 1 & iso == "GBR" 
replace vote_pro = "majorleft___; Lab; 1556; Labour" 									if GB_PRTY == 2 & iso == "GBR" 
replace vote_pro = "other_______; Lib; 659; Liberals" 									if GB_PRTY == 3 & iso == "GBR" 
replace vote_pro = "other_______; SNP; 1284; Scottish National Party" 					if GB_PRTY == 6 & iso == "GBR" 
replace vote_pro = "other_______; Plaid; 311; Plaid Cymru" 								if GB_PRTY == 7 & iso == "GBR" 
replace vote_pro = "other_______; GP; 467; Green Party" 								if GB_PRTY == 8 & iso == "GBR" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(GB_PRTY, 93, 95) & iso == "GBR" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(GB_PRTY, 96) & iso == "GBR"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(GB_PRTY, 97, 98, .) & iso == "GBR"

replace vote_pro = "other_______; MDF; 546; Hungarian Democratic Forum" 				if HU_PRTY == 1 & iso == "HUN" 
replace vote_pro = "other_______; SzDSz; 1426; Alliance of Free Democrats" 				if HU_PRTY == 2 & iso == "HUN" 
replace vote_pro = "popcentre___; LMP; 403; Politics Can Be Different" 					if HU_PRTY == 3 & iso == "HUN" 
replace vote_pro = "majorleft___; MSZP; 1591; Hungarian Socialist Party" 				if HU_PRTY == 4 & iso == "HUN" 
replace vote_pro = "majorright__; Fi+KDNP; 437; Fidesz / Christian Democratic People's Party" if HU_PRTY == 5 & iso == "HUN" 
replace vote_pro = "majorright__; Fi+KDNP; 437; Fidesz / Christian Democratic People's Party" if HU_PRTY == 6 & iso == "HUN" 
replace vote_pro = "radleft_____; MMP; 1202; Hungarian Workers' Party" 					if HU_PRTY == 7 & iso == "HUN" 
replace vote_pro = "radright____; MIEP; 95; Hungarian Justice and Life Party" 			if HU_PRTY == 8 & iso == "HUN" 
replace vote_pro = "radright____; Jobbik; 600; Jobbik Movement for a Better Hungary" 	if HU_PRTY == 9 & iso == "HUN" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(HU_PRTY, 95) & iso == "HUN" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(HU_PRTY, 96) & iso == "HUN"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(HU_PRTY, 97, 99, .) & iso == "HUN"

replace vote_pro = "radleft_____; PRC; 1321; Communist Refoundation Party"			 	if IT_PRTY == 1 & iso == "ITA" 
replace vote_pro = "radleft_____; SEL; 465; Left Ecology Freedom"			 			if IT_PRTY == 2 & iso == "ITA" 
replace vote_pro = "majorleft___; PD; 382; Democratic Party"							if IT_PRTY == 3 & iso == "ITA" 
replace vote_pro = "other_______; IdV; 693; Italy of Values"					 		if IT_PRTY == 4 & iso == "ITA" 
replace vote_pro = "other_______; UdC; 226; Union of the Centre"			 			if IT_PRTY == 6 & iso == "ITA" 
replace vote_pro = "other_______; FLI; 1477; Future and Freedom for Italy"				if IT_PRTY == 7 & iso == "ITA" 
replace vote_pro = "majorright__; PdL; 596; The People of Freedom"				 		if IT_PRTY == 8 & iso == "ITA" 
replace vote_pro = "radright____; LN; 1436; North League" 								if IT_PRTY == 9 & iso == "ITA" 
replace vote_pro = "radright____; Destra; -21; The Right"		 						if IT_PRTY == 10 & iso == "ITA" 
replace vote_pro = "popcentre___; M5S; 2155; Five Star Movement"						if IT_PRTY == 11 & iso == "ITA" 
replace vote_pro = "other_______; R; 1296; Radicals"									if IT_PRTY == 12 & iso == "ITA" 
replace vote_pro = "other_______; FdV; 910; Federation of the Greens"					if IT_PRTY == 14 & iso == "ITA" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(IT_PRTY, 5, 15, 95) & iso == "ITA"
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(IT_PRTY, 17, 18, 96) & iso == "ITA"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(IT_PRTY, 97, 98, 99, .) & iso == "ITA"

replace vote_pro = "radleft_____; RV; 1638; Red Electoral Alliance" 					if NO_PRTY == 1 & iso == "NOR" 
replace vote_pro = "majorleft___; DNA; 104; Norwegian Labour Party" 					if NO_PRTY == 2 & iso == "NOR" 
replace vote_pro = "radright____; Fr; 351; Progress Party" 								if NO_PRTY == 3 & iso == "NOR" 
replace vote_pro = "majorright__; H; 1435; Conservative Party" 							if NO_PRTY == 4 & iso == "NOR" 
replace vote_pro = "other_______; KrF; 1538; Christian Democratic Party" 				if NO_PRTY == 5 & iso == "NOR" 
replace vote_pro = "other_______; Sp; 702; Centre Party" 								if NO_PRTY == 6 & iso == "NOR" 
replace vote_pro = "radleft_____; SV; 81; Socialist Left Party" 						if NO_PRTY == 7 & iso == "NOR" 
replace vote_pro = "other_______; V; 647; Liberal Party of Norway" 						if NO_PRTY == 8 & iso == "NOR" 
replace vote_pro = "other_______; others; -90; Other parties, independents"				if inlist(NO_PRTY, 95) & iso == "NOR" 
replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(NO_PRTY, 96) & iso == "NOR"
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(NO_PRTY, 98, 99, .) & iso == "NOR"

replace vote_pro = "radleft_____; KSS; 44; Communist Party of Slovakia" 				if SK_PRTY == 1 & iso == "SVK" 
replace vote_pro = "other_______; KDH; 1432; Christian Democratic Movement"				if SK_PRTY == 2 & iso == "SVK" 
replace vote_pro = "majorright__; HZDS; 1142; Movement for a Democratic Slovakia" 		if SK_PRTY == 3 & iso == "SVK" 
replace vote_pro = "other_______; MH; 1620; Most-Hid"									if SK_PRTY == 4 & iso == "SVK" 
replace vote_pro = "other_______; SaS; 1460; Freedom and Solidarity"					if SK_PRTY == 5 & iso == "SVK" 
replace vote_pro = "other_______; SF; 752; Free Forum"									if SK_PRTY == 6 & iso == "SVK" 
replace vote_pro = "majorright__; SDKU; 131; Slovak Democratic and Christian Union"		if SK_PRTY == 7 & iso == "SVK" 
replace vote_pro = "radright____; SNS; 1072; Slovak National Party"						if SK_PRTY == 8 & iso == "SVK" 
replace vote_pro = "majorleft___; Smer; 220; Direction -- Social Democracy"				if SK_PRTY == 9 & iso == "SVK" 
replace vote_pro = "other_______; SZ; 874; Green Party"									if SK_PRTY == 10 & iso == "SVK" 
replace vote_pro = "other_______; SMK; 559; Hungarian Coalition"						if SK_PRTY == 11 & iso == "SVK" 
//	replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(SK_PRTY, 96) & iso == "SVK"  // not available -> missing category
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(SK_PRTY, 0, 98, 99, .) & iso == "SVK" 

replace vote_pro = "other_______; DeSUS; 1587; Democratic Party of Pensioners of Slovenia"	if SI_PRTY == 1 & iso == "SVN" 
replace vote_pro = "majorleft___; LDS; 1252; Liberal Democracy of Slovenia"				if SI_PRTY == 2 & iso == "SVN" 
replace vote_pro = "other_______; SLS ; 16; Slovenian People's Party"					if SI_PRTY == 3 & iso == "SVN" 
replace vote_pro = "radright____; SNS; 981; Slovenian National Party"					if SI_PRTY == 4 & iso == "SVN" 
replace vote_pro = "radright____; SDS; 179; Slovenian Democratic Party"					if SI_PRTY == 5 & iso == "SVN" 
replace vote_pro = "other_______; NSI; 1047; New Slovenia -- Christian People's Party"	if SI_PRTY == 6 & iso == "SVN" 
replace vote_pro = "majorleft___; ZL-SD; 706; United List -- Social Democrats"			if SI_PRTY == 7 & iso == "SVN" 
replace vote_pro = "other_______; Zares; 326; For Real"									if SI_PRTY == 10 & iso == "SVN"
replace vote_pro = "other_______; others; -90; Other parties, independents"			   	if inlist(SI_PRTY, 95) & iso == "SVN"
//	replace vote_pro = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(SI_PRTY, 96) & iso == "SVN"  // not available -> missing category
replace vote_pro = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(SI_PRTY, 97, 98, 99, .) & iso == "SVN" 

*** PARTY AFFILIATION

gen aff = "NA_________; NA; .c; Not asked" if !inlist(iso, "AUS", "CAN", "CHE", "EST", "FRA", "ISL", "JPN", "LVA", "LTU") & !inlist(iso, "POL", "PRT", "SWE", "USA") // Only asked in: AUS, CAN, CHE, EST, FRA, ISL, JPN, LVA, LTU, POL, PRT, SWE, USA

replace aff = "majorright__; LPA; 1411; Liberal Party of Australia" 				if AU_PRTY == 1 & iso == "AUS" 
replace aff = "majorleft___; ALP; 1253; Australian Labor Party" 					if AU_PRTY == 2 & iso == "AUS" 
replace aff = "other_______; NPA; 184; National Party of Australia"				 	if AU_PRTY == 3 & iso == "AUS" 
replace aff = "other_______; AD; 120; Australian Democrats"							if AU_PRTY == 4 & iso == "AUS" 
replace aff = "other_______; AG; 751; Australian Greens"							if AU_PRTY == 5 & iso == "AUS" 
replace aff = "radright____; ONP; 386; One Nation Party"							if AU_PRTY == 6 & iso == "AUS" 
replace aff = "other_______; FFP; 446; Family First Party"							if AU_PRTY == 7 & iso == "AUS" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(AU_PRTY, 95) & iso == "AUS" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(AU_PRTY, 96) & iso == "AUS"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(AU_PRTY, 99, .) & iso == "AUS" 

replace aff = "majorright__; PCP; 794; Progressive Conservative Party of Canada" 	if CA_PRTY == 1 & iso == "CAN" 
replace aff = "majorleft___; LP; 368; Liberal Party of Canada" 						if CA_PRTY == 2 & iso == "CAN"
replace aff = "other_______; NDP; 296; New Democratic Party" 						if CA_PRTY == 3 & iso == "CAN"
replace aff = "other_______; BQ; 448; Quebec Bloc" 									if CA_PRTY == 4 & iso == "CAN"
replace aff = "other_______; GPC; 1259; Green Party of Canada" 						if CA_PRTY == 5 & iso == "CAN"
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(CA_PRTY, 8) & iso == "CAN" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(CA_PRTY, 9) & iso == "CAN"	
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(CA_PRTY, .a, .) & iso == "CAN" 	

replace aff = "majorright__; FDP-PRD; 26; Radical Democratic Party" 				if CH_PRTY == 1 & iso == "CHE" 
replace aff = "majorright__; CVP; 531; Christian Democratic Peoples Party"			if CH_PRTY == 2 & iso == "CHE" 
replace aff = "majorleft___; SP-PS; 35; Social Democratic Party of Switzerland"		if CH_PRTY == 3 & iso == "CHE" 
replace aff = "radright____; SVP-UDC; 750; Swiss People's Party"					if CH_PRTY == 4 & iso == "CHE" 
replace aff = "other_______; LPS; 458; Liberal Party of Switzerland"				if CH_PRTY == 5 & iso == "CHE" 
replace aff = "other_______; EVP-PEP; 602; Protestant Peoples Party"				if CH_PRTY == 6 & iso == "CHE" 
replace aff = "other_______; CsP-PCS; 1012; Christian Social Party"					if CH_PRTY == 7 & iso == "CHE" 
replace aff = "radleft_____; PdA; 1167; Swiss Party of Labour"						if CH_PRTY == 8 & iso == "CHE" 
replace aff = "other_______; Grue; 141; Greens"										if CH_PRTY == 9 & iso == "CHE" 
replace aff = "other_______; GLP-PVL; 308; Green Liberal Party"						if CH_PRTY == 10 & iso == "CHE" 
replace aff = "radright____; SD; 628; Swiss Democrats"								if CH_PRTY == 11 & iso == "CHE" 
replace aff = "other_______; EDU-UDF; 1318; Federal Democratic Union of Switzerland"	if CH_PRTY == 12 & iso == "CHE" 
replace aff = "radright____; LdT; 1500; Ticino League"								if CH_PRTY == 13 & iso == "CHE" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(CH_PRTY, 95) & iso == "CHE" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(CH_PRTY, 90, 96) & iso == "CHE"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(CH_PRTY, 97, .) & iso == "CHE" 

replace aff = "other_______; IRL; 1597; Union of Pro Patria and Res Publica"		if EE_PRTY == 1 & iso == "EST" 
replace aff = "majorleft___; EK; 1137; Estonian Centre Party"						if EE_PRTY == 2 & iso == "EST" 
replace aff = "majorright__; ERe; 113; Estonian Reform Party"						if EE_PRTY == 3 & iso == "EST" 
replace aff = "majorleft___; SDE|M; 1448; Social Democratic Party | Moderates"		if EE_PRTY == 4 & iso == "EST" 
replace aff = "other_______; EER; 219; Estonian Greens"								if EE_PRTY == 5 & iso == "EST" 
replace aff = "other_______; ERa; 417; People's Union of Estonia"					if EE_PRTY == 6 & iso == "EST" 
replace aff = "other_______; EKD; 609; Estonian Christian Democrats"				if EE_PRTY == 7 & iso == "EST" 
replace aff = "other_______; PK; 1553; Union of Farmers"							if EE_PRTY == 9 & iso == "EST" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(EE_PRTY, 8) & iso == "EST" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(EE_PRTY, 96) & iso == "EST"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(EE_PRTY, 98, .) & iso == "EST"

replace aff = "radleft_____; PCF; 686; French Communist Party" 						if FR_PRTY == 1 & iso == "FRA" 
replace aff = "radleft_____; LO; 1176; Workers' Struggle" 							if FR_PRTY == 2 & iso == "FRA" 
replace aff = "majorleft___; PS; 1539; Socialist Party" 							if FR_PRTY == 3 & iso == "FRA" 
replace aff = "other_______; V; 873; Greens" 										if FR_PRTY == 4 & iso == "FRA" 
replace aff = "other_______; UDF; 509; Union for French Democracy" 					if FR_PRTY == 5 & iso == "FRA" 
replace aff = "majorright__; UMP; 658; Union for a Popular Movement" 				if FR_PRTY == 6 & iso == "FRA"
replace aff = "radright____; FN; 270; National Front" 								if FR_PRTY == 7 & iso == "FRA" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(FR_PRTY, 95) & iso == "FRA" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(FR_PRTY, 96) & iso == "FRA"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(FR_PRTY, 97, 99, .) & iso == "FRA"

replace aff = "popcentre___; B-H; 587; Civic Movement -- The Movement" 				if IS_PRTY == 1 & iso == "ISL" 
replace aff = "popcentre___; B-H; 587; Civic Movement -- The Movement" 				if IS_PRTY == 2 & iso == "ISL" 
replace aff = "other_______; F; 1455; Progressive Party" 							if IS_PRTY == 3 & iso == "ISL" 
replace aff = "other_______; Ff; 506; Liberal Party" 								if IS_PRTY == 4 & iso == "ISL" 
replace aff = "majorleft___; Sam; 1006; Social Democratic Alliance" 				if IS_PRTY == 5 & iso == "ISL" 
replace aff = "majorright__; Sj; 1342; Independence Party" 							if IS_PRTY == 6 & iso == "ISL" 
replace aff = "other_______; Graen; 210; Left-Green Movement" 						if IS_PRTY == 7 & iso == "ISL" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(IS_PRTY, 8) & iso == "ISL" 
//	replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(IS_PRTY, ) & iso == "ISL"  // not available -> missing category
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(IS_PRTY, 97, 98, .) & iso == "ISL"

replace aff = "majorright__; LDP; 1193; Liberal Democratic Party" 					if JP_PRTY == 1 & iso == "JPN" 
replace aff = "majorleft___; DPJ; 439; Democratic Party of Japan" 					if JP_PRTY == 2 & iso == "JPN" 
replace aff = "other_______; K; 837; Komeito Party"			 						if JP_PRTY == 4 & iso == "JPN" 
replace aff = "radleft_____; JCP; 1540; Japan Communist Party" 						if JP_PRTY == 5 & iso == "JPN" 
replace aff = "majorleft___; JSP; 940; Japan Socialist Party" 						if JP_PRTY == 6 & iso == "JPN" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(JP_PRTY, 95) & iso == "JPN" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(JP_PRTY, 96) & iso == "JPN"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(JP_PRTY, 99, .) & iso == "JPN"

replace aff = "majorleft___; SC; 1100; Harmony Centre" 								if LV_PRTY == 2 & iso == "LVA" 
replace aff = "radright____; VL; 801; All For Latvia!" 								if LV_PRTY == 4 & iso == "LVA" 
replace aff = "other_______; PCTVL; 1520; For Human Rights in a United Latvia" 		if LV_PRTY == 5 & iso == "LVA" 
replace aff = "other_______; ZZS; 466; Green and Farmers' Union" 					if LV_PRTY == 7 & iso == "LVA" 
replace aff = "other_______; LPP/LC; 662; Latvian First Party / Latvian Way Party" 	if LV_PRTY == 9 & iso == "LVA" 
replace aff = "other_______; LSDSP; 1656; Latvian Social Democratic Workers' Party"	if LV_PRTY == 10 & iso == "LVA" 
replace aff = "other_______; JD; 1294; New Democrats"								if LV_PRTY == 13 & iso == "LVA" 
replace aff = "majorright__; TP; 811; People's Party"								if LV_PRTY == 14 & iso == "LVA" 
replace aff = "popcentre___; JL; 1518; New Era" 									if LV_PRTY == 15 & iso == "LVA" 
replace aff = "radright____; TB/LNNK; 521; For Fatherland and Freedom / LNNK" 		if LV_PRTY == 19 & iso == "LVA" 
replace aff = "other_______; PS; 445; Civic Union"									if LV_PRTY == 20 & iso == "LVA" 
replace aff = "other_______; SCP; 962; Society for Other Politics"					if LV_PRTY == 21 & iso == "LVA" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(LV_PRTY, 12, 16, 18, 22) & iso == "LVA" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(LV_PRTY, 96) & iso == "LVA"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(LV_PRTY, 97, 98, .) & iso == "LVA"

replace aff = "majorleft___; DP; 581; Labour Party" 									if LT_PRTY == 1 & iso == "LTU" 
replace aff = "other_______; LiCS; 983; Liberal and Centre Union" 						if LT_PRTY == 2 & iso == "LTU" 
replace aff = "other_______; LLRA; 28; Election Action of Lithuania's Poles" 			if LT_PRTY == 3 & iso == "LTU" 
replace aff = "other_______; LRLS; 482; Liberals Movement of the Republic of Lithuania" if LT_PRTY == 4 & iso == "LTU" 
replace aff = "majorleft___; LSDP; 1277; Lithuanian Social Democratic Party" 			if LT_PRTY == 5 & iso == "LTU" 
replace aff = "other_______; LVLS; 191; Lithuanian Peasant Union" 						if LT_PRTY == 6 & iso == "LTU" 
replace aff = "popcentre___; NS; 856; New Union (Social Liberals)" 						if LT_PRTY == 7 & iso == "LTU" 
replace aff = "popcentre___; TT; 1421; Order and Justice" 								if LT_PRTY == 8 & iso == "LTU" 
replace aff = "popcentre___; TPP; 1502; National Resurrection Party" 					if LT_PRTY == 9 & iso == "LTU" 
replace aff = "majorright__; TS-LKD; 1045; Homeland Union – Christian democrats"		if LT_PRTY == 10 & iso == "LTU" 
replace aff = "other_______; others; -90; Other parties, independents"					if inlist(LT_PRTY, 95) & iso == "LTU"
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"		if inlist(LT_PRTY, 96) & iso == "LTU"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"			if inlist(LT_PRTY, 97, .) & iso == "LTU"

replace aff = "radright____; LPR; 987; League of Polish Families"					if PL_PRTY == 1 & iso == "POL" 
replace aff = "majorleft___; LiD; 180; Left and Democrats"							if PL_PRTY == 2 & iso == "POL" 
replace aff = "majorright__; PO; 512; Civic Platform"								if PL_PRTY == 5 & iso == "POL" 
replace aff = "other_______; PSL; 664; Polish People's Party"						if PL_PRTY == 7 & iso == "POL" 
replace aff = "radright____; PiS; 528; Law and Justice"								if PL_PRTY == 8 & iso == "POL" 
replace aff = "radright____; SRP; 207; Self-Defense of the Republic Poland"			if inlist(PL_PRTY, 9, 10) & iso == "POL" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(PL_PRTY, 3, 4, 6, 95) & iso == "POL"
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(PL_PRTY, 96) & iso == "POL"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(PL_PRTY, 97, 98, 99, .) & iso == "POL" 

replace aff = "radleft_____; BE; 557; Bloc of the Left"		 						if PT_PRTY == 1 & iso == "PRT" 
replace aff = "other_______; CDS-PP; 251; Democratic and Social Centre -- People's Party"	if PT_PRTY == 2 & iso == "PRT" 
replace aff = "radleft_____; CDU; 1295; Unified Democratic Coalition"				if PT_PRTY == 3 & iso == "PRT" 
replace aff = "radleft_____; PCTP/MRPP; 281; Reorganizative Movement of the Party of the Proletariat"	if PT_PRTY == 4 & iso == "PRT" 
replace aff = "majorright__; PSD; 1273; Social Democratic Party"					if PT_PRTY == 5 & iso == "PRT" 
replace aff = "majorleft___; PS; 725; Socialist Party"								if PT_PRTY == 6 & iso == "PRT" 
replace aff = "radleft_____; PSR; 998; Revolutionary Socialist Party"				if PT_PRTY == 7 & iso == "PRT" 
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(PT_PRTY, 95) & iso == "PRT" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(PT_PRTY, 96) & iso == "PRT"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(PT_PRTY, 97, .) & iso == "PRT" 

replace aff = "other_______; C; 1461; Centre Party"									if SE_PRTY == 1 & iso == "SWE"
replace aff = "other_______; FP; 892; Liberal People's Party"						if SE_PRTY == 2 & iso == "SWE"
replace aff = "other_______; KD; 282; Christian Democrats"							if SE_PRTY == 3 & iso == "SWE"
replace aff = "other_______; MP; 1154; Greens"										if SE_PRTY == 4 & iso == "SWE"
replace aff = "majorright__; M; 657; Moderate Party"								if SE_PRTY == 5 & iso == "SWE"
replace aff = "majorleft___; SAP; 904; Social Democrats"							if SE_PRTY == 6 & iso == "SWE"
replace aff = "radright____; SD; 1546; Sweden Democrats"							if SE_PRTY == 7 & iso == "SWE"
replace aff = "radleft_____; V; 882; Left Party"									if SE_PRTY == 8 & iso == "SWE"
replace aff = "other_______; others; -90; Other parties, independents"				if inlist(SE_PRTY, 95) & iso == "SWE" 
//	replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(SE_PRTY, 96) & iso == "SWE" // not available -> missing category
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(SE_PRTY, 99, .) & iso == "SWE"

replace aff = "majorleft___; Dem; -1; Democratic Party" 			if inlist(US_PRTY, 1, 2, 3) & iso == "USA" 
replace aff = "majorright__; Rep; -2; Republican Party" 			if inlist(US_PRTY, 5, 6, 7) & iso == "USA" 
replace aff = "abstain_____; abstain; .a; Abstain (did not vote/no affiliation)"	if inlist(US_PRTY, 4, 95) & iso == "USA" // USA: Independents and other parties as "abstain"
replace aff = "missing_____; missing; .b; Don't know, no answer, not eligible"		if inlist(US_PRTY, 99, .) & iso == "USA" 

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
