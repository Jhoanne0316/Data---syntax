
/*******IDMP BASED ON HDDS**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_ihdmpHDDS.dta", clear

twoway kdensity widmp_hdds || kdensity midmp_hdds
summarize hed wed midmp_hdds widmp_hdds
 

************************
*AUG 25
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_ihdmpHDDS.dta", clear

fracreg probit widmp_hdds weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)

************************
*OCT 1
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_ihdmpHDDS.dta", clear

fracreg probit widmp_hdds weekends_both Morning Kolkata ///
     T1 T2 T3 PBC_00 hunger ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)



