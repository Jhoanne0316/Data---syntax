
/*******IDMP BASED ON HDDS**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_hdds.dta"


keep round iresid HDDS 

**reshaping the data to generate food group variables for each round

reshape wide HDDS, i(iresid) j (round)

merge 1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


sort    iresid
drop    if round!=1

keep iresid HDDS1 HDDS2 HDDS3  ///
         weekends_both Morning       Kolkata                           ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors

	 
gen double hdis_hdds=(HDDS1-HDDS3)^2
gen double wdis_hdds=(HDDS2-HDDS3)^2

gen double hed=round(sqrt(hdis_hdds),0.0001)
gen double wed=round(sqrt(wdis_hdds),0.0001)

gen double midmp_hdds=round(wed/(hed+wed),0.0001)
gen double widmp_hdds=round(hed/(hed+wed),0.0001)



label variable hed "Euclidean distance for husband"
label variable wed "Euclidean distance for wife"
label variable midmp_hdds "Men’s intrahousehold decision making power (HDDS)"
label variable widmp_hdds "Women’s intrahousehold decision making power (HDDS)"


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_idmphdds.dta", replace

