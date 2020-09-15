/*******energy shares**********/
clear all

use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile.dta", clear
sort uniqueID
keep uniqueID session hh round treatment urbanity carbkcal prokcal fatkcal energytotal share_carb share_pro share_fat

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

/*share of energy during an occasion comes from foodgroup*/
sort occasion

***ENERGY***
by occasion: tabulate foodgroup_dish  if round==3, summarize (shareenergy_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==3, summarize (shareenergy_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==3, summarize (shareenergy_occ) mean

by occasion: tabulate foodgroup_dish  if round==1, summarize (shareenergy_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==1, summarize (shareenergy_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==1, summarize (shareenergy_occ) mean

by occasion: tabulate foodgroup_dish  if round==2, summarize (shareenergy_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==2, summarize (shareenergy_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==2, summarize (shareenergy_occ) mean

***CARBS***
by occasion: tabulate foodgroup_dish  if round==3, summarize (sharecarb_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==3, summarize (sharecarb_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==3, summarize (sharecarb_occ) mean

by occasion: tabulate foodgroup_dish  if round==1, summarize (sharecarb_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==1, summarize (sharecarb_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==1, summarize (sharecarb_occ) mean

by occasion: tabulate foodgroup_dish  if round==2, summarize (sharecarb_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==2, summarize (sharecarb_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==2, summarize (sharecarb_occ) mean

***PROTEIN***
by occasion: tabulate foodgroup_dish  if round==3, summarize (sharepro_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==3, summarize (sharepro_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==3, summarize (sharepro_occ) mean

by occasion: tabulate foodgroup_dish  if round==1, summarize (sharepro_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==1, summarize (sharepro_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==1, summarize (sharepro_occ) mean

by occasion: tabulate foodgroup_dish  if round==2, summarize (sharepro_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==2, summarize (sharepro_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==2, summarize (sharepro_occ) mean

***FAT***
by occasion: tabulate foodgroup_dish  if round==3, summarize (sharefat_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==3, summarize (sharefat_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==3, summarize (sharefat_occ) mean

by occasion: tabulate foodgroup_dish  if round==1, summarize (sharefat_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==1, summarize (sharefat_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==1, summarize (sharefat_occ) mean

by occasion: tabulate foodgroup_dish  if round==2, summarize (sharefat_occ) mean
by occasion: tabulate foodgroup_dish urbanity if round==2, summarize (sharefat_occ) mean
by occasion: tabulate foodgroup_dish treatment if round==2, summarize (sharefat_occ) mean

/*share of of energy during a round (H,W,J) comes from foodgroup*/
/*note: this should be household level/per round. n=177*/
sort uniqueID foodgroup_dish
by uniqueID foodgroup_dish: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup


**ENERGY**
tabulate foodgroup_dish if round==3, summarize (shareenergy_round) mean
tabulate foodgroup_dish urbanity if round==3, summarize (shareenergy_round) mean
tabulate foodgroup_dish treatment if round==3, summarize (shareenergy_round) mean

tabulate foodgroup_dish if round==1, summarize (shareenergy_round) mean
tabulate foodgroup_dish urbanity if round==1, summarize (shareenergy_round) mean 
tabulate foodgroup_dish treatment if round==1, summarize (shareenergy_round) mean 

tabulate foodgroup_dish if round==2, summarize (shareenergy_round) mean
tabulate foodgroup_dish urbanity if round==2, summarize (shareenergy_round) mean
tabulate foodgroup_dish treatment if round==2, summarize (shareenergy_round)mean

**CARBS**
tabulate foodgroup_dish if round==3, summarize (sharecarb_round) mean
tabulate foodgroup_dish urbanity if round==3, summarize (sharecarb_round) mean
tabulate foodgroup_dish treatment if round==3, summarize (sharecarb_round) mean

tabulate foodgroup_dish if round==1, summarize (sharecarb_round) mean
tabulate foodgroup_dish urbanity if round==1, summarize (sharecarb_round) mean 
tabulate foodgroup_dish treatment if round==1, summarize (sharecarb_round) mean 

tabulate foodgroup_dish if round==2, summarize (sharecarb_round) mean
tabulate foodgroup_dish urbanity if round==2, summarize (sharecarb_round) mean
tabulate foodgroup_dish treatment if round==2, summarize (sharecarb_round)mean

**PROTEIN**
tabulate foodgroup_dish if round==3, summarize (sharepro_round) mean
tabulate foodgroup_dish urbanity if round==3, summarize (sharepro_round) mean
tabulate foodgroup_dish treatment if round==3, summarize (sharepro_round) mean

tabulate foodgroup_dish if round==1, summarize (sharepro_round) mean
tabulate foodgroup_dish urbanity if round==1, summarize (sharepro_round) mean 
tabulate foodgroup_dish treatment if round==1, summarize (sharepro_round) mean 

tabulate foodgroup_dish if round==2, summarize (sharepro_round) mean
tabulate foodgroup_dish urbanity if round==2, summarize (sharepro_round) mean
tabulate foodgroup_dish treatment if round==2, summarize (sharepro_round)mean

**FAT**
tabulate foodgroup_dish if round==3, summarize (sharefat_round) mean
tabulate foodgroup_dish urbanity if round==3, summarize (sharefat_round) mean
tabulate foodgroup_dish treatment if round==3, summarize (sharefat_round) mean

tabulate foodgroup_dish if round==1, summarize (sharefat_round) mean
tabulate foodgroup_dish urbanity if round==1, summarize (sharefat_round) mean 
tabulate foodgroup_dish treatment if round==1, summarize (sharefat_round) mean 

tabulate foodgroup_dish if round==2, summarize (sharefat_round) mean
tabulate foodgroup_dish urbanity if round==2, summarize (sharefat_round) mean
tabulate foodgroup_dish treatment if round==2, summarize (sharefat_round)mean
