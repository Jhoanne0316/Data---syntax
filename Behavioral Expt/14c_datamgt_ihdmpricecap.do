
/*******INVESTMENT SHARE - IDMP BASED ON CAL PER CAP**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14analysis_ricecap.dta"


keep round iresid logallricepercap 

reshape wide logallricepercap, i(iresid) j (round)

merge 1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge


sort iresid
by iresid: generate dup = cond(_N==1,0,_n)
drop if dup>1
keep iresid logallricepercap1 logallricepercap2 logallricepercap3  ///
     weekends_both Morning Kolkata ///
     BCC1 BCC2 BCC3 PBC_00 hunger_h hunger_w hunger hunger_sr ///
	 highschool_h highschool_w agriocc_h employed_w ///
	 inv_allw  ref incpercap000  ///
	 source_hlabel source_wlabel hhsize wchild wseniors

	 
gen double hdis_logallricepercap=(logallricepercap1-logallricepercap3)^2
gen double wdis_logallricepercap=(logallricepercap2-logallricepercap3)^2

gen double hed=round(sqrt(hdis_logallricepercap),0.0001)
gen double wed=round(sqrt(wdis_logallricepercap),0.0001)

gen double midmp_ricecap=round(wed/(hed+wed),0.0001)
gen double widmp_ricecap=round(hed/(hed+wed),0.0001)

label variable logallricepercap1 "ave amount of steamed rice per capita per day(log)(husband)"
label variable logallricepercap2 "ave amount of steamed rice per capita per day(log)(wife)"
label variable logallricepercap3 "ave amount of steamed rice per capita per day(log)(joint)"

label variable hed "Euclidean distance for husband"
label variable wed "Euclidean distance for wife"
label variable midmp_ricecap "Men’s intrahousehold decision making power"
label variable widmp_ricecap "Women’s intrahousehold decision making power"



save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14analysis_ihdmpricecap.dta", replace

