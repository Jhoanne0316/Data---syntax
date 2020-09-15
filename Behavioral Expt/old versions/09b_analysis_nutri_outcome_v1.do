/******DATA ANALYSIS: NUTRITIONAL OUTCOMES - 09analysis_nutri_outcome_v1.0*******/



clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

sort round
by round: summarize sharecarb_percap sharepro_percap sharefat_percap ///
          age_h age_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  hunger_h hunger_w enough_h enough_w prop_child prop_teens prop_adults prop_seniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hTVrad source_hwom source_hlabel source_wTV source_wTVrad source_wretail source_wlabel ///
		  wkmarket grocery hypermarket otherstore wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_modern store_tradonly freq_riceconv amsnack  pmsnack ///
		  tue2 wed2 thu2 fri2 sat2 sun2 weekdays weekends weekends_both Morning Kolkata BCC1 BCC2 BCC3 PBC_00 husband0 wife0

		  
pwcorr summarize sharecarb_percap sharepro_percap sharefat_percap ///
          age_h age_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  hunger_h hunger_w enough_h enough_w prop_child prop_teens prop_adults prop_seniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hTVrad source_hwom source_hlabel source_wTV source_wTVrad source_wretail source_wlabel ///
		  wkmarket grocery hypermarket otherstore wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_modern store_tradonly freq_riceconv amsnack  pmsnack ///
		  tue2 wed2 thu2 fri2 sat2 sun2 weekdays weekends weekends_both Morning Kolkata BCC1 BCC2 BCC3 PBC_00 husband0 wife0, star (0.95)


**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*using second day 
collin 	youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  tue2 wed2 thu2 fri2 sat2 sun2 Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0, corr
	
*using weekends
collin 	youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  weekends Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0, corr

		  
*using weekends_both
collin 	youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  weekends_both Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0, corr
		  
*using weekdays
collin 	youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  weekdays Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0, corr

		  
*============================================*
*                 weekends*
*============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap , ///
		eta(youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  weekends Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0) cluster(iresid)

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v9.1wkend.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap  {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBD_v9.1wkend.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


*============================================*
*                 weekends*
*============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap , ///
		eta(youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  weekends Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0) cluster(iresid)

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v9.1wkend.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap  {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBD_v9.1wkend.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

*============================================*
*                 weekends_both              *
*============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap , ///
		eta(youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  weekends_both Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0) cluster(iresid)

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v9.1wkendboth.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap  {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBD_v9.1wkendboth.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


*============================================*
*                 weekdays*
*============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap , ///
		eta(youngadult_h youngadult_w highschool_h highschool_w work_hfull work_whousewife inv_allw ///
		  enough_h enough_w  wchild wteens wseniors ///
		  low_inc caste ref north incpercap000 ///
		  source_hTV source_hwom source_hlabel source_wTV source_wretail source_wlabel ///
		  wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
		  store_tradonly freq_riceconv amsnack  pmsnack ///
		  weekdays Morning  BCC1 BCC2 BCC3 PBC_00 husband0 wife0) cluster(iresid)

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v9.1wkdays.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap  {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBD_v9.1wkdays.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps
