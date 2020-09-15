
/*******INVESTMENT SHARE - IDMP BASED ON CAL PER CAP**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13analysis_kcalcap.dta"


keep round iresid logkcalpercap 

reshape wide logkcalpercap, i(iresid) j (round)

merge 1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


sort iresid
by iresid: generate dup = cond(_N==1,0,_n)
drop if dup>1
keep iresid logkcalpercap1 logkcalpercap2 logkcalpercap3  ///
     weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w hunger hunger_sr ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors

	 
gen double hdis_logkcalpercap=(logkcalpercap1-logkcalpercap3)^2
gen double wdis_logkcalpercap=(logkcalpercap2-logkcalpercap3)^2

gen double hed=round(sqrt(hdis_logkcalpercap),0.0001)
gen double wed=round(sqrt(wdis_logkcalpercap),0.0001)

gen double midmp_kcalcap=round(wed/(hed+wed),0.0001)
gen double widmp_kcalcap=round(hed/(hed+wed),0.0001)

label variable logkcalpercap1 "total calories per capita (log) (husband)"
label variable logkcalpercap2 "total calories per capita (log)(wife)"
label variable logkcalpercap3 "total calories per capita (log)(joint)"

label variable hed "Euclidean distance for husband"
label variable wed "Euclidean distance for wife"
label variable midmp_kcalcap "Men’s intrahousehold decision making power"
label variable widmp_kcalcap "Women’s intrahousehold decision making power"



save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\13analysis_ihdmpkcalcap.dta", replace

