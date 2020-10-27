
*********
* RANDOMIZATION
*********
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta", clear

*************

edit    uniqueID iresid defbudget    ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		hunger_h      hunger_w                            ///
		highschool_h  highschool_w  agriocc_h      employed_w                  ///
		inv_allw      ref           incpercap000   wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize         wchild     wseniors
sort    iresid
drop    if round!=1

regress defbudget    ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		hunger_h      hunger_w                            ///
		highschool_h  highschool_w  agriocc_h      employed_w                  ///
		inv_allw      ref           incpercap000   wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize         wchild     wseniors
		
eststo wkbudget
esttab using C:\Users\jynion\Desktop\000c_random.rtf, mtitles title(Randomization)label star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) pr2(3) onecell nogaps


**************************
sort treatment
by treatment: summarize weekends_both Morning       Kolkata                     ///
		  hunger_h      hunger_w      highschool_h  highschool_w  ///
		  agriocc_h     employed_w   inv_allw       ref           ///
		  incpercap000  wkbudgetpercap00      ///
		  source_hlabel source_wlabel hhsize        wchild     wseniors
