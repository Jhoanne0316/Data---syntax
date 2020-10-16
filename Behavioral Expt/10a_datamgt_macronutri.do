/**DATA MANAGEMENT BEFORE ANALYSIS**/

/*In calorie distribution, this analysis shows the distribution of protein, carbs, 
and fat macronutrients in a household. This is regardless of the occasion or food group 
the dish belongs to.

How does the quantity of servings affect the calorie share of a dish?

*/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep    uniqueID session hh round day occasion dish quantity hhsize carbkcal prokcal fatkcal energytotal
sort    uniqueID day occasion dish


edit     uniqueID session hh round day occasion dish quantity hhsize carbkcal prokcal fatkcal energytotal

***generating the total calories accounting the no. of serving (quantity)

gen      double carbs   =round(carbkcal   *quantity, 0.0001)
gen      double protein =round(prokcal    *quantity, 0.0001)
gen      double fat     =round(fatkcal    *quantity, 0.0001)
gen      double kcal    =round(energytotal*quantity, 0.0001)

/*
computing the total calorie per day for each respondent
reason: the calorie consumed for the day 1 may be different from day 2. 
Then, the share of macronutrient is computed.
*/
collapse (sum) carbs protein fat kcal, by (uniqueID day)
gen      double s_carbs   =round(carbs/kcal, 0.0001)
gen      double s_protein =round(protein/kcal, 0.0001)
gen      double s_fat     =round(fat/kcal, 0.0001)


***computing daily average share of macronutrient consumed per day
collapse (mean) s_carbs s_protein s_fat, by (uniqueID)


/*checking the sum if equal to 1.0 to secure smooth run of fmlogit*/
rename   s_carbs   carb
rename   s_protein protein
rename   s_fat     fat

gen      s0_kcal=carb+ protein+ fat
edit     carb protein fat s0_kcal

tab      s0_kcal
sort     s0_kcal

gen      dum_s0_kcal  =3 if s0_kcal>1   /*subtract 0.0001 */
replace  dum_s0_kcal  =4 if s0_kcal>1.00005 /*subtract 0.00005 */
replace  dum_s0_kcal  =2 if s0_kcal<.99995   /*subtract 0.00005 */
replace  dum_s0_kcal  =1 if s0_kcal<.9999/*add 0.00005*/
replace  dum_s0_kcal  =0 if s0_kcal==1
tab      dum_s0_kcal


*since 100% of the respondents have dinner, it is much easier to adjust the variable to have an exact 1.0 sum of shares
sort      s0_kcal


replace   carb       = carb-0.0001  if dum_s0_kcal==4
replace   carb       = carb-0.00005 if dum_s0_kcal==3
replace   carb       = carb+0.00005 if dum_s0_kcal==2
replace   carb       = carb+0.0001  if dum_s0_kcal==1
replace   s0_kcal    = carb+ protein+ fat
summarize s0_kcal

drop      s0_kcal dum_s0_kcal

label     variable carb    "ave daily share of carbs"
label     variable protein "ave daily share of protein"
label     variable fat     "ave daily share of fat"

merge     1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop      _merge

***kdensity
twoway    kdensity carb if round ==1 || kdensity carb if round ==2 ||kdensity carb if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway    kdensity protein if round ==1 || kdensity protein if round ==2 ||kdensity protein if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway    kdensity fat if round ==1 || kdensity fat if round ==2 ||kdensity fat if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway    kdensity carb || kdensity protein || kdensity fat , ///
                legend(order(1 "carb" 2 "protein" 3 "fat"))

				
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_macronutri.dta", replace


   
