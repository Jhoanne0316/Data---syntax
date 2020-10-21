*********************************************
* TESTING MUTLICOLLINEARITY AMONG VARIABLES *
*********************************************
**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/
/*Rules of thumb for values of VIF have appeared in the literature: the
rule of 4, rule of 10, etc. When VIF exceeds these values, these rules
often are interpreted as casting doubts on the results of the regression
analysis*/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta", clear

describe weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_indiv hunger_ratio /// *hunger ratio is only included for IDMP models
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w work_hfull work_whousewife ///
		 inv_allw  ref incpercap000 wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors
sort round
by round:summarize weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_indiv hunger_ratio /// *hunger ratio is only included for IDMP models
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w work_hfull work_whousewife ///
		 inv_allw  ref incpercap000 wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors 
		 
*********** USING T's *******************	

**use all

collin   weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_indiv  /// *hunger ratio is only included for IDMP models
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000 wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr
		 
**removing incpercap000
collin   weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_indiv  /// *hunger ratio is only included for IDMP models
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref  wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr
		 
**removing PBC_00		 
collin   weekends_both Morning Kolkata ///
		 T1 T2 T3  ///
		 hunger_indiv  /// *hunger ratio is only included for IDMP models
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000 wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr
		 

**removing wkbudgetpercap			 
collin   weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_indiv  /// *hunger ratio is only included for IDMP models
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr
		 
*********** USING T's for IDMP models*******************		

**use all

collin   weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_ratio /// *hunger ratio is only included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000 wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr

**removing incpercap000
collin   weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_ratio /// *hunger ratio is only included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr


**removing PBC_00	
collin   weekends_both Morning Kolkata ///
		 T1 T2 T3  ///
		 hunger_ratio /// *hunger ratio is only included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000 wkbudgetpercap00 ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr

**removing wkbudgetpercap00
collin   weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_ratio /// *hunger ratio is only included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr




	 
		 
		 
		 
*********** USING T's for IDMP models*******************		 
collin   weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_ratio  /// *hunger ratio is only included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000 fbudgetpercap ///
		 source_hlabel source_wlabel hhsize wchild wseniors , corr
		 
		 
*********** USING TREATMENTS *******************

*T's+hunger level +occupation (husband has full time occ&housewife)
collin weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_h hunger_w  ///
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr
		 
*T's+hunger level +occupation (Husband is employed in Agriculture &Wife is employed)

collin weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_h hunger_w  ///
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr
		 
*T's+self-reported+occupation (husband has full time occ&housewife)

collin weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_indiv  ///
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr

*T's+self-reported+occupation (Husband is employed in Agriculture &Wife is employed)	
				
collin weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_indiv  ///
		 husband0 wife0 /// *not included for IDMP models
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr
		 
******************* FOR IDMP *******************


*BCC+hunger ratio+occupation (husband has full time occ&housewife)

collin weekends_both Morning Kolkata ///
		 BCC1 BCC2 BCC3 PBC_00 ///
		 hunger_ratio  ///
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr

*BCC+hunger ratio+occupation (Husband is employed in Agriculture &Wife is employed)	
				
collin weekends_both Morning Kolkata ///
		 BCC1 BCC2 BCC3 PBC_00 ///
		 hunger_ratio  ///
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr
		 
*T's+hunger ratio+occupation (husband has full time occ&housewife)

collin weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_ratio  ///
		 highschool_h highschool_w work_hfull work_whousewife ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr

*T's+hunger ratio+occupation (Husband is employed in Agriculture &Wife is employed)	
				
collin weekends_both Morning Kolkata ///
		 T1 T2 T3 PBC_00 ///
		 hunger_ratio  ///
		 highschool_h highschool_w agriocc_h employed_w ///
		 inv_allw  ref incpercap000  ///
		 source_hlabel source_wlabel hhsize wchild wseniors, corr
