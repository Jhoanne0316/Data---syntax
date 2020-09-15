/*******INVESTMENT SHARE - FOOD EXPENDITURE SHARES**********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup


merge 1:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\03reshape_foodgrp"
sort uniqueID

keep uniqueID invfoodgrp1 invfoodgrp2 invfoodgrp3 invfoodgrp4 invfoodgrp5 invfoodgrp6 invfoodgrp7 

/*Dependent variable*/

rename invfoodgrp1 starch
rename invfoodgrp2 nonveg
rename invfoodgrp3 pulses
rename invfoodgrp4 dairy
rename invfoodgrp5 veg
rename invfoodgrp6 fruit
rename invfoodgrp7 savings


label variable starch "Starch-food expenditure shares"
label variable nonveg "Nonveg-food expenditure shares"
label variable pulses "Pulses-food expenditure shares"
label variable dairy "Dairy-food expenditure shares"
label variable veg "Veg-food expenditure shares"
label variable fruit "Fruit-food expenditure shares"
label variable savings "Savings-food expenditure shares"


merge 1:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_foodexp.dta", replace
