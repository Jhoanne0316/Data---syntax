/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep    uniqueID session hh round treatment urbanity day occasion carbkcal prokcal fatkcal energytotal hhsize

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


edit uniqueID session hh round day occasion carbkcal prokcal fatkcal energytotal

collapse (sum) carbkcal prokcal fatkcal energytotal (mean) hhsize occ, by (uniqueID day occasion)

sort uniqueID occasion 
collapse (mean) carbkcal prokcal fatkcal energytotal hhsize occ, by (uniqueID occasion)
drop occasion
reshape wide carbkcal prokcal fatkcal energytotal, i(uniqueID) j (occ)

keep uniqueID energytotal1 energytotal2 energytotal3 energytotal4 energytotal5

replace energytotal1=0 if energytotal1==.
replace energytotal2=0 if energytotal2==.
replace energytotal3=0 if energytotal3==.
replace energytotal4=0 if energytotal4==.
replace energytotal5=0 if energytotal5==.

*compute the average energy shares among occasion
gen kcal=energytotal1+ energytotal2+ energytotal3+ energytotal4+ energytotal5
gen long s1_bfast=0
gen long s2_amsnacks=0
gen long s3_lunch=0
gen long s4_pmsnacks=0
gen long s5_dinner=0

replace s1_bfast    =round(energytotal1/kcal,0.0001)
replace s2_amsnacks =round(energytotal2/kcal,0.0001)
replace s3_lunch    =round(energytotal3/kcal,0.0001)
replace s4_pmsnacks =round(energytotal4/kcal,0.0001)
replace s5_dinner   =round(energytotal5/kcal,0.0001)


/*checking the sum if equal to 1.0 to secure smooth run of fmlogit*/

gen       s0_kcal=s1_bfast+s2_amsnacks+s3_lunch+s4_pmsnacks+s5_dinner
edit      s1_bfast s2_amsnacks s3_lunch s4_pmsnacks s5_dinner s0_kcal
gen       dum_s0_kcal=0 if s0_kcal==1 & s0_kcal!=.
replace   dum_s0_kcal=1 if s0_kcal<1  & s0_kcal!=. /*add 0.0001*/
replace   dum_s0_kcal=2 if s0_kcal==1.0001  /*subtract 0.0001 */
replace   dum_s0_kcal=3 if s0_kcal==1.0002 /*subtract 0.0002 */
tab       dum_s0_kcal

sort  s0_kcal
replace   s5_dinner   =s5_dinner+0.0001 if dum_s0_kcal==1
replace   s5_dinner   =s5_dinner-0.0001 if s0_kcal==1.0002
replace   s5_dinner   =s5_dinner-0.0001 if dum_s0_kcal==2

replace   s0_kcal     =s1_bfast+s2_amsnacks+s3_lunch+s4_pmsnacks+s5_dinner
summarize bfastkcal


   
