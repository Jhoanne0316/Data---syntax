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
					breakfast amsnack lunch pmsnack dinner
					

pwcorr carb_round pro_round fat_round energy_round ///
		carb_percap pro_percap fat_percap energy_percap ///
		sharecarb_percap sharepro_percap sharefat_percap ///
		Morning BCC1 BCC2 BCC3 act_2daypercapbudget giv_2daypercapbudget PBC PSBC ///
		Kolkata urbanity incpercap low_income weeklypercapitabudget hhsize AH2 AH3 AH4 AH5 ///
		prop_child prop_teens prop_adult prop_senior rel_h rel_w ///
		AS1_h AS1_w AH6_h AH6_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		breakfast amsnack lunch pmsnack dinner if round==3, star (0.95)
	
	
**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*initial; PBC (budget constraint) excluded to give way to giv_2daypercapbudget
*excluded: weeklypercapitabudget, urbanity, hhsize, AH6_h, AH6_w, prop_child 
collin 	Morning BCC1 BCC2 BCC3 act_2daypercapbudget giv_2daypercapbudget PSBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		 amsnack  pmsnack  if round==3, corr
		
*initial; given_wkbudget actual_wkbudget and PSBC are excluded since PBC (budget constraint) is a function of these variables
*excluded: weeklypercapitabudget, urbanity, hhsize, AH6_h, AH6_w, prop_child 
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		 amsnack  pmsnack  if round==3, corr		

/*=============================*=================================================================
*****MODEL - backward Stepwise regression using shares of nutritional outcomes*****
*==============================*================================================================
*****MODEL 1 FOR CARBOHYDRATES with robust std errors*****
stepwise, pr(.05): regress carb_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

*****MODEL 2 FOR PROTEIN with robust std errors*****
stepwise, pr(.05): regress pro_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

*****MODEL 3 FOR FAT with robust std errors*****
stepwise, pr(.05): regress fat_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

*****MODEL 4 FOR ENERGY with robust std errors*****
stepwise, pr(.05): regress energy_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

*/


*=============================*=================================================================
*****MODEL - fmlogit using shares of nutritional outcomes*****
*==============================*================================================================

fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 amsnack pmsnack) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v5.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv5.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


