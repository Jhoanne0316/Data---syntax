
************************************************************************************
*** data cleaning of Nutrition_data_WB_final(30Jan2020).xlsx, Date: 11 May 2020  ***
************************************************************************************

*****computing the total energy of each dish*****

clear all
import excel "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\nutri information\Nutrition_data_WB_final(30Jan2020).xlsx", sheet("Nutrition_data_WB_ingredients") firstrow

replace Amount_gm="" if Amount_gm=="NULL"
replace Carbohydrate_gm="" if Carbohydrate_gm=="NULL"
replace Protein_gm="" if Protein_gm=="NULL"
replace Fat_gm="" if Fat_gm=="NULL"
replace Energy_kcal="" if Energy_kcal=="NULL"

destring Amount_gm Carbohydrate_gm Protein_gm Fat_gm Energy_kcal, replace
drop if Amount_gm==.

collapse (sum) Amount_gm Carbohydrate_gm Protein_gm Fat_gm Energy_kcal , by( Dish )

duplicates tag Dish, generate(dish_dup)
tab dish_dup /*to check whether there are dupplicated dish-- no duplicates*/
tab Dish /*spell check--no duplicates*/
drop dish_dup
sort Dish
gen Nutri_Id = _n


/*converts macronutrients from grams to kcal*/
 gen carbkcal=Carbohydrate_gm*4
 gen prokcal=Protein_gm*4
 gen fatkcal=Fat_gm*9
 gen energytotal=carbkcal+prokcal+fatkcal
 
 
  /*check consistency of given energykcal and generated energy kcal*/
 ttest Energy_kcal=energytotal
 
 /* RESULTS: generated energytotal using the conversion factors from ICFT 
 is not significantly different from energy kcal given by Dr. Anindita,
 hence generated total Energy will be used to compute kcal shares
 
Paired t test
------------------------------------------------------------------------------
Variable |     Obs        Mean    Std. Err.   Std. Dev.   [95% Conf. Interval]
---------+--------------------------------------------------------------------
Energy~l |     158    422.7955    25.63881    322.2749     372.154     473.437
energy~l |     158    398.8852    23.24693    292.2094    352.9682    444.8023
---------+--------------------------------------------------------------------
    diff |     158    23.91022    15.15365    190.4784   -6.021095    53.84154
------------------------------------------------------------------------------
     mean(diff) = mean(Energy_kcal - energytotal)                 t =   1.5779
 Ho: mean(diff) = 0                              degrees of freedom =      157

 Ha: mean(diff) < 0           Ha: mean(diff) != 0           Ha: mean(diff) > 0
 Pr(T < t) = 0.9417         Pr(|T| > |t|) = 0.1166          Pr(T > t) = 0.0583

 */

 /*computing the share of macronutrients*/
 gen share_carb=carbkcal/energytotal
 gen share_pro=prokcal/energytotal
 gen share_fat=fatkcal/energytotal
 
 /*verify generated total energy*/
 gen energytotal2= share_carb+share_pro+share_fat
 gen energycheck=1 if energytotal==energytotal2
 replace energycheck=0 if energytotal==energytotal2
 tab energycheck
      
drop Energy_kcal energytotal2 energycheck
 
 
 /*NEED TO REDO THIS ASAP*/
label variable carbkcal "Carbohydrates content(in kcal) of a dish"
label variable prokcal "Protein content(in kcal) of a dish"
label variable fatkcal "Fat content(in kcal) of a dish"
label variable energytotal "Energy content of a dish"


label variable share_carb "Share of Carbohydrates content(in kcal) of a dish"
label variable share_pro "Share of Protein content(in kcal) of a dish"
label variable share_fat "Share of Fat content(in kcal) of a dish"


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\dish database_nutri info.dta", replace


 /*merging with dish database with cost*/
 
/**    DISH DATABASE      **/
*/
clear all
import excel "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\Dish database as of 29Nov2018(workingfile).xlsx", sheet("unique dishes") firstrow


/*To reconcile with foodapp data, cost of dish for lunch and dinner were assumed to be the same during breakfast*/
replace occasion="Breakfast, Lunch, Dinner" if cookeddish=="ALOO BARBATI FRY (FRIED POTATO CUBES AND BEANS)" 


