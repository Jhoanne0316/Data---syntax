/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep uniqueID session hh round treatment urbanity day occasion foodgroup_dish dish quantity cost hhsize ///
     weeklypercapitabudget budget  s6q9 s6q18_to SSBC
sort uniqueID day occasion foodgroup_dish

/*generate new variables*/
gen double defbudget=round(weeklypercapitabudget/2.85031581297067,0.0001)/*rescaled to account inflation*/

gen double totalbudget=defbudget*hhsize

gen double defdishcost=round(cost/2.85031581297067,0.0001) /*rescaled to account inflation*/



/*label new variables*/
label variable weeklypercapitabudget "received weeklypercapitabudget for two days"
label variable defbudget "received weeklypercapitabudget (adjusted to inflation) for two days"
label variable totalbudget "received household budget (adjusted to inflation) for two days"
label variable defdishcost "deflated dish cost"

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

gen double amtspentperdish=round(quantity*defdishcost,0.0001)
label variable amtspentperdish "amount spent per dish"


sort uniqueID day occasion foodgroup_dish dish
edit uniqueID day occasion foodgroup_dish dish quantity cost hhsize defbudget totalbudget defdishcost amtspentperdish if session==2 & hh==1 & round==3

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta", replace


/*(1)to get the total of amount spent in all dishes for two days per round*/
collapse (sum) amtspentperdish (mean) hhsize, by (uniqueID)

rename amtspentperdish totalamtspent
label variable totalamtspent "total amount spent in the budget"

merge 1:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta"
drop _merge

edit totalamtspent uniqueID day occasion foodgroup_dish quantity cost hhsize defbudget totalbudget defdishcost amtspentperdish if session==2 & hh==1 & round==3

gen double unspentbudget=round(totalbudget-totalamtspent,0.0001)
label variable unspentbudget "total unspent budget"

***********for checking**********************
gen totalbudget2=totalamtspent+unspentbudget
gen check=1 if totalbudget2!=totalbudget
tab check  /*no obs*/
drop totalbudget2 check /*if no obs*/
*********************************************

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta", replace

*********************************************
* do not include this section in the analysis and merging. 
* This section is for checking the status of of those households with excessive use of the budget

collapse (sum) amtspentperdish (mean)  totalbudget totalamtspent unspentbudget hhsize, by (uniqueID)
gen excess=1 if unspentbudget<0
replace excess=0 if unspentbudget>=0
summarize unspent if excess==1
summarize totalamtspent if excess==0
tab unspent if excess==1
*********************************************

clear
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta"

gen excess=1 if unspentbudget<0
replace excess=0 if unspentbudget>=0

edit uniqueID totalamtspent totalbudget unspentbudget excess if excess==1

replace totalbudget=totalamtspent if excess==1
replace unspentbudget=totalbudget-totalamtspent
replace excess=1 if unspentbudget<0


gen double percntamtspent=round(totalamtspent/totalbudget, 0.0001)
label variable percntamtspent "% amount spent in the budget"

gen double percnt_unspent=round(unspentbudget/totalbudget, 0.0001)
label variable percnt_unspent "% amount unspent in the budget"

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta", replace


collapse (sum) amtspentperdish (mean)  totalbudget totalamtspent unspentbudget percntamtspent percnt_unspent hhsize, by (uniqueID)

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\01collapsed_investment.dta", replace

