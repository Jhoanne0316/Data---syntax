
/*******IDMP BASED ON ricecap**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14analysis_ihdmpricecap.dta", clear

twoway kdensity widmp_ricecap || kdensity midmp_ricecap
summarize hed wed midmp_ricecap widmp_ricecap
 

************************
*AUG 25
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14analysis_ihdmpricecap.dta", clear

fracreg probit widmp_ricecap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)


*TESTING 456
