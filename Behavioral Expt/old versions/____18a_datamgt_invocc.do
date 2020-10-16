/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear


/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/
keep     uniqueID session hh round day occasion foodgroup_dish dish quantity cost hhsize weeklypercapitabudget
sort     uniqueID day occasion

**rescaled to account inflation
gen      double defdishcost     =round(cost/2.85031581297067,0.0001) 

**investment shares is based on this variable
gen      double amtspentperdish =round(quantity*defdishcost,0.0001) 

gen      occ=1 if occasion=="Breakfast"
replace  occ=2 if occasion=="Morning Snack"
replace  occ=3 if occasion=="Lunch"
replace  occ=4 if occasion=="Afternoon Snack"
replace  occ=5 if occasion=="Dinner"

tab      occ occasion

replace  occasion=""
replace  occasion="01Breakfast"       if occ==1
replace  occasion="02Morning Snack"   if occ==2
replace  occasion="03Lunch"           if occ==3
replace  occasion="04Afternoon Snack" if occ==4
replace  occasion="05Dinner"          if occ==5

/*label new variables*/
label    variable amtspentperdish "amount spent per dish"

sort     uniqueID day occasion 
edit     uniqueID session hh round day occasion dish amtspentperdish

***computing the budget spent per occasion per day for each respondent
collapse (sum) amtspentperdish (mean)occ, by (uniqueID day occasion)

***computing the budget spent per occasion for each respondent
sort     uniqueID occasion 
collapse (mean) amtspentperdish (mean) occ, by (uniqueID occasion)

***reshaping the data to create investment variables for each occasion
drop occasion
reshape  wide amtspentperdish, i(uniqueID) j (occ)

*replaceing zero indicating that the respondent did not spend any amount for a particular occasion
foreach v of varlist amtspentperdish1-amtspentperdish5 {
    replace `v' =0 if `v'==.
  }

*compute the average energy shares among occasion
gen      totalamountspent=amtspentperdish1+ amtspentperdish2+ amtspentperdish3+ ///
                          amtspentperdish4+ amtspentperdish5
						  
*generating variables for investment share among occasion
gen long sinv1_bfast    =0
gen long sinv2_amsnacks =0
gen long sinv3_lunch    =0
gen long sinv4_pmsnacks =0
gen long sinv5_dinner   =0

replace  sinv1_bfast    =round(amtspentperdish1/totalamountspent,0.0001)
replace  sinv2_amsnacks =round(amtspentperdish2/totalamountspent,0.0001)
replace  sinv3_lunch    =round(amtspentperdish3/totalamountspent,0.0001)
replace  sinv4_pmsnacks =round(amtspentperdish4/totalamountspent,0.0001)
replace  sinv5_dinner   =round(amtspentperdish5/totalamountspent,0.0001)


/*checking the sum if equal to 1.0 to secure smooth run of fmlogit*/

gen       s0_totalamountspent=sinv1_bfast+sinv2_amsnacks+sinv3_lunch+sinv4_pmsnacks+sinv5_dinner
edit      sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks sinv5_dinner s0_totalamountspent
sort      s0_totalamountspent

gen       dum_s0_totalamountspent=3 if s0_totalamountspent>1.0001 & s0_totalamountspent!=. /*subtract 0.0002 */
replace   dum_s0_totalamountspent=2 if s0_totalamountspent>1      & s0_totalamountspent <1.0002 &  s0_totalamountspent!=. /*subtract 0.0001 */
replace   dum_s0_totalamountspent=1 if s0_totalamountspent<1      & s0_totalamountspent!=. /*add 0.0001*/
replace   dum_s0_totalamountspent=0 if s0_totalamountspent==1     & s0_totalamountspent!=. 
tab       dum_s0_totalamountspent


*since 100% of the respondents have dinner, it is much easier to adjust the variable to have an exact 1.0 sum of shares
replace   sinv5_dinner        = sinv5_dinner-0.0002 if dum_s0_totalamountspent==3
replace   sinv5_dinner        = sinv5_dinner-0.0001 if dum_s0_totalamountspent==2
replace   sinv5_dinner        = sinv5_dinner+0.0001 if dum_s0_totalamountspent==1
replace   s0_totalamountspent = sinv1_bfast+sinv2_amsnacks+sinv3_lunch+sinv4_pmsnacks+sinv5_dinner
summarize s0_totalamountspent

drop      amtspentperdish1 amtspentperdish2 amtspentperdish3 amtspentperdish4 amtspentperdish5 totalamountspent  s0_totalamountspent dum_s0_totalamountspent

***labelling variable description*
 
label     variable sinv1_bfast    "totalamountspent share for Breakfast"
label     variable sinv2_amsnacks "totalamountspent share for AM Snacks"
label     variable sinv3_lunch    "totalamountspent share for Lunch"
label     variable sinv4_pmsnacks "totalamountspent share for PM Snacks"
label     variable sinv5_dinner   "totalamountspent share for Dinner"

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


twoway kdensity sinv1_bfast if round ==1 || kdensity sinv1_bfast if round ==2 ||kdensity sinv1_bfast if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity sinv2_amsnacks if round ==1 || kdensity sinv2_amsnacks if round ==2 ||kdensity sinv2_amsnacks if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity sinv3_lunch if round ==1 || kdensity sinv3_lunch if round ==2 ||kdensity sinv3_lunch if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity sinv4_pmsnacks if round ==1 || kdensity sinv4_pmsnacks if round ==2 ||kdensity sinv4_pmsnacks if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

twoway kdensity sinv5_dinner if round ==1 || kdensity sinv5_dinner if round ==2 ||kdensity sinv5_dinner if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity sinv1_bfast || kdensity sinv2_amsnacks || kdensity sinv3_lunch || kdensity sinv4_pmsnacks || kdensity sinv5_dinner, ///
                legend(order(1 "Breakfast" 2 "AM Snacks" 3 "Lunch" 4 "PM Snacks" 5 "Dinner"))

				
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\18analysis_invocc.dta", replace


   
