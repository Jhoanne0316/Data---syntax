/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06d_dfc_workingfile.dta", clear

edit uniqueID occasion foodgroup_dish day quantity cost value hhsize carbkcal prokcal fatkcal energytotal
sort uniqueID occasion foodgroup_dish


/*(1)to get the cumulative sum of quantity and cost in two days*/
	collapse (sum) quantity cost value carbkcal prokcal fatkcal energytotal (mean) hhsize, by (uniqueID occasion foodgroup_dish)
	sort uniqueID occasion foodgroup_dish
	
	rename quantity qty_days
	rename cost cost_days
	rename value value_days
	
	rename carbkcal carb_days	
	rename prokcal pro_days
	rename fatkcal fat_days	
	rename energytotal energy_days
				
		
	/*this dataset adds up the quantity and the cost in  two days*/
	save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed01_day.dta", replace



/*(2)to get the total quantity, cost, and value in an occasion*/
	clear all
	use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed01_day.dta", clear
	
	rename qty_days qty_occ
	rename cost_days cost_occ
	rename value_days value_occ
	
	rename carb_days carb_occ	
	rename pro_days pro_occ
	rename fat_days	fat_occ
	rename energy_days energy_occ
	
	collapse (sum) qty_occ cost_occ value_occ carb_occ pro_occ fat_occ energy_occ, by (uniqueID occasion)
	sort uniqueID occasion
	
	/*this dataset adds up the quantity and the cost of all food groups per occasion*/
	save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed02_day_occ.dta", replace

/*(3)to get the total quantity and total cost per round*/
	clear all
	use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed02_day_occ.dta", clear
	
	rename qty_occ qty_round
	rename cost_occ cost_round
	rename value_occ value_round

	rename carb_occ	carb_round
	rename pro_occ pro_round
	rename fat_occ fat_round
	rename energy_occ energy_round
	
	collapse (sum) qty_round cost_round value_round carb_round pro_round fat_round energy_round, by (uniqueID)
	
	/*this dataset adds up the quantity and the cost per round*/
	 save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed03_day_occ_round.dta", replace


/*(4)to get the total quantity and cost per foodgroup*/
	clear all
	use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed01_day.dta", clear
	sort uniqueID foodgroup_dish occasion
	
	rename qty_days qty_foodgrp
	rename cost_days cost_foodgrp
	rename value_days value_foodgrp
	
	rename carb_days carb_foodgrp	
	rename pro_days pro_foodgrp
	rename fat_days	fat_foodgrp
	rename energy_days energy_foodgrp
	
	collapse (sum) qty_foodgrp cost_foodgrp value_foodgrp carb_foodgrp pro_foodgrp fat_foodgrp energy_foodgrp, by (uniqueID foodgroup_dish)
	sort uniqueID foodgroup_dish
	/*this dataset adds up the quantity and the cost per foodgroup*/
	 save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed04_day_foodgroup.dta", replace

/**MERGING 1  AND 2**/

clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed01_day.dta", clear

	/*to compute the share of each food group in an occasion*/
	merge m:m uniqueID occasion using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed02_day_occ.dta"
	drop _merge
	/*
	    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             5,184  (_merge==3)
    -----------------------------------------
	
	April 3 results
	
	
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                            15,870  (_merge==3)==> there are 5,184 rows in the base file
    -----------------------------------------

    May 21, 2020 results
	
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             5,184  (_merge==3)
    -----------------------------------------

     */

	**to compute quantity and cost share of food group per occasion
	edit uniqueID qty_days qty_occ
	gen shareqty_occ= qty_days/ qty_occ
	edit uniqueID qty_days qty_occ shareqty_occ if shareqty_occ==. /*no obs*/
	
	edit uniqueID cost_days cost_occ
	gen sharecost_occ= cost_days/ cost_occ
	edit uniqueID cost_days cost_occ sharecost_occ if sharecost_occ==. /*no obs*/
		
	edit uniqueID value_days value_occ
	gen shareval_occ=value_days/value_occ
	edit uniqueID value_days value_occ shareval_occ if shareval_occ==. /*no obs*/
	
	**to compute quantity share of a food group in an occasion
	**(interpretation: share of carbohydrate during an occasion comes from the foodgroup)
	edit uniqueID carb_days carb_occ
	gen sharecarb_occ=carb_days/carb_occ
	edit uniqueID carb_days carb_occ sharecarb_occ if sharecarb_occ==. /*no obs*/
	
	edit uniqueID pro_days pro_occ
	gen sharepro_occ=pro_days/pro_occ
	edit uniqueID pro_days pro_occ sharepro_occ if sharepro_occ==. /*no obs*/
		
	edit uniqueID fat_days fat_occ
	gen sharefat_occ=fat_days/fat_occ
	edit uniqueID fat_days fat_occ sharefat_occ if sharefat_occ==. /*no obs*/
	
	edit uniqueID energy_days energy_occ 
	gen shareenergy_occ=energy_days/energy_occ
	edit uniqueID energy_days energy_occ shareenergy_occ if shareenergy_occ==. /*no obs*/
	

	**share of carbs in starch dishes during an occasion
	edit uniqueID carb_days energy_day
	gen share_carbocc=carb_days/energy_day
	edit uniqueID carb_days energy_day share_carbocc if share_carbocc==.
	
	edit uniqueID pro_days energy_day
	gen share_proocc=pro_days/energy_day
	edit uniqueID pro_days energy_day share_proocc if share_proocc==.
	
	edit uniqueID fat_days energy_day
	gen share_fatocc=fat_days/energy_day
	edit uniqueID fat_days energy_day share_fatocc if share_fatocc==.

	
/*this was addedd to replace "." to "0"*/
	foreach v of varlist shareqty_occ- share_fatocc {
    replace `v' =0 if `v'==.
  }
	
	
	


 save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapse0102.dta", replace

 
 /*checking the values*/
 clear all
 use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapse0102.dta"
 
 gen energysharetotal=share_carbocc+share_proocc+share_fatocc
 summarize energysharetotal
 /*
 
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
energyshar~l |      5,184           1    1.80e-08   .9999999          1

 */
 
 collapse (sum) shareqty_occ	sharecost_occ	shareval_occ	sharecarb_occ	sharepro_occ	sharefat_occ	shareenergy_occ , by (uniqueID occasion)
 summarize shareqty_occ- shareenergy_occ
 
/*
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
shareqty_occ |      2,137           1    1.62e-08          1          1
sharecost_~c |      2,137           1    1.55e-08          1          1
shareval_occ |      2,137           1    1.67e-08          1          1
sharecarb_~c |      2,137           1    1.51e-08          1          1
sharepro_occ |      2,137           1    1.57e-08          1          1
-------------+---------------------------------------------------------
sharefat_occ |      2,137           1    1.55e-08          1          1
shareenerg~c |      2,137           1    1.53e-08          1          1

*/

/**MERGING 3 AND 4**/

clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed04_day_foodgroup.dta", clear

	/*to compute the share of each food group in ALL occasion*/
	merge m:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\collapsed03_day_occ_round.dta"
	drop _merge
	/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             3,174  (_merge==3) May 26, 2020 results when nonconsumption of food group was included in the data
    -----------------------------------------

	May 22, 2020 result
	    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             2,262  (_merge==3)
    -----------------------------------------

	*/


	**to compute quantity and cost share of food group in ALL occasion
	edit uniqueID occasion foodgroup_dish qty_foodgrp qty_round
	gen shareqty_round= qty_foodgrp/ qty_round
	edit uniqueID qty_foodgrp qty_round shareqty_round if shareqty_round==. /*no obs*/
		
	edit uniqueID cost_foodgrp cost_round
	gen sharecost_round= cost_foodgrp/ cost_round
	edit uniqueID cost_foodgrp cost_round sharecost_round if sharecost_round==. /*no obs*/
		
	edit uniqueID value_foodgrp value_round
	gen shareval_round= value_foodgrp/ value_round
	edit uniqueID value_foodgrp value_round shareval_round if shareval_round==. /*no obs*/
	

