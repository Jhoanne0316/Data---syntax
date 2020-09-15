 /**EXPORTING SPSS FILE TO SASXPORT TO RETAIN VARIABLE LABELS**/
 /*FILENAME: food_habit 2018.xpt*/
 
clear all

import sasxport "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food Habit 2018\food_habit 2018.xpt"

sort vks_id

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food Habit 2018\dataset01_foodhabit.dta", replace
