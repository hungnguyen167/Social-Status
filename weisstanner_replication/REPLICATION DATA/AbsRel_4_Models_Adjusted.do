* REPLICATION DATA
* WEISSTANNER, D. (2022), Stagnating incomes and preferences for redistribution: The role of absolute and relative experiences. European Journal of Political Research. https://doi.org/10.1111/1475-6765.12520
clear all
set more off
set scheme s1mono
cd "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\" // ... set working directory

grstyle init
grstyle set plain, horizontal grid
grstyle set color RdYlBu

use AbsRel_ADJUSTED.dta, clear
xtset cwave


***************************************** LIBERAL VALUES I *******************************************************
*** TABLE 1, MODEL 1 NEW and ADJUSTED:

xtset cwave
xtreg redist_dum_libZ_i c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word replace alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, at((min) absgr5_wa) at((p10) absgr5_wa) at((p50) absgr5_wa) at((p90) absgr5_wa) at((max) absgr5_wa)
		marginsplot

*** TABLE 1, MODELS 2 AND 3:
		
* INTERACTION ABS*REL:

xtreg redist_dum_libZ_i c.absgr5_wa##c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
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
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1A_libvalI.png", as(png) replace
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(relgr5_wa) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of relative income growth") xsize(4) scale(*1.5) legend(off) title("{bf:B. Effect of relative stagnation}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
	graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1B_libvalI.png", as(png) replace
	
	margins, at((p10) absgr5_wa (p10) relgr5_wa) at((p10) absgr5_wa (p90) relgr5_wa) at((p90) absgr5_wa (p10) relgr5_wa) at((p90) absgr5_wa (p90) relgr5_wa)
		
***	INTERACTION ABS*Income:
					
xtreg redist_dum_libZ_i c.absgr5_wa##c.hinc_decile c.relgr5_wa i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, dydx(absgr5_wa) at(hinc_decile=(1/10))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			xlab(1/10, grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040", grid gmin gmax glc(gs15) angle(0) axis(1)) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.5) legend(off) title("{bf:C. Effect of absolute stagnation}" "{bf:by income decile}" "", size(*0.8) pos(11)) xtitle("Income decile")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1C_libvalI.png", as(png) replace 
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(hinc_decile) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of income decile") xsize(4) scale(*1.5) legend(off) title("{bf:D. Effect of income decile}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1D_libvalI.png", as(png) replace

	

***************************************** LIBERAL VALUES II *******************************************************
*** TABLE 1, MODEL 1 NEW and ADJUSTED:

xtreg redist_dum_libZ_redist_i c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word replace alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, at((min) absgr5_wa) at((p10) absgr5_wa) at((p50) absgr5_wa) at((p90) absgr5_wa) at((max) absgr5_wa)
		marginsplot

*** TABLE 1, MODELS 2 AND 3:
		
* INTERACTION ABS*REL:

xtreg redist_dum_libZ_redist_i c.absgr5_wa##c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
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
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1A_libvalII.png", as(png) replace
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(relgr5_wa) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of relative income growth") xsize(4) scale(*1.5) legend(off) title("{bf:B. Effect of relative stagnation}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
	graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1B_libvalII.png", as(png) replace
	
	margins, at((p10) absgr5_wa (p10) relgr5_wa) at((p10) absgr5_wa (p90) relgr5_wa) at((p90) absgr5_wa (p10) relgr5_wa) at((p90) absgr5_wa (p90) relgr5_wa)
		
***	INTERACTION ABS*Income:
					
xtreg redist_dum_libZ_redist_i c.absgr5_wa##c.hinc_decile c.relgr5_wa i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, dydx(absgr5_wa) at(hinc_decile=(1/10))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			xlab(1/10, grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040", grid gmin gmax glc(gs15) angle(0) axis(1)) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.5) legend(off) title("{bf:C. Effect of absolute stagnation}" "{bf:by income decile}" "", size(*0.8) pos(11)) xtitle("Income decile")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1C_libvalII.png", as(png) replace 
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(hinc_decile) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of income decile") xsize(4) scale(*1.5) legend(off) title("{bf:D. Effect of income decile}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1D_libvalII.png", as(png) replace
	

	
	

***************************************** LACK OF TRUST *******************************************************
*** TABLE 1, MODEL 1 NEW and ADJUSTED:

xtreg redist_dum_notrust c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word replace alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, at((min) absgr5_wa) at((p10) absgr5_wa) at((p50) absgr5_wa) at((p90) absgr5_wa) at((max) absgr5_wa)
		marginsplot

*** TABLE 1, MODELS 2 AND 3:
		
* INTERACTION ABS*REL:

xtreg redist_dum_notrust c.absgr5_wa##c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
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
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1A_notrust.png", as(png) replace
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(relgr5_wa) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of relative income growth") xsize(4) scale(*1.5) legend(off) title("{bf:B. Effect of relative stagnation}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
	graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1B_notrust.png", as(png) replace
	
	margins, at((p10) absgr5_wa (p10) relgr5_wa) at((p10) absgr5_wa (p90) relgr5_wa) at((p90) absgr5_wa (p10) relgr5_wa) at((p90) absgr5_wa (p90) relgr5_wa)
		
***	INTERACTION ABS*Income:
					
