
*******WIDMP**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_ihdmpfoodexp.dta", clear

describe hdis_starch- widmp 
summarize hdis_starch- widmp 

twoway kdensity widmp_fexp || kdensity midmp_fexp

summarize widmp_fexp weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors

************************
*AUG 25
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_ihdmpfoodexp.dta", clear

fracreg probit widmp_fexp weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, vce (cluster iresid)
	 
margins, dyex(_all)

collin weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, corr



