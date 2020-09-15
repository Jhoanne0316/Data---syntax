/******DATA ANALYSIS: INVESTMENT*******/


clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_inv.dta"

describe percntamtspent weekends weekends_both north Morning Kolkata ///
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
by round: summarize percntamtspent weekends weekends_both north Morning Kolkata ///
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
		  
pwcorr percntamtspent weekends weekends_both north Morning Kolkata ///
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

*/
*************************************************************************
*                          DEP VAR: percntamtspent
*************************************************************************

*********************
*3a.weekends_both+BCCs+PBC
*********************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_inv.dta"

glm  percntamtspent weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 husband0 wife0 ///
	 highschool_h highschool_w work_hfull work_whousewife ///
	 inv_allw enough_h enough_w caste ref incpercap000  ///
	 source_hTV  source_hwom source_hlabel ///
	 source_wTV  source_wretail source_wlabel  ///
	 grocery hypermarket otherstore  ///
	 wkmarket_veg  wkmarket_rice grocery_rice  ///
	 store_tradonly freq_riceconv youngadult_h youngadult_w, ///
	 family (binomial) link (probit) vce (cluster iresid) nolog

