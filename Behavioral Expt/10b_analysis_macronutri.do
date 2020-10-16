/******DATA ANALYSIS: NUTRITIONAL OUTCOMES *******/


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_macronutri.dta"

**variable description
describe  carb          protein       fat ///
		  weekends_both Morning       Kolkata                               ///
          BCC1          BCC2          BCC3                                  ///
		  T1            T2            T3                                    ///
		  PBC_00        hunger_indiv  husband0     wife0                    ///
	      highschool_h  highschool_w  agriocc_h    employed_w               ///
		  inv_allw      ref           incpercap000                          ///
		  source_hlabel source_wlabel hhsize       wchild     wseniors

**desc statistics
sort round
by   round: summarize carb          protein       fat  ///
					  weekends_both Morning       Kolkata                               ///
					  BCC1          BCC2          BCC3                                  ///
					  T1            T2            T3                                    ///
					  PBC_00        hunger_indiv  husband0  wife0                       ///
					  highschool_h  highschool_w  agriocc_h employed_w                  ///
					  inv_allw      ref           incpercap000                          ///
					  source_hlabel source_wlabel hhsize    wchild     wseniors

		 

******************************************************************************************
*                           START OF ANALYSIS
******************************************************************************************


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_macronutri.dta"


fmlogit protein carb fat , ///
	  eta(weekends_both Morning       Kolkata                               ///
		  BCC1          BCC2          BCC3                                  ///
	      PBC_00        hunger_indiv  husband0  wife0                       ///
		  highschool_h  highschool_w  agriocc_h employed_w                  ///
		  inv_allw      ref           incpercap000                          ///
		  source_hlabel source_wlabel hhsize    wchild     wseniors)     cluster(iresid)
	 
eststo macronutri
esttab macronutri using C:\Users\jynion\macronutri.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in   carb  protein fat{
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore macronutri
}
eststo drop macronutri

esttab using C:\Users\jynion\macronutri_ame.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

********************END****************************
