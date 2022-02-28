********************************************************************************
***	Set working directory:
cd "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\"
********************************************************************************

***	IMPORT LIS DATA

	import excel using AbsRel_0.1_LIS_Estimates_DATA.xlsx, firstrow clear
		gen iso2 = regexs(0) if regexm(dataset1, "[a-z][a-z]")
			replace iso2 = strupper(iso2)
			replace iso2 = "GB" if iso2 == "UK"
		gen year = regexs(0) if regexm(dataset1, "[0-9][0-9]")
			destring year, replace
			replace year = year + 1900 if year >= 30
			replace year = year + 2000 if year < 30
		merge m:m iso2 using Countrynames.dta, nogen
		drop if year == .
		xtset countryn year
			tsfill, full
			tsappend, add(3)
		merge m:m countryn using Countrynames.dta, nogen update keep(match match_update)
			sort countryn year
			xtset countryn year
	
********************************************************************************
***	INCOME ADJUSTMENTS
********************************************************************************
	
	merge m:m countryn year using AbsRel_0.2_CPI_Indicators_DATA.dta, nogen keep(match master)
		sort countryn year
		xtset countryn year
		
***	INFLATION ADJUSTMENT

	qui foreach var of varlist eqdhi* {
		replace `var' = `var' / (cpi / 100)
	}
	
***	INTERPOLATE (Linear)

	qui foreach var of varlist eqdhi* {
		by countryn: ipolate `var' year, gen(i`var')
	}
	sort countryn year
	order country year  eqdhi* ieqdhi*

***	ADD unemp and realgdpgr from AMECO

merge m:m countryn year using "AMECO_GDP_Unemp (Download 2020-07-12).dta", nogen keep(master match)
	
