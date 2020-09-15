/******DATA ANALYSIS: NUTRITIONAL OUTCOMES*******/

clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

sort round
by round: summarize carb_round pro_round fat_round energy_round ///
					carb_percap pro_percap fat_percap energy_percap ///
					Morning BCC1 BCC2 BCC3 actual_wkbudget given_wkbudget PBC PSBC ///
					Kolkata urbanity incpercap low_income weeklypercapitabudget hhsize AH2 AH3 AH4 AH5 rel_h rel_w ///
					AS1_h AS1_w AH6_h AH6_w tue2 wed2 thu2 fri2 sat2 sun2 
					

pwcorr carb_round pro_round fat_round energy_round ///
		carb_percap pro_percap fat_percap energy_percap ///
		Morning BCC1 BCC2 BCC3 actual_wkbudget given_wkbudget PBC PSBC ///
		Kolkata urbanity incpercap low_income weeklypercapitabudget hhsize AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, star (0.95)
	
	
**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*initial; PBC (budget constraint) excluded to give way to given_wkbudget
collin 	Morning BCC1 BCC2 BCC3 actual_wkbudget given_wkbudget PSBC ///
		Kolkata urbanity incpercap low_income hhsize AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, corr
		
*initial; given_wkbudget actual_wkbudget and PSBC are excluded since PBC (budget constraint) is a function of these variables
collin 	Morning BCC1 BCC2 BCC3 PBC  ///
		Kolkata urbanity incpercap low_income hhsize AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, corr		

* revised, excluded variables: given_wkbudget actual_wkbudget, urbanity, hhsize
collin 	Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, corr	

		
*========================================
*****MODEL - all variable*****
*========================================
regress carb_round Morning BCC1 BCC2 BCC3 PBC PSBC ///
		Kolkata incpercap low_income weeklypercapitabudget AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3
		
/*POST ESTIMATION*/
estat hettest /*Breusch-Pagan Test*/
estat vif

*========================================
regress pro_round Morning BCC1 BCC2 BCC3 PBC PSBC ///
		Kolkata incpercap low_income weeklypercapitabudget AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3
		
/*POST ESTIMATION*/
estat hettest /*Breusch-Pagan Test*/
estat vif

*========================================
regress fat_round Morning BCC1 BCC2 BCC3 PBC PSBC ///
		Kolkata incpercap low_income weeklypercapitabudget AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3
		
/*POST ESTIMATION*/
estat hettest /*Breusch-Pagan Test*/
estat vif

*========================================
*****MODEL - all variable (per capita consumption*****
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

*========================================
regress carb_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
*========================================
regress pro_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income  AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
*========================================
regress fat_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust

		
*========================================
regress energy_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
*===============================================
*****MODEL - backward Stepwise regression*****
*===============================================
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_regn_kcal.dta"

*****MODEL 1 FOR CARBOHYDRATES with robust std errors*****
stepwise, pr(.05): regress carb_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

*****MODEL 2 FOR PROTEIN with robust std errors*****
stepwise, pr(.05): regress pro_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

*****MODEL 3 FOR FAT with robust std errors*****
stepwise, pr(.05): regress fat_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

*****MODEL 4 FOR ENERGY with robust std errors*****
stepwise, pr(.05): regress energy_percap Morning BCC1 BCC2 BCC3 PBC ///
		Kolkata incpercap low_income AH2 AH3 AH4 AH5 ///
		AS1_h AS1_w tue2 wed2 thu2 fri2 sat2 sun2 if round==3, robust
		
/*POST ESTIMATION*/
estat vif

