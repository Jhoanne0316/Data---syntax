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
drop occasion
reshape wide share_carb share_pro share_fat, i(uniqueID) j (occ)

/*converting the variables to long format*/
gen long kcal_carb1=.
gen long kcal_pro1=.
gen long kcal_fat1=.
gen long kcal_carb2=.
gen long kcal_pro2=.
gen long kcal_fat2=.
gen long kcal_carb3=.
gen long kcal_pro3=.
gen long kcal_fat3=.
gen long kcal_carb4=.
gen long kcal_pro4=.
gen long kcal_fat4=.
gen long kcal_carb5=.
gen long kcal_pro5=.
gen long kcal_fat5=.

replace kcal_carb1=round(share_carb1,0.0001)
replace kcal_pro1=round(share_pro1,0.0001)
replace kcal_fat1=round(share_fat1,0.0001)
replace kcal_carb2=round(share_carb2,0.0001)
replace kcal_pro2=round(share_pro2,0.0001)
replace kcal_fat2=round(share_fat2,0.0001)
replace kcal_carb3=round(share_carb3,0.0001)
replace kcal_pro3=round(share_pro3,0.0001)
replace kcal_fat3=round(share_fat3,0.0001)
replace kcal_carb4=round(share_carb4,0.0001)
replace kcal_pro4=round(share_pro4,0.0001)
replace kcal_fat4=round(share_fat4,0.0001)
replace kcal_carb5=round(share_carb5,0.0001)
replace kcal_pro5=round(share_pro5,0.0001)
replace kcal_fat5=round(share_fat5,0.0001)

label variable kcal_carb1 "Bfast-kcal share for carbs"
label variable kcal_pro1 "Bfast-kcal share for protein"
label variable kcal_fat1 "Bfast-kcal share for fat"
label variable kcal_carb2 "AM Snacks-kcal share for carbs"
label variable kcal_pro2 "AM Snacks-kcal share for protein"
label variable kcal_fat2 "AM Snacks-kcal share for fat"
label variable kcal_carb3 "Lunch-kcal share for carbs"
label variable kcal_pro3 "Lunch-kcal share for protein"
label variable kcal_fat3 "Lunch-kcal share for fat"
label variable kcal_carb4 "PM Snacks-kcal share for carbs"
label variable kcal_pro4 "PM Snacks-kcal share for protein"
label variable kcal_fat4 "PM Snacks-kcal share for fat"
label variable kcal_carb5 "Dinner-kcal share for carbs"
label variable kcal_pro5 "Dinner-kcal share for protein"
label variable kcal_fat5 "Dinner-kcal share for fat"

drop share_carb1- share_fat5 hhsize 

/*checking the sum if equal to 1.0 to secure smooth run of fmlogit*/

gen bfastkcal   =kcal_carb1+kcal_pro1+kcal_fat1
gen amsnackkcal =kcal_carb2+kcal_pro2+kcal_fat2
gen lunchkcal   =kcal_carb3+kcal_pro3+kcal_fat3
gen pmsnackkcal =kcal_carb4+kcal_pro4+kcal_fat4
gen dinnerkcal  =kcal_carb5+kcal_pro5+kcal_fat5

label variable bfastkcal   "sum of kcal share for breakfast"
label variable amsnackkcal "sum of kcal share for AM Snacks"
label variable lunchkcal   "sum of kcal share for Lunch"
label variable pmsnackkcal "sum of kcal share for PM Snacks"
label variable dinnerkcal  "sum of kcal share for Dinner"

summarize bfastkcal amsnackkcal lunchkcal pmsnackkcal dinnerkcal
/*
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
   bfastkcal |        521    1.000002    .0000519      .9999     1.0001
 amsnackkcal |        163    .9999951    .0000442      .9999     1.0001
   lunchkcal |        528    1.000002    .0000483      .9999     1.0001
 pmsnackkcal |        396    .9999965     .000046      .9999     1.0001
  dinnerkcal |        529    1.000001    .0000513      .9999     1.0001

*/

/*converting the variable to make an exact 1.0 sum*/
****** breakfast ******
edit      kcal_carb1 kcal_pro1 kcal_fat1 bfastkcal
gen       dum_bfastkcal=0 if bfastkcal==1 & bfastkcal!=.
replace   dum_bfastkcal=1 if bfastkcal<1  & bfastkcal!=. /*add 0.0001*/
replace   dum_bfastkcal=2 if bfastkcal>1  & bfastkcal!=. /*subtract 0.0001*/
tab       dum_bfastkcal

