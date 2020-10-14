/******DATA ANALYSIS: NUTRITIONAL OUTCOMES - 09analysis_nutri_outcome_v1.0*******/

**general analysis

clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_fg.dta"

describe starch nonveg pulses dairy veg fruit unspent ///
         weekends weekends_both north Morning Kolkata ///
         BCC1 BCC2 BCC3 T1 T2 T3 PBC_00 PSBC husband0 wife0 ///
		 age_h age_w highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw hunger_h hunger_w enough_h enough_w  ///
		 prop_child prop_teens prop_adults prop_seniors ///
		 low_inc caste ref incpercap000  ///
		 source_hTV source_hTVrad source_hwom source_hlabel ///
		 source_wTV source_wTVrad source_wretail source_wlabel  ///
		 wkmarket grocery hypermarket otherstore  ///
		 wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice  ///
		 store_modern store_tradonly freq_riceconv youngadult_h youngadult_w



sort round
by round: summarize starch nonveg pulses dairy veg fruit unspent ///
         weekends weekends_both north Morning Kolkata ///
         BCC1 BCC2 BCC3 T1 T2 T3 PBC_00 PSBC husband0 wife0 ///
		 age_h age_w highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw hunger_h hunger_w enough_h enough_w  ///
		 prop_child prop_teens prop_adults prop_seniors ///
		 low_inc caste ref incpercap000  ///
		 source_hTV source_hTVrad source_hwom source_hlabel ///
		 source_wTV source_wTVrad source_wretail source_wlabel  ///
		 wkmarket grocery hypermarket otherstore  ///
		 wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice  ///
		 store_modern store_tradonly freq_riceconv youngadult_h youngadult_w
		  
pwcorr starch nonveg pulses dairy veg fruit unspent ///
         weekends weekends_both north Morning Kolkata ///
         BCC1 BCC2 BCC3 PBC_00 PSBC husband0 wife0 ///
		 age_h age_w highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw hunger_h hunger_w enough_h enough_w  ///
		 prop_child prop_teens prop_adults prop_seniors ///
		 low_inc caste ref incpercap000  ///
		 source_hTV source_hTVrad source_hwom source_hlabel ///
		 source_wTV source_wTVrad source_wretail source_wlabel  ///
		 wkmarket grocery hypermarket otherstore  ///
		 wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice  ///
		 store_modern store_tradonly freq_riceconv youngadult_h youngadult_w, star (0.95)
		 
**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/
/*Rules of thumb for values of VIF have appeared in the literature: the
rule of 4, rule of 10, etc. When VIF exceeds these values, these rules
often are interpreted as casting doubts on the results of the regression
analysis*/

******************************************************************************************
*                           START OF ANALYSIS
******************************************************************************************


******************************************************************************************

clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_foodexp.dta"


fmlogit savings starch nonveg pulses dairy veg fruit , ///
	  eta(weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_indiv husband0 wife0 ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors) cluster(iresid)
	 
	
eststo foodexp
esttab foodexp using C:\Users\jynion\foodexp.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  starch nonveg pulses dairy veg fruit savings {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore foodexp
}
eststo drop foodexp
esttab using C:\Users\jynion\foodexp_ame.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps
