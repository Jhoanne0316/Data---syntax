/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep    uniqueID session hh round treatment urbanity day occasion share_carb share_pro share_fat dish hhsize

sort    uniqueID day occasion

/*label new variables*/

gen     occ=1 if occasion=="Breakfast"
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


sort uniqueID day occasion 

edit uniqueID session hh round day occasion share_carb share_pro share_fat

collapse (mean) share_carb share_pro share_fat hhsize occ, by (uniqueID day occasion)
collapse (mean) share_carb share_pro share_fat hhsize occ, by (uniqueID occasion)
reshape wide share_carb share_pro share_fat, i(uniqueID) j (occ)
