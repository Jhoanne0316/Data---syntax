***************************************
*  merging all dependent variables
***************************************
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta", clear

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06analysis_foodexp.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_ricecap.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_hdds.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcalcap.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_macronutri.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\11analysis_kcalocc.dta"
drop _merge



save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta", replace

*********
* ECON MODELS
*********
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta", clear

*************

* allocated for WIDMP

*************
*06b_analysis_foodexp
fmlogit savings starch nonveg pulses dairy veg fruit ,                  ///
	  eta(weekends_both Morning       Kolkata                           ///
		  T1            T2            T3                                ///
	      PBC_00        hunger_indiv  husband0     wife0                ///
		  highschool_h  highschool_w  agriocc_h    employed_w           ///
		  inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		  source_hlabel source_wlabel hhsize       wchild     wseniors) ///
		  cluster(iresid)
	 
eststo foodexp

foreach o in  starch nonveg pulses dairy veg fruit savings {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore foodexp
}
eststo drop foodexp

*************

* 07b_analysis_ricecap
regress ricepercap    ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000    wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize    wchild     wseniors, ///
	    vce (cluster iresid) 
	  
eststo ricecap

esttab using C:\Users\jynion\Desktop\ricecap.rtf, mtitles title(Econometric results of the nudging experiment)label star(* 0.10 ** 0.05 *** 0.01 ****0.000526316) b(3) se(3) pr2(3) onecell nogaps


*************
*08b_analysis_hdds
regress HDDS              ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000    wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize    wchild     wseniors, ///
	    vce (cluster iresid) 
	  
eststo hdds

*************
*09b_analysis_kcalcap


regress kcalcap                               ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		PBC_00        hunger_indiv  husband0  wife0                       ///
		highschool_h  highschool_w  agriocc_h employed_w                  ///
		inv_allw      ref           incpercap000    wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize    wchild     wseniors, ///
	    vce (cluster iresid) 

eststo kcalcap

*************
*10b_analysis_macronutri
fmlogit protein carb fat , ///
	  eta(weekends_both Morning       Kolkata                           ///
		  T1            T2            T3                                ///
	      PBC_00        hunger_indiv  husband0     wife0                ///
		  highschool_h  highschool_w  agriocc_h    employed_w           ///
		  inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		  source_hlabel source_wlabel hhsize       wchild     wseniors) ///
		  cluster(iresid)
	 
eststo macronutri

foreach o in   carb  protein fat{
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore macronutri
}
eststo drop macronutri


*************
* 11b_analysis_kcalocc
fmlogit   s5_dinner     s1_bfast      s2_amsnacks   s3_lunch   s4_pmsnacks, ///
	  eta(weekends_both Morning       Kolkata                           ///
		  T1            T2            T3                                ///
	      PBC_00        hunger_indiv  husband0     wife0                ///
		  highschool_h  highschool_w  agriocc_h    employed_w           ///
		  inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		  source_hlabel source_wlabel hhsize       wchild     wseniors)     cluster(iresid)
	 
eststo kcalocc


foreach o in  s1_bfast      s2_amsnacks   s3_lunch     s4_pmsnacks    s5_dinner {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore kcalocc
}
eststo drop kcalocc
*************


/*esttab caldist calcap diet using C:\Users\jynion\Desktop\DFC_v1.rtf , title (Econometric results of the nudging experiment) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps unstack*/
esttab using C:\Users\jynion\Desktop\000a_modelsame.rtf, mtitles title(Econometric results of the nudging experiment)label star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) pr2(3) onecell nogaps


