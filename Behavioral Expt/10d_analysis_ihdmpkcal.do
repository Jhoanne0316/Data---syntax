
/*******IDMP BASED ON HDDS**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_ihdmpkcal.dta", clear

describe hdis_starch- widmp_kcal 

twoway kdensity widmp_kcal || kdensity midmp_kcal
summarize hed wed midmp_kcal widmp_kcal
 

************************
*AUG 25
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_ihdmpkcal.dta", clear

fracreg probit widmp_kcal  weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)



