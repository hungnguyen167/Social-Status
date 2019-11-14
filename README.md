# Svallfors-1997-Replication
A replication of the paper by Svallfors (1997)

# Description of the Study (from Lisa's notes)

### Research Question:
How are attitudes to redistribution structured in various welfare state regimes?
elements of analysis:
#### 1.	Attitudes towards redistribution (dependent variables):
-	Y1: The overall support for state intervention and redistribution 
-	Y2: The range of income differences that are considered legitimate (Nate thinks we should drop this from our replication as Evans and Kelley have analyzed these questions extensively and they mostly reflect the actual distribution of pay in a society, and are not really about the classic social policy - more about distribution rather than redistribution)
#### 2.	The impact of various structural cleavages on patterns of attitudes (independent variables): 
-	X1: Class
-	X2: Gender
-	X3: Sector 
-	(X4: position in labor market)

#### Hypotheses/Assumptions
Assumption: insider/outsider cleavage most dominant (and gender (Taylor-Gooby 1991))
-	USA/Canada (liberal regime)
Assumption: class cleavage most dominant
-	Sweden/Norway (social-democratic)
Assumption: gender (+ public/private sector) cleavage most dominant
-	New Zealand/ Australia (radical) 
Assumption: class cleavage most dominant 
Other cleavages also existent but subsumed under the dominant one in theory.
#### Data:
##### Case selection:
(based on Esping-Andersen 1990 and Castle and Mitchel 1993)
-	Germany/Austria (conservative regime)ISSP, wave of 1992, module on Social Inequality 
+ wave of 1987 (for Austria)
##### Variables, Operationalization and Coding:
Y1: Attitudes on Redistribution
-	Questions from ISSP
o	It is the responsibility of the government to reduce the differences between people with high incomes and those with low incomes?
o	The government should provide a job for everyone who wants one?
o	The government should provide everyone with a guaranteed basic income? 
-	Construction of an additive index of the three items for regressions: “government index”
o	“For this purpose, an additive index was constructed from the three items, dividing between 'strongly agree' and 'agree' (2); 'neither agree nor disagree' (1); and ‘disagree' and 'strongly disagree' (0). These items were summed, creating an index which may vary between 0 and 6, where 0 means disagreeing with all three propositions and thereby endorsing a clear-cut anti-interventionist stand and 6 means a strong interventionist standpoint.“  how exactly? I guess on individual level?

Y2: Attitude on Income difference 
-	Questions from ISSP:
o	How much do you think a _____ should earn in relation to an income of an unskilled factory worker? (Farm worker, Skilled factory worker, owner of a small shop, Doctor (GP), Cabinet minister, Chairman of a large national company)
-	Construction of an additive/ratio index: “income distribution index”
o	„as an indication of what constitutes legitimate income differences, we use the ratio of the three top and the three bottom occupations in every country.”  how exactly? ((Farm worker+Skilled factory worker+owner of a small shop)/( Doctor (GP)+Cabinet minister+Chairman of a large national company)) Again, on individual level? 

X1: Class 
-	Recoding of different occupational codes following the class schema of Goldthorpe et al. (and Ganzeboom and Treiman, 1994)
-	1 = “Service I” (higher-level controllers and administrators), 2 = “Service II” (lower-level controllers and administrators), 3 = “Routine non-manual”, 4 = “Skilled manual”, 5 = “Non-skilled manual”, 6 = “Self-employed”. 
-	SPSS commands in annex
-	Understand and translate to R
X2: Gender
-	Men/women (dummy)
X3: Sector 
-	Private/public employment (dummy)
X4: position in labor market (Insider/outsider) 
-	Employed
-	Unemployed
-	Retired
-	Housewife, students
(Each as dummy) 
Stages of Analysis:
1.	Descriptive statistics of dependent Variables 
a.	Aggregated on country level (table 1, 3)  compared  
b.	Additive Index building for Y1 and Y2 (table 2, 3)
c.	Aggregated on country level, disaggregated by independent variables (group means)  compared … only in annex (A2)
2.	Multiple bi- and multivariate regressions (OLS) 
a.	X1, X2, X4 with Y1 (table 4) only for 4 countries, one/regime (separate regressions)
b.	X1, X2, X4 with Y2 (table 5) only 4 countries, one/regime (separate regression)
c.	Common regression with countries as dummies (table 6)
Previous empirical studies:
Coughlin 1979, 1980
Svallfors 1993
Matheson 1993

# Critique (from Hung's notes plus comments from Lisa)

-	Limited to one point in time.
-	Southern European economies/societies are entirely left out of the picture. 
-	Low R2 statistics in many models have not been discussed.
-	The author used the module on Social Inequality (1992). These questions, however, can be found in many other modules. 
-	Sampling and non-responses have been considered (we should do the same).
-	Austria case: 1987 ISSP survey instead
-	Note the way he coded class categorizations (Appendix 2). 1 = “Service I” (higher-level controllers and administrators), 2 = “Service II” (lower-level controllers and administrators), 3 = “Routine non-manual”, 4 = “Skilled manual”, 5 = “Non-skilled manual”, 6 = “Self-employed”. This class schema was built by Goldthorpe et al.
-	 Legitimate income differences used in multivariate regression analyses: ratio of the three top and the three bottom occupations in every country.
-	Multivariate analysis with country variables as dummy variables (not multilevel). 
# Research Plan
### Ideas
-	More waves, more modules, more issues. We can try to find similar questions across the modules regarding welfare state issues. Besides redistribution and income differences, we can also add other issues, such as old-age care, pensions, unemployment benefits. We can also consider cross-issue variables, such as unemployment benefits x old-age care. This is particularly interesting in Southern European economies (if I remember correctly), where welfare provisions/transfers for the young unemployed are low and the retired are high.  
-	Concerning more issues, Svallfors himself makes some interesting suggestions. Namely to differentiate between attitudes on: general and specific questions of social policy, selective and universal social programs, and questions of security and equality … maybe there are respective questions in the ISSP in the meantime?
-	Similar to what Svallfors suggests in his conclusion we could try to include a dynamic perspective (see how these specific attitudes have developed over time) 
-	We should avoid getting trapped in the “typology” debate but instead focus on the functionality of our models. I believe every group of issues will be prevalent in a particular group of countries. 
-	There are more cleavage structures to be considered, for instance, age conflict.  
-	This type of research is also linked to the overall debate of institutionalism, especially in American sociology. 
### Action
#### 1. Replicate Svallfors original analysis of Y1 using 1992 ISSP data to see if we get the same results
#### 2. Extend Svallfors' analysis to all available waves of ISSP data and see if the results hold or maybe change over time
#### 3. Improve the analysis (Robustness checking maybe)
- measurement model for the three combined questions
- add countries (see above)
- add variables (see above)
