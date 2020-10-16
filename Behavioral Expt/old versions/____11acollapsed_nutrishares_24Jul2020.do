/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep uniqueID session hh round treatment urbanity day occasion foodgroup_dish dish ///
     carbkcal prokcal fatkcal energytotal share_carb share_pro  share_fat ///
	 hhsize s6q9 s6q18_to SSBC
sort uniqueID day occasion foodgroup_dish

/*generate new variables*/


/*label new variables*/

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


sort uniqueID day occasion foodgroup_dish dish
edit uniqueID day occasion foodgroup_dish dish hhsize carbkcal prokcal fatkcal energytotal share_carb share_pro  share_fat if session==2 & hh==1 & round==3

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_nutrishares.dta", replace


/*(1)to get the total of amount spent in all dishes for two days per round*/
collapse (mean) share_carb share_pro share_fat hhsize, by (uniqueID occasion)

rename share_carb aveshare_carb
rename share_pro aveshare_pro
rename share_fat aveshare_fat

label variable aveshare_carb "ave share of carbohydrates in an occasion"
label variable aveshare_pro "ave share of protein in an occasion"
label variable aveshare_fat "ave share of fat in an occasion"

merge 1:m uniqueID occasion using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_nutrishares.dta"
drop _merge

edit uniqueID day occasion foodgroup_dish hhsize aveshare_carb aveshare_pro aveshare_fat if session==2 & hh==1 & round==3

********************************************
/*(2)to get the total of amount spent in all dishes for two days by foodgroup per round*/



/*******restructuring the amount spent by foodgroup**********/
clear
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\00masterfile_nutrishares.dta"


sort uniqueID occasion
by uniqueID occasion:  gen count = cond(_N==1,0,_n)
drop if count>1
gen occgrp=substr(occasion, 1, 2) /*cut string*/
destring occgrp, replace

rename occ occ_ind

merge m:m uniqueID occ_ind using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06b_occasion indicator.dta"

replace occasion=""
replace occasion="01Breakfast" if occ_ind==1
replace occasion="02Morning Snack" if occ_ind==2
replace occasion="03Lunch" if occ_ind==3
replace occasion="04Afternoon Snack" if occ_ind==4
replace occasion="05Dinner" if occ_ind==5

keep uniqueID occasion occgrp aveshare_carb aveshare_pro aveshare_fat 
drop occgrp

gen occgrp=substr(occasion, 1, 2) /*cut string*/
destring occgrp, replace

drop occasion


reshape wide aveshare_carb aveshare_pro aveshare_fat , i(uniqueID) j (occgrp)
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
