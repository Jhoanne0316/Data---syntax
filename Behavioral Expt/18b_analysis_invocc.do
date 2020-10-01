***********************************
*  INVESTMENT SHARE AMONG OCCASION*
***********************************


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\18analysis_invocc.dta"

describe sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks sinv5_dinner ///
		weekends_both Morning Kolkata ///
        BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors

sort round
by round: summarize sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks sinv5_dinner ///
		weekends_both Morning Kolkata ///
        BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors


fmlogit sinv5_dinner sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks , ///
	    eta(weekends_both Morning Kolkata ///
        BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors) cluster(iresid)
	 
	
eststo invocc
esttab invocc using C:\Users\jynion\invocc.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks sinv5_dinner {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore invocc
}
eststo drop invocc
esttab using C:\Users\jynion\invoccl_ame.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


***************************************************
*  INVESTMENT SHARE AMONG OCCASION USING TRMT VARS*
***************************************************


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\18analysis_invocc.dta"

describe sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks sinv5_dinner ///
		weekends_both Morning Kolkata ///
        T1 T2 T3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors

sort round
by round: summarize sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks sinv5_dinner ///
		weekends_both Morning Kolkata ///
        T1 T2 T3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors


fmlogit sinv5_dinner sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks , ///
	    eta(weekends_both Morning Kolkata ///
        T1 T2 T3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors) cluster(iresid)
	 
	
eststo invocc
esttab invocc using C:\Users\jynion\invocc_v2.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  sinv1_bfast sinv2_amsnacks sinv3_lunch sinv4_pmsnacks sinv5_dinner {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore invocc
}
eststo drop invocc
esttab using C:\Users\jynion\invoccl_amev2.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps
