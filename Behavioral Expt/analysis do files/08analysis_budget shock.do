/*FOR BUDGET CONSTRAINT*/
clear all

use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile.dta", clear
sort uniqueID
keep uniqueID session hh round weeklypercapitabudget hhsize treatment budget urbanity s6q9 s6q18_to SSBC

sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup



***********************************************************


***********************************************************
/*checking distributions*/


	**checking data using standard dev to see variability. hhsize should be the same among rounds in a session
	sort session
	by session: tabulate hh round, summarize ( weeklypercapitabudget ) standard /*no variability*/
	by session: tabulate hh round, summarize ( s6q18_to  ) standard /*no variability*/



/*********************************/
tabulate round urbanity, summarize (SSBC) 
tabulate round treatment, summarize (SSBC) 
sort round
by round:ttest SSBC=0.5


/*********************************/
gen wkbudget= ((s6q18_to/4.3)/7)*2 /*from 2018 consumer survey--2/30.5 factor was added to adjust budget for two days*/
gen wkpercapbudget= wkbudget/ hhsize

gen deflated=weeklypercapitabudget/2.85031581297067 /*rescaled to account inflation*/


label variable weeklypercapitabudget "received weeklypercapitabudget for two days"
label variable wkpercapbudget "weekly per capita budget for two days from consumer survey"

sort round
by round: ttest wkpercapbudget= weeklypercapitabudget 
	/*results: mean wkpercapbudget (survey) is significantly higher to weeklypercapitabudget (workshop)*/


gen PBC= deflate-wkpercapbudget /*allocated-actual, if allocated>actual, PBC is positive, then unconstrained*/
summarize PBC                   /*allocated-actual, if allocated<actual, PBC is negative, then constrained*/
sort round
by round:ttest PBC=0

tabulate round urbanity, summarize (PBC) 
tabulate round treatment, summarize (PBC) mean standard

/*********************************/
gen PSBC=1 if PBC<0 /*1-constrained*/
replace PSBC=0 if PBC>0 /*unconstrained*/
sort round urbanity
by round urbanity: tabulate PSBC
by round: tabulate PSBC
tabulate PSBC
by round urbanity: summarize s6q18_to deflated wkpercapbudget
by round : summarize s6q18_to deflated wkpercapbudget
by round urbanity: ttest deflated=wkpercapbudget


summarize PSBC

tabulate round urbanity, summarize (PSBC)  mean
tabulate round treatment, summarize (PSBC) mean 
sort round urbanity
by round urbanity:ttest PSBC=0.5

