/**DFC workshop data**/

clear all

import excel "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Workshop data\DFC_workshop data.xlsx", sheet("data") firstrow
sort session hh

gen checkdays=mon+tue+wed+thu+fri+sat+sun
edit session hh mon-sun checkdays if checkdays==3
replace fri=0 if session==2 & hh==9
replace checkdays=mon+tue+wed+thu+fri+sat+sun
tab checkdays

/*(Resp_ID 6048) came in late and missed the treatment, set to control*/
edit session hh treatment if session==5 & hh==8
replace treatment=4 if session==5 & hh==8

/*To improve balance of treatment groups, hh 12, 13, 14, 15 to retain as control group*/
edit session hh treatment if session==14
replace treatment=3 if session==14 & (hh==1|hh==2|hh==3) 
replace treatment=2 if session==14 & (hh==4|hh==5|hh==6)
replace treatment=1 if session==14 & (hh==7|hh==8|hh==9|hh==10|hh==11)


save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Workshop data\dataset02_workshop.dta", replace

/*importing food app identifier 
ID in reg form was lifted from 2018 consumer survey if the respondent is  surveyed, else ID was created based on the session no. by Aeon

*/

clear all
import excel "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\food_app identifier.xlsx", sheet("food app identifier") firstrow
sort session hh

merge 1:1 session hh using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Workshop data\dataset02_workshop.dta"

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                               192  (_merge==3)
    -----------------------------------------
*/


sort vks_id
by vks_id :  gen dup = cond(_N==1,0,_n)
tab dup

drop _merge dup checkdays

sort session hh

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Workshop data\dataset02_workshop.dta", replace
/*next step is to merge with mergeddata_03_04.dta */
