
/*******INVESTMENT SHARE - IDMP BASED ON CAL PER CAP**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcalcap.dta"

keep round iresid kcalcap 

**reshaping the data to generate food group variables for each round

reshape wide kcalcap, i(iresid) j (round)

merge 1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


sort    iresid
drop    if round!=1


keep iresid kcalcap1 kcalcap2 kcalcap3  ///
         weekends_both Morning       Kolkata                           ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio  hunger_h       hunger_w           ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors


gen double hdis_kcalcap=(kcalcap1-kcalcap3)^2
gen double wdis_kcalcap=(kcalcap2-kcalcap3)^2

gen double hed=round(sqrt(hdis_kcalcap),0.0001)
gen double wed=round(sqrt(wdis_kcalcap),0.0001)

gen double midmp_kcalcap=round(wed/(hed+wed),0.0001)
gen double widmp_kcalcap=round(hed/(hed+wed),0.0001)


label variable hed "Euclidean distance for husband"
label variable wed "Euclidean distance for wife"
label variable midmp_kcalcap "Men’s intrahousehold decision making power (kcal/cap)"
label variable widmp_kcalcap "Women’s intrahousehold decision making power (kcal/cap)"

drop kcalcap1 kcalcap2 kcalcap3

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_idmpkcalcap.dta", replace

