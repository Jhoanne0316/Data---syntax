******************
*  CALORIE SHARE *
******************


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\15analysis_kcalshares.dta"

*****BREAKFAST
fmlogit kcal_pro1 kcal_carb1 kcal_fat1, ///
	    eta(weekends_both Morning Kolkata ///
        BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors) cluster(iresid)
	 
	
eststo bfast
esttab bfast using C:\Users\jynion\bfastkcal.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  kcal_pro1 kcal_carb1 kcal_fat1 {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore bfast
}
eststo drop bfast
esttab using C:\Users\jynion\bfastkcal_ame.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps
