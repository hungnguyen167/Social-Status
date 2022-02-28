********************************************************************************
***	LABELS & ADDITIONAL VARIABLES & SURVEY SETUP
********************************************************************************

cd "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\"
	use ESS_ISSP_DATA.dta, clear
		sort countryn year
		tab year iso		
		
***	SAMPLE DECISIONS:

	keep if inrange(age, 18, 130)
	
*** Generate auxiliary variables:

	gen iso_survey_wave = iso + "_" + survey + "_" + string(wave)
	gen survey_wave = survey + "_" + string(wave)
	gen iso_wave = iso + "_" + string(wave)
	
	egen cwave = group(iso_survey_wave)
	
	egen cyear = group(country year)
	gen time = year - 1984
	gen time2 = time^2
	gen time3 = time^3
		
***	INCOME DECILES

	qui levelsof iso, local(cn)
	qui foreach country in `cn' {
		fastxtile q10_`country' = hinc if iso == "`country'" [aw=weight], nq(10)		
	}
	egen hinc_decile = rowtotal(q10_*), miss
		
	egen cdecile = group(country hinc_decile)
	egen cyeardecile = group(country year hinc_decile)
	egen cwavedecile = group(country wave hinc_decile)
		
***	REDISTRIBUTION PREFERENCES:

	su redist* [aw=weight]
	gen redist1 = .
	gen redist4 = .
	lab var redist1 "[defunct]Support for redistribution, 1-5 ESS scale"		
	lab var redist3 "Support for redistribution, 1-5 ISSP scale"
	lab var redist4 "Support for redistribution, 1-4 ISSP scale"
	lab var incdiff "Income diff too large, 1-5 ISSP scale"

	gen redistitem = 1 if redist1 != .
		replace redistitem = 2 if redist3 != . & redistitem == .
		replace redistitem = 3 if redist4 != . & redistitem == .
	lab def redistitem 1 "ESS 5-point" 2 "ISSP 5-point" 3 "ISSP 4-point"
	lab val redistitem redistitem
	
*	drop if redistitem == 3
	tab redistitem
		
	* Create ordered and binary variables for redistribution support:
	gen redist = redist1 if redist1 != .
		replace redist = redist3 if redist3 != . & redist == .
	
	gen redist1_dum = (inlist(redist1, 4, 5)) if !mi(redist1)
	gen redist3_dum = (inlist(redist3, 4, 5)) if !mi(redist3)
	
	gen redist_dum = redist1_dum if redist1_dum != .
		replace redist_dum = redist3_dum if redist3_dum != . & redist_dum == .
	
	tab redist redist_dum 
	
***	Gov responsible to provide living standard to the unemployed:

	gen resp_unemp_dum_4pt = (inlist(resp_unemp_4pt, 3, 4)) if !mi(resp_unemp_4pt)
	gen resp_unemp_dum_5pt = (inlist(resp_unemp_5pt, 4, 5)) if !mi(resp_unemp_5pt)
	gen resp_unemp_dum_comb = (inlist(resp_unemp_4pt, 3, 4) | inlist(resp_unemp_5pt, 4, 5)) if !mi(resp_unemp_4pt) | !mi(resp_unemp_5pt)
		
***	Cuts in governments spending:

	gen cut_spending_dum = (inlist(cut_spending, 4, 5)) if !mi(cut_spending)

*** Satisfied with present state of economy

	gen econsat_dum = (inlist(stfeco, 6, 10)) if !mi(stfeco)
	
*** Taxes on middle incomes are (much) too high

	gen tax_mid_toohigh_dum = (inlist(tax_mid_toohigh, 4, 5)) if !mi(tax_mid_toohigh)
	
***	PARTY SUPPORT:
	
*** RELATIVE PARTY SUPPORT

* 	We use retrospective voting where available. If that is missing, we use prospective voting.
* 	If that is missing as well, we use party affiliation.

* 	We measure RELATIVE party support, i.e. only among those that have a vote/party preference.
* 	We cannot neatly measure abstain over time in our surveys and/or neatly distinguish it from missing values.

foreach p in majorright majorleft radright radleft popcentre other {
	replace `p'_vote_re = . if !(majorright_vote_re == 1 | majorleft_vote_re == 1 | radright_vote_re == 1 |  radleft_vote_re == 1 |  popcentre_vote_re == 1 | other_vote_re == 1)
	replace `p'_vote_pro = . if !(majorright_vote_pro == 1 | majorleft_vote_pro == 1 | radright_vote_pro == 1 |  radleft_vote_pro == 1 |  popcentre_vote_pro == 1 | other_vote_pro == 1)
	replace `p'_aff = . if !(majorright_aff == 1 | majorleft_aff == 1 | radright_aff == 1 |  radleft_aff == 1 |  popcentre_aff == 1 | other_aff == 1)

	gen `p' = `p'_vote_re if `p'_vote_re != .
	replace `p' = `p'_vote_pro if `p'_vote_re == . & `p'_vote_pro != .
	replace `p' = `p'_aff if `p'_vote_re == . & `p'_vote_pro == . & `p'_aff != .
}
gen nonmajor = (majorright == 0 & majorleft == 0) if majorright != .
lab var majorright "Major right (dummy)"
lab var majorleft "Major left (dummy)"
lab var radright "Radical right (dummy)"
lab var radleft "Radical left (dummy)"
lab var popcentre "Centrist populist (dummy)"
lab var other "Other party (dummy)"
lab var nonmajor "Not major left/right (dummy)"

gen party_support = 1 if majorright == 1
	replace party_support = 2 if majorleft == 1
	replace party_support = 3 if radright == 1
	replace party_support = 4 if radleft == 1
	replace party_support = 5 if popcentre == 1
	replace party_support = 6 if other == 1
lab def party_support 1 "Major right" 2 "Major left" 3 "Radical right" 4 "Radical left" 5 "Centrist populist" 6 "Other party", replace
lab val party_support party_support

gen party_support2 = 1 if majorright == 1 | majorleft == 1 | popcentre == 1 | other == 1
	replace party_support2 = 2 if radleft == 1
	replace party_support2 = 3 if radright == 1
lab def party_support2 1 "Non-radical parties" 2 "Radical left" 3 "Radical right", replace
lab val party_support2 party_support2
gen nonradical = (party_support2 == 1) & !mi(party_support2)

gen party_support3 = 1 if majorright == 1
	replace party_support3 = 2 if majorleft == 1
	replace party_support3 = 3 if nonmajor == 1
lab def party_support3 1 "Major right" 2 "Major left" 3 "Not major left/right", replace
lab val party_support3 party_support3

gen party_support5 = 1 if majorright == 1
	replace party_support5 = 2 if majorleft == 1
	replace party_support5 = 3 if radright == 1
	replace party_support5 = 4 if radleft == 1
	replace party_support5 = 5 if other == 1 | popcentre == 1
lab def party_support5 1 "Major right" 2 "Major left" 3 "Radical right" 4 "Radical left" 5 "Other party", replace
lab val party_support5 party_support5

gen party_support5_inclmissing = 1 if majorright == 1
	replace party_support5_inclmissing = 2 if majorleft == 1
	replace party_support5_inclmissing = 3 if radright == 1
	replace party_support5_inclmissing = 4 if radleft == 1
	replace party_support5_inclmissing = 5 if other == 1 | popcentre == 1
	replace party_support5_inclmissing = 6 if party_support5_inclmissing == .
lab def party_support5_inclmissing 1 "Major right" 2 "Major left" 3 "Radical right" 4 "Radical left" 5 "Other party" 6 "No party/missing", replace
lab val party_support5_inclmissing party_support5_inclmissing

gen partyitem = 1 if majorright_vote_re != .
	replace partyitem = 2 if majorright_vote_re == . & majorright_vote_pro != .
	replace partyitem = 3 if majorright_vote_re == . & majorright_vote_pro == . & majorright_aff != .
lab def partyitem 1 "Retrospective voting" 2 "Prospective voting" 3 "Affiliation", replace
lab val partyitem partyitem
		
***	MAKE SURE THERE ARE NO MISSING QUINTILE DATA

tab cyear hinc_decile
		
*** MATCH LIS/OECD INCOME ESTIMATES WITH THE INCOME QUINTILES (ABSOLUTE AND RELATIVE MEASURES)

merge m:m countryn year using AbsRel_0.3_LIS_FINAL_DATA.dta, nogen keep(master match)

*** Absolute growth
foreach growth in 5 10 {
	gen absgr`growth' = .
	replace absgr`growth' = ieqdhi_d1_gr`growth' if hinc_decile == 1
	replace absgr`growth' = ieqdhi_d2_gr`growth' if hinc_decile == 2
	replace absgr`growth' = ieqdhi_d3_gr`growth' if hinc_decile == 3
	replace absgr`growth' = ieqdhi_d4_gr`growth' if hinc_decile == 4
	replace absgr`growth' = ieqdhi_d5_gr`growth' if hinc_decile == 5
	replace absgr`growth' = ieqdhi_d6_gr`growth' if hinc_decile == 6
	replace absgr`growth' = ieqdhi_d7_gr`growth' if hinc_decile == 7
	replace absgr`growth' = ieqdhi_d8_gr`growth' if hinc_decile == 8
	replace absgr`growth' = ieqdhi_d9_gr`growth' if hinc_decile == 9
	replace absgr`growth' = ieqdhi_d10_gr`growth' if hinc_decile == 10
	gen absgr`growth'_wa = .
	replace absgr`growth'_wa = ieqdhi_d1_wa_gr`growth' if hinc_decile == 1
	replace absgr`growth'_wa = ieqdhi_d2_wa_gr`growth' if hinc_decile == 2
	replace absgr`growth'_wa = ieqdhi_d3_wa_gr`growth' if hinc_decile == 3
	replace absgr`growth'_wa = ieqdhi_d4_wa_gr`growth' if hinc_decile == 4
	replace absgr`growth'_wa = ieqdhi_d5_wa_gr`growth' if hinc_decile == 5
	replace absgr`growth'_wa = ieqdhi_d6_wa_gr`growth' if hinc_decile == 6
	replace absgr`growth'_wa = ieqdhi_d7_wa_gr`growth' if hinc_decile == 7
	replace absgr`growth'_wa = ieqdhi_d8_wa_gr`growth' if hinc_decile == 8
	replace absgr`growth'_wa = ieqdhi_d9_wa_gr`growth' if hinc_decile == 9
	replace absgr`growth'_wa = ieqdhi_d10_wa_gr`growth' if hinc_decile == 10
}

*** Growth relative to other deciles / "Mean positional deprivation"
foreach growth in 5 10 {
	gen relgr`growth' = .
	replace relgr`growth' = ieqdhi_d1_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 1
	replace relgr`growth' = ieqdhi_d2_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 2
	replace relgr`growth' = ieqdhi_d3_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 3
	replace relgr`growth' = ieqdhi_d4_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 4
	replace relgr`growth' = ieqdhi_d5_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 5
	replace relgr`growth' = ieqdhi_d6_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 6
	replace relgr`growth' = ieqdhi_d7_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 7
	replace relgr`growth' = ieqdhi_d8_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 8
	replace relgr`growth' = ieqdhi_d9_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 9
	replace relgr`growth' = ieqdhi_d10_gr`growth' - ieqdhi_avg_gr`growth' if hinc_decile == 10
	gen relgr`growth'_wa = .
	replace relgr`growth'_wa = ieqdhi_d1_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 1
	replace relgr`growth'_wa = ieqdhi_d2_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 2
	replace relgr`growth'_wa = ieqdhi_d3_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 3
	replace relgr`growth'_wa = ieqdhi_d4_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 4
	replace relgr`growth'_wa = ieqdhi_d5_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 5
	replace relgr`growth'_wa = ieqdhi_d6_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 6
	replace relgr`growth'_wa = ieqdhi_d7_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 7
	replace relgr`growth'_wa = ieqdhi_d8_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 8
	replace relgr`growth'_wa = ieqdhi_d9_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 9
	replace relgr`growth'_wa = ieqdhi_d10_wa_gr`growth' - ieqdhi_avg_wa_gr`growth' if hinc_decile == 10
	gen relgr`growth'_upper = .
	replace relgr`growth'_upper = ieqdhi_d1_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 1
	replace relgr`growth'_upper = ieqdhi_d2_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 2
	replace relgr`growth'_upper = ieqdhi_d3_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 3
	replace relgr`growth'_upper = ieqdhi_d4_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 4
	replace relgr`growth'_upper = ieqdhi_d5_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 5
	replace relgr`growth'_upper = ieqdhi_d6_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 6
	replace relgr`growth'_upper = ieqdhi_d7_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 7
	replace relgr`growth'_upper = ieqdhi_d8_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 8
	replace relgr`growth'_upper = ieqdhi_d9_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 9
	replace relgr`growth'_upper = ieqdhi_d10_gr`growth' - ieqdhi_d10_gr`growth' if hinc_decile == 10
	gen relgr`growth'_upper_wa = .
	replace relgr`growth'_upper_wa = ieqdhi_d1_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 1
	replace relgr`growth'_upper_wa = ieqdhi_d2_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 2
	replace relgr`growth'_upper_wa = ieqdhi_d3_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 3
	replace relgr`growth'_upper_wa = ieqdhi_d4_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 4
	replace relgr`growth'_upper_wa = ieqdhi_d5_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 5
	replace relgr`growth'_upper_wa = ieqdhi_d6_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 6
	replace relgr`growth'_upper_wa = ieqdhi_d7_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 7
	replace relgr`growth'_upper_wa = ieqdhi_d8_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 8
	replace relgr`growth'_upper_wa = ieqdhi_d9_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 9
	replace relgr`growth'_upper_wa = ieqdhi_d10_wa_gr`growth' - ieqdhi_d10_wa_gr`growth' if hinc_decile == 10
	gen relgr`growth'_lower = .
	replace relgr`growth'_lower = ieqdhi_d1_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 1
	replace relgr`growth'_lower = ieqdhi_d2_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 2
	replace relgr`growth'_lower = ieqdhi_d3_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 3
	replace relgr`growth'_lower = ieqdhi_d4_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 4
	replace relgr`growth'_lower = ieqdhi_d5_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 5
	replace relgr`growth'_lower = ieqdhi_d6_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 6
	replace relgr`growth'_lower = ieqdhi_d7_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 7
	replace relgr`growth'_lower = ieqdhi_d8_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 8
	replace relgr`growth'_lower = ieqdhi_d9_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 9
	replace relgr`growth'_lower = ieqdhi_d10_gr`growth' - ieqdhi_d1_gr`growth' if hinc_decile == 10
	gen relgr`growth'_lower_wa = .
	replace relgr`growth'_lower_wa = ieqdhi_d1_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 1
	replace relgr`growth'_lower_wa = ieqdhi_d2_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 2
	replace relgr`growth'_lower_wa = ieqdhi_d3_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 3
	replace relgr`growth'_lower_wa = ieqdhi_d4_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 4
	replace relgr`growth'_lower_wa = ieqdhi_d5_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 5
	replace relgr`growth'_lower_wa = ieqdhi_d6_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 6
	replace relgr`growth'_lower_wa = ieqdhi_d7_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 7
	replace relgr`growth'_lower_wa = ieqdhi_d8_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 8
	replace relgr`growth'_lower_wa = ieqdhi_d9_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 9
	replace relgr`growth'_lower_wa = ieqdhi_d10_wa_gr`growth' - ieqdhi_d1_wa_gr`growth' if hinc_decile == 10
}
	
