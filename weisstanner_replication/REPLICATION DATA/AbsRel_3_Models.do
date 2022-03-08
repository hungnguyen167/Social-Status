* REPLICATION DATA
* WEISSTANNER, D. (2022), Stagnating incomes and preferences for redistribution: The role of absolute and relative experiences. European Journal of Political Research. https://doi.org/10.1111/1475-6765.12520
clear all
set more off
set scheme s1mono
cd "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\" // ... set working directory

grstyle init
grstyle set plain, horizontal grid
grstyle set color RdYlBu

use AbsRel_FINAL_REP.dta, clear
xtset cwave

*** TABLE 1, MODEL 1:

xtset cwave
xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word replace alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, at((min) absgr5_wa) at((p10) absgr5_wa) at((p50) absgr5_wa) at((p90) absgr5_wa) at((max) absgr5_wa)
		marginsplot

*** TABLE 1, MODELS 2 AND 3:
		
* INTERACTION ABS*REL:

xtreg redist_dum c.absgr5_wa##c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)
	
		cap drop x_relgr5_wa d_relgr5_wa zero_relgr5_wa
		kdensity relgr5_wa if e(sample), gen(x_relgr5_wa d_relgr5_wa)
		gen zero_relgr5_wa = 0
		su relgr5_wa if e(sample)
	margins, dydx(absgr5_wa) at(relgr5_wa=(`r(min)' -6(2)6 `r(max)'))
	* note we can adjust the level() here given the much smaller sample for better visualization
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_relgr5_wa zero_relgr5_wa x_relgr5_wa if x_relgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 6, axis(2)) xlab(-6(2)6, grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040" 0.050 "0.050" 0.060 "0.060", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.5) legend(off) title("{bf:A. Effect of absolute stagnation}" "{bf:by relative stagnation}" " ", size(*0.8) pos(11)) xtitle("Relative income growth")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1A.png", as(png) replace
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(relgr5_wa) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of relative income growth") xsize(4) scale(*1.5) legend(off) title("{bf:B. Effect of relative stagnation}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
	graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1B.png", as(png) replace
	
	margins, at((p10) absgr5_wa (p10) relgr5_wa) at((p10) absgr5_wa (p90) relgr5_wa) at((p90) absgr5_wa (p10) relgr5_wa) at((p90) absgr5_wa (p90) relgr5_wa)
		
***	INTERACTION ABS*Income:
					
xtreg redist_dum c.absgr5_wa##c.hinc_decile c.relgr5_wa i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, dydx(absgr5_wa) at(hinc_decile=(1/10))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			xlab(1/10, grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040", grid gmin gmax glc(gs15) angle(0) axis(1)) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.5) legend(off) title("{bf:C. Effect of absolute stagnation}" "{bf:by income decile}" "", size(*0.8) pos(11)) xtitle("Income decile")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1C.png", as(png) replace 
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(hinc_decile) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of income decile") xsize(4) scale(*1.5) legend(off) title("{bf:D. Effect of income decile}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1D.png", as(png) replace

	
	/*
***	TABLE 1, MODELS 4 AND 5 (OTHER DEP. VARS.)

	* Govt responsible to provide decent living standard for unemployed - 4- and 5-point scale combined:
	xtreg resp_unemp_dum_comb c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	
	* Cut government spending:
	xtreg cut_spending_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust

	
*** ROBUSTNESS TESTS

*** Methodological robustness tests:
	
	* Collinearity - omitting relative income:
	xtreg redist_dum c.absgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust1, word replace alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)
	
	* Collinearity - omitting current income decile:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust1, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Random effects by country:
	xtset countryn
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust1, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Random effects by country-wave-decile:
	xtset cwavedecile
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust1, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Continuous DV instead of binary DV:
	xtset cwave
	xtreg redist c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust1, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Random-effects ordered logistic regression:
	xtologit redist c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), vce(robust)
		outreg2 using robust1, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Country-wave fixed effects:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed unemp socexp gini_mkt gdppc if inrange(age, 18, 65), fe robust
		outreg2 using robust1, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Pooled OLS with country-wave clustered SEs, without random effects:
	reg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), vce(cluster cwave)
		outreg2 using robust1, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

*** Substantive robustness tests:

	* Total population:	
	xtreg redist_dum c.absgr5 c.relgr5 c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 150), re robust
		outreg2 using robust2, word replace alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Distinguishing upper/lower relative growth:	
	xtreg redist_dum c.absgr5_wa c.relgr5_upper_wa c.relgr5_lower_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* 10-year growth window:	
	xtreg redist_dum c.absgr10_wa c.relgr10_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* No macro-level controls:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave if inrange(age, 18, 65), re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Year insted of wave dummies:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.year unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.year) addstat(R2 overall, e(r2_o)) adec(2)

	* Period dummies insted of wave dummies:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.period5 unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.period5) addstat(R2 overall, e(r2_o)) adec(2)

	* ISSP only
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65) & survey == "ISSP", re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.period5) addstat(R2 overall, e(r2_o)) adec(2)

	* ESS only
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65) & survey == "ESS", re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.period5) addstat(R2 overall, e(r2_o)) adec(2)
	
	* ESS only with subjective income:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hincfel i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65) & survey == "ESS", re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.period5) addstat(R2 overall, e(r2_o)) adec(2)
	
	* Control for redistribution level (rel_red from SWIID)
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt rel_red gdppc if inrange(age, 18, 65), re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.period5) addstat(R2 overall, e(r2_o)) adec(2)

	* Tertiary-educated respondents only:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65) & educ_tert == 1, re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	* Non-tertiary-educated respondents only:
	xtreg redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65) & educ_tert == 0, re robust
		outreg2 using robust2, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)
*/
/*		
*** APPENDIX 1: DESCRIPTIVE STATISTICS

su redist_dum c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed unemp socexp gini_mkt gdppc if inrange(age, 18, 65) & e(sample) [aw=weight]
			
***	APPENDIX: Interaction absolute stagnation * ideology:
	
xtreg redist_dum c.absgr5_wa i.party_support5_inclmissing c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)
	
xtreg redist_dum c.absgr5_wa##i.party_support5_inclmissing c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, dydx(absgr5_wa) at(party_support5_inclmissing=(1/6))
		marginsplot, xdim(party_support5_inclmissing) ciopts(col(gs0) lpatt(solid)) plotopts(connect(none) mcol(gs0) lcol(gs0)) ///
			xlab(, angle(45) grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040", grid gmin gmax glc(gs15) angle(0) axis(1)) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.3) legend(off) title("{bf:D. Effect of absolute stagnation}" "{bf:by partisanship}" "", size(*0.85) pos(11)) xtitle("")

		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(party_support5_inclmissing) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of relative income growth") xsize(4) scale(*1.5) legend(off) title("{bf:B. Effect of relative stagnation}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
*/

			