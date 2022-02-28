*	AMECO files
******************

*	Select variable
*	Select all countries and years
*	Download and save as .xlsx

cd "C:\Users\dweis\OneDrive - Nexus365\PAPERS\2020_AbsRel_Voting\DATA_newMarch2021\"

*	--> REPLACE FILE NAME AND EXCEL CELL RANGE (FROM "COUNTRY" TO BOTTOM-RIGHT) <--
import excel using "AMECO_GDP_Unemp (Download 2020-07-12).xlsx", sheet("Real GDP growth") cellrange(A4:AQ47) clear allstring
replace A = subinstr(A," ","",.)
forval i = 1(1)20 {
replace A = subinstr(A,"(`i')","",.)
}
replace A = subinstr(A,"(","",.)
replace A = subinstr(A,")","",.)
replace A = subinstr(A,"-","",.)
replace A = subinstr(A,"_","",.)
sxpose, clear firstnames
drop in 1

rename * nat*
gen year = real(natCountry)
drop natCountry
order year
reshape long nat, i(year) j(country) string
sort country year
gen newvar = real(nat)
drop nat

*	-> replace country names (if applicable)
replace country = "Czech Republic" if country == "Czechia"
replace country = "New Zealand" if country == "NewZealand"
replace country = "United Kingdom" if country == "UnitedKingdom"
replace country = "USA" if country == "UnitedStates"

*	-> replace countries to be kept (if applicable)
keep if country == "Australia" | country == "Austria" | country == "Belgium" | ///
		country == "Bulgaria" | country == "Canada" | country == "Croatia" | ///
		country == "Cyprus" | country == "Czech Republic" | country == "Denmark" | ///
		country == "Estonia" | country == "Finland" | country == "France" | ///
		country == "Germany" | country == "Greece" | country == "Hungary" | ///
		country == "Iceland" | country == "Ireland" | country == "Italy" | ///
		country == "Japan" | country == "Latvia" | country == "Lithuania" | ///
		country == "Luxembourg" | country == "Malta" | country == "Netherlands" | ///
		country == "New Zealand" | country == "Norway" | country == "Poland" | ///
		country == "Portugal" | country == "Romania" | country == "Slovakia" | ///
		country == "Slovenia" | country == "Spain" | country == "Sweden" | ///
		country == "Switzerland" | country == "United Kingdom" | country == "USA"
merge m:m country using Countrynames.dta, nogen
sort countryn year

*	--> REPLACE NAME OF THE NEW VARIABLE <--
rename newvar realgdpgr

save "AMECO_GDP_Unemp (Download 2020-07-12).dta", replace

*	--> REPLACE FILE NAME AND EXCEL CELL RANGE (FROM "COUNTRY" TO BOTTOM-RIGHT) <--
import excel using "AMECO_GDP_Unemp (Download 2020-07-12).xlsx", sheet("Unemployment rate") cellrange(A4:AQ45) clear allstring
replace A = subinstr(A," ","",.)
forval i = 1(1)20 {
replace A = subinstr(A,"(`i')","",.)
}
replace A = subinstr(A,"(","",.)
replace A = subinstr(A,")","",.)
replace A = subinstr(A,"-","",.)
replace A = subinstr(A,"_","",.)
sxpose, clear firstnames
drop in 1

rename * nat*
gen year = real(natCountry)
drop natCountry
order year
reshape long nat, i(year) j(country) string
sort country year
gen newvar = real(nat)
drop nat

*	-> replace country names (if applicable)
replace country = "Czech Republic" if country == "Czechia"
replace country = "New Zealand" if country == "NewZealand"
replace country = "United Kingdom" if country == "UnitedKingdom"
replace country = "USA" if country == "UnitedStates"

*	-> replace countries to be kept (if applicable)
keep if country == "Australia" | country == "Austria" | country == "Belgium" | ///
		country == "Bulgaria" | country == "Canada" | country == "Croatia" | ///
		country == "Cyprus" | country == "Czech Republic" | country == "Denmark" | ///
		country == "Estonia" | country == "Finland" | country == "France" | ///
		country == "Germany" | country == "Greece" | country == "Hungary" | ///
		country == "Iceland" | country == "Ireland" | country == "Italy" | ///
		country == "Japan" | country == "Latvia" | country == "Lithuania" | ///
		country == "Luxembourg" | country == "Malta" | country == "Netherlands" | ///
		country == "New Zealand" | country == "Norway" | country == "Poland" | ///
		country == "Portugal" | country == "Romania" | country == "Slovakia" | ///
		country == "Slovenia" | country == "Spain" | country == "Sweden" | ///
		country == "Switzerland" | country == "United Kingdom" | country == "USA"
merge m:m country using Countrynames.dta, nogen
sort countryn year

*	--> REPLACE NAME OF THE NEW VARIABLE <--
rename newvar unemp

merge 1:1 countryn year using "AMECO_GDP_Unemp (Download 2020-07-12).dta", nogen
xtset countryn year
gen unemp_l1 = L.unemp
gen unemp_ch = D.unemp
gen unemp_ch_l1 = L.D.unemp
gen realgdpgr_l1 = L.realgdpgr
order unemp* realgdpgr*

save "AMECO_GDP_Unemp (Download 2020-07-12).dta", replace
