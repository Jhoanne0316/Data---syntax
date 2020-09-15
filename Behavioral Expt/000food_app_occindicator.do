
/*******occasion indicator********/
clear all

use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile.dta", clear

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

  
rename occ_cons1 breakfast
rename occ_cons2 amsnack
rename occ_cons3 lunch
rename occ_cons4 pmsnack
rename occ_cons5 dinner
  
label variable breakfast "Breakfast"
label variable amsnack "Morning snack"
label variable lunch "Lunch"
label variable pmsnack "Afternoon snack"
label variable dinner "Dinner"

label values breakfast amsnack lunch pmsnack dinner yesno

foreach v of varlist breakfast-dinner{
 tab `v'
}
  
 save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\occasion_indicator.dta", replace

