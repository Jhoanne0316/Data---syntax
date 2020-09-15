/*******INVESTMENT SHARE - HDDS**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

keep uniqueID session hh round foodgroup_dish day

/*identifying duplicates to proceed */
sort uniqueID day foodgroup_dish 

gen num_fg=1

by uniqueID day foodgroup_dish : generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

/*counting the no. of food groups per day*/
collapse (sum) num_fg, by (uniqueID day)

rename num_fg HDDS


/*counting the ave. food groups per hh--HDDS*/
collapse (mean) HDDS, by (uniqueID)

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\00uniqueID.dta"
drop new_vks new_vks2 _merge session hh round

label var HDDS "Household Dietary Diversity Score"
summarize HDDS

sort rnd
by rnd: summarize HDDS

ttest HDDS=6
by rnd:ttest HDDS=6

kdensity HDDS
kdensity HDDS, nograph generate(x rd)
kdensity HDDS if rnd=="01", nograph generate(rd1) at(x)
kdensity HDDS if rnd=="02", nograph generate(rd2) at(x)
kdensity HDDS if rnd=="03", nograph generate(rd3) at(x)
label var rd1 "Husband"
label var rd2 "Wife"
label var rd3 "Consensus"
line rd1 rd2 rd3 x, sort xtitle(Household Dietary Diversity Score)

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_HDDS.dta", replace










