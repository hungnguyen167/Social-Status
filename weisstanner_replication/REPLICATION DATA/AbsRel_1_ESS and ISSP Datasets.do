clear all
set more off
set scheme s1mono
cd "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\ESS and ISSP data and do files - March 2021\"



***	ESS AND ISSP SURVEY CODING FROM JFF PROJECT ORGINAL DO FILES (NOTE THAT THESE CAN STILL CHANGE!)

*** DEFINE COUNTRY SAMPLE: 14 OECD Countries with LIS data available
#delimit ;
global countrysample "inlist(iso, "AUS","AUT","BEL","CAN","DEU","DNK","ESP") | 
					  inlist(iso, "FIN","GBR","IRL","ITA","NLD","NOR","USA")" ;

*** DEFINE LIST OF FINAL VARIABLES ;

global finalvars "survey wave country year month iso iso2 countryn weight redist* incdiff age female nhhmem
	hinc hinc_quint hinc_ppp* retired fulltime parttime unemployed nonemp educ_tert educ_years union urban
	party_id* vote_re vote_pro aff majorright* majorleft* radright* radleft* popcentre* other* abstain* 
	resp_unemp_4pt resp_unemp_5pt cut_spending stfeco hincfel tax_mid_toohigh" ;
#delimit cr
	
***	RUN INDIVIDUAL DO FILES

*	ESS:
*	foreach essyear of numlist 2002(2)2018 {
*		do "DATASETS\ESS `essyear'\cr_ESS_`essyear'.do"
*		keep $finalvars
*		keep if $countrysample
*		if `essyear' != 2002 append using ESS_ISSP_DATA.dta
*		save ESS_ISSP_DATA.dta, replace
*	}

*	ISSP:
	foreach isspyear of numlist 1987 1992 1999 2009 {
		do "DATASETS\ISSP `isspyear'\cr_ISSP_`isspyear'.do"
		keep $finalvars
		keep if $countrysample
		*append using ESS_ISSP_DATA.dta
		save ESS_ISSP_DATA.dta, replace
	}
cd "C:\GitHub\Social-Status-V\weisstanner_replication\REPLICATION DATA\"
save ESS_ISSP_DATA.dta, replace
