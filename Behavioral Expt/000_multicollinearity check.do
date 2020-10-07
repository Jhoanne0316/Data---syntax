*********************************************
* TESTING MUTLICOLLINEARITY AMONG VARIABLES *
*********************************************

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta", clear

*correlation among 

*hunger levels of husband and wife
**response from survey

		****checking multicollinearity with BCC
		collin weekends_both Morning Kolkata ///
				BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w husband0 wife0 ///
				highschool_h highschool_w agriocc_h employed_w ///
				inv_allw  ref incpercap000  ///
				source_hlabel source_wlabel hhsize wchild wseniors, corr

		***checking multicollinearity with treatments
		collin weekends_both Morning Kolkata ///
				T1 T2 T3 PBC_00 hunger_h hunger_w husband0 wife0 ///
				highschool_h highschool_w agriocc_h employed_w ///
				inv_allw  ref incpercap000  ///
				source_hlabel source_wlabel hhsize wchild wseniors, corr
		
*whether husband and wife experiences hunger
**generated from hunger_ and hunger_w variables
***dummy variable: 1 if hunger level is negative

		****checking multicollinearity with BCC
		collin weekends_both Morning Kolkata ///
				BCC1 BCC2 BCC3 PBC_00 hungry_h hungry_w husband0 wife0 ///
				highschool_h highschool_w agriocc_h employed_w ///
				inv_allw  ref incpercap000  ///
				source_hlabel source_wlabel hhsize wchild wseniors, corr
		
		****checking multicollinearity with BCC				
		collin weekends_both Morning Kolkata ///
				T1 T2 T3 PBC_00 hungry_h hungry_w husband0 wife0 ///
				highschool_h highschool_w agriocc_h employed_w ///
				inv_allw  ref incpercap000  ///
				source_hlabel source_wlabel hhsize wchild wseniors, corr
				
*self-reported hunger
**generated from hunger_ and hunger_w variables
***dummy variable: 1 if hunger level is negative

		****checking multicollinearity with BCC
		collin weekends_both Morning Kolkata ///
				BCC1 BCC2 BCC3 PBC_00 hungry_h hungry_w husband0 wife0 ///
				highschool_h highschool_w agriocc_h employed_w ///
				inv_allw  ref incpercap000  ///
				source_hlabel source_wlabel hhsize wchild wseniors, corr
		
		****checking multicollinearity with BCC				
		collin weekends_both Morning Kolkata ///
				T1 T2 T3 PBC_00 hungry_h hungry_w husband0 wife0 ///
				highschool_h highschool_w agriocc_h employed_w ///
				inv_allw  ref incpercap000  ///
				source_hlabel source_wlabel hhsize wchild wseniors, corr


