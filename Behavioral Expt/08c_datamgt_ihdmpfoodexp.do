
/*******INVESTMENT SHARE - IDMP BASED ON FOOD EXPENDITURE SHARES**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_foodexp.dta"
keep round iresid starch nonveg pulses dairy veg fruit savings 

**reshaping the data to generate food group variables for each round
reshape wide starch nonveg pulses dairy veg fruit savings, i(iresid) j (round)

merge   1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop    _merge


sort    iresid
drop    if round!=1

keep     iresid starch1 - savings3 ///
         weekends_both Morning Kolkata ///
         BCC1 BCC2 BCC3 T1 T2 T3 PBC_00 hunger_h hunger_w husband0 wife0 ///
	     highschool_h highschool_w agriocc_h employed_w ///
	     inv_allw  ref incpercap000  ///
	     source_hlabel source_wlabel hhsize wchild wseniors

edit     iresid starch1 starch2 starch3
		 
gen      double hdis_starch  = ( starch1- starch3)^2
gen      double hdis_nonveg  = ( nonveg1- nonveg3)^2
gen      double hdis_pulses  = ( pulses1- pulses3)^2
gen      double hdis_dairy   = (  dairy1-  dairy3)^2
gen      double hdis_veg     = (    veg1-    veg3)^2
gen      double hdis_fruit   = (  fruit1-  fruit3)^2
gen      double hdis_savings = (savings1-savings3)^2

gen      double wdis_starch  = ( starch2- starch3)^2
gen      double wdis_nonveg  = ( nonveg2- nonveg3)^2
gen      double wdis_pulses  = ( pulses2- pulses3)^2
gen      double wdis_dairy   = (  dairy2-  dairy3)^2
gen      double wdis_veg     = (    veg2-    veg3)^2
gen      double wdis_fruit   = (  fruit2-  fruit3)^2
gen      double wdis_savings = (savings2-savings3)^2

gen      double hed=round(sqrt(hdis_starch+ hdis_nonveg+ hdis_pulses+ ///
                  hdis_dairy + hdis_veg   + hdis_fruit + hdis_savings),0.0001)
gen      double wed=round(sqrt(wdis_starch+ wdis_nonveg+ wdis_pulses+ ///
                  wdis_dairy + wdis_veg   + wdis_fruit + wdis_savings),0.0001)

gen      double midmp_fexp=round(wed/(hed+wed),0.0001)
gen      double widmp_fexp=round(hed/(hed+wed),0.0001)



label    variable hed        "Euclidean distance for husband(foodexp)"
label    variable wed        "Euclidean distance for wife(foodexp)"
label    variable midmp_fexp "Men’s intrahousehold decision making power(foodexp)"
label    variable widmp_fexp "Women’s intrahousehold decision making power(foodexp)"


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_ihdmpfoodexp.dta", replace


/*
label variable starch1 "average investment share for Starch (husband)"
label variable nonveg1 "average investment share for Non-vegetarian (husband)"
label variable pulses1 "average investment share for Pulses (husband)"
label variable dairy1 "average investment share for Dairy (husband)"
label variable veg1 "average investment share for Vegetables (husband)"
label variable fruit1 "average investment share for Fruit (husband)"
label variable savings1 "average savings investment share (husband)"

label variable starch2 "average investment share for Starch (wife)"
label variable nonveg2 "average investment share for Non-vegetarian (wife)"
label variable pulses2 "average investment share for Pulses (wife)"
label variable dairy2 "average investment share for Dairy (wife)"
label variable veg2 "average investment share for Vegetables (wife)"
label variable fruit2 "average investment share for Fruit (wife)"
label variable savings2 "average savings investment share (wife)"

label variable starch3 "average investment share for Starch (joint)"
label variable nonveg3 "average investment share for Non-vegetarian (joint)"
label variable pulses3 "average investment share for Pulses (joint)"
label variable dairy3 "average investment share for Dairy (joint)"
label variable veg3 "average investment share for Vegetables (joint)"
label variable fruit3 "average investment share for Fruit (joint)"
label variable savings3 "average savings investment share (joint)"

*/
