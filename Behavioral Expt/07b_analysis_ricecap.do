
/*******rice per day**********/

clear all

use     "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_ricecap.dta", clear

**variable description
describe  ricepercap ///
		  weekends_both Morning       Kolkata                               ///
		  T1            T2            T3                                    ///
		  PBC_00        hunger_indiv  husband0     wife0                    ///
	      highschool_h  highschool_w  agriocc_h    employed_w               ///
		  inv_allw      ref           incpercap000 wkbudgetpercap00         ///
		  source_hlabel source_wlabel hhsize       wchild     wseniors

**desc statistics
sort round
by   round: summarize ricepercap ///
					  weekends_both Morning       Kolkata                               ///
					  T1            T2            T3                                    ///
					  PBC_00        hunger_indiv  husband0  wife0                       ///
					  highschool_h  highschool_w  agriocc_h employed_w                  ///
					  inv_allw      ref           incpercap000    wkbudgetpercap00                      ///
					  source_hlabel source_wlabel hhsize    wchild     wseniors


******************************************************************************************
*                           START OF ANALYSIS
******************************************************************************************


clear all

use     "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_ricecap.dta", clear

********************************************			  
**  OLS:ricepercap  
*result: not normally distributed errors   *
********************************************	
					  
regress ricepercap    ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000    wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize    wchild     wseniors, ///
	    vce (cluster iresid) 

predict yricepercap

/*checking whether errors are normal*/
gen     e=ricepercap-yricepercap
swilk   e

/*****************************************
 logarithmic:logricepercap  
result: not normally distributed errors 
******************************************/

clear all

use     "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_ricecap.dta", clear
			  
regress logricepercap weekends_both Morning       Kolkata                 ///
		T1            T2            T3                                    ///
		PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000    wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize    wchild     wseniors,        ///
	    vce (cluster iresid) 

predict ylogricepercap

/*checking whether errors are normal*/
gen     e2=logricepercap-ylogricepercap
swilk   e2



/*****************************************
 square-root transformation :sqrtricepercap  
result: not normally distributed errors 
******************************************/

clear all

use     "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_ricecap.dta", clear
			  
regress sqrtricepercap weekends_both Morning       Kolkata                 ///
		T1            T2            T3                                    ///
		PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000    wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize    wchild     wseniors,        ///
	    vce (cluster iresid) 

predict ysqrtricepercap

/*checking whether errors are normal*/
gen     e3=sqrtricepercap-ysqrtricepercap
swilk   e3

********************END****************************
