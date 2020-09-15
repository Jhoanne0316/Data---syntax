/******DATA ANALYSIS: FOOD GROUPS*******/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_budgetshares.dta"

keep uniqueID pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent


merge 1:1 uniqueID using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

drop _merge

save"D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_fgrp.dta", replace

*********DESCRIPTIVE STATISTICS*********
*==========================*
** DESCRIPTIVE STATISTICS **
*==========================*

sort round
by round: summarize pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent ///
		  Morning BCC1 BCC2 BCC3 PBC ///
		  Kolkata  incpercap low_inc ///
		  prop_teens prop_adult prop_senior ///
		  hunger_h hunger_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		  mon tue wed thu fri sat sun weekdays ///
		  amsnack pmsnack  husband0 wife0
		  
*==========================*
**       CORRELATION      **
*==========================*		  
		  

pwcorr pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent ///
		carb_round pro_round fat_round energy_round ///
		carb_percap pro_percap fat_percap energy_percap ///
		sharecarb_percap sharepro_percap sharefat_percap ///
		Morning BCC1 BCC2 BCC3 act_2daypercapbudget giv_2daypercapbudget PBC PSBC ///
		Kolkata incpercap low_inc hhsize child teens adults seniors ///
		prop_child prop_teens prop_adult prop_senior rel_h rel_w ///
		hunger_h hunger_w  tue2 wed2 thu2 fri2 sat2 sun2 ///
		breakfast amsnack lunch pmsnack dinner ///
		mon tue wed thu fri sat sun weekdays ///
		husband1 wife1 husband0 wife0 if round==3, star (0.95) 

*===============*
** DAY code **
*===============*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_fgrp.dta"


fmlogit pct_unspent pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit , ///
		eta(Morning BCC1 BCC2 BCC3 PBC ///
		  Kolkata  incpercap low_inc ///
		  prop_teens prop_adult prop_senior ///
		  hunger_h hunger_w tue wed thu fri sat sun ///
		  amsnack pmsnack  husband0 wife0) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v8_day2.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv8_day2.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

*============*
* SECOND DAY *
*============*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_fgrp.dta"


fmlogit pct_unspent pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit , ///
		eta(Morning BCC1 BCC2 BCC3 PBC ///
		  Kolkata  incpercap low_inc ///
		  prop_teens prop_adult prop_senior ///
		  hunger_h hunger_w tue2 wed2 thu2 fri2 sat2 sun2 ///
		  amsnack pmsnack  husband0 wife0) cluster(iresid)


eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v8_2ndday2.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv8_2ndday2.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

*============================================*
*                 weekdays*
*============================================*

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_fgrp.dta"


fmlogit pct_unspent pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit , ///
		eta(Morning BCC1 BCC2 BCC3 PBC ///
		  Kolkata  incpercap low_inc ///
		  prop_teens prop_adult prop_senior ///
		  hunger_h hunger_w weekday ///
		  amsnack pmsnack  husband0 wife0) cluster(iresid)

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v8_wkday2.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv8_wkday2.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps
