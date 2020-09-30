
/*******IDMP BASED ON AMOUNT ON DISH SPENT**********/


clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\17analysis_ihdmpdishspent.dta", clear

describe widmp_dishspent midmp_dishspent ///
		weekends_both Morning Kolkata ///
        BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors 
		
summarize widmp_dishspent midmp_dishspent ///
		weekends_both Morning Kolkata ///
        BCC1 BCC2 BCC3 PBC_00 hunger husband0 wife0 ///
	    highschool_h highschool_w agriocc_h employed_w ///
	    inv_allw  ref incpercap000  ///
	    source_hlabel source_wlabel hhsize wchild wseniors 
 
fracreg probit widmp_dishspent weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref  incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors, ///
	  vce (cluster iresid)
	 
margins, dyex(_all)


***add trmt


