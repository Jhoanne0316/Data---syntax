
/*******rice per day**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14b_analysis_rice.dta", clear

describe steamed otherrice allrice stricepercap otricepercap allricepercap logstricepercap logotricepercap logallricepercap
sort round
by round: summarize steamed otherrice allrice stricepercap otricepercap allricepercap logstricepercap logotricepercap logallricepercap

******************
* steamed rice
******************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14b_analysis_rice.dta", clear

regress stricepercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ystricepercap

/*checking whether errors are normal*/
gen e=stricepercap-ystricepercap
swilk e

**does not follow the normal distribution



******************
* log steamed rice
******************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14b_analysis_rice.dta", clear

regress logstricepercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ylogstricepercap

/*checking whether errors are normal*/
gen e=logstricepercap-ylogstricepercap
swilk e

**does not follow the normal distribution



******************
* all rice
******************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14b_analysis_rice.dta", clear

regress allricepercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict yallricepercap

/*checking whether errors are normal*/
gen e=allricepercap-yallricepercap
swilk e

**does not follow the normal distribution



******************
* log all rice
******************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14b_analysis_rice.dta", clear

regress logallricepercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.75*/

predict ylogallricepercap

/*checking whether errors are normal*/
gen e=logallricepercap-ylogallricepercap
swilk e
/*
 
                   Shapiro-Wilk W test for normal data

    Variable |        Obs       W           V         z       Prob>z
-------------+------------------------------------------------------
           e |        529    0.99492      1.800     1.416    0.07840

*/


****AUG 18 2020*********

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14analysis_ricecap.dta", clear

* allocated for Rice per capita
regress logallricepercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	  
	  
vif 
/*mean VIF=1.75*/

predict ylogallricepercap

/*checking whether errors are normal*/
gen e=logallricepercap-ylogallricepercap
swilk e
