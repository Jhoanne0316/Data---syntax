
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


**************************
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
*https://stats.idre.ucla.edu/stata/faq/everything-you-always-wanted-to-know-about-contrasts-but-were-afraid-to-ask/
sort treatment
by treatment: summarize defbudget             weekends_both Morning       Kolkata  ///
		      hunger_h      hunger_w          highschool_h  highschool_w   ///
		      agriocc_h     employed_w        inv_allw      ref           ///
		      incpercap000  wkbudgetpercap00  source_hlabel source_wlabel ///
			  hhsize        wchild            wseniors
			  

*********
* ANOVA
*********
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta", clear

*************
sort    iresid
drop    if round!=1
			  
anova hunger_h treatment
pwcompare treatment, mcompare(duncan) effects group

esttab using r3
 
mat list r(coefs)
mat rename r(coefs) foo2
mat list foo2

esttab foo2 using C:\Users\jynion\Desktop\pwcompare9.rtf, mtitles title(pairwise comparison)label star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) pr(3) onecell nogaps


esttab using C:\Users\jynion\Desktop\pwcompare8.rtf, mtitles title(pairwise comparison)label star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) pr(3) onecell nogaps

