/******* NUTRITIONAL OUTCOMES**********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

*before: merge 1:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapseALL.dta"

merge m:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07a_nutrishares.dta"


sort uniqueID
drop _merge

collapse  (mean) share_carbround share_proround share_fatround, by (uniqueID)
rename share_carbround carb
rename share_proround protein
rename share_fatround fat

label variable carb "Ave share of Carbohydrates consumed per household"
label variable protein "Ave share of Protein consumed per household"
label variable fat "Ave share of Fat consumed per household"

merge 1:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcal.dta", replace
