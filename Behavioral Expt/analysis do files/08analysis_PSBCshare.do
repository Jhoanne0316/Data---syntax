
/**computing shares: quantity, value, cost for constrained and unconstrained**/

clear all

use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile.dta", clear
sort uniqueID
keep uniqueID session hh round weeklypercapitabudget hhsize treatment budget urbanity s6q9 s6q18_to SSBC

/*checking distributions*/
label variable s6q9 "hhsize (survey)"
label variable hhsize "hhsize (workshop)"

	**checking data using standard dev to see variability. hhsize should be the same among rounds in a session
	sort session
	by session: tabulate hh round, summarize (hhsize) standard /*no variability*/
	by session: tabulate hh round, summarize (s6q9) standard /*no variability*/

	**checking data using standard dev to see variability. hhsize should be the same among rounds in a session
	sort session
	by session: tabulate hh round, summarize ( weeklypercapitabudget ) standard /*no variability*/
	by session: tabulate hh round, summarize ( s6q18_to  ) standard /*no variability*/

/*FOR BUDGET CONSTRAINT*/
gen wkbudget= (s6q18_to/30.44)*2 /*from 2018 consumer survey--2/30.5 factor was added to adjust budget for two days*/
gen wkpercapbudget= wkbudget/ hhsize
sort round
by round: ttest wkpercapbudget= weeklypercapitabudget 
	/*results: mean wkpercapbudget (survey) is significantly higher to weeklypercapitabudget (workshop)*/

gen PBC= wkpercapbudget-weeklypercapitabudget
summarize PBC
by round:ttest PBC=0

gen PSBC=1 if PBC>0
replace PSBC=0 if PBC<0
sort round
by round: tabulate PSBC
tabulate PSBC
/* 71% of the respondents are constrained with the budget

. tabulate PSBC

       PSBC |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      3,011       29.48       29.48
          1 |      7,204       70.52      100.00
------------+-----------------------------------
      Total |     10,215      100.00

*/

summarize PSBC
ttest PSBC=0.5
/*******************/
sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

merge 1:m uniqueID using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapseALL.dta"
sort uniqueID
drop _merge


gen foodgroup=1 if foodgroup_dish=="Starch"
replace foodgroup=2 if foodgroup_dish=="Non-vegetarian"
replace foodgroup=3 if foodgroup_dish=="Pulses"
replace foodgroup=4 if foodgroup_dish=="Dairy"
replace foodgroup=5 if foodgroup_dish=="Vegetables"
replace foodgroup=6 if foodgroup_dish=="Fruit"


replace foodgroup_dish=""
replace foodgroup_dish="01Starch" if foodgroup==1
replace foodgroup_dish="02Non-vegetarian" if foodgroup==2
replace foodgroup_dish="03Pulses" if foodgroup==3
replace foodgroup_dish="04Dairy" if foodgroup==4
replace foodgroup_dish="05Vegetables" if foodgroup==5
replace foodgroup_dish="06Fruit" if foodgroup==6

tab foodgroup foodgroup_dish

gen occ=1 if occasion=="Breakfast"
replace occ=2 if occasion=="Morning Snack"
replace occ=3 if occasion=="Lunch"
replace occ=4 if occasion=="Afternoon Snack"
replace occ=5 if occasion=="Dinner"

tab occ occasion

replace occasion=""
replace occasion="01Breakfast" if occ==1
replace occasion="02Morning Snack" if occ==2
replace occasion="03Lunch" if occ==3
replace occasion="04Afternoon Snack" if occ==4
replace occasion="05Dinner" if occ==5


/***************************************************ANALYSIS***************************************************/


/*share of value during an occasion comes from foodgroup*/
/*share of quantity*/
sort occasion PSBC
by occasion PSBC: tabulate foodgroup_dish PSBC if round==3, summarize (shareqty_occ)  mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==3, summarize (shareqty_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==3, summarize (shareqty_occ) 

by occasion PSBC: tabulate foodgroup_dish  if round==1, summarize (shareqty_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==1, summarize (shareqty_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==1, summarize (shareqty_occ) mean

by occasion PSBC: tabulate foodgroup_dish  if round==2, summarize (shareqty_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==2, summarize (shareqty_occ) mean 
by occasion PSBC: tabulate foodgroup_dish treatment if round==2, summarize (shareqty_occ) 



/*share of value*/
sort occasion PSBC
by occasion PSBC: tabulate foodgroup_dish  if round==3, summarize (shareval_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==3, summarize (shareval_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==3, summarize (shareval_occ) mean


by occasion PSBC: tabulate foodgroup_dish  if round==1, summarize (shareval_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==1, summarize (shareval_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==1, summarize (shareval_occ) mean


by occasion PSBC: tabulate foodgroup_dish  if round==2, summarize (shareval_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==2, summarize (shareval_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==2, summarize (shareval_occ) mean

/*share of cost*/
sort occasion PSBC
by occasion PSBC: tabulate foodgroup_dish  if round==3, summarize (sharecost_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==3, summarize (sharecost_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==3, summarize (sharecost_occ) mean


by occasion PSBC: tabulate foodgroup_dish  if round==1, summarize (sharecost_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==1, summarize (sharecost_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==1, summarize (sharecost_occ) mean


by occasion PSBC: tabulate foodgroup_dish  if round==2, summarize (sharecost_occ) mean
by occasion PSBC: tabulate foodgroup_dish urbanity if round==2, summarize (sharecost_occ) mean
by occasion PSBC: tabulate foodgroup_dish treatment if round==2, summarize (sharecost_occ) mean


/*share of of quantity during a round (H,W,J) comes from foodgroup*/
/*note: this should be household level/per round. n=177*/
sort uniqueID foodgroup_dish
by uniqueID foodgroup_dish: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

sort PSBC
by PSBC: tabulate foodgroup_dish if round==3, summarize (shareqty_round) 
by PSBC: tabulate foodgroup_dish urbanity if round==3, summarize (shareqty_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==3, summarize (shareqty_round) mean
 
by PSBC: tabulate foodgroup_dish if round==1, summarize (shareqty_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==1, summarize (shareqty_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==1, summarize (shareqty_round) mean

by PSBC: tabulate foodgroup_dish if round==2, summarize (shareqty_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==2, summarize (shareqty_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==2, summarize (shareqty_round) mean

/*share of value during a round (H,W,J) comes from foodgroup*/

by PSBC: tabulate foodgroup_dish if round==3, summarize (shareval_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==3, summarize (shareval_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==3, summarize (shareval_round) mean

by PSBC: tabulate foodgroup_dish if round==1, summarize (shareval_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==1, summarize (shareval_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==1, summarize (shareval_round) mean

by PSBC: tabulate foodgroup_dish if round==2, summarize (shareval_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==2, summarize (shareval_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==2, summarize (shareval_round) mean


/*share of cost during a round (H,W,J) comes from foodgroup*/

by PSBC: tabulate foodgroup_dish if round==3, summarize (sharecost_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==3, summarize (sharecost_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==3, summarize (sharecost_round) mean

by PSBC: tabulate foodgroup_dish if round==1, summarize (sharecost_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==1, summarize (sharecost_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==1, summarize (sharecost_round) mean

by PSBC: tabulate foodgroup_dish if round==2, summarize (sharecost_round) mean
by PSBC: tabulate foodgroup_dish urbanity if round==2, summarize (sharecost_round) mean
by PSBC: tabulate foodgroup_dish treatment if round==2, summarize (sharecost_round) mean
