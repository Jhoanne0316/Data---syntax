/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear


/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/
keep     uniqueID session hh round day occasion foodgroup_dish dish quantity ///
         cost hhsize weeklypercapitabudget
sort     uniqueID day occasion

/**generating the deflated budget as the basis for total budget received by the ///
   household, rescaled to account inflation*/
gen      double defdishcost     =round(cost/2.85031581297067,0.0001) 

**investment shares is based on this variable
gen      double amtspentperdish =round(quantity*defdishcost,0.0001) 

gen       foodgroup=1 if foodgroup_dish=="Starch"
replace   foodgroup=2 if foodgroup_dish=="Non-vegetarian"
replace   foodgroup=3 if foodgroup_dish=="Pulses"
replace   foodgroup=4 if foodgroup_dish=="Dairy"
replace   foodgroup=5 if foodgroup_dish=="Vegetables"
replace   foodgroup=6 if foodgroup_dish=="Fruit"

replace   foodgroup_dish=""
replace   foodgroup_dish="01Starch"         if foodgroup==1
replace   foodgroup_dish="02Non-vegetarian" if foodgroup==2
replace   foodgroup_dish="03Pulses"         if foodgroup==3
replace   foodgroup_dish="04Dairy"          if foodgroup==4
replace   foodgroup_dish="05Vegetables"     if foodgroup==5
replace   foodgroup_dish="06Fruit"          if foodgroup==6

/*label new variables*/
label    variable amtspentperdish "amount spent per dish"

sort     uniqueID foodgroup_dish 
edit     uniqueID session hh round day foodgroup_dish dish amtspentperdish

***computing the budget spent per foodgroup_dish for each respondent
*note: compute sum for two days since budget is for two days 

sort     uniqueID foodgroup_dish

collapse (sum) amtspentperdish (mean) foodgroup, by (uniqueID foodgroup_dish)
rename   amtspentperdish amtspentperfoodgrp

***reshaping the data to create investment variables for each foodgroup
drop     foodgroup_dish
reshape  wide amtspentperfoodgrp, i(uniqueID) j (foodgroup)

*replaceing zero indicating that the respondent did not spend any amount for a particular food group
foreach  v of varlist amtspentperfoodgrp1-amtspentperfoodgrp6 {
         replace `v' =0 if `v'==.
          }

*compute the average energy shares among foodgroup
gen      totalamountspent=amtspentperfoodgrp1+ amtspentperfoodgrp2+ amtspentperfoodgrp3+ ///
                          amtspentperfoodgrp4+ amtspentperfoodgrp5+ amtspentperfoodgrp6
						  
						  
merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

***********************************************
*  adjustments on exces spending from the app *
***********************************************

/**generating the deflated budget as the basis for total budget received by the ///
   household, rescaled to account inflation*/
   
gen       double defbudget   =round(weeklypercapitabudget/2.85031581297067,0.0001)

**computing totalbudget to be used as the denominator for computing the shares
gen       double totalbudget =round(defbudget*hhsize,0.0001)
gen       double unspentbudget=round(totalbudget-totalamountspent,0.0001)

label     variable defbudget   "received weeklypercapitabudget for two days (adjusted to inflation)"
label     variable totalbudget "received household budget for two days (adjusted to inflation)"
label     variable unspentbudget   "total amount unspent in the budget"

edit      uniqueID  totalamountspent unspentbudget totalbudget 
*************************************************
/*check whether the total amtspentperdish is equal to the total budget
**do not include in the analysis. This section is to check whether total 
amtspentperdish does not have an excess on total budget */

gen       excess=1 if unspentbudget<0
replace   excess=0 if unspentbudget>=0
summarize unspent if excess==1 /*44 obs*/


/**to adjust excess spending from the app, the excessive budget was takes as 
   the randomized budget for the household */
   
edit      uniqueID  totalamountspent unspentbudget totalbudget if excess==1

replace   totalbudget=totalamountspent if excess==1
replace   unspentbudget=totalbudget-totalamountspent
replace   excess=1 if unspentbudget<0
*************************************************

*generating variables for investment share among food group
gen       long starch =0
gen       long nonveg =0
gen       long pulses =0
gen       long dairy  =0
gen       long veg    =0
gen       long fruit  =0
gen       long savings=0

