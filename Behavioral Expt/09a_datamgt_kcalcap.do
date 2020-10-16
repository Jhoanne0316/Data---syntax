/******* TOTAL CALORIES per capita**********/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep    uniqueID session hh round day occasion dish quantity hhsize energytotal
sort    uniqueID day occasion


edit     uniqueID session hh round day occasion dish quantity hhsize energytotal

***generating the total calories accounting the no. of serving (quantity)
gen      double kcal    =round(energytotal*quantity, 0.0001)
gen      double kcalcap =round(kcal/hhsize         , 0.0001)

/*
computing the calorie per day for each respondent
reason: the calorie consumed for the day 1 may be different from day 2. 
Here, we get the average daily calorie consumption.
*/
collapse (sum) kcalcap, by (uniqueID day)


***computing daily average calorie consumed per capita
collapse (mean) kcalcap, by (uniqueID)


/*
natural logarithm transformation (ln); log transformation (log)== same results
this is done to transform the data to normal distribution
*/

gen      lnkcalcap =ln(kcalcap)
gen      logkcalcap=log(kcalcap)

**labelling variables
label    variable kcalcap    "ave daily calories per capita"
label    variable logkcalcap "ave daily calories per capita (log)"


merge    1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop     _merge


***kdensity
twoway kdensity kcalcap if round ==1 || kdensity kcalcap if round ==2 || ///
                                        kdensity kcalcap if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))
				
twoway kdensity logkcalcap if round ==1 || kdensity logkcalcap if round ==2 || ///
                                           kdensity logkcalcap if round ==3, ///
                legend(order(1 "husband" 2 "wife" 3 "consensus"))				
				
save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\09analysis_kcalcap.dta", replace

