***************************************
*  merging all IHDMP dependent variables
***************************************
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06analysis_idmpfoodexp.dta", clear

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_idmpricecap.dta"
drop _merge

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_idmphdds.dta"
drop _merge

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_idmpkcalcap.dta"
drop _merge

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_idmpmacronutri.dta"
drop _merge

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_idmpdishspent.dta"
drop _merge


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000b_idmpmodels.dta", replace

describe widmp_dishspent  weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio  hunger_h       hunger_w           ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors
		 

summarize widmp_dishspent  weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio  hunger_h       hunger_w           ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors
		 


/*VIF*/

collin weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                         ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, corr

collin weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                          ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, corr
********************************
* WIDMP MODELS - hunger level  *
********************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000b_idmpmodels.dta", clear

*************

* allocated for WIDMP

*************
*06Food Expenditure
fracreg probit widmp_fexp weekends_both Morning Kolkata               ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                         ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo foodexp

*************

*07Rice per capita
fracreg probit widmp_ricepercap weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
	  
eststo rice

*************
*08HDDS
fracreg probit widmp_hdds weekends_both Morning Kolkata   north              ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                         ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
	  
eststo HDDS

*************
*09calories per capita
fracreg probit widmp_kcalcap weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                         ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo Calpercap

*************
*10Calorie distribution
fracreg probit widmp_macronutri  weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                         ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo caldist


*************

*12dish spent

fracreg probit widmp_dishspent weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_h       hunger_w                         ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo dishspent

*************

esttab using C:\Users\jynion\Desktop\DFC_widmpame_hdds.rtf, mtitles title(Econometric results of the nudging experiment)label star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) pr2(3) onecell nogaps



********************************
* WIDMP MODELS - hunger ratio  *
********************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000b_idmpmodels.dta", clear

collin weekends_both Morning       Kolkata      north                     ///
		  T1            T2            T3                                ///
	      PBC_00        hunger_indiv  husband0     wife0                ///
		  highschool_h  highschool_w  agriocc_h    employed_w           ///
		  inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		  source_hlabel source_wlabel hhsize       wchild     wsenior, corr
		  

*************
*06Food Expenditure
fracreg probit widmp_fexp weekends_both Morning Kolkata               ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo foodexp

*************

*07Rice per capita
fracreg probit widmp_ricepercap weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
	  
eststo rice

*************
*08HDDS
fracreg probit widmp_hdds weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
	  
eststo HDDS

*************
*09calories per capita
fracreg probit widmp_kcalcap weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo Calpercap

*************
*10Calorie distribution
fracreg probit widmp_macronutri  weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo caldist


*************

*12dish spent

fracreg probit widmp_dishspent weekends_both Morning Kolkata                 ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)
margins, dyex(_all) coeflegend post
eststo dishspent

*************

esttab using C:\Users\jynion\Desktop\DFC_widmpame1.rtf, mtitles title(Econometric results of the nudging experiment)label star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) pr2(3) onecell nogaps