xtreg redist_dum_notrust c.absgr5_wa##c.hinc_decile c.relgr5_wa i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, dydx(absgr5_wa) at(hinc_decile=(1/10))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			xlab(1/10, grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040", grid gmin gmax glc(gs15) angle(0) axis(1)) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.5) legend(off) title("{bf:C. Effect of absolute stagnation}" "{bf:by income decile}" "", size(*0.8) pos(11)) xtitle("Income decile")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1C_notrust.png", as(png) replace 
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(hinc_decile) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot, level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of income decile") xsize(4) scale(*1.5) legend(off) title("{bf:D. Effect of income decile}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1D_notrust.png", as(png) replace
	
	
	
	
	
	
	
	
	

***************************************** CORRUPTION PERCEPTIONS *******************************************************
*** TABLE 1, MODEL 1 NEW and ADJUSTED:

xtreg redist_dum_cpi c.absgr5_wa c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word replace alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, at((min) absgr5_wa) at((p10) absgr5_wa) at((p50) absgr5_wa) at((p90) absgr5_wa) at((max) absgr5_wa)
		marginsplot

*** TABLE 1, MODELS 2 AND 3:
		
* INTERACTION ABS*REL:

xtreg redist_dum_cpi c.absgr5_wa##c.relgr5_wa c.hinc_decile i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)
	
		cap drop x_relgr5_wa d_relgr5_wa zero_relgr5_wa
		kdensity relgr5_wa if e(sample), gen(x_relgr5_wa d_relgr5_wa)
		gen zero_relgr5_wa = 0
		su relgr5_wa if e(sample)
	margins, dydx(absgr5_wa) at(relgr5_wa=(`r(min)' -6(2)6 `r(max)'))
	* note we can adjust the level() here given the much smaller sample for better visualization
		marginsplot,  level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_relgr5_wa zero_relgr5_wa x_relgr5_wa if x_relgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 6, axis(2)) xlab(-6(2)6, grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040" 0.050 "0.050" 0.060 "0.060", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.5) legend(off) title("{bf:A. Effect of absolute stagnation}" "{bf:by relative stagnation}" " ", size(*0.8) pos(11)) xtitle("Relative income growth")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1A_cpi.png", as(png) replace
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(relgr5_wa) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot,  level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of relative income growth") xsize(4) scale(*1.5) legend(off) title("{bf:B. Effect of relative stagnation}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
	graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1B_cpi.png", as(png) replace
	
	margins, at((p10) absgr5_wa (p10) relgr5_wa) at((p10) absgr5_wa (p90) relgr5_wa) at((p90) absgr5_wa (p10) relgr5_wa) at((p90) absgr5_wa (p90) relgr5_wa)
		
***	INTERACTION ABS*Income:
					
xtreg redist_dum_cpi c.absgr5_wa##c.hinc_decile c.relgr5_wa i.educ_tert i.female age i.unemployed i.wave unemp socexp gini_mkt gdppc if inrange(age, 18, 65), re robust
	outreg2 using results, word append alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) bdec(3) drop(i.wave) addstat(R2 overall, e(r2_o)) adec(2)

	margins, dydx(absgr5_wa) at(hinc_decile=(1/10))
		marginsplot,   level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			xlab(1/10, grid gmin gmax glc(gs15)) ylab(-0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020" 0.030 "0.030" 0.040 "0.040", grid gmin gmax glc(gs15) angle(0) axis(1)) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of absolute income growth") xsize(4) scale(*1.5) legend(off) title("{bf:C. Effect of absolute stagnation}" "{bf:by income decile}" "", size(*0.8) pos(11)) xtitle("Income decile")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1C_cpi.png", as(png) replace 
			
		cap drop x_absgr5_wa d_absgr5_wa zero_absgr5_wa
		kdensity absgr5_wa if e(sample), gen(x_absgr5_wa d_absgr5_wa)
		gen zero_absgr5_wa = 0
		su absgr5_wa if e(sample)
	margins, dydx(hinc_decile) at(absgr5_wa=(`r(min)' -6(2)10 `r(max)'))
		marginsplot,  level(90) recastci(rline) ciopts(col(gs0) lpatt(shortdash)) plotopts(mcol(none) lcol(gs0)) ///
			addplot(rarea d_absgr5_wa zero_absgr5_wa x_absgr5_wa if x_absgr5_wa < 7, col(gs11%50) lwidth(none) ///
			below yaxis(2) ysc(axis(2) off) ylab(0 1, axis(2)) xlab(-8(2)12, grid gmin gmax glc(gs15)) ylab(-0.060 "-0.060" -0.050 "-0.050" -0.040 "-0.040" -0.030 "-0.030" -0.020 "-0.020" -0.010 "-0.010" 0 "0" 0.010 "0.010" 0.020 "0.020", grid gmin gmax glc(gs15) angle(0) axis(1))) ///
			yline(0, lcol(gs0)) ytitle("Marginal effect" "of income decile") xsize(4) scale(*1.5) legend(off) title("{bf:D. Effect of income decile}" "{bf:by absolute stagnation}" "", size(*0.8) pos(11)) xtitle("Absolute income growth")
    graph export "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\results\Fig1D_cpi.png", as(png) replace