***	GENERATE GROWTH MEASURES
		
	sort countryn year
	xtset countryn year
	
	* Average annual growth over 2 years, 3, 4, 5, 6, and 10 years.
	qui foreach var of varlist ieqdhi* {
		gen `var'_gr2  = 100*((L0.`var'/L1.`var')-1)
		gen `var'_gr3  = 100*((1/2)*((L0.`var'/L1.`var')-1) + (1/2)*((L1.`var'/L2.`var')-1))
		gen `var'_gr4  = 100*((1/3)*((L0.`var'/L1.`var')-1) + (1/3)*((L1.`var'/L2.`var')-1) + (1/3)*((L2.`var'/L3.`var')-1))
		gen `var'_gr5  = 100*((1/4)*((L0.`var'/L1.`var')-1) + (1/4)*((L1.`var'/L2.`var')-1) + (1/4)*((L2.`var'/L3.`var')-1) + (1/4)*((L3.`var'/L4.`var')-1))
		gen `var'_gr6  = 100*((1/5)*((L0.`var'/L1.`var')-1) + (1/5)*((L1.`var'/L2.`var')-1) + (1/5)*((L2.`var'/L3.`var')-1) + (1/5)*((L3.`var'/L4.`var')-1) + (1/5)*((L4.`var'/L5.`var')-1))
		gen `var'_gr10 = 100*((1/9)*((L0.`var'/L1.`var')-1) + (1/9)*((L1.`var'/L2.`var')-1) + (1/9)*((L2.`var'/L3.`var')-1) + (1/9)*((L3.`var'/L4.`var')-1) + (1/9)*((L4.`var'/L5.`var')-1) + (1/9)*((L5.`var'/L6.`var')-1) + (1/9)*((L6.`var'/L7.`var')-1) + (1/9)*((L7.`var'/L8.`var')-1) + (1/9)*((L8.`var'/L9.`var')-1))
	}


	foreach incd of numlist 1/10 {
		gen absgr5_d`incd' = ieqdhi_d`incd'_gr5
		gen relgr5_d`incd' = ieqdhi_d`incd'_gr5  - ieqdhi_avg_gr5
		gen absgr5_d`incd'_wa = ieqdhi_d`incd'_wa_gr5
		gen relgr5_d`incd'_wa = ieqdhi_d`incd'_wa_gr5  - ieqdhi_avg_wa_gr5
	}
	
	sort countryn year
		xtset countryn year
		gen country2 = country
			replace country2 = "United_Kingdom" if country == "United Kingdom"
	save AbsRel_0.3_LIS_FINAL_DATA.dta, replace

	
*** GRAPHS

	use AbsRel_0.3_LIS_FINAL_DATA.dta, clear

	
*** WORKING-AGE POPULATION:
graph hbar absgr5_d1_wa relgr5_d1_wa if inrange(year, 1991, 2013), over(country, sort(absgr5_d1_wa) lab(tick grid angle(0))) bar(2, col(gs7%60)) ///
	legend(order(1 "Absolute" 2 "Relative") size(*0.85) symxsize(*0.15) position(6) ring(1) region(lcol(none))) ///
	ytitle("Annual income growth (%)") subtitle("{bf:Bottom decile}") name(d1_wa, replace)
graph hbar absgr5_d5_wa relgr5_d5_wa if inrange(year, 1991, 2013), over(country, sort(absgr5_d5_wa) lab(tick grid angle(0))) bar(2, col(gs7%60)) ///
	legend(order(1 "Absolute" 2 "Relative") size(*0.85) symxsize(*0.15) position(6) ring(1) region(lcol(none))) ///
	ytitle("Annual income growth (%)") subtitle("{bf:5th decile}") name(d5_wa, replace)
graph hbar absgr5_d10_wa relgr5_d10_wa if inrange(year, 1991, 2013), over(country, sort(absgr5_d10_wa) lab(tick grid angle(0))) bar(2, col(gs7%60)) ///
	legend(order(1 "Absolute" 2 "Relative") size(*0.85) symxsize(*0.15) position(6) ring(1) region(lcol(none))) ///
	ytitle("Annual income growth (%)") subtitle("{bf:Top decile}") name(d10_wa, replace)

graph combine d1_wa d5_wa d10_wa, row(1) xcommon xsize(8) iscale(*1.45) imargin(medsmall)

	*** TOTAL POPULATION:
		graph hbar absgr5_d1 relgr5_d1 if inrange(year, 1991, 2013), over(country, sort(absgr5_d1) lab(tick grid angle(0))) bar(2, col(gs7%60)) ///
			legend(order(1 "Absolute" 2 "Relative") size(*0.85) symxsize(*0.15) position(6) ring(1) region(lcol(none))) ///
			ytitle("Annual income growth (%)") subtitle("{bf:Bottom decile}") name(d1_total, replace)
		graph hbar absgr5_d5 relgr5_d5 if inrange(year, 1991, 2013), over(country, sort(absgr5_d5) lab(tick grid angle(0))) bar(2, col(gs7%60)) ///
			legend(order(1 "Absolute" 2 "Relative") size(*0.85) symxsize(*0.15) position(6) ring(1) region(lcol(none))) ///
			ytitle("Annual income growth (%)") subtitle("{bf:5th decile}") name(d5_total, replace)
		graph hbar absgr5_d10 relgr5_d10 if inrange(year, 1991, 2013), over(country, sort(absgr5_d10) lab(tick grid angle(0))) bar(2, col(gs7%60)) ///
			legend(order(1 "Absolute" 2 "Relative") size(*0.85) symxsize(*0.15) position(6) ring(1) region(lcol(none))) ///
			ytitle("Annual income growth (%)") subtitle("{bf:Top decile}") name(d10_total, replace)
		graph combine d1_total d5_total d10_total, row(1) xcommon xsize(8) iscale(*1.45) imargin(medsmall)
	
/*	
	
	

gen period10 = 1 if inrange(year, 1985, 1999)
replace period10 = 2 if inrange(year, 2000, 2009)
replace period10 = 3 if inrange(year, 2010, 2019)
	lab def period10 1 "1980/90s" 2 "2000s" 3 "2010s", replace
	lab val period10 period10



gen period5 = 1 if inrange(year, 1985, 1989)
replace period5 = 2 if inrange(year, 1990, 1994)
replace period5 = 3 if inrange(year, 1995, 1999)
replace period5 = 4 if inrange(year, 2000, 2004)
replace period5 = 5 if inrange(year, 2005, 2009)
replace period5 = 6 if inrange(year, 2010, 2014)
replace period5 = 7 if inrange(year, 2015, 2019)
	lab def period5 1 "1985-89" 2 "1990-94" 3 "1995-99" 4 "2000-04" 5 "2005-09" 6 "2010-14" 7 "2015-19", replace
	lab val period5 period5

graph bar ieqdhi_d1_gr5 ieqdhi_d2_gr5 ieqdhi_d3_gr5 ieqdhi_d4_gr5 ieqdhi_d5_gr5 ///
	ieqdhi_d6_gr5 ieqdhi_d7_gr5 ieqdhi_d8_gr5 ieqdhi_d9_gr5 ieqdhi_d10_gr5, over(period10, gap(*3) label(ticks grid)) ///
	yline(0, lcol(gs2)) ///
	legend(order(1 "Bottom" 10 "Top") pos(1) ring(0) size(*0.7) row(1) symxsize(*0.1) textwidth(*0.8) keygap(*0.3) region(lcol(none) fcol(gs15))) ///
	xsize(4) name(all, replace)
	
levelsof iso, local(c1)
foreach c in `c1' {
graph bar ieqdhi_d1_gr5 ieqdhi_d2_gr5 ieqdhi_d3_gr5 ieqdhi_d4_gr5 ieqdhi_d5_gr5 ///
	ieqdhi_d6_gr5 ieqdhi_d7_gr5 ieqdhi_d8_gr5 ieqdhi_d9_gr5 ieqdhi_d10_gr5 if iso == "`c'", over(period10, gap(*3) label(ticks grid)) ///
	yline(0, lcol(gs2)) title("`c'") ///
	legend(order(1 "Bottom" 10 "Top") pos(1) ring(0) size(*0.7) row(1) symxsize(*0.1) textwidth(*0.8) keygap(*0.3) region(lcol(none) fcol(gs15))) ///
	xsize(4) name(`c', replace)
}
	
	
graph combine AUS AUT BEL CAN DEU DNK ESP FIN GBR IRL ITA NLD NOR USA, ycommon ///
	row(5) ysize(7) iscale(*1) imargin(2 2 0 0)

	
	
/*


foreach decile of numlist 1/10 {
	rename ieqdhi_d`decile'_gr5 ieqdhi_gr5_d`decile'
}
reshape long ieqdhi_gr5_d, i(iso year) j(hinc_decile)
order ieqdhi_gr5_d hinc_decile iso year

rename ieqdhi_gr5_d absgr5
tabstat absgr5, by(hinc_decile)



graph bar absgr5, over(hinc_decile) over(period5) 


* Overall:
reg absgr5 i.hinc_decile##period5
margins period5, at(hinc_decile=(1/10)) nose
mplotoffset, xdim(period5) recast(dropline) plotopts(base(ieqdhi_gr5_d1)) title("All 14 countries", size(*0.8)) xtitle("") ytitle("") yline(0, lcol(gs2)) ///
	xlab(1 "1985" 2 "1990" 3 "1995" 4 "2000" 5 "2005" 6 "2010" 7 "2015", angle(0) labsize(*0.9)) ///
	legend(order(- "Decile:   " 11 "1" 12 "2" 13 "3" 14 "4" 15 "5" 16 "6" 17 "7" 18 "8" 19 "9" 20 "Top") size(*0.7) row(1) symxsize(*0.1) region(lcol(none))) ///
	scale(*1.2) name(all, replace)



* by regime:


* Country-by-country:

levelsof iso, local(c1)
foreach c in `c1' {

reg absgr5 i.hinc_decile##period5 if iso == "`c'"
margins period5, at(hinc_decile=(1/10)) nose
mplotoffset, xdim(period5) recast(dropline) title("`c'", size(*0.8)) xtitle("") ytitle("") yline(0, lcol(gs2)) ///
	xlab(1 "1985" 2 "1990" 3 "1995" 4 "2000" 5 "2005" 6 "2010" 7 "2015", angle(0) labsize(*0.9)) ///
	legend(order(- "Decile:   " 11 "1" 12 "2" 13 "3" 14 "4" 15 "5" 16 "6" 17 "7" 18 "8" 19 "9" 20 "Top") size(*0.7) row(1) symxsize(*0.1) region(lcol(none))) ///
	scale(*1.2) name(`c', replace)

}

graph combine AUS AUT BEL CAN DEU DNK ESP FIN GBR IRL ITA NLD NOR USA, ycommon ///
	row(5) ysize(7) iscale(*0.8) imargin(2 2 0 0)
