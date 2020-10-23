
/*******IDMP BASED ON HDDS**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_idmpmacronutri.dta", clear


summarize widmp_macronutri  weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors
		 
		 
twoway kdensity widmp_macronutri || kdensity midmp_macronutri

************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_idmpmacronutri.dta", clear

fracreg probit widmp_macronutri  weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)



