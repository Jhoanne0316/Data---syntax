/*FOR FAMILY size*/
clear all

use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile.dta", clear
sort uniqueID
keep uniqueID session hh round urbanity treatment hhsize s6q9 AH1 AH2 AH3 AH4 AH5

sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

***********************************************************
label variable s6q9 "hhsize (survey)"
label variable hhsize "hhsize (workshop)"
label variable AH1 "no. of household members"
label variable AH2 "young children aged below 5 years old"
label variable AH3 "physically active - 5 to 17 years old"
label variable AH4 "physically active - 18 to 64 years old"
label variable AH5 "physically active - 65 years old and above"
***********************************************************

**logic check for AH family size variables
gen AH1_check=AH2+AH3+AH4+AH5
gen AH1_dum=1 if AH1_check==AH1
replace AH1_dum=0 if AH1_dum==.  /*(15 real changes made---2.8%, can be ignored)*/
sort round
by round:tab AH1_dum  
drop AH1_check AH1_dum

**logic check for hhsize(food app) and AH1 (expt)
gen famsize1=1 if hhsize==AH1
replace famsize1=0 if famsize1==. /*(9 real changes made---1.70%, can be ignored)*/
tab famsize1

**logic check for hhsize(food app) and s6q9 (expt)
gen famsize2=1 if hhsize==s6q9
replace famsize2=0 if famsize2==. 
tab famsize2 /*( 379 real changes made---71.64%, too much)*/

**logic check for AH1 (expt) and s6q9 (expt)
gen famsize3=1 if AH1==s6q9
replace famsize3=0 if famsize3==. 
tab famsize3 /*( 373 real changes made---70.51% too much)*/


**checking data using standard dev to see variability. hhsize should be the same among rounds in a session
sort session
by session: tabulate hh round, summarize (hhsize) standard /*no variability*/
by session: tabulate hh round, summarize (AH1) standard /*no variability*/
by session: tabulate hh round, summarize (s6q9) standard /*no variability*/


/*comparing family size variables*/
sort round
by round: ttest hhsize == AH1	/*results: no significantly difference*/
by round: ttest hhsize == s6q9	/*results: mean hhsize is significantly higher to s6q9*/
by round: ttest AH1 == s6q9	
/*results: mean hhsize is significantly higher to s6q9*/


**dummy vars for physically active family members
gen AH2_active=1 if AH2>0
replace AH2_active=0 if AH2==0
tab AH2_active

gen AH3_active=1 if AH3>0
replace AH3_active=0 if AH3==0
tab AH3_active

gen AH4_active=1 if AH4>0
replace AH4_active=0 if AH4==0
tab AH4_active

gen AH5_active=1 if AH5>0
replace AH5_active=0 if AH5==0
tab AH5_active


***generate descriptive stats
tabulate round urbanity if round==3, summarize (hhsize)
tabulate round treatment if round==3, summarize (hhsize)

tabulate round urbanity if round==3, summarize (AH1)
tabulate round treatment if round==3, summarize (AH1)

tabulate round urbanity if round==3, summarize (s6q9)
tabulate round treatment if round==3, summarize (s6q9)

tabulate round urbanity if round==3, summarize (AH2)
tabulate round treatment if round==3, summarize (AH2)

tabulate round urbanity if round==3, summarize (AH3) 
tabulate round treatment if round==3, summarize (AH3) 

tabulate round urbanity if round==3, summarize (AH4) 
tabulate round treatment if round==3, summarize (AH4) 

tabulate round urbanity if round==3, summarize (AH5) 
tabulate round treatment if round==3, summarize (AH5) 

**proportion of physically active household members

tabulate round urbanity if round==3, summarize (AH2_active) mean
tabulate round treatment if round==3, summarize (AH2_active)  mean

tabulate round urbanity if round==3, summarize (AH3_active) mean
tabulate round treatment if round==3, summarize (AH3_active)  mean

tabulate round urbanity if round==3, summarize (AH4_active) mean
tabulate round treatment if round==3, summarize (AH4_active)  mean

tabulate round urbanity if round==3, summarize (AH5_active) mean
tabulate round treatment if round==3, summarize (AH5_active)  mean