edit      kcal_carb1 kcal_pro1 kcal_fat1 bfastkcal
replace   kcal_pro1   =kcal_pro1+0.0001 if dum_bfastkcal==1
replace   kcal_pro1   =kcal_pro1-0.0001 if dum_bfastkcal==2
replace   bfastkcal   =kcal_carb1+kcal_pro1+kcal_fat1
summarize bfastkcal

****** AM Snacks ******
edit      kcal_carb2 kcal_pro2 kcal_fat2 amsnackkcal
gen       dum_amsnackkcal =0 if amsnackkcal==1 & amsnackkcal!=.
replace   dum_amsnackkcal =1 if amsnackkcal<1  & amsnackkcal!=. /*add 0.0001*/
replace   dum_amsnackkcal =2 if amsnackkcal>1  & amsnackkcal!=. /*subtract 0.0001*/
tab       dum_amsnackkcal

edit      kcal_carb2 kcal_pro2 kcal_fat2 amsnackkcal
replace   kcal_pro2   =kcal_pro2+0.0001 if dum_amsnackkcal==1
replace   kcal_pro2   =kcal_pro2-0.0001 if dum_amsnackkcal==2
replace   amsnackkcal =kcal_carb2+kcal_pro2+kcal_fat2
summarize amsnackkcal

****** Lunch ******
edit      kcal_carb3 kcal_pro3 kcal_fat3 lunchkcal
gen       dum_lunchkcal =0 if lunchkcal==1 & lunchkcal!=.
replace   dum_lunchkcal =1 if lunchkcal<1  & lunchkcal!=. /*add 0.0001*/
replace   dum_lunchkcal =2 if lunchkcal>1  & lunchkcal!=. /*subtract 0.0001*/
tab       dum_lunchkcal

edit      kcal_carb3 kcal_pro3 kcal_fat3 lunchkcal
replace   kcal_pro3   =kcal_pro3+0.0001 if dum_lunchkcal==1
replace   kcal_pro3   =kcal_pro3-0.0001 if dum_lunchkcal==2
replace   lunchkcal   =kcal_carb3+kcal_pro3+kcal_fat3
summarize lunchkcal

****** PM Snacks ******
edit      kcal_carb4 kcal_pro4 kcal_fat4 pmsnackkcal
gen       dum_pmsnackkcal =0 if pmsnackkcal==1 & pmsnackkcal!=.
replace   dum_pmsnackkcal =1 if pmsnackkcal<1  & pmsnackkcal!=. /*add 0.0001*/
replace   dum_pmsnackkcal =2 if pmsnackkcal>1  & pmsnackkcal!=. /*subtract 0.0001*/
tab       dum_pmsnackkcal

edit      kcal_carb4 kcal_pro4 kcal_fat4 pmsnackkcal
replace   kcal_pro4   =kcal_pro4+0.0001 if dum_pmsnackkcal==1
replace   kcal_pro4   =kcal_pro4-0.0001 if dum_pmsnackkcal==2
replace   pmsnackkcal =kcal_carb4+kcal_pro4+kcal_fat4
summarize pmsnackkcal

****** Dinner ******
edit      kcal_carb5 kcal_pro5 kcal_fat5 dinnerkcal
gen       dum_dinnerkcal =0 if dinnerkcal==1 & dinnerkcal!=.
replace   dum_dinnerkcal =1 if dinnerkcal<1  & dinnerkcal!=. /*add 0.0001*/
replace   dum_dinnerkcal =2 if dinnerkcal>1  & dinnerkcal!=. /*subtract 0.0001*/
tab       dum_dinnerkcal

edit      kcal_carb5 kcal_pro5 kcal_fat5 dinnerkcal
replace   kcal_pro5   =kcal_pro5+0.0001 if dum_dinnerkcal==1
replace   kcal_pro5   =kcal_pro5-0.0001 if dum_dinnerkcal==2
replace   dinnerkcal  =kcal_carb5+kcal_pro5+kcal_fat5
summarize dinnerkcal
 **************************
 
summarize bfastkcal amsnackkcal lunchkcal pmsnackkcal dinnerkcal
drop dum_amsnackkcal dum_lunchkcal dum_pmsnackkcal dum_dinnerkcal


merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\15analysis_kcalshares.dta", replace



