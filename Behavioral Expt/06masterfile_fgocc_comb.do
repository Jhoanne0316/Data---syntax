

/*******food group indicator********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

keep uniqueID foodgroup_dish

/*identifying duplicates to proceed */
sort uniqueID foodgroup_dish

by uniqueID foodgroup_dish: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

gen fg_ind=1
replace fg_ind=1 if foodgroup_dish=="Dairy"
replace fg_ind=2 if foodgroup_dish=="Fruit"
replace fg_ind=3 if foodgroup_dish=="Non-vegetarian"
replace fg_ind=4 if foodgroup_dish=="Pulses"
replace fg_ind=5 if foodgroup_dish=="Starch"
replace fg_ind=6 if foodgroup_dish=="Vegetables"

tab foodgroup_dish fg_ind


gen fg_cons=1

drop foodgroup_dish 
reshape wide fg_cons, i( uniqueID ) j( fg_ind)

foreach v of varlist fg_cons1-fg_cons6 {
    replace `v' =0 if `v'==.
  }

reshape long

gen foodgroup_dish=""
replace foodgroup_dish="Dairy" if fg_ind==1
replace foodgroup_dish="Fruit" if fg_ind==2
replace foodgroup_dish="Non-vegetarian" if fg_ind==3
replace foodgroup_dish="Pulses" if fg_ind==4
replace foodgroup_dish="Starch" if fg_ind==5
replace foodgroup_dish="Vegetables" if fg_ind==6

drop fg_ind fg_cons

*before May 20, 2020: save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\test data\foodgroup indicator2.dta", replace

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06a_foodgroup indicator.dta", replace

/*******occasion indicator********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

keep uniqueID occasion

/*identifying duplicates to proceed */
sort uniqueID occasion

by uniqueID occasion: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

gen occ_ind=1
replace occ_ind=1 if occasion=="Breakfast"
replace occ_ind=2 if occasion=="Morning Snack"
replace occ_ind=3 if occasion=="Lunch"
replace occ_ind=4 if occasion=="Afternoon Snack"
replace occ_ind=5 if occasion=="Dinner"

tab occasion occ_ind


gen occ_cons=1

drop occasion
reshape wide occ_cons, i( uniqueID ) j( occ_ind)

foreach v of varlist occ_cons1-occ_cons5 {
    replace `v' =0 if `v'==.
  }

reshape long

gen occasion=""
replace occasion="Breakfast" if occ_ind==1
replace occasion="Morning Snack" if occ_ind==2
replace occasion="Lunch" if occ_ind==3
replace occasion="Afternoon Snack" if occ_ind==4
replace occasion="Dinner" if occ_ind==5

*before May 20, 2020: save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\test data\occasion indicator2.dta", replace


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06b_occasion indicator.dta", replace




****forming all combinations within the group occasion X foodgroup
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06b_occasion indicator.dta", clear

joinby uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06a_foodgroup indicator.dta", unmatched(none)

*before May 20, 2020: save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\test data\fg_occ consumption2.dta", replace
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06c_consumption indicator.dta", replace

*****merging the combination of foodgroup& occ with col0102********

***note: May 20, 2020: where did with col0102 come from?


 clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

 tab hh treatment  if session==14
 
merge m:m uniqueID occasion foodgroup_dish using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06c_consumption indicator.dta"
/*
    Result                           # of obs.
    -----------------------------------------
    not matched                        10,686
        from master                         0  (_merge==1)
        from using                     10,686  (_merge==2)

    matched                            10,215  (_merge==3)
    -----------------------------------------
	Same result from 12 May 2020 run
*/

/*drop if _merge==2--May 26, will not dro merge==2 to allow zeroes*/
summarize  quantity cost value _merge if _merge==3
drop _merge

**note: Before May 20, 2020- file name is dfc_masterfile_fgocc_comb.dta then changed to dfc_workingfile.dta
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06d_dfc_workingfile.dta", replace


**then next step is to compute shares

