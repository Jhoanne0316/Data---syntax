/******* Rice per day**********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear


tab dish
tab round if dish=="Steamed rice"
edit uniqueID quantity hhsize Amount_gm if dish=="Steamed rice"

gen double dishwtpercap=round(quantity*Amount_gm,0.001)/hhsize

collapse (mean) quantity hhsize Amount_gm dishwtpercap, by (uniqueID dish)

label variable dishwtpercap "ave dish weight per capita per day"

gen steamed=1 if dish=="Steamed rice"
gen otherrice=1 if dish=="Fried rice"|dish=="Panta rice"|dish=="Puffed rice"|dish=="Raw rice"
gen allrice=1 if dish=="Fried rice"|dish=="Panta rice"|dish=="Puffed rice"|dish=="Raw rice"|dish=="Steamed rice"


gen stricepercap=dishwtpercap if steamed==1
gen otricepercap=dishwtpercap if otherrice==1
gen allricepercap=dishwtpercap if allrice==1


collapse (mean) steamed otherrice allrice  stricepercap otricepercap allricepercap, by (uniqueID)

replace steamed=0 if steamed==.
replace otherrice=0 if otherrice==.
replace allrice=0 if allrice==.

replace stricepercap=0 if stricepercap==.
replace otricepercap=0 if otricepercap==.
replace allricepercap=0 if allricepercap==.


*natural logarithm transformation (ln); log transformation (log)*
gen logstricepercap=log(stricepercap)
gen logotricepercap=log(otricepercap)
gen logallricepercap=log(allricepercap)

label variable steamed "has steamed rice in meal plan"
label variable otherrice "has other rice dish in meal plan"
label variable allrice "has rice in meal plan"

label variable stricepercap "ave amount of steamed rice per capita per day"
label variable otricepercap "ave amount of other rice dish per capita per day"
label variable allricepercap "ave amount of rice dish per capita per day"

label variable logstricepercap "ave amount of steamed rice per capita per day(log)"
label variable logotricepercap "ave amount of other rice dish per capita per day (log)"
label variable logallricepercap "ave amount of rice dish per capita per day (log)"


merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\14analysis_ricecap.dta", replace


