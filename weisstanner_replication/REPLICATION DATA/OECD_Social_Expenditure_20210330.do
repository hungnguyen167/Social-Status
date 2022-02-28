***
cd "C:\Users\dweis\OneDrive - Nexus365\PAPERS\2020_AbsRel_Voting\DATA_newMarch2021\"
***
	*	OECD files
		*	Select variable and years
		*	Set format to country=columns and year=lines (as for CPDS)
		*	Download and save as .xlsx
	*	--> REPLACE FILE NAME AND EXCEL CELL RANGE (FROM "COUNTRY" TO BOTTOM-RIGHT) <--
	import excel using "OECD_Social_Expenditure_20210330.xlsx", cellrange(A8:AO50) firstrow clear allstring
		*	--> CHECK IN DATA EDITOR AND ADJUST <--
		drop in 1/2
		drop B
		rename * nat*
		gen year = real(natCountry)
		drop natCountry
		order year
		reshape long nat, i(year) j(country) string
		sort country year
		gen newvar = real(nat)
		drop nat
		*	-> replace country names (if applicable)
		replace country = "Czech Republic" if country == "CzechRepublic"
		replace country = "New Zealand" if country == "NewZealand"
		replace country = "Slovakia" if country == "SlovakRepublic"
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
		xtset countryn year
	*	--> REPLACE NAME OF THE NEW VARIABLE <--
	rename newvar socexp
	
*** MISSINGS/LAGS

* Austria missings in the 1980s -> interpolate:
ipolate socexp year if iso == "AUT", gen(socexp_AUT)
replace socexp = socexp_AUT if iso == "AUT"
drop socexp_AUT

* In a few cases, 2019/2018 socexp data is missing -> use lags
tabstat year if socexp != ., by(country) stat(min max)
replace socexp = L.socexp if year == 2018 & socexp == .
replace socexp = L.socexp if year == 2019 & socexp == .
tabstat year if socexp != ., by(country) stat(min max)

* In Latvia 1995/96, socexp is 0 -> put to missing
replace socexp = . if socexp == 0
su socexp, d	

gen socexp_l1 = L.socexp

order year country socexp socexp_l1

save "OECD_Social_Expenditure_20210330.dta", replace
