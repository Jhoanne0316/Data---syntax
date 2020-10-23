**************************************
*  CALORIE SHARE AMONG OCCASION (BCC)*
**************************************


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\11analysis_kcalocc.dta"

**variable description
describe  s1_bfast      s2_amsnacks   s3_lunch     s4_pmsnacks    s5_dinner ///
					  weekends_both Morning       Kolkata                               ///
					  T1            T2            T3                                    ///
					  PBC_00        hunger_indiv  husband0  wife0                       ///
					  highschool_h  highschool_w  agriocc_h employed_w                  ///
					  inv_allw      ref           incpercap000    wkbudgetpercap00                      ///
					  source_hlabel source_wlabel hhsize    wchild     wseniors

**desc statistics
sort round
by   round: summarize s1_bfast      s2_amsnacks   s3_lunch     s4_pmsnacks    s5_dinner ///
					  weekends_both Morning       Kolkata                               ///
					  T1            T2            T3                                    ///
					  PBC_00        hunger_indiv  husband0  wife0                       ///
					  highschool_h  highschool_w  agriocc_h employed_w                  ///
					  inv_allw      ref           incpercap000    wkbudgetpercap00                      ///
					  source_hlabel source_wlabel hhsize    wchild     wseniors

		 

******************************************************************************************
*                           START OF ANALYSIS
******************************************************************************************


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\11analysis_kcalocc.dta"


fmlogit   s5_dinner     s1_bfast      s2_amsnacks   s3_lunch   s4_pmsnacks, ///
	      eta(weekends_both Morning       Kolkata                               ///
			  T1            T2            T3                                    ///
			  PBC_00        hunger_indiv  husband0  wife0                       ///
			  highschool_h  highschool_w  agriocc_h employed_w                  ///
			  inv_allw      ref           incpercap000    wkbudgetpercap00                      ///
			  source_hlabel source_wlabel hhsize    wchild     wseniors)     ///
			  cluster(iresid)
	 
eststo kcalocc
esttab kcalocc using C:\Users\jynion\11kcalocc.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  s1_bfast      s2_amsnacks   s3_lunch     s4_pmsnacks    s5_dinner {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore kcalocc
}
eststo drop kcalocc
esttab using C:\Users\jynion\11kcalocc_ame.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps



		 