**NOTE: data for the dependent variable :INVESTMENT need to merge with ALL DATA (refer to macronutrient analysis

/*Next action 
1. MERGE this data with "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta" 
2. datamgt for investment share 
3. Save it as ___
*/

********************************************
/*(2)to get the total of amount spent in all dishes for two days by foodgroup per round*/


clear
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta"

collapse (sum) amtspentperdish (mean) totalbudget, by (uniqueID foodgroup_dish)
rename amtspentperdish totalamtspentbyfoodgrp

*************************************************
*check whether the total amtspentperdish is equal to the total budget
**do not include in the analysis. This section is to check whether total amtspentperdish does not have an excess on total budget
collapse (sum) totalamtspentbyfoodgrp (mean) totalbudget, by (uniqueID)

gen double unspentbudget=round(totalbudget-totalamtspent,0.0001)
label variable unspentbudget "total amount unspent in the budget"

gen excess=1 if unspentbudget<0
replace excess=0 if unspentbudget>=0
summarize unspent if excess==1
*************************************************

gen double invfoodgrp=round(totalamtspentbyfoodgrp/totalbudget,0.0001)
label variable invfoodgrp "investment shares per food group"

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\02collapsed_foodgrp.dta", replace

/*merging*/
clear

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta"
sort uniqueID day occasion foodgroup_dish dish
edit uniqueID day occasion foodgroup_dish hhsize totalbudget amtspentperdish percntamtspent percnt_unspent if session==2 & hh==1 & round==3

merge m:m uniqueID foodgroup_dish using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\02collapsed_foodgrp.dta"
drop _merge
sort uniqueID day occasion foodgroup_dish dish

edit uniqueID day occasion foodgroup_dish dish quantity cost hhsize defbudget totalbudget defdishcost invfoodgrp if session==2 & hh==1 & round==3

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta", replace



/*******restructuring the amount spent by foodgroup**********/
clear
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_budgetshares.dta"

sort uniqueID foodgroup_dish
by uniqueID foodgroup_dish:  gen count = cond(_N==1,0,_n)
drop if count>1
gen fgrp=substr(foodgroup_dish, 1, 2) /*cut string*/
destring fgrp, replace

keep uniqueID foodgroup_dish totalamtspentbyfoodgrp invfoodgrp fgrp totalbudget unspentbudget percntamtspent percnt_unspent invfoodgrp

reshape wide totalamtspentbyfoodgrp invfoodgrp foodgroup_dish, i(uniqueID) j (fgrp)
drop foodgroup_dish1 foodgroup_dish2 foodgroup_dish3 foodgroup_dish4 foodgroup_dish5 foodgroup_dish6

rename unspentbudget totalamtspentbyfoodgrp7
rename percnt_unspent invfoodgrp7

foreach v of varlist totalamtspentbyfoodgrp1-totalamtspentbyfoodgrp7 {
    replace `v' =0 if `v'==.
  }
  
  foreach v of varlist invfoodgrp1-invfoodgrp7 {
    replace `v' =0 if `v'==.
  }
  
**************************
*note: this are for checking
gen double totalamtspentbyfoodgrp00=round(totalamtspentbyfoodgrp1+totalamtspentbyfoodgrp2+totalamtspentbyfoodgrp3+totalamtspentbyfoodgrp4+totalamtspentbyfoodgrp5+totalamtspentbyfoodgrp6+totalamtspentbyfoodgrp7,0.0001)

gen double invfoodgrp00=round(invfoodgrp1+invfoodgrp2+invfoodgrp3+invfoodgrp4+invfoodgrp5+invfoodgrp6+invfoodgrp7,0.0001)

gen double totalamtspentbyfoodgrp0=round(totalbudget-totalamtspentbyfoodgrp00,0.0001) /*note: there are negative unspent budget, meaning, excess from the budget allocation */

gen double invfoodgrp0=round(1-invfoodgrp00,0.0001)

**************************
replace invfoodgrp7= invfoodgrp7+ invfoodgrp0
replace invfoodgrp00=invfoodgrp1+invfoodgrp2+invfoodgrp3+invfoodgrp4+invfoodgrp5+invfoodgrp6+invfoodgrp7

drop totalamtspentbyfoodgrp00 invfoodgrp00 totalamtspentbyfoodgrp0 invfoodgrp0

label variable invfoodgrp1 "investment share for Starch"
label variable invfoodgrp2 "investment share for Non-vegetarian"
label variable invfoodgrp3 "investment share for Pulses"
label variable invfoodgrp4 "investment share for Dairy"
label variable invfoodgrp5 "investment share for Vegetables"
label variable invfoodgrp6 "investment share for Fruit"
label variable invfoodgrp7 "Unspent investment share"

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\03reshape_foodgrp", replace



/*Next action 
1. MERGE this data with "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta" 
2. datamgt for investment share for food groups
3. Save it as 
*/