**to compute nutrient share of food group in ALL occasion
***share of carbohydrate during in a round(H,W,J) from the foodgroup
	edit uniqueID carb_foodgrp carb_round
	gen sharecarb_round= carb_foodgrp/ carb_round
	edit uniqueID carb_foodgrp carb_round sharecarb_round if sharecarb_round==. /*no obs*/
	
	edit uniqueID pro_foodgrp pro_round
	gen sharepro_round= pro_foodgrp/ pro_round
	edit uniqueID pro_foodgrp pro_round sharepro_round if sharepro_round==. /*no obs*/
	
	edit uniqueID fat_foodgrp fat_round
	gen sharefat_round= fat_foodgrp/ fat_round
	edit uniqueID fat_foodgrp fat_round sharefat_round if sharefat_round==. /*no obs*/

	edit uniqueID energy_foodgrp energy_round
	gen shareenergy_round= energy_foodgrp/ energy_round
	edit uniqueID energy_foodgrp energy_round shareenergy_round if shareenergy_round==.  /*no obs*/

	
***to compute for share of carbs in a foodgroup_dish (all occasion)
	edit uniqueID foodgroup_dish carb_foodgrp energy_foodgrp
	gen share_carbround=carb_foodgrp/energy_foodgrp
	edit uniqueID foodgroup_dish carb_foodgrp energy_foodgrp share_carbround if share_carbround==.  /*no obs*/
	
	edit uniqueID pro_foodgrp energy_foodgrp 
	gen share_proround=pro_foodgrp/energy_foodgrp
	edit uniqueID pro_foodgrp energy_foodgrp  share_proround if share_proround==.  /*no obs*/
	
	edit uniqueID fat_foodgrp energy_foodgrp
	gen share_fatround=fat_foodgrp/energy_foodgrp
	edit uniqueID fat_foodgrp energy_foodgrp share_fatround if share_fatround==.
	
	edit if uniqueID=="0201016010"
		
 save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapse0304.dta", replace

 /**MERGING ALL collapsed data**/
 
 clear all
 use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapse0102.dta", clear

merge m:m uniqueID foodgroup_dish using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapse0304.dta"

	/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             5,184  (_merge==3)
    -----------------------------------------
	
	april 03 results
	    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                            15,870  (_merge==3) May 26, 2020 results when nonconsumption of food group was reflected in the data
    -----------------------------------------

    May 22, 2020 results
	    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             5,184  (_merge==3)
    -----------------------------------------

	*/
	
sort uniqueID occasion foodgroup_dish /*checking share of carbohydrate during in a round(H,W,J) from the foodgroup)*/

sort uniqueID foodgroup_dish occasion
drop _merge 

