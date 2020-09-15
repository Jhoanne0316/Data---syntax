
/*******IDMP BASED ON HDDS**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_HDDS.dta"


keep round iresid HDDS 

reshape wide HDDS, i(iresid) j (round)

merge 1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


sort iresid
by iresid: generate dup = cond(_N==1,0,_n)
drop if dup>1
keep iresid HDDS1 HDDS2 HDDS3  ///
     weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w hunger hunger_sr ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors

	 
gen double hdis_hdds=(HDDS1-HDDS3)^2
gen double wdis_hdds=(HDDS2-HDDS3)^2

gen double hed=round(sqrt(hdis_hdds),0.0001)
gen double wed=round(sqrt(wdis_hdds),0.0001)

gen double midmp_hdds=round(wed/(hed+wed),0.0001)
gen double widmp_hdds=round(hed/(hed+wed),0.0001)

label variable HDDS1 "Household Dietary Diversity Score (husband)"
label variable HDDS2 "Household Dietary Diversity Score(wife)"
label variable HDDS3 "Household Dietary Diversity Score(joint)"

label variable hed "Euclidean distance for husband"
label variable wed "Euclidean distance for wife"
label variable midmp_hdds "Men’s intrahousehold decision making power"
label variable widmp_hdds "Women’s intrahousehold decision making power"


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_ihdmpHDDS.dta", replace