drop bengaliname imageno cookeddishes Description ingredients actionforrakesh
split occasion , p(", ")


foreach v of varlist occasion1-occasion5 {
    table `v'
  } 

foreach v of varlist occasion1-occasion5 {
    replace `v' ="Afternoon Snack" if `v'=="PM Snack"
  } 

  foreach v of varlist occasion1-occasion5 {
    replace `v' ="Afternoon Snack" if `v'=="PM snack"
  } 
   
   foreach v of varlist occasion1-occasion5 {
    replace `v' ="Morning Snack" if `v'=="AM Snack"
  } 

  
  drop occasion
  reshape long occasion, i(srno_new) j (n)
  drop if occasion==""
  drop n srno_prev
  rename Dish dish
  rename type foodgroup_dish

sort dish occasion
	 
merge m:1 Nutri_Id  using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\dish database_nutri info.dta"

drop Dish _merge
		
/**************end of data cleaning***********************/
  save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\dataset04_dishdatabase.dta", replace

 
  
/**************ready for merging***********************/





/* **************IGNORE - previous syntax***************
clear all
import excel "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\nutri information\Dish database_for nutritional content (final 3April2019).xls", sheet("by ingredients (2)") firstrow
drop if Ingredients_2!="Total="
drop BengaliName - Amountgm Status_ingredients- V

sort Srno_new
by Srno_new: generate dup = cond(_N==1,0,_n)
tab dup
drop if dup>1
drop dup

gen id = _n
gen srno_check=1 if Srno_new==id
replace srno_check=0 if srno_check==.
tab srno_check

tab Cookeddishesparticulars if Carbohydrateg==.
tab Cookeddishesparticulars if Proteing==.
tab Cookeddishesparticulars if Fatg==.
tab Cookeddishesparticulars if Energykcal==.
tab Cookeddishesparticulars if Energykcal==0

/* MISSING INFO 03Apr2019

           Cooked dishes (particulars)  |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                       CHOCOLATE PASTRY |          1      100.00      100.00
----------------------------------------+-----------------------------------
                                  Total |          1      100.00
*/
 
 gen carbkcal=Carbohydrateg*4
 gen prokcal=Proteing*4
 gen fatkcal=Fatg*9
 gen energytotal=carbkcal+prokcal+fatkcal
 
 gen share_carb=carbkcal/energytotal
 gen share_pro=prokcal/energytotal
 gen share_fat=fatkcal/energytotal
 
 gen energytotal2= share_carb+share_pro+share_fat
 gen energycheck=1 if energytotal==energytotal2
 replace energycheck=0 if energytotal==energytotal2
 tab energycheck
  
 /*check consistency of given energykcal and generated energy kcal*/
 ttest Energykcal=energytotal
 
 /* RESULTS: generated energytotal using the conversion factors from ICFT 
 is not significantly different from energy kcal given by Dr. Anindita
 
Paired t test
------------------------------------------------------------------------------
Variable |     Obs        Mean    Std. Err.   Std. Dev.   [95% Conf. Interval]
---------+--------------------------------------------------------------------
Energy~l |     187    489.5594    77.89743    1065.231    335.8834    643.2355
energy~l |     187    387.7743    20.00315     273.539    348.3121    427.2365
---------+--------------------------------------------------------------------
    diff |     187    101.7852    75.80754    1036.652   -47.76796    251.3383
------------------------------------------------------------------------------
     mean(diff) = mean(Energykcal - energytotal)                  t =   1.3427
 Ho: mean(diff) = 0                              degrees of freedom =      186

 Ha: mean(diff) < 0           Ha: mean(diff) != 0           Ha: mean(diff) > 0
 Pr(T < t) = 0.9095         Pr(|T| > |t|) = 0.1810          Pr(T > t) = 0.0905
 
 */
 
drop Energykcal id srno_check energytotal2 energycheck
 
rename Srno_new srno_new
rename Type foodgroup_dish
rename Occasion occasion
rename Cookeddishesparticulars dish

  
save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\dish database_nutri info.dta", replace
 
