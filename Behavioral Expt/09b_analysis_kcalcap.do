
/*******INVESTMENT SHARE - total calories**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear


describe kcal lnkcal logkcal kcalpercap lnkcalpercap logkcalpercap
sort round
by round: summarize kcal lnkcal logkcal kcalpercap lnkcalpercap logkcalpercap

*********
* kcal
*********

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear

regress kcal weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ykcal

/*checking whether errors are normal*/
gen e=kcal-ykcal
swilk e


*********
* lnkcal
*********

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear

regress lnkcal weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ylnkcal

/*checking whether errors are normal*/
gen e=lnkcal-ylnkcal
swilk e
/*pvalue=0.43045*/

*********
* logkcal
*********

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear

regress logkcal weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ykcal

/*checking whether errors are normal*/
gen e=kcal-ykcal
swilk e



clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear


describe kcal lnkcal logkcal kcalpercap lnkcalpercap logkcalpercap
sort round
by round: summarize kcal lnkcal logkcal kcalpercap lnkcalpercap logkcalpercap

*********
* kcalpercap
*********

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear

regress kcalpercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ykcalpercap

/*checking whether errors are normal*/
gen e=kcalpercap-ykcalpercap
swilk e

*********
* lnkcalpercap
*********

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear

regress lnkcalpercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ylnkcalpercap

/*checking whether errors are normal*/
gen e=lnkcalpercap-ylnkcalpercap
swilk e




*********
* logkcalpercap
*********

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcal.dta", clear

regress logkcalpercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ylogkcalpercap

/*checking whether errors are normal*/
gen e=logkcalpercap-ylogkcalpercap
swilk e




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
