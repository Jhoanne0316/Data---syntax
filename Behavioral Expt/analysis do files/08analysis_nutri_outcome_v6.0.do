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
					mon tue wed thu fri sat sun weekdays husband wife indiv
					
					

pwcorr carb_round pro_round fat_round energy_round ///
		carb_percap pro_percap fat_percap energy_percap ///
		sharecarb_percap sharepro_percap sharefat_percap ///
		Morning BCC1 BCC2 BCC3 act_2daypercapbudget giv_2daypercapbudget PBC PSBC ///
		Kolkata urbanity incpercap low_income weeklypercapitabudget hhsize AH2 AH3 AH4 AH5 ///
		prop_child prop_teens prop_adult prop_senior rel_h rel_w ///
		AS1_h AS1_w AH6_h AH6_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		breakfast amsnack lunch pmsnack dinner ///
		mon tue wed thu fri sat sun weekdays husband wife if round==3, star (0.95)
	
	
**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*initial; given_wkbudget actual_wkbudget and PSBC are excluded since PBC (budget constraint) is a function of these variables
*excluded: weeklypercapitabudget, urbanity, hhsize, AH6_h, AH6_w, prop_child 

*using second day+husband wife
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue2 wed2 thu2 fri2 sat2 sun2 husband wife indiv, corr
		
*using presence of day+husband wife
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue wed thu fri sat sun husband wife, corr

*using weekdays+husband wife
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack weekdays indiv, corr
*========================================================
* instead of husband & wife variable, we use individual
*========================================================
*using second day+individual
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue2 wed2 thu2 fri2 sat2 sun2 indiv, corr
		
*using presence of day+individual
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack tue wed thu fri sat sun indiv, corr

*using weekdays+individual
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w  ///
		amsnack  pmsnack weekdays indiv, corr



*=============================*=================================================================
*****MODEL - fmlogit using shares of nutritional outcomes*****
*==============================*================================================================
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

**DAY 2 (clustered errors at individual level)
fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC round ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		amsnack pmsnack indiv) cluster(iresid2)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v6_day2.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv6_day2.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps



**DAY 2 (clustered errors at household level)
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC round ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		amsnack pmsnack indiv) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v6_day2hh.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv6_day2hh.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


*=======*
** DAY **
*=======*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"


fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC round ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue wed thu fri sat sun ///
		amsnack pmsnack indiv) cluster(iresid2)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v6_day.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv6_day.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

*============================================*
* DAY 2 (clustered errors at household level)*
*============================================*
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"


fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC round ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w tue wed thu fri sat sun ///
		amsnack pmsnack indiv) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v6_dayhh.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv6_dayhh.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


*============================================*
*                 weekdays*
*============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC round ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w weekdays ///
		amsnack pmsnack indiv) cluster(iresid2)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v6_wkday.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv6_wkday.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

*=============================================*
* WEEKDAY(clustered errors at household level)*
*=============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

fmlogit sharecarb_percap sharepro_percap sharefat_percap, ///
		eta(Morning BCC1 BCC2 BCC3 PBC round ///
		Kolkata  incpercap low_income ///
		prop_teens prop_adult prop_senior ///
		AS1_h AS1_w weekdays ///
		amsnack pmsnack indiv) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v6_wkdayhh.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in sharecarb_percap sharepro_percap sharefat_percap {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv6_wkdayhh.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps
