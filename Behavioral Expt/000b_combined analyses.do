***************************************
*  merging all dependent variables
***************************************
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta", clear

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_foodexp.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcal.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_HDDS.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13b_analysis_kcalcap.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14b_analysis_ricecap.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\16analysis_kcalocc.dta"
drop _merge



save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000_econ_models.dta", replace

/*VIF*/

collin weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, corr


*********
* ECON MODELS
*********
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000_econ_models.dta", clear

*************

* allocated for WIDMP

*************
*Food Expenditure
fmlogit savings starch nonveg pulses dairy veg fruit , ///
	  eta(weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors) cluster(iresid)
		
eststo foodexp

foreach o in  starch nonveg pulses dairy veg fruit savings {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore foodexp
}
eststo drop foodexp

*************

* allocated for Rice per capita
regress logallricepercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	  
eststo rice

*************
*HDDS
regress HDDS weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 
	  
eststo HDDS

*************
*calories per capita
regress logkcalpercap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid) 

eststo Calpercap

*************
*Calorie distribution
fmlogit  protein carb fat, ///
	  eta(weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors) cluster(iresid)
		
eststo caldist

foreach o in   carb  protein fat{
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore caldist
}
eststo drop caldist

*************

* allocated for Calorie distribution among occasions
fmlogit s5_dinner s1_bfast s2_amsnacks s3_lunch s4_pmsnacks , ///
	    eta(weekends_both Morning Kolkata ///
        BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors) cluster(iresid)
	 
eststo kcalocc


foreach o in  s1_bfast s2_amsnacks s3_lunch s4_pmsnacks s5_dinner {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore kcalocc
}
eststo drop kcalocc

*************


/*esttab caldist calcap diet using C:\Users\jynion\Desktop\DFC_v1.rtf , title (Econometric results of the nudging experiment) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps unstack*/
esttab using C:\Users\jynion\Desktop\DFC_results_09222020.rtf, mtitles title(Econometric results of the nudging experiment)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


