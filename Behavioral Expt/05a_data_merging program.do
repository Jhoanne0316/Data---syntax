/**MERGING OF FOOD APP DATA AND DISH DATABASE**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\dataset03_foodapp.dta", clear

merge m:m occasion dish  using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\dataset04_dishdatabase.dta"

/***
(note: variable dish was str68, now str81 to accommodate using data's values)

   Result                           # of obs.
    -----------------------------------------
    not matched                            61
        from master                         0  (_merge==1)
        from using                         61  (_merge==2)

    matched                            10,215  (_merge==3)
    -----------------------------------------
	
Same result from 12 May 2020 run	


	**/
	
edit dish occasion foodgroup_dish cost if _merge==2 /*dishes that were not consumed by respondents*/
drop if _merge==2 /*(54 observations deleted)*/
edit dish occasion foodgroup_dish cost if _merge==1
sort session hh
drop _merge
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\mergeddata_03_04.dta", replace


/**MERGING OF (FOOD APP DATA AND DISH DATABASE) and WORKSHOP DATA**/

merge m:1 session hh using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Workshop data\dataset02_workshop.dta"

gen checkdays=mon+tue+wed+thu+fri+sat+sun
tab checkdays

/*


    Result                           # of obs.
    -----------------------------------------
    not matched                            15
        from master                         0  (_merge==1)
        from using                         15  (_merge==2)

    matched                            10,215  (_merge==3)
    -----------------------------------------
	Same result from 12 May 2020 run
*/

edit if _merge==2

drop if session==1
drop _merge

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\mergeddata__020304.dta", replace

/**MERGING OF [(FOOD APP DATA AND DISH DATABASE) and WORKSHOP DATA] and  FOOD HABIT SURVEY**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\mergeddata__020304.dta", clear
sort vks_id


 merge m:1 vks_id using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food Habit 2018\dataset01_foodhabit.dta"
/**
(note: variable vks_id was int, now double to accommodate using data's values)

    Result                           # of obs.
    -----------------------------------------
    not matched                            15
        from master                         0  (_merge==1)
        from using                         15  (_merge==2)

    matched                            10,215  (_merge==3)
    -----------------------------------------
	Same result from 12 May 2020 run	
*/

/*CHECKING THE MERGING WITH VKS_ID*/
generate vks_check=1 if vks_id==new_vks
tab vks_check
/*
  vks_check |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |      9,346      100.00      100.00
------------+-----------------------------------
      Total |      9,346      100.00
	Same result from 12 May 2020 run
*/
tab vks_id new_vks if vks_check==.
tab vks_id new_vks if vks_check==.

edit VKSregform new_vks vks_id session name name_regform vks_check if vks_check==.
/*new_vks will be the UNIQUE IDENTIFIER FOR ALL DATASETS. This was already the reconsiliation of  all the datasets*/

/*CHECKING THE MERGING WITH NAMES*/
generate name_check=1 if name==name_regform
tab name_check
/*
 name_check |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |      9,935      100.00      100.00
------------+-----------------------------------
      Total |      9,935      100.00
	Same result from 12 May 2020 run
*/
edit VKSregform new_vks vks_id session name name_regform vks_check name_check if name_check==.

/*
those name_check==. but vks_check==1, these are valid cases
those cases with no session will be dropped. they are those who are in session one(pretest) but are included in the food habit survey

*/
drop if _merge==2
drop _merge vks_check starttime endtime vks_id n

tostring session hh round new_vks, generate(ses hh2 rnd new_vks2)

replace ses="02" if ses=="2"
replace ses="03" if ses=="3"
replace ses="04" if ses=="4"
replace ses="05" if ses=="5"
replace ses="06" if ses=="6"
replace ses="07" if ses=="7"
replace ses="08" if ses=="8"
replace ses="09" if ses=="9"
tab ses

replace hh2="01" if hh2=="1"
replace hh2="02" if hh2=="2"
replace hh2="03" if hh2=="3"
replace hh2="04" if hh2=="4"
replace hh2="05" if hh2=="5"
replace hh2="06" if hh2=="6"
replace hh2="07" if hh2=="7"
replace hh2="08" if hh2=="8"
replace hh2="09" if hh2=="9"
tab hh2

replace rnd="01" if rnd=="1"
replace rnd="02" if rnd=="2"
replace rnd="03" if rnd=="3"
tab rnd

gen uniqueID=ses+hh2+rnd+new_vks2
drop ses hh2 rnd srno_new VKSregform new_vks new_vks2 serialnumber uniquekey
gen value=quantity*cost

/*
gen valpercap=value/hhsize
gen SSBC=.
replace SSBC=AS2_h if round==1 /*(3,442 real changes made)*/
replace SSBC=AS2_w if round==2 /*(3,344 real changes made)*/
replace SSBC=1 if AS2_h==1 &AS2_w==1 /*for round==3, (2,022 real changes made)*/
replace SSBC=0 if AS2_h==0 &AS2_w==0 /*for round==3, (648 real changes made)*/
*/
label variable uniqueID "UniqueID of respondent"
/*
label variable value "value of a dish(quantity*cost)-household level"
label variable valpercap "value of a dish(quantity*cost) per capita"
label variable SSBC "Self-reported status of being budget-constrained"
*/
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", replace



