# The Moderating Role of Government Heuristics in Public Preferences for Redistribution


### Weisstanner Replication

Obtained original Stata code from author.
Altered do files to extract the variable 'incdiff' measuring 'attitudes toward inequality' from each Social Inequality ISSP module

cr_ISSP_1987.do
cr_ISSP_1992.do
cr_ISSP_1999.do
cr_ISSP_2009.do

Added ISSP source .dta files, changed code to use these files instead of Weisstanner's naming convention, e.g., "ISSP 1992 Inequality - ZA2310_SPSS.dta" in the 'use' command would be changed to simply "ZA2310.dta"

We removed or commented out code to extract ESS data or non-Social Inequality ISSP module data. We downloaded the necessary ISSP datasets from GESIS.

We renamed file paths.

We changed the final dataset name from AbsRel_FINAL.dta to AbsRel_FINAL_REP.dta.

We created a variable with all missing values for the variables redist1 & redist4 to allow the code to run.

This affected the following code:

AbsRel_0.3_Finalise_LIS_estimates_CODE.do
AbsRel_1_ESS and ISSP Datasets.do
AbsRel_2_Label variables.do
AbsRel_3_Models.do

Then we ran the above two code chunks in that order. We can confirm that these models produce the original results, even on the smaller sample. The confidence intervals are not surprisingly much larger.

