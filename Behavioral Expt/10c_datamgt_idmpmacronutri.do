
/*******INVESTMENT SHARE - IDMP BASED ON CALORIE SHARES**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_macronutri.dta"
keep    round iresid carb protein fat

**reshaping the data to generate food group variables for each round
reshape wide carb protein fat, i(iresid) j (round)

merge   1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop    _merge

sort    iresid
drop    if round!=1

keep     iresid carb1 - fat3 ///
         weekends_both Morning       Kolkata                           ///
		 T1            T2            T3                                ///
	     PBC_00        hunger_ratio                                    ///
		 highschool_h  highschool_w  agriocc_h    employed_w           ///
		 inv_allw      ref           incpercap000 wkbudgetpercap00     ///
		 source_hlabel source_wlabel hhsize       wchild     wseniors
	 
edit     iresid carb1 carb2 carb3

gen      double hdis_carb    =(   carb1-   carb3)^2
gen      double hdis_protein =(protein1-protein3)^2
gen      double hdis_fat     =(    fat1-    fat3)^2

gen      double wdis_carb    =(   carb2-   carb3)^2
gen      double wdis_protein =(protein2-protein3)^2
gen      double wdis_fat     =(    fat2-    fat3)^2

gen      double hed=round(sqrt(hdis_carb+ hdis_protein+ hdis_fat),0.0001)
gen      double wed=round(sqrt(wdis_carb+ wdis_protein+ wdis_fat),0.0001)

gen      double midmp_macronutri=round(wed/(hed+wed),0.0001)
gen      double widmp_macronutri=round(hed/(hed+wed),0.0001)

 

label    variable midmp_macronutri "Men’s intrahousehold decision making power(macronutrients)"
label    variable widmp_macronutri "Women’s intrahousehold decision making power(macronutrients)"


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_idmpmacronutri.dta", replace

