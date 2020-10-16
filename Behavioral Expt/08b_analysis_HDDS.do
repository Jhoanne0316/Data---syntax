/*******INVESTMENT SHARE - HDDS**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_hdds.dta", clear

**variable description
describe  HDDS  ///
		  weekends_both Morning       Kolkata                               ///
          BCC1          BCC2          BCC3                                  ///
		  T1            T2            T3                                    ///
		  PBC_00        hunger_indiv  husband0     wife0                    ///
	      highschool_h  highschool_w  agriocc_h    employed_w               ///
		  inv_allw      ref           incpercap000                          ///
		  source_hlabel source_wlabel hhsize       wchild     wseniors

**desc statistics
sort round
by   round: summarize HDDS  ///
					  weekends_both Morning       Kolkata                               ///
					  BCC1          BCC2          BCC3                                  ///
					  T1            T2            T3                                    ///
					  PBC_00        hunger_indiv  husband0  wife0                       ///
					  highschool_h  highschool_w  agriocc_h employed_w                  ///
					  inv_allw      ref           incpercap000                          ///
					  source_hlabel source_wlabel hhsize    wchild     wseniors
					  
******************************************************************************************
*                           START OF ANALYSIS
******************************************************************************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_hdds.dta", clear

regress HDDS weekends_both          Morning       Kolkata                 ///
		BCC1          BCC2          BCC3                                  ///
	    PBC_00        hunger_indiv  husband0      wife0                       ///
		highschool_h  highschool_w  agriocc_h     employed_w                  ///
		inv_allw      ref           incpercap000                          ///
		source_hlabel source_wlabel hhsize        wchild     wseniors, ///
	    vce (cluster iresid) 
	 

vif /*mean VIF=1.63*/

predict yHDDS

/*checking whether errors are normal*/
gen e=HDDS-yHDDS
swilk e

********************END****************************











*average_hunger
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_HDDS.dta", clear

regress HDDS weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors ave_hunger, ///
	  vce (cluster iresid) 
	 

vif /*mean VIF=1.63*/

predict yHDDS

/*checking whether errors are normal*/
gen e=HDDS-yHDDS
swilk e

/* normal
                 Shapiro-Wilk W test for normal data

    Variable |        Obs       W           V         z       Prob>z
-------------+------------------------------------------------------
           e |        529    0.99767      0.825    -0.465    0.67886


*/


describe HDDS hhsize wchild wseniors ave_hunger
sort round
by round: summarize  HDDS hhsize wchild wseniors ave_hunger


/*******INVESTMENT SHARE - HDDS**********/
*self-reported hunger



clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_regn_HDDS.dta", clear

regress HDDS weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors hunger, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.63*/

predict yHDDS

/*checking whether errors are normal*/
gen e=HDDS-yHDDS
swilk e

/* normal
                 Shapiro-Wilk W test for normal data

    Variable |        Obs       W           V         z       Prob>z
-------------+------------------------------------------------------
           e |        529    0.99767      0.825    -0.465    0.67886


*/


describe HDDS hhsize wchild wseniors ave_hunger hunger
sort round
by round: summarize  HDDS hhsize wchild wseniors hunger



/*******INVESTMENT SHARE - HDDS**********/
*using T1 T2 T3



clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_regn_HDDS.dta", clear

regress HDDS weekends_both Morning Kolkata ///
     T1 T2 T3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors hunger, ///
	  vce (cluster iresid) 
	 

vif 
/*mean VIF=1.63*/

predict yHDDS

/*checking whether errors are normal*/
gen e=HDDS-yHDDS
swilk e

/* normal
                 Shapiro-Wilk W test for normal data

    Variable |        Obs       W           V         z       Prob>z
-------------+------------------------------------------------------
           e |        529    0.99767      0.825    -0.465    0.67886


*/


describe  T1 T2 T3
sort round
by round: summarize   T1 T2 T3r


**********AUG 18 2020**************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_HDDS.dta", clear

regress HDDS weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	  
