/******DATA ANALYSIS: NUTRITIONAL OUTCOMES*******/

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

sort round
by round: summarize carb_round pro_round fat_round energy_round ///
					carb_percap pro_percap fat_percap energy_percap ///
					sharecarb_percap sharepro_percap sharefat_percap ///
					Morning BCC1 BCC2 BCC3 act_2daypercapbudget giv_2daypercapbudget PBC PSBC ///
					Kolkata urbanity incpercap low_income weeklypercapitabudget hhsize AH2 AH3 AH4 AH5 ///
					prop_child prop_teens prop_adult prop_senior rel_h rel_w ///
					AS1_h AS1_w AH6_h AH6_w tue2 wed2 thu2 fri2 sat2 sun2 ///
					breakfast amsnack lunch pmsnack dinner ///
					mon tue wed thu fri sat sun weekdays ///
					husband1 wife1 husband0 wife0
					
					

pwcorr carb_round pro_round fat_round energy_round ///
		carb_percap pro_percap fat_percap energy_percap ///
		sharecarb_percap sharepro_percap sharefat_percap ///
		Morning BCC1 BCC2 BCC3 act_2daypercapbudget giv_2daypercapbudget PBC PSBC ///
		Kolkata urbanity incpercap low_income weeklypercapitabudget hhsize AH2 AH3 AH4 AH5 ///
		prop_child prop_teens prop_adult prop_senior rel_h rel_w ///
		AS1_h AS1_w AH6_h AH6_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		breakfast amsnack lunch pmsnack dinner ///
		mon tue wed thu fri sat sun weekdays ///
		husband1 wife1 husband0 wife0 if round==3, star (0.95)
	
	
**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*initial; given_wkbudget actual_wkbudget and PSBC are excluded since PBC (budget constraint) is a function of these variables
*excluded: weeklypercapitabudget, urbanity, hhsize, AH6_h, AH6_w, prop_child 

*===================*
*  husband1 + wife1 *
*===================*
*using second day+husband1 wife1
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue2 wed2 thu2 fri2 sat2 sun2 ///
		husband1 wife1, corr
		
*using presence of day+husband1 wife1
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue wed thu fri sat sun ///
		husband1 wife1, corr

*using weekdays+husband1 wife1
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack weekdays ///
		husband1 wife1, corr

*===================*
*  husband0 + wife0 *
*===================*

* *using second day+husband1 wife1
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue2 wed2 thu2 fri2 sat2 sun2 ///
		husband0 wife0, corr
		
*using presence of day+husband1 wife1
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue wed thu fri sat sun ///
		husband0 wife0, corr

*using weekdays+husband1 wife1
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack weekdays ///
		husband0 wife0, corr
		


*=============================*=================================================================
*****MODEL - fmlogit using shares of nutritional outcomes*****
*==============================*================================================================

*===============*
** DAY code  **
*===============*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"


fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC  ///
		Kolkata  incpercap low_inc ///
		prop_teens prop_adult prop_senior ///
		hunger_h hunger_w tue wed thu fri sat sun ///
		amsnack pmsnack husband0 wife0) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v7_day.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv7_day.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

*=======*
* DAY 2 *
*=======*
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"


fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_inc ///
		prop_teens prop_adult prop_senior ///
		hunger_h hunger_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		amsnack pmsnack  husband0 wife0) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v7_2ndday.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv7_2ndday.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


*============================================*
*                 weekdays*
*============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_inc ///
		prop_teens prop_adult prop_senior ///
		hunger_h hunger_w weekday ///
		amsnack pmsnack  husband0 wife0) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v7_wkday.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv7_wkday.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

