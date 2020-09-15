/******* TOTAL CALORIES**********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

merge m:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07a_nutrishares.dta"


sort uniqueID
drop _merge

collapse  (mean) hhsize share_carbround share_proround share_fatround energy_round , by (uniqueID)

rename share_carbround carb
rename share_proround protein
rename share_fatround fat
rename energy_round kcal


label variable carb "Ave share of Carbohydrates consumed per household"
label variable protein "Ave share of Protein consumed per household"
label variable fat "Ave share of Fat consumed per household"
label variable kcal "total calories"
label variable hhsize "household size"

*natural logarithm transformation (ln); log transformation (log)*
gen lnkcal=ln(kcal)
gen logkcal=log(kcal)



gen kcalpercap=kcal/hhsize
gen lnkcalpercap=ln(kcalpercap)
gen logkcalpercap=log(kcalpercap)


label variable lnkcal "total calories (ln)"
label variable logkcal "total calories (log)"


label variable kcalpercap "total calories per capita"
label variable lnkcalpercap "total calories per capita (ln)"
label variable logkcalpercap "total calories per capita (log)"


merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13analysis_kcalcap.dta", replace