*** MATCH WITH AMECO GDP GROWTH / UNEMPLOYMENT DATA AS WELL AS OECD SOCIAL EXPENDITURE

merge m:m countryn year using "OECD_Social_Expenditure_20210330.dta", nogen keep(master match)
merge m:m countryn year using "OECD_GDPpercapita_20210401.dta", nogen keep(master match)
merge m:m countryn year using "AMECO_GDP_Unemp (Download 2020-07-12).dta", nogen keep(master match)
* Merge with SWIID
preserve
	import delimited "swiid9_0_summary.csv", clear
		replace country = "USA" if country == "United States"
		merge m:m country using Countrynames.dta, nogen keep(match) keepusing(countryn iso iso2 iso3n)
		sort countryn year
		xtset countryn year
		tsfill, full
		tabstat year if gini_mkt != ., by(country) stat(min max)	// 2019 (and a few 2018) mostly missing -- use lags
		foreach inc in mkt disp {
			replace gini_`inc' = L.gini_`inc' if year == 2018 & gini_`inc' == .
			replace gini_`inc' = L.gini_`inc' if year == 2019 & gini_`inc' == .
		}
		tabstat year if gini_mkt != ., by(countryn) stat(min max)	// 2019 (and a few 2018) mostly missing -- use lags
	save "swiid9_0_summary.dta", replace
restore
merge m:m countryn year using "swiid9_0_summary.dta", keep(master match) nogen
	
**	TIME PERIODS

gen period3 = 1 if inrange(year, 1985, 1998)
replace period3 = 2 if inrange(year, 1999, 2008)
replace period3 = 3 if inrange(year, 2009, 2020)
	lab def period3 1 "1985-1998" 2 "1999-2008" 3 "2009-2020", replace
	lab val period3 period3

gen period5 = 1 if inrange(year, 1985, 1989)
replace period5 = 2 if inrange(year, 1990, 1994)
replace period5 = 3 if inrange(year, 1995, 1999)
replace period5 = 4 if inrange(year, 2000, 2004)
replace period5 = 5 if inrange(year, 2005, 2009)
replace period5 = 6 if inrange(year, 2010, 2014)
replace period5 = 7 if inrange(year, 2015, 2019)
	lab def period5 1 "1985-89" 2 "1990-94" 3 "1995-99" 4 "2000-04" 5 "2005-09" 6 "2010-14" 7 "2015-19", replace
	lab val period5 period5


save AbsRel_FINAL_REP.dta, replace
