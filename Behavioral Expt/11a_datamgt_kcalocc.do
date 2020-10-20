/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep    uniqueID session hh round day occasion dish quantity energytotal

sort     uniqueID day occasion dish
edit     uniqueID session hh round day occasion dish quantity energytotal

***generating the total energy spent accounting the no. of serving (quantity)
gen      double kcal=round(energytotal*quantity, 0.0001)

***computing the energy spent per occasion per day for each respondent
collapse (sum) kcal, by (uniqueID day occasion)

collapse (mean) kcal, by (uniqueID occasion)

collapse (sum) kcal, by (uniqueID)

rename kcal kcaltotal

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\11analysis_kcalocc.dta", replace

merge m:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta"
drop _merge
*===================================
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


sort     uniqueID day occasion dish
edit uniqueID day occasion occ dish quantity energytotal kcaltotal

***generating the total energy spent accounting the no. of serving (quantity)
gen      double kcal=round(energytotal*quantity, 0.0001)


***computing the energy spent per occasion per day for each respondent
collapse (sum) kcal (mean) occ kcaltotal, by (uniqueID day occasion)

collapse (mean) kcal kcaltotal occ, by (uniqueID occasion)


***computing the energy share per occasion per day for each respondent
gen double kcalshare=round(kcal/kcaltotal,0.0001)


***reshaping the data to wide to create energy spent variable for each occasion
*/
drop     occasion kcal kcaltotal

rename kcalshare kcal

reshape  wide kcal, i(uniqueID) j (occ)


foreach  v of varlist kcal1- kcal5{
         replace `v' =0 if `v'==.
          }
		    

		  
/***need to compute the average daily share of energy per occasion*/


***computing the energy shares  among occasions
 
rename      kcal1 s1_bfast  
rename      kcal2 s2_amsnacks 
rename      kcal3 s3_lunch    
rename      kcal4 s4_pmsnacks 
rename      kcal5 s5_dinner   


/*checking the sum if equal to 1.0 to secure smooth run of fmlogit*/

gen       s0_kcal         =s1_bfast+s2_amsnacks+s3_lunch+s4_pmsnacks+s5_dinner
edit      s1_bfast s2_amsnacks s3_lunch s4_pmsnacks s5_dinner s0_kcal
tab       s0_kcal

sort      s0_kcal
gen       dum_s0_kcal     =3 if s0_kcal>1.0001 & s0_kcal!=.                    /*subtract 0.0002 */
replace   dum_s0_kcal     =2 if s0_kcal>1      & s0_kcal< 1.0002 &  s0_kcal!=. /*subtract 0.0001 */
replace   dum_s0_kcal     =1 if s0_kcal<1      & s0_kcal!=.                    /*add 0.0001*/
replace   dum_s0_kcal     =0 if s0_kcal==1     & s0_kcal!=. 
tab       dum_s0_kcal

*since 100% of the respondents have dinner, it is much easier to adjust the variable to have an exact 1.0 sum of shares
replace   s5_dinner       = s5_dinner-0.0002 if dum_s0_kcal==3
replace   s5_dinner       = s5_dinner-0.0001 if dum_s0_kcal==2
replace   s5_dinner       = s5_dinner+0.0001 if dum_s0_kcal==1
replace   s0_kcal         = s1_bfast+s2_amsnacks+s3_lunch+s4_pmsnacks+s5_dinner
summarize s0_kcal

drop s0_kcal dum_s0_kcal

***labelling the variables
label     variable s1_bfast    "ave daily share of calories during Breakfast"
label     variable s2_amsnacks "ave daily share of calories during AM Snacks"
label     variable s3_lunch    "ave daily share of calories during Lunch"
label     variable s4_pmsnacks "ave daily share of calories during PM Snacks"
label     variable s5_dinner   "ave daily share of calories during Dinner"

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

***kdensity
twoway kdensity s1_bfast if round ==1 || kdensity s1_bfast if round ==2 ||kdensity s1_bfast if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity s2_amsnacks if round ==1 || kdensity s2_amsnacks if round ==2 ||kdensity s2_amsnacks if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity s3_lunch if round ==1 || kdensity s3_lunch if round ==2 ||kdensity s3_lunch if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity s4_pmsnacks if round ==1 || kdensity s4_pmsnacks if round ==2 ||kdensity s4_pmsnacks if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity s5_dinner if round ==1 || kdensity s5_dinner if round ==2 ||kdensity s5_dinner if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity s1_bfast || kdensity s2_amsnacks || kdensity s3_lunch || kdensity s4_pmsnacks || kdensity s5_dinner, ///
                legend(order(1 "Breakfast" 2 "AM Snacks" 3 "Lunch" 4 "PM Snacks" 5 "Dinner"))

				
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\11analysis_kcalocc.dta", replace


   
