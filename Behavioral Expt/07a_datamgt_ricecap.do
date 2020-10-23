/******* Rice per day**********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

keep     uniqueID session hh round day dish quantity Amount_gm hhsize
sort     uniqueID day dish

edit     uniqueID day dish quantity Amount_gm hhsize 

* allrice "has rice in meal plan"
gen      allrice=1   if dish=="Fried rice"|dish=="Panta rice"|dish=="Puffed rice"| ///
                        dish=="Raw rice"|dish=="Steamed rice"

keep     if allrice==1

gen      double riceperday =round(quantity*Amount_gm,0.0001)
gen      double ricepercap =round(riceperday/hhsize , 0.0001)

*computing the total rice consumed per capita per day
collapse (sum)  ricepercap, by (uniqueID day)


*computing the average rice consumption per capita per day
collapse (mean) ricepercap, by (uniqueID)

label    variable ricepercap "ave daily rice consumption per capita (in grams)"


*data transformation: log transformation (log), square-root transformation for moderate skew:*

gen      logricepercap=log(ricepercap)
gen      sqrtricepercap=sqrt(ricepercap)

label    variable ricepercap    "ave daily rice consumption per capita (in grams)"
label    variable logricepercap "ave daily rice consumption per capita (in grams, log)"
label    variable sqrtricepercap "ave daily rice consumption per capita (in grams, sqrt)"

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop _merge

***kdensity
twoway kdensity ricepercap if round ==1 || kdensity ricepercap if round ==2 ||kdensity ricepercap if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity logricepercap if round ==1 || kdensity logricepercap if round ==2 ||kdensity logricepercap if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity sqrtricepercap if round ==1 || kdensity sqrtricepercap if round ==2 ||kdensity sqrtricepercap if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
				
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\07analysis_ricecap.dta", replace