/*merging session, hh, and round*/
merge m:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\00uniqueID.dta"
drop _merge ses hh2 rnd new_vks new_vks2
***checking statistics: share of food group per occasion
tabulate occasion foodgroup_dish if round==3, summarize (shareqty_occ) mean
/*
                           Means of shareqty_occ with n=15, 870 and zeroes. 

                |                  type
       occasion |     Dairy      Fruit  Non-veg..     Pulses |     Total
----------------+--------------------------------------------+----------
Afternoon Snack | .00308166  .01772022  .00789767  .09429799 | .12429379
      Breakfast | .00265794  .00988661  .02869532  .03906003 | .16384181
         Dinner |  .0460857  .00394353  .07291103  .10250807 | .16666667
          Lunch |  .0099889    .014843  .20395717  .15083191 | .16666667
  Morning Snack | .00385702  .03791372  .00405834  .07046733 | .06497175
----------------+--------------------------------------------+----------
          Total | .01313424  .01686142  .06350391  .09143307 | .13728814

                |        type
       occasion |    Starch  Vegetab.. |     Total
----------------+----------------------+----------
Afternoon Snack | .62115096  .00161421 | .12429379
      Breakfast | .85880871  .04394224 | .16384181
         Dinner | .58875305  .18579863 | .16666667
          Lunch | .44753474   .1728443 | .16666667
  Morning Snack | .25836695  .01516716 | .06497175
----------------+----------------------+----------
          Total | .55492288  .08387331 | .13728814

		  
may 22, 2020 results, n=5,184. this is correct.
                          Means of shareqty_occ

                |                  type
       occasion |     Dairy      Fruit  Non-veg..     Pulses |     Total
----------------+--------------------------------------------+----------
Afternoon Snack | .54545456  .39205991  .34947211  .29804902 | .66000001
      Breakfast | .11761385     .24999  .33860473  .20334195 | .65413534
         Dinner | .18539021  .08725056  .24349534  .20386435 | .35470942
          Lunch | .14733625  .09382893  .24558108  .18411895 | .27272728
  Morning Snack | .34134616  .74563653  .23944193  .31981325 | .56097561
----------------+--------------------------------------------+----------
          Total | .18450486  .24870588  .25315747  .22291533 | .41968912

                |        type
       occasion |    Starch  Vegetab.. |     Total
----------------+----------------------+----------
Afternoon Snack | .84572092   .2857143 | .66000001
      Breakfast | .87361576   .2430555 | .65413534
         Dinner | .58875305  .25692467 | .35470942
          Lunch | .44753474  .21852457 | .27272728
  Morning Snack | .76218249  .26845871 | .56097561
----------------+----------------------+----------
          Total | .68399269  .23867484 | .41968912



*/
***checking statistics: share of food group in all occasions
	
	tabulate foodgroup_dish if round==3, summarize (shareqty_round) mean
	
	/*
	results when n=15,870
              | Summary of
              | shareqty_ro
              |     und
         type |        Mean
--------------+------------
        Dairy |   .01887815
        Fruit |   .01510394
Non-vegetar.. |   .10001524
       Pulses |   .11701673
       Starch |   .62022454
   Vegetables |    .1287614
--------------+------------


             | Summary of
              | shareqty_ro
              |     und
         type |        Mean
--------------+------------
        Dairy |   .07272126
        Fruit |   .06440431
Non-vegetar.. |   .13865123
       Pulses |   .13785425
       Starch |   .61872144
   Vegetables |   .15384579
--------------+------------
        Total |   .33468935

	
	*/
	

replace occasion = "01Breakfast" if occasion =="Breakfast"
replace occasion = "02Morning Snack" if occasion =="Morning Snack"
replace occasion = "03Lunch" if occasion =="Lunch"
replace occasion = "04Afternoon Snack" if occasion =="Afternoon Snack"
replace occasion = "05Dinner" if occasion =="Dinner"


*before May 22, 2020: save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapseALL.dta", replace
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07a_nutrishares.dta", replace

****************************************************
************    DESCRIPTIVE ANALYSIS    ************
****************************************************

clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07a_nutrishares.dta"
/***ready for analysis of share of food group in an occasion
example:
tabulate occasion foodgroup_dish if round==3, summarize (shareqty_occ) mean

note: total of share in an occasion shold be equal to 1.0, Due to nonconsumption of an occasion, we get the nonconumption by deducting the total share to 1.0

*/
 tabulate occasion foodgroup_dish if round==1, summarize (shareqty_occ) mean
 collapse (mean) shareqty_occ	sharecost_occ	shareval_occ	sharecarb_occ	sharepro_occ	sharefat_occ	shareenergy_occ , by (round occasion foodgroup_dish)

 collapse (mean) shareqty_round	sharecost_round	shareval_round	sharecarb_round	sharepro_round	sharefat_round	shareenergy_round	share_carbround	share_proround	share_fatround , by (round occasion foodgroup_dish)

