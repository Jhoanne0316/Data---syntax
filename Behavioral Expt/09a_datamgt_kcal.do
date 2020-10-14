/**DATA MANAGEMENT BEFORE ANALYSIS**/

/*In calorie distribution, this analysis shows the distribution of protein, carbs, 
and fat macronutrients in a household. This is regardless of the occasion or food group 
the dish belongs to.

How does the quantity of servings affect the calorie share of a dish?

*/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep    uniqueID session hh round day occasion dish quantity carbkcal prokcal fatkcal energytotal
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

sort     uniqueID day 
edit     uniqueID session hh round day occasion dish quantity carbkcal prokcal fatkcal energytotal

***generating the total energy spent accounting the no. of serving (quantity)
gen      double carbkcalspent=round(carbkcal   *quantity, 0.0001)
gen      double prokcalspent =round(prokcal    *quantity, 0.0001)
gen      double fatkcalspent =round(fatkcal    *quantity, 0.0001)
gen      double energyspent  =round(energytotal*quantity, 0.0001)


***computing the energy spent per day for each respondent
collapse (sum) carbkcalspent prokcalspent fatkcalspent energyspent, by (uniqueID day)


***computing the energy spent per occasion for each respondent
collapse (mean) carbkcalspent prokcalspent fatkcalspent energyspent, by (uniqueID)


***computing the calorie shares  among occasions
gen      long carb    =0
gen      long protein =0
gen      long fat     =0

replace  carb         =round(carbkcalspent/energyspent,0.0001)
replace  protein      =round(prokcalspent /energyspent,0.0001)
replace  fat          =round(fatkcalspent /energyspent,0.0001)

label    variable carb    "Share of Carbohydrates consumed per household"
label    variable protein "Share of Protein consumed per household"
label    variable fat     "Share of Fat consumed per household"

/*checking the sum if equal to 1.0 to secure smooth run of fmlogit*/

gen       s0_kcal         =carb+ protein+ fat
edit      carb protein fat s0_kcal


gen       dum_s0_kcal     =3 if s0_kcal>1.0001 & s0_kcal!=.                    /*subtract 0.0002 */
replace   dum_s0_kcal     =2 if s0_kcal>1      & s0_kcal< 1.0002 &  s0_kcal!=. /*subtract 0.0001 */
replace   dum_s0_kcal     =1 if s0_kcal<1      & s0_kcal!=.                    /*add 0.0001*/
replace   dum_s0_kcal     =0 if s0_kcal==1     & s0_kcal!=. 
tab       dum_s0_kcal

*since 100% of the respondents have dinner, it is much easier to adjust the variable to have an exact 1.0 sum of shares
sort      s0_kcal

replace   carb       = carb-0.0001 if dum_s0_kcal==2
replace   carb       = carb+0.0001 if dum_s0_kcal==1
replace   s0_kcal    = carb+ protein+ fat
summarize s0_kcal

drop carbkcalspent prokcalspent fatkcalspent energyspent s0_kcal dum_s0_kcal



merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

***kdensity
twoway kdensity carb if round ==1 || kdensity carb if round ==2 ||kdensity carb if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity protein if round ==1 || kdensity protein if round ==2 ||kdensity protein if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity fat if round ==1 || kdensity fat if round ==2 ||kdensity fat if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity carb || kdensity protein || kdensity fat , ///
                legend(order(1 "carb" 2 "protein" 3 "fat"))

				
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\16analysis_kcalocc.dta", replace


   
