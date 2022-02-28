# Redistributive Justice Confounded by Attitudes toward Government: The Political Economy of Public Support for Redistribution across 34 Countries

Nate Breznau, Principal Investigator, breznau.nate@gmail.com 0000-0003-4983-3137 
Lisa Heukamp, Doctoral Researcher, heukamp@uni-bremen.de 0000-0002-6381-7099
Hung H.V. Nguyen, Doctoral Researcher, hunghvnguyen@gmail.com (0000-0001-9496-6217)
Tom Knuf, Research Assistant, knuf@uni-bremen.de 
Arne Köller, Research Assistant, arne.koeller@uni-bremen.de https://orcid.org/0000-0002-9721-5125
Sören Goldenstein, Research Assistant, soeren.gold@googlemail.com 


Link to paper: https://docs.google.com/document/d/1rCnLWJVScMimQP_9LL5Ed9cqksii07nVlCw4hTUTnRs/



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

Then we ran the above two code chunks in that order.