replace   starch  =round(amtspentperfoodgrp1/totalbudget,0.0001)
replace   nonveg  =round(amtspentperfoodgrp2/totalbudget,0.0001)
replace   pulses  =round(amtspentperfoodgrp3/totalbudget,0.0001)
replace   dairy   =round(amtspentperfoodgrp4/totalbudget,0.0001)
replace   veg     =round(amtspentperfoodgrp5/totalbudget,0.0001)
replace   fruit   =round(amtspentperfoodgrp6/totalbudget,0.0001)
replace   savings =round(unspentbudget      /totalbudget,0.0001)

/*checking the sum if equal to 1.0 to secure smooth run of fmlogit*/

gen       double  s0_totalamountspent=round(starch+ nonveg+ pulses+ dairy+ veg+ fruit+ savings,0.0001)

edit      starch- savings s0_totalamountspent
sort      s0_totalamountspent

gen       dum_s0_totalamountspent=3  if s0_totalamountspent>1.0001 & ///
          s0_totalamountspent!=. /*subtract 0.0002 */
replace   dum_s0_totalamountspent=2  if s0_totalamountspent>1  ///
          & s0_totalamountspent <1.0002 &  s0_totalamountspent!=. 
		  /*subtract 0.0001 */
replace   dum_s0_totalamountspent=1  if s0_totalamountspent<1  ///
          & s0_totalamountspent!=. /*add 0.0001*/
replace   dum_s0_totalamountspent=-1 if s0_totalamountspent<1  ///
          & s0_totalamountspent < 0.9999 /*add 0.0001*/
replace   dum_s0_totalamountspent=0  if s0_totalamountspent==1  ///
          & s0_totalamountspent!=. 
tab       dum_s0_totalamountspent


*it is more logical to adjust the unspent budget to have an exact 1.0 sum of shares
replace   savings        = savings-0.0002 if dum_s0_totalamountspent==3
replace   savings        = savings-0.0001 if dum_s0_totalamountspent==2
replace   savings        = savings+0.0001 if dum_s0_totalamountspent==1
replace   savings        = savings+0.0002 if dum_s0_totalamountspent==-1
replace   s0_totalamountspent=starch+ nonveg+ pulses+ dairy+ veg+ fruit+ savings

summarize s0_totalamountspent

drop      amtspentperfoodgrp1 amtspentperfoodgrp2 amtspentperfoodgrp3 ///
          amtspentperfoodgrp4 amtspentperfoodgrp5 amtspentperfoodgrp6 ///
		  totalamountspent  s0_totalamountspent dum_s0_totalamountspent ///
		  excess unspentbudget

***labelling variable description*

label     variable starch  "Starch-food expenditure shares"
label     variable nonveg  "Nonveg-food expenditure shares"
label     variable pulses  "Pulses-food expenditure shares"
label     variable dairy   "Dairy-food expenditure shares"
label     variable veg     "Veg-food expenditure shares"
label     variable fruit   "Fruit-food expenditure shares"
label     variable savings "Savings-food expenditure shares"

sort uniqueID
edit uniqueID starch nonveg pulses dairy veg fruit savings

twoway    kdensity starch if round ==1 || kdensity starch if round ==2 ///
                                       || kdensity starch if round ==3, ///
                   legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway    kdensity nonveg if round ==1 || kdensity nonveg if round ==2 ///
                                       || kdensity nonveg if round ==3, ///
                   legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway    kdensity pulses  if round ==1 || kdensity pulses if round ==2 ///
                                        || kdensity pulses if round ==3, ///
                   legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway    kdensity dairy   if round ==1 || kdensity dairy if round ==2 ///
                                        || kdensity dairy if round ==3, ///
                   legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway    kdensity veg     if round ==1 || kdensity veg   if round ==2 ///
                                        || kdensity veg   if round ==3, ///
                   legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway    kdensity fruit   if round ==1 || kdensity fruit if round ==2 ///
                                        || kdensity fruit if round ==3, ///
                   legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway    kdensity savings if round ==1 || kdensity savings if round ==2 ///
                                        ||  kdensity savings if round ==3, ///
                  legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway    kdensity starch || kdensity nonveg || kdensity pulses || kdensity dairy ///
                          || kdensity veg    || kdensity fruit  || kdensity savings, ///
                  legend(order(1 "Starch"     2 "Non-veg" 3 "Pulses" 4 "Dairy" ///
				               5 "Vegetables" 6 "Fruit"   7 "Savings"))

				
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_foodexp.dta", replace


   
