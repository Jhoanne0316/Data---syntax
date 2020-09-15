/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile_fgocc_comb.dta", clear

edit uniqueID occasion foodgroup_dish day quantity cost value valpercap hhsize
sort uniqueID occasion foodgroup_dish


/*(1)to get the cummulative sum of quantity and cost in two days*/
	collapse (sum) quantity cost value valpercap (mean) hhsize, by (uniqueID occasion foodgroup_dish)
	sort uniqueID occasion foodgroup_dish
	
	rename quantity qty_days
	rename cost cost_days
	rename value value_days
	rename valpercap valpercap_days
	
	
	/*this dataset adds up the quantity and the cost in  two days*/
	save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed01_day.dta", replace



/*(2)to get the total quantity, cost, and value in an occasion*/
	clear all
	use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed01_day.dta", clear
	
	rename qty_days qty_occ
	rename cost_days cost_occ
	rename value_days value_occ
	rename valpercap_days valpercap_occ
	
	collapse (sum) qty_occ cost_occ value_occ valpercap_occ (mean) hhsize, by (uniqueID occasion)
	sort uniqueID occasion
	
	/*this dataset adds up the quantity and the cost of all food groups per occasion*/
	save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed02_day_occ.dta", replace

/*(3)to get the total quantity and total cost per round*/
	clear all
	use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed02_day_occ.dta", clear
	
	rename qty_occ qty_round
	rename cost_occ cost_round
	rename value_occ value_round
	rename valpercap_occ valpercap_round
	
	collapse (sum) qty_round cost_round value_round valpercap_round (mean) hhsize, by (uniqueID)
	
	/*this dataset adds up the quantity and the cost per round*/
	 save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed03_day_occ_round.dta", replace


/*(4)to get the total quantity and cost per foodgroup*/
	clear all
	use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed01_day.dta", clear
	sort uniqueID foodgroup_dish occasion
	
	rename qty_days qty_foodgrp
	rename cost_days cost_foodgrp
	rename value_days value_foodgrp
	rename valpercap_days valpercap_foodgrp
	
	
	collapse (sum) qty_foodgrp cost_foodgrp value_foodgrp valpercap_foodgrp (mean) hhsize, by (uniqueID foodgroup_dish)
	sort uniqueID foodgroup_dish
	/*this dataset adds up the quantity and the cost per foodgroup*/
	 save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed04_day_foodgroup.dta", replace

/**MERGING 1  AND 2**/

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed01_day.dta", clear

	/*to compute the share of each food group in an occasion*/
	merge m:m uniqueID occasion using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed02_day_occ.dta"
	drop _merge
	/*
	    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             5,184  (_merge==3)
    -----------------------------------------
     */

	**to compute quantity and cost share of food group per occasion
	gen shareqty_occ= qty_days/ qty_occ
	replace shareqty_occ=0 if shareqty_occ==.
	
	gen sharecost_occ= cost_days/ cost_occ
	replace sharecost_occ=0 if sharecost_occ==.
	
	gen shareval_occ=value_days/value_occ
	replace shareval_occ=0 if shareval_occ==.
	
	gen sharevalpercap_occ=valpercap_days/valpercap_occ
	replace sharevalpercap_occ=0 if sharevalpercap_occ==.
	
 save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_merge_collapse0102.dta", replace

/**MERGING 3 AND 4**/

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed04_day_foodgroup.dta", clear

	/*to compute the share of each food group in ALL occasion*/
	merge m:m uniqueID using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_collapsed03_day_occ_round.dta"
	drop _merge
	/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             3,174  (_merge==3)
    -----------------------------------------

	*/


	**to compute quantity and cost share of food group in ALL occasion
	gen shareqty_round= qty_foodgrp/ qty_round
	replace shareqty_round=0 if shareqty_round==.
	
	gen sharecost_round= cost_foodgrp/ cost_round
	replace sharecost_round=0 if sharecost_round==.
		
	gen shareval_round= value_foodgrp/ value_round
	replace shareval_round=0 if shareval_round==.
	
	gen sharevalpercap_round= valpercap_foodgrp/ valpercap_round
	replace sharevalpercap_round=0 if sharevalpercap_round==.
	
	
 save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_merge_collapse0304.dta", replace

 /**MERGING ALL collapsed data**/
 
 clear all
 use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_merge_collapse0102.dta", clear

merge m:m uniqueID foodgroup_dish using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_merge_collapse0304.dta"

	/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             5,184  (_merge==3)
    -----------------------------------------
	*/
	
sort uniqueID occasion foodgroup_dish

sort uniqueID foodgroup_dish occasion
drop _merge 

merge m:1 uniqueID using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\00uniqueID.dta"
drop _merge ses hh2 rnd new_vks new_vks2
***checking statistics: share of food group per occasion
tabulate occasion foodgroup_dish if round==3, summarize (shareqty_occ) mean
/*
                           Means of shareqty_occ

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




*/
***checking statistics: share of food group in all occasions
	
	tabulate foodgroup_dish if round==3, summarize (shareqty_round) mean
	
	/*
	
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

	
	*/

save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\test_merge_collapseALL.dta", replace

/***ready for analysis of share of food group in an occasion
example:
tabulate occasion foodgroup_dish if round==3, summarize (shareqty_occ) mean
total of share in an occasion shold be equal to 1.0, Due to nonconsumption of an occasion, we get the nonconumption by deducting the total share to 1.0


*/
/**next step: check the 

****next step is to compute for the per capita share. need to merge hhsize with the collapseALL data
/**PENDING: MERGE RESPONDENT INFO EVEN WITH NO FOOD CONSUMPTION**/


/***MERGE COLLAPSE DATA TO MASTERFILE***
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapseALL.dta", clear
merge m:m uniqueID occasion foodgroup_dish using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile_fgocc_comb.dta"


/*

    -----------------------------------------
    not matched                             0
    matched                            10,215  (_merge==3)
    -----------------------------------------

*/

gen shareqtypercap_occ=shareqty_occ/hhsize
gen sharevalpercap_occ=shareval_occ/hhsize
gen shareqtypercap_rnd=shareqty_round/hhsize
gen sharevalpercap_rnd=shareval_round/hhsize

save "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_analysisfile.dta", replace

 */
