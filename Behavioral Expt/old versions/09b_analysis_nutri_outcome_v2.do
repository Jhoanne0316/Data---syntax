m/******DATA ANALYSIS: NUTRITIONAL OUTCOMES - 09analysis_nutri_outcome_v1.0*******/



clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

describe carb protein fat weekends weekends_both north Morning Kolkata ///
         BCC1 BCC2 BCC3 PBC_00 PSBC husband0 wife0 ///
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
by round: summarize carb protein fat weekends weekends_both north Morning Kolkata ///
         BCC1 BCC2 BCC3 PBC_00 PSBC husband0 wife0 ///
		 age_h age_w highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw hunger_h hunger_w enough_h enough_w  ///
		 prop_child prop_teens prop_adults prop_seniors ///
		 low_inc caste ref incpercap000  ///
		 source_hTV source_hTVrad source_hwom source_hlabel ///
		 source_wTV source_wTVrad source_wretail source_wlabel  ///
		 wkmarket grocery hypermarket otherstore  ///
		 wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice  ///
		 store_modern store_tradonly freq_riceconv youngadult_h youngadult_w
		  
pwcorr carb protein fat weekends weekends_both north Morning Kolkata ///
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

collin 	weekends Morning Kolkata ///
         BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw enough_h enough_w low_inc caste ref incpercap000  ///
		 source_hTV  source_hwom source_hlabel ///
		 source_wTV  source_wretail source_wlabel  ///
		  grocery hypermarket otherstore  ///
		 wkmarket_veg  wkmarket_rice grocery_rice  ///
		 store_tradonly freq_riceconv youngadult_h youngadult_w, corr
		 
		 
*added weekends_both, treatment, and PSBC; removed weekends, PBC_00, BCC1-3, and low_inc
collin 	weekends_both Morning Kolkata ///
         treatment PSBC husband0 wife0 ///
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw enough_h enough_w  caste ref incpercap000  ///
		 source_hTV  source_hwom source_hlabel ///
		 source_wTV  source_wretail source_wlabel  ///
		  grocery hypermarket otherstore  ///
		 wkmarket_veg  wkmarket_rice grocery_rice  ///
		 store_tradonly freq_riceconv youngadult_h youngadult_w, corr


**----------------GLM; Protein as the numeraire--------------------**/
https://stats.idre.ucla.edu/stata/faq/how-does-one-do-regression-when-the-dependent-variable-is-a-proportion/
*the glm model is used when the dep var is a proportion.
*Here, the objective is to choose variables that are robust, meaning, they always appear in the model.
* first step is to run the model with fixed variables to try:
*1) treatment vs BCC1-3
*2) weekends vs weekends_both (a stricter version)
/*
. pwcorr weekends weekends_both treatment BCC1 BCC2	BCC3, star(0.95)

				weekends weeken~h treatm~t   BCC1	BCC2     BCC3
	
weekends    	1.0000 
weekends_b~h    0.4816*  1.0000 
treatment   	-0.0194* -0.0049*  1.0000 
BCC1   			-0.0069* -0.0066* -0.8028*  1.0000 
BCC2   			-0.0405* -0.0165* -0.1054*  0.6285*	1.0000 
BCC3   			-0.0264* -0.0151*  0.1845*  0.3679*	0.5854*  1.0000 

*note that weekends_both has lower coeff with the treatments that could lessen multicollinearity
hence, weekends_both is better to match to treatment or BCCs
while weekends has lower coff to treatment compared to BCCs, hence, weekends is better to match with treatments



models to create:
weekends_both+treatments+PSBC
weekends_both+treatments+PBC

weekends_both+BCCs+PSBC
weekends_both+BCCs+PBC

weekends+treatments+PSBC
weekends+treatments+PBC

(observe if significant, observe SE)
weekends+BCCs+PSBC
weekends+BCCs+PBC

*/
*********************
*1a. weekends+BCCs+PBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog
	 

*********************
*1b. weekends+BCCs+PSBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends Morning Kolkata ///
     BCC1 BCC2 BCC3 PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends Morning Kolkata ///
     BCC1 BCC2 BCC3 PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog


*********************
*2a. weekends+treatments+PBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends Morning Kolkata ///
     treatment PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends Morning Kolkata ///
     treatment PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog
	 
	 
*********************
*2b. weekends+treatments+PSBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends Morning Kolkata ///
     treatment PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends Morning Kolkata ///
     treatment PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

	 
*********************
*3a.weekends_both+BCCs+PBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog
	 

*********************
*3b. weekends_both+BCCs+PSBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog


*********************
*4a.weekends_both+treatments+PBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends_both Morning Kolkata ///
     treatment PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends_both Morning Kolkata ///
     treatment PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

*********************
*4b. weekends_both+treatments+PSBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends_both Morning Kolkata ///
     treatment PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends_both Morning Kolkata ///
     treatment PSBC husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog
	 
	 
	 
*********************
*weekends_both+treatments+PSBC (streamlined)
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

glm  protein weekends_both treatment PSBC enough_h freq_riceconv highschool_h ///
     inv_allw Kolkata ref source_hwom ///
     source_wretail wife0 youngadult_h low_inc, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

stepwise, pr(.2):glm  protein weekends_both treatment PSBC enough_h ///
     freq_riceconv highschool_h inv_allw Kolkata ref source_hwom ///
     source_wretail wife0 youngadult_h low_inc, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog
	 
	 
**----------------FM logit; Protein as the numeraire--------------------**/
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

fmlogit  protein carb fat, ///
		eta(weekends Morning Kolkata ///
         BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw enough_h enough_w low_inc caste ref incpercap000  ///
		 source_hTV  source_hwom source_hlabel ///
		 source_wTV  source_wretail source_wlabel  ///
		  grocery hypermarket otherstore  ///
		 wkmarket_veg  wkmarket_rice grocery_rice  ///
		 store_tradonly freq_riceconv youngadult_h youngadult_w) cluster(iresid)

eststo fmlogit
esttab fmlogit using C:\Users\jynion\DFCdepvars_v1.1.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  protein carb fat {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using C:\Users\jynion\DFCdepvars_MEBD_v1.1.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


**----------------FM logit; Protein as the numeraire--------------------**/
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_regn_kcal.dta"

fmlogit  protein carb fat, ///
		eta(weekends_both Morning Kolkata ///
         treatment PSBC husband0 wife0 ///
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw enough_h enough_w  caste ref incpercap000  ///
		 source_hTV  source_hwom source_hlabel ///
		 source_wTV  source_wretail source_wlabel  ///
		  grocery hypermarket otherstore  ///
		 wkmarket_veg  wkmarket_rice grocery_rice  ///
		 store_tradonly freq_riceconv youngadult_h youngadult_w) cluster(iresid)
eststo fmlogit
esttab fmlogit using C:\Users\jynion\DFCdepvars_v2.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in  protein carb fat {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using C:\Users\jynion\DFCdepvars_MEBD_v2.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

