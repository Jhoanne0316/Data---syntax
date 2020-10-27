
*******WIDMP**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06analysis_idmpfoodexp.dta", clear



summarize widmp_fexp weekends_both Morning Kolkata                           ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors

twoway kdensity widmp_fexp || kdensity midmp_fexp


************************
*        START         *
************************
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06analysis_idmpfoodexp.dta", clear

fracreg probit widmp_fexp weekends_both Morning Kolkata               ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, vce (cluster iresid)
	 
margins, dyex(_all)

************************
*        START         *
************************
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06analysis_idmpfoodexp.dta", clear

fracreg probit widmp_fexp weekends_both Morning Kolkata               ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, vce (cluster iresid)
	 
margins, dyex(_all)




