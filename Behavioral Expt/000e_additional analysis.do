

*********
* ECON MODELS
*********
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta", clear

sort    iresid
drop    if round!=1

summarize     defbudget     weekends_both     Morning   ///
              north         Kolkata           PBC_00 ///
		      hunger_h      hunger_w          highschool_h  highschool_w   ///
		      agriocc_h     employed_w        inv_allw      ref           ///
		      incpercap000  wkbudgetpercap00  source_hlabel source_wlabel ///
			  hhsize        wchild            wseniors
			  
sort treatment
by treatment:summarize     defbudget     weekends_both     Morning   ///
              north         Kolkata           PBC_00///
		      hunger_h      hunger_w          highschool_h  highschool_w   ///
		      agriocc_h     employed_w        inv_allw      ref           ///
		      incpercap000  wkbudgetpercap00  source_hlabel source_wlabel ///
			  hhsize        wchild            wseniors
			  
tab session treatment

* Is there a correlation between the “wives being employed dummy” and “weekly per capita food budget” and income?

pwcorr agriocc_h employed_w incpercap000  wkbudgetpercap00, sig


/*What was the average household size in Kolkata and the rural areas based on the 
 consumer surveys from where we sampled food budgets? And in our behavioral experiment? */

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food Habit 2018\dataset01_foodhabit.dta",clear

sort Kolkata
by Kolkata: summarize hhsize
