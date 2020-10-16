/******DATA ANALYSIS: food expenditure*******/


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06analysis_foodexp.dta"

**variable description
describe  starch        nonveg        pulses    dairy     veg fruit savings ///
		  weekends_both Morning       Kolkata                               ///
          BCC1          BCC2          BCC3                                  ///
		  T1            T2            T3                                    ///
		  PBC_00        hunger_indiv  husband0     wife0                    ///
	      highschool_h  highschool_w  agriocc_h    employed_w               ///
		  inv_allw      ref           incpercap000                          ///
		  source_hlabel source_wlabel hhsize       wchild     wseniors

**desc statistics
sort round
by   round: summarize starch nonveg pulses dairy veg fruit savings ///
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
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\06analysis_foodexp.dta"


fmlogit savings starch nonveg pulses dairy veg fruit , ///
	  eta(weekends_both Morning       Kolkata                               ///
		  BCC1          BCC2          BCC3                                  ///
	      PBC_00        hunger_indiv  husband0  wife0                       ///
		  highschool_h  highschool_w  agriocc_h employed_w                  ///
		  inv_allw      ref           incpercap000                          ///
		  source_hlabel source_wlabel hhsize    wchild     wseniors)     cluster(iresid)
	 
eststo foodexp
esttab foodexp using C:\Users\jynion\foodexp.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  starch nonveg pulses dairy veg fruit savings {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore foodexp
}
eststo drop foodexp
esttab using C:\Users\jynion\foodexp_ame.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

********************END****************************
