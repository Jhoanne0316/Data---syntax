******************************************************************************************
*                           output for July 29, 2020 webinar
******************************************************************************************


*****************************************
**Intermediate outcome: food choice
*****************************************

clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_fg.dta"

collin 	BCC1 BCC2 BCC3 PBC_00 weekends_both Kolkata  husband0 wife0 Morning ///
		incpercap000 highschool_h highschool_w work_hfull work_whousewife ///
		inv_allw caste ref source_hlabel source_wlabel
*result: Mean VIF 

fmlogit  starch nonveg pulses dairy veg fruit unspent , ///
	  eta(BCC1 BCC2 BCC3 PBC_00 weekends_both Kolkata  husband0 wife0 Morning ///
		incpercap000 highschool_h highschool_w work_hfull work_whousewife ///
		inv_allw caste ref source_hlabel source_wlabel) cluster(iresid)
eststo fmlogit
esttab fmlogit using C:\Users\jynion\DFCdepvars_imdoutcome.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  starch nonveg pulses dairy veg fruit unspent {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using C:\Users\jynion\DFCdepvars_MEBD_imdoutcome.rtf, mtitles title(Average Marginal Effects)label star(** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps



*****************************************
***Final outcome: calorie distribution
*****************************************

clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

collin 	BCC1 BCC2 BCC3 PBC_00 weekends_both Kolkata  husband0 wife0 Morning ///
		incpercap000 highschool_h highschool_w work_hfull work_whousewife ///
		inv_allw caste ref source_hlabel source_wlabel
		
*result: Mean VIF 1.61

fmlogit  protein carb fat, ///
	  eta(BCC1 BCC2 BCC3 PBC_00 weekends_both Kolkata  husband0 wife0 Morning ///
		incpercap000 highschool_h highschool_w work_hfull work_whousewife ///
		inv_allw caste ref source_hlabel source_wlabel) cluster(iresid)
eststo fmlogit
esttab fmlogit using C:\Users\jynion\DFCdepvars_finaloutcome.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  protein carb fat {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using C:\Users\jynion\DFCdepvars_MEBD_finaloutcome.rtf, mtitles title(Average Marginal Effects)label star(** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

