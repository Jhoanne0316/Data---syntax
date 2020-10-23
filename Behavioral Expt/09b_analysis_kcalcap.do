/******* TOTAL CALORIES per capita**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcalcap.dta", clear

**variable description
describe  kcalcap       logkcalcap  ///
		  weekends_both Morning       Kolkata                               ///
		  T1            T2            T3                                    ///
		  PBC_00        hunger_indiv  husband0  wife0                       ///
		  highschool_h  highschool_w  agriocc_h employed_w                  ///
		  inv_allw      ref           incpercap000    wkbudgetpercap00                      ///
		  source_hlabel source_wlabel hhsize    wchild     wseniors

**desc statistics
sort round
by   round: summarize kcalcap       logkcalcap   ///
					  weekends_both Morning       Kolkata                               ///
						T1            T2            T3                                    ///
						PBC_00        hunger_indiv  husband0  wife0                       ///
						highschool_h  highschool_w  agriocc_h employed_w                  ///
						inv_allw      ref           incpercap000    wkbudgetpercap00                      ///
						source_hlabel source_wlabel hhsize    wchild     wseniors
					  
******************************************************************************************
*                           START OF ANALYSIS
******************************************************************************************

********************************************			  
**  OLS:kcalcap  
*result: non-normally distributed errors   *
********************************************	

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcalcap.dta", clear
	  
regress kcalcap                               ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000    wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize    wchild     wseniors, ///
	    vce (cluster iresid) 

predict ykcalcap

/*checking whether errors are normal*/
gen     e=kcalcap-ykcalcap
swilk   e

******************************
* logarithmic:logricepercap  *
******************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcalcap.dta", clear
				  
regress logkcalcap    weekends_both Morning       Kolkata                               ///
		BCC1          BCC2          BCC3                                  ///
	    PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000                          ///
		source_hlabel source_wlabel hhsize    wchild     wseniors, ///
	    vce (cluster iresid) 

predict ylogkcalcap

/*checking whether errors are normal*/
gen     e2=logkcalcap-ylogkcalcap
swilk   e2


********************END****************************



************************************
* logkcalpercap - AUG 19 2020
************************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13analysis_kcalcap.dta", clear

*calories per capita
regress logkcalpercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 

eststo Calpercap
