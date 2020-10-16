/*******INVESTMENT SHARE - HDDS**********/

clear all

use      "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

keep     uniqueID session hh round foodgroup_dish day

/*identifying duplicates to proceed */
sort     uniqueID day foodgroup_dish 

gen      num_fg=1

by       uniqueID day foodgroup_dish : generate dup = cond(_N==1,0,_n)
drop     if dup>1
drop     dup

/*counting the no. of food groups per day*/
collapse (sum) num_fg, by (uniqueID day)

rename   num_fg HDDS


/*counting the ave. food groups per hh--HDDS*/
collapse (mean) HDDS, by (uniqueID)

merge     1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\00c_uniqueID.dta"
drop      new_vks new_vks2 _merge session hh round

label     var HDDS "Household Dietary Diversity Score"
summarize HDDS

sort      rnd
by        rnd: summarize HDDS

ttest     HDDS=6
by        rnd:ttest HDDS=6


merge     1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop      _merge

twoway    kdensity HDDS if round ==1 || kdensity HDDS if round ==2 ||kdensity HDDS if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_hdds.dta", replace










