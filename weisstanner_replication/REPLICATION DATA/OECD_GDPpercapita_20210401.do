***
cd "C:\Users\dweis\OneDrive - Nexus365\PAPERS\2020_AbsRel_Voting\DATA_newMarch2021\"
***
	*	OECD files
		*	Select variable and years
		*	Set format to country=columns and year=lines (as for CPDS)
		*	Download and save as .xlsx
	*	--> REPLACE FILE NAME AND EXCEL CELL RANGE (FROM "COUNTRY" TO BOTTOM-RIGHT) <--
	import excel using "OECD_GDPpercapita_20210401.xlsx", cellrange(A6:AY59) firstrow clear allstring
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
	rename newvar gdppc
	
*** MISSINGS/LAGS - none

tabstat year if gdppc != ., by(country) stat(min max)

gen gdppc_l1 = L.gdppc

order year country gdppc gdppc_l1

save "OECD_GDPpercapita_20210401.dta", replace
