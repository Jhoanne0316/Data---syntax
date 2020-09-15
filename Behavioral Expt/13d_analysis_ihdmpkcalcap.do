
/*******IDMP BASED ON kcalcap**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13analysis_ihdmpkcalcap.dta", clear

twoway kdensity widmp_kcalcap || kdensity midmp_kcalcap
summarize hed wed midmp_kcalcap widmp_kcalcap
 

************************
*AUG 25
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13analysis_ihdmpkcalcap.dta", clear

fracreg probit widmp_kcalcap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)



