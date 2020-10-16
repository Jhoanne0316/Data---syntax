***************************************
*  merging all IHDMP dependent variables
***************************************
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_ihdmpkcal.dta", clear

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_ihdmpfoodexp.dta"
drop _merge

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_ihdmpHDDS.dta"
drop _merge

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13analysis_ihdmpkcalcap.dta"
drop _merge

merge 1:1 iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14analysis_ihdmpricecap.dta"
drop _merge


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000_ihdmp_models.dta", replace

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

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000_ihdmp_models.dta", clear

*************

* allocated for WIDMP

*************
*Food Expenditure
fracreg probit widmp_fexp weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)

margins, dyex(_all)

eststo foodexp

*************

* allocated for Rice per capita
fracreg probit widmp_ricecap weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)

	  
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

* allocated for Calorie distribution among occasionsCalorie distribution among occasions

*************


/*esttab caldist calcap diet using C:\Users\jynion\Desktop\DFC_v1.rtf , title (Econometric results of the nudging experiment) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps unstack*/
esttab using C:\Users\jynion\Desktop\DFC_results.rtf, mtitles title(Econometric results of the nudging experiment)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


