
/*******INVESTMENT SHARE - IDMP BASED ON CAL PER CAP**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_ricecap.dta"

keep round iresid ricepercap 

**reshaping the data to generate food group variables for each round

reshape wide ricepercap, i(iresid) j (round)

merge 1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


sort    iresid
drop    if round!=1

keep iresid ricepercap1 ricepercap2 ricepercap3  ///
         weekends_both Morning       Kolkata                           ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors

edit     iresid ricepercap1 ricepercap2 ricepercap3

gen double hdis_ricepercap=(ricepercap1-ricepercap3)^2
gen double wdis_ricepercap=(ricepercap2-ricepercap3)^2

gen double hed=round(sqrt(hdis_ricepercap),0.0001)
gen double wed=round(sqrt(wdis_ricepercap),0.0001)

gen double midmp_ricepercap=round(wed/(hed+wed),0.0001)
gen double widmp_ricepercap=round(hed/(hed+wed),0.0001)


label variable hed "Euclidean distance for husband"
label variable wed "Euclidean distance for wife"
label variable midmp_ricepercap "Men’s intrahousehold decision making power(ricepercap)"
label variable widmp_ricepercap "Women’s intrahousehold decision making power(ricepercap)"



save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_idmpricecap.dta", replace

