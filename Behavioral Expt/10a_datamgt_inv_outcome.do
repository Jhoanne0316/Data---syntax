/*******INVESTMENT SHARE - FOOD GROUP**********/
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta", clear

sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

merge 1:m uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed_budgetshares\01collapsed_investment.dta"

sort uniqueID
drop _merge

/************** IDENTIFICATION OF VARIABLES FOR MANAGEMENT******************/
sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

keep uniqueID session hh round percntamtspent percnt_unspent ///
     Morning treatment Kolkata weeklypercapitabudget hhsize ///
	 mon tue wed thu fri sat sun ///
	 AH1 AH2 AH3 AH4 AH5 ///                                         /*Qstnr: 1a HH (AH1-AH6) - AS for agent&enumerator v1.4*/
	 AS1_h AS1_w AS2_h AS2_w ///                                     /* (2) INDIVIDUAL - Accompanying Sheet for AGENT*/
	 D2_h D2_w D3_h D3_w D4_h D4_w D5_h D5_w D6_h D6_w I1_h  I1_w ///          /*(3) INDIVIDUAL – Questionnaire for ENUMERATOR*/ /*addedd D6*/
	 M1_h M1_w M3_h M3_w S1_h S1_w ///
	 District s06_urba s06_rura s07 s3q1 s3q2a s3q2b s3q2c s3q2d s3q2e s3q2f s3q3d /// /*2018 Consumer Survey*/ /*addedd s6q7*/
	 s3q4_1 s3q4_2 s3q4_3 s3q4_4 s3q4_5 s3q4_6_o /// 
	 s3q5_01 s3q5_02 s3q5_03 s3q5_04 s3q5_05 s3q5_06 ///
	 s4q1_06 s4q1_07 s6q3 s6q6 s6q7 q1a_06 s6q18_to



/**************DATA MANAGEMENT OF INDEPENDENT VARIABLES******************/

destring s3q1 s3q2b s3q2c s3q2d s3q4_1 s3q4_2 s3q4_3 s3q4_4 s3q4_5 s3q4_6_o, replace

**LABEL VARIABLE OF EXISTING VARIABLES

label variable weeklypercapitabudget "received weeklypercapitabudget for two days"
label variable hhsize "Household size reported during workshop"
label variable Kolkata "Kolkata - Urban"
label variable Morning "Morning session"
label variable mon "Monday"
label variable tue "Tuesday"
label variable wed "Wednesday"
label variable thu "Thursday"
label variable fri "Friday"
label variable sat "Saturday"
label variable sun "Sunday"

label variable AH1 "number of household members"
label variable AH2 "young children aged below 5 years old"
label variable AH3 "physically active in household - 5 to 17 years old"
label variable AH4 "physically active in household - 18 to 64 years old"
label variable AH5 "physically active in household - 65 years old and above"

label variable AS1_h "hunger level - husband"
label variable AS1_w "hunger level - wife"
label variable AS2_h "feel that had enough budget - Husband"
label variable AS2_w "feel that had enough budget - Wife"

label variable D2_h "Age - Husband"
label variable D2_w "Age - Wife"
label variable D3_h "religion-husband"
label variable D3_w "religion-wife"
label variable D4_h "Years in school - Husband"
label variable D4_w "Years in school - Wife"
label variable D5_h "Working status - Husband"
label variable D5_w "Working status - Wife"
label variable D6_h "Primary occupation - Husband"
label variable D6_w "Primary occupation - Wife"
label variable I1_h "Involvement in meal planning or preparation - Husband"
label variable I1_w "Involvement in meal planning or preparation - Wife"
label variable M1_h "member of any organization"
label variable M1_w "member of any organization"
label variable M3_h "participated in any training course or workshop about nutrition - Huband"
label variable M3_w "participated in any training course or workshop about nutrition - Wife"
label variable S1_h "trusted sources of information about nutrition - Husband"
label variable S1_w "trusted sources of information about nutrition - Wife"

label variable District "District"
label variable s06_urba "monthly hh income reported from 2018 consumer survey - urban"
label variable s06_rura "monthly hh income reported from 2018 consumer survey - rural"
label variable s07 "low income group reported from 2018 consumer survey"
label variable s3q1 "Vegetarian household"
label variable s3q2b "Store type where food product is purchased - Vegetable"
label variable s3q2c "Store type where food product is purchased - Fruits"
label variable s3q2d "Store type where food product is purchased - Rice"
label variable s3q3d "frequency of purchasing rice"
label variable s3q4_1 "Store buy any product - Weekly market"
label variable s3q4_2 "Store buy any product - Local Grocery store"
label variable s3q4_3 "Store buy any product - Super markets"
label variable s3q4_4 "Store buy any product - Hyper markets"
label variable s3q4_5 "Store buy any product - Online store/shop"
label variable s3q4_6_o "Store buy any product - Others"
label variable s3q5_01 "Distance - Weekly market"
label variable s3q5_02 "Distance - Local Grocery store"
label variable s3q5_03 "Distance - Super markets"
label variable s3q5_04 "Distance - Hyper markets"
label variable s3q5_05 "Distance - Online store/shop"
label variable s3q5_06 "Distance - Others"
label variable s4q1_06 "The food product is traditionally consumed because of its health benefits"
label variable s4q1_07 "The food product has high nutrient content."
label variable s6q3 "belong to a Schedule Caste or Schedule Tribe"
label variable s6q6 "current occupation"
label variable s6q18_to "monthly budget reported from 2018 consumer survey"
label variable q1a_06 "Own Refrigerator"

*RENAME VARIABLES


/*Qstnr: 1a HH (AH1-AH6) - AS for agent&enumerator v1.4*/
rename AH1 hhmembers
rename AH2 child
rename AH3 teens
rename AH4 adults
rename AH5 seniors

 /* (2) INDIVIDUAL - Accompanying Sheet for AGENT*/
rename AS1_h hunger_h
rename AS1_w hunger_w
rename AS2_h enough_h
rename AS2_w enough_w

/*(3) INDIVIDUAL – Questionnaire for ENUMERATOR*/
rename D2_h age_h
rename D2_w age_w
rename D3_h rel_h
rename D3_w rel_w
rename D4_h educ_h
rename D4_w educ_w
rename D5_h work_h
rename D5_w work_w
rename I1_h involve_h
rename I1_w involve_w
rename M1_h org_h
rename M1_w org_w
rename M3_h train_h
rename M3_w train_w
rename S1_h source_h
rename S1_w source_w

/*2018 Consumer Survey*/
rename s07 low_inc
rename s3q1 vegetarian
rename s3q2b store_veg
rename s3q2c store_fruit
rename s3q2d store_rice
rename s3q3d freq_rice
rename s3q4_1 store_wkmarket
rename s3q4_2 store_grocery
rename s3q4_3 store_supermarket
rename s3q4_4 store_hypermarket
rename s3q4_5 store_online
rename s3q4_6_o store_others
rename s3q5_01 dis_wkmarket
rename s3q5_02 dis_grocery
rename s3q5_03 dis_supermarket
rename s3q5_04 dis_hypermarket
rename s3q5_05 dis_online
rename s3q5_06 dis_others
rename s4q1_06 importance_health
rename s4q1_07 importance_nutricontent
rename s6q3 caste
rename s6q6 occ
rename s6q18_to actual_monbudget
rename q1a_06 ref


*DEFINING THE VALUE LABEL
label define impt 1 "Not at all important" 2 "Of little importance" 3 "Neutral" 4 "Very important" 5 "Extremely important"

label define cons 1 "constrained" 0 "unconstrained"

label define involve 1 "do all majority" 2 "frequent" 3 "someone else and mainly supervise" 4 "never or hardly"

label define freq 1 "Everyday" 2 "4–6 times per week" 3 "2–3 times per week" 4 "Once a week" 5 "2–3 times per month" ///
                  6 "Once a month" 7 "Every other month/six times a year" 8 "Less frequent than every other month"

label define rel 1 "Hindu" 0 "Others"
 
label define rnd 1 "Husband" 2 "Wife" 3 "Joint"

label define lowincome 1 "low income group" 0 "Otherwise"

label define source 1 "Newspaper" 2 "Magazine" 3 "Television" 4 "Radio" 5 "Internet" 6 "Social Media" 7 "Family/relatives" ///
					8 "Friends/co-workers" 9 "Retailers/sellers" 10 "Info materials inside the store/grocery/supermarkets" ///
					11 "labels in food package"

label define educ 0 "No Formal Schooling" 1 "Primary School" 2 "Junior Secondary School/Middle School/Junior High School" ///
				  3 "Sr Secondary School/ Sr" 4 "High Schools" 5 "Technical/Vocational Training" 6 "University" 7 "Post Graduate", modify

label define trmt 1 "T1:ingredient" 2 "T2:ingredient+dish" 3 "T3:ingredient+dish+occasion" 4 "otherwise"

label define yesno 1 "yes" 0 "no" 
label define yes 1 "yes" 0 "otherwise" 

label define work 1 "Working Full Time (30 hours above a week)" 2 "Working Part Time (> 15 hrs but < 30 hrs a week)" ///
				  3 "Working Less than 15 hrs a week" 4 "Student - Working part time" 5 "Retired" 6 "Unemployed - less than 6 months" ///
				  7 "Unemployed - more than 6 months" 8 "Student - Not working" 9 "Housewife" 96 "Refused"

label define district 6 "Kolkata" 7 "South Twenty Four Parganas" 8 "Bankura" 9 "Murshidabad" 10 "Jalpaiguri" 11 "Paschim Medinipur" ///
					  12 "Hugli" 13 "Uttar Dinajpur" 14 "Koch Bihar"
					  
label define store 1 "Weekly market" 2 "Local Grocery store" 3 "Supermarkets" 4 "Hypermarkets" 5 "Online store/shop" 6 "Others" 97 "Refused" 99 "Don't know"

* Attach the value label to the variable *

label values importance_health importance_nutricontent impt
label values involve_h involve_w involve 
label values freq_rice freq
label values rel_h rel_w rel
label values round rnd
label values low_inc lowincome
label values educ_h educ_w educ
label values treatment trmt
label values enough_h enough_w org_h org_w train_h train_w vegetarian caste ref Morning Kolkata ///
	  		 mon tue wed thu fri sat sun yesno
label values work_h work_w work
label values District district
label values store_veg store_fruit store_rice s3q2a s3q2e s3q2f store

***********************DEPENDENT VARIABLES********************************

*******************************************************************************
*                              REQUIIRED VARIABLES                            *
*******************************************************************************
tab session Kolkata
replace Kolkata=1 if session<=6

***********************BCC********************************
/*BCC-- T4 (control) as the reference var*/
gen BCC1=0
gen BCC2=0
gen BCC3=0

replace BCC1=1 if treatment==1 | treatment==2 | treatment==3
replace BCC2=1 if treatment==2 | treatment==3
replace BCC3=1 if treatment==3

sort round
by round: tab treatment BCC1, row
by round: tab treatment BCC2,row
by round: tab treatment BCC3, row


***********************treatment********************************

gen T1=1 if treatment==1 
gen T2=1 if treatment==2 
gen T3=1 if treatment==3 

replace T1=0 if T1==.
replace T2=0 if T2==.
replace T3=0 if T3==.


**********************/*FOR BUDGET CONSTRAINT*/********************************
/*from 2018 consumer survey--"/4.3)/7*2" factor was added to adjust budget for two days*/

gen actual_2daybudget= ((actual_monbudget/4.3)/7)*2 

gen act_2daypercapbudget= actual_2daybudget/hhsize

gen giv_2daypercapbudget=weeklypercapitabudget/2.85031581297067

gen actual_wkbudget=actual_monbudget/4.3

gen given_wkbudget=(((weeklypercapitabudget/2.85031581297067)*hhsize)/2)*7

sort round
by round:summarize actual_wkbudget given_wkbudget


sort round
by round:summarize act_2daypercapbudget giv_2daypercapbudget


gen PBC=act_2daypercapbudget-giv_2daypercapbudget /*for actual > given (PBC>0), then constrained*/
                                                  /*for actual < given (PBC<0, then unconstrained */

gen PSBC=1 if PBC>0 /*1-constrained*/
replace PSBC=0 if PBC<=0 /*unconstrained*/

**PBC
summarize PBC                   
by round:ttest PBC=0

tabulate round Kolkata, summarize (PBC) 
tabulate round treatment, summarize (PBC) mean standard

gen PBC_00=PBC/100
summarize PBC_00

***PSBC
sort round Kolkata
by round Kolkata: tabulate PSBC
by round: tabulate PSBC
tabulate PSBC

sort round Kolkata

by round Kolkata: summarize actual_monbudget act_2daypercapbudget giv_2daypercapbudget
by round: summarize actual_monbudget act_2daypercapbudget giv_2daypercapbudget
by round Kolkata: ttest act_2daypercapbudget=giv_2daypercapbudget

summarize PSBC

tabulate round Kolkata, summarize (PSBC)  mean
tabulate round treatment, summarize (PSBC) mean 
sort round Kolkata
by round Kolkata:ttest PSBC=0.5

********************** SECOND DAY********************************
/*working on day of the week dummies, MON AS REFERENCE VARIABLE*/
/*generating DAY2*/
gen mon2=1 if sun==1 & mon==1
gen tue2=1 if mon==1 & tue==1
gen wed2=1 if tue==1 & wed==1
gen thu2=1 if wed==1 & thu==1
gen fri2=1 if thu==1 & fri==1
gen sat2=1 if fri==1 & sat==1
gen sun2=1 if sat==1 & sun==1
foreach v of varlist mon2-sun2 {
    replace `v' =0 if `v'==.
  }
  
********************** WEEKDAY********************************
gen weekdays=1 if mon==1| tue==1| wed==1| thu==1| fri==1
replace weekdays=0 if weekdays==.
 
gen weekends=1 if sat==1|sun==1
replace weekends=0 if weekends==.
 
gen weekends_both=1 if sat==1 & sun==1
replace weekends_both=0 if weekends_both==.
 
**********************ROUND********************************

gen husband1=1 if round==1|round==3
replace husband1=0 if husband1==.
tab round husband1

gen wife1=1 if round==2|round==3
replace wife1=0 if wife1==.
tab round wife1


gen husband0=1 if round==1
replace husband0=0 if husband0==.
tab round husband0

gen wife0=1 if round==2
replace wife0=0 if wife0==.
tab round wife0

/*examined difference between resutls when using joint as 00 or 11 thru fmlogit*/
/*assessment: coefficients interchange */
drop husband1 wife1 

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_inv.dta", replace

*******************************************************************************
*                Qstnr: 1a HH (AH1-AH6) - AS for agent&enumerator v1.4        *
*******************************************************************************

**********************FAMILY COMPOSITION**********************

gen prop_child=child/hhsize
gen prop_teens=teens/hhsize
gen prop_adults=adults/hhsize
gen prop_seniors=seniors/hhsize

gen tot_prop=prop_child+prop_teens+prop_adult+prop_senior
summarize prop_child prop_teens prop_adult prop_senior tot_prop
drop tot_prop

*******************************************************************************
*                Qstnr: (3) INDIVIDUAL – Questionnaire for ENUMERATOR         *
*******************************************************************************

**********************AGE**********************

summarize age_h age_w, detail
/*assessment: based on the the link below, Adults age rang is 25-64 years, while seniors are 65 and over
 the statistics shows that for husband's age, below 5% are in youth, while, at least 99% are senior.
 for wife's age, at most 10% are in their youth, while no seniors yet. Relevant categories would only lead to disproportionate distribution,
 hence, it is not advisable to make categories for the variable AGE

https://www.statcan.gc.ca/eng/concepts/definitions/age2
*/

**********************RELIGION********************************
replace  rel_h=0 if rel_h ==2|rel_h ==9
replace  rel_w=0 if rel_w ==2
tab rel_h
tab rel_w

**********************EDUCATION**********************
tab educ_h
tab educ_w

/*at least high school graduate*/
gen highschool_h=0 if educ_h<=3
replace highschool_h=1 if highschool_h==.

tab educ_h highschool_h 
tab highschool_h

gen highschool_w=0 if educ_w<=3
replace highschool_w=1 if highschool_w==.

tab educ_w highschool_w 
tab highschool_w
**********************WORK**********************
tab work_h
gen work_hfull=0
replace work_hfull=1 if work_h==1
tab work_hfull

tab work_w
gen work_whousewife=0
replace work_whousewife=1 if work_w==9
tab work_whousewife
**********************INVOLVEMENT**********************
tab involve_h

gen inv_allh=0 
replace inv_allh=1 if involve_h==1
tab inv_allh

tab involve_w

gen inv_allw=0 
replace inv_allw=1 if involve_w==1
tab inv_allw

**********************TRAINING**********************
tab train_h train_w

/*

participat |
 ed in any |
  training |
 course or |  participated in any
  workshop |  training course or
     about |    workshop about
 nutrition |   nutrition - Wife
  - Huband |        no        yes |     Total
-----------+----------------------+----------
        no |       511          9 |       520 
       yes |         6          0 |         6 
-----------+----------------------+----------
     Total |       517          9 |       526 
*/

gen train_one=0
replace train_one=1 if train_h==1|train_w==1
tab train_one

gen train_both=0
replace train_both=1 if train_h==1 & train_w==1
tab train_both

/*assessment: not more than 3% have participated in any trainings, it is advised not to include this in the model*/

**********************SOURCE OF INFORMATION**********************
**husband
tab source_h
split source_h , p(",")

destring source_h1- source_h8, replace

sort round
gen source_hTV=1 if source_h1==3|source_h2==3|source_h3==3|source_h4==3|source_h5==3|source_h6==3|source_h7==3|source_h8==3
replace source_hTV=0 if source_hTV==.
by round: tab source_hTV

gen source_hTVrad=1 if source_hTV==1 |(source_h1==4|source_h2==4|source_h3==4|source_h4==4|source_h5==4|source_h6==4|source_h7==4|source_h8==4)
replace source_hTVrad=0 if source_hTVrad==.
by round: tab source_hTVrad

gen source_hfamily=1 if source_h1==7|source_h2==7|source_h3==7|source_h4==7|source_h5==7|source_h6==7|source_h7==7|source_h8==7
replace source_hfamily=0 if source_hfamily==.

gen source_hfriends=1 if source_h1==8|source_h2==8|source_h3==8|source_h4==8|source_h5==8|source_h6==8|source_h7==8|source_h8==8
replace source_hfriends=0 if source_hfriends==.

gen source_hwom=1 if source_hfamily==1|source_hfriends==1
replace source_hwom=0 if source_hwom==.
by round: tab source_hwom

gen source_hretailer=1 if source_h1==9|source_h2==9|source_h3==9|source_h4==9|source_h5==9|source_h6==9|source_h7==9|source_h8==9
replace source_hretailer=0 if source_hretailer==.

gen source_hinfomats=1 if source_h1==10|source_h2==10|source_h3==10|source_h4==10|source_h5==10|source_h6==10|source_h7==10|source_h8==10
replace source_hinfomats=0 if source_hinfomats==.

gen source_hretail=1 if source_hretailer==1|source_hinfomats==1
replace source_hretail=0 if source_hretail==.
by round: tab source_hretail

gen source_hlabel=1 if source_h1==11|source_h2==11|source_h3==11|source_h4==11|source_h5==11|source_h6==11|source_h7==11|source_h8==11
replace source_hlabel=0 if source_hlabel==.
by round: tab source_hlabel

*checking distribution
summarize source_hTV source_hTVrad source_hwom source_hretail source_hlabel

**wife
tab source_w
split source_w , p(",")

destring source_w1- source_w10, replace

gen source_wTV=1 if source_w1==3|source_w2==3|source_w3==3|source_w4==3|source_w5==3|source_w6==3|source_w7==3|source_w8==3|source_w9==3|source_w10==3
replace source_wTV=0 if source_wTV==.
by round: tab source_wTV

gen source_wTVrad=1 if source_wTV==1 |(source_w1==4|source_w2==4|source_w3==4|source_w4==4|source_w5==4|source_w6==4|source_w7==4|source_w8==4|source_w9==4|source_w10==4)
replace source_wTVrad=0 if source_wTVrad==.
by round: tab source_wTVrad

gen source_wfamily=1 if source_w1==7|source_w2==7|source_w3==7|source_w4==7|source_w5==7|source_w6==7|source_w7==7|source_w8==7|source_w9==7|source_w10==7
replace source_wfamily=0 if source_wfamily==.

gen source_wfriends=1 if source_w1==8|source_w2==8|source_w3==8|source_w4==8|source_w5==8|source_w6==8|source_w7==8|source_w8==8|source_w9==8|source_w10==8
replace source_wfriends=0 if source_wfriends==.

gen source_wwom=1 if source_wfamily==1|source_wfriends==1
replace source_wwom=0 if source_wwom==.
by round: tab source_wwom

gen source_wretailer=1 if source_w1==9|source_w2==9|source_w3==9|source_w4==9|source_w5==9|source_w6==9|source_w7==9|source_w8==9|source_w9==9|source_w10==9
replace source_wretailer=0 if source_wretailer==.

gen source_winfomats=1 if source_w1==10|source_w2==10|source_w3==10|source_w4==10|source_w5==10|source_w6==10|source_w7==10|source_w8==10|source_w9==10|source_w10==10
replace source_winfomats=0 if source_winfomats==.

gen source_wretail=1 if source_wretailer==1|source_winfomats==1
replace source_wretail=0 if source_wretail==.
by round: tab source_wretail

gen source_wlabel=1 if source_w1==11|source_w2==11|source_w3==11|source_w4==11|source_w5==11|source_w6==11|source_w7==11|source_w8==11|source_w9==11|source_w10==11
replace source_wlabel=0 if source_wlabel==.
by round: tab source_wlabel

*checking distribution
summarize source_wTV source_wTVrad source_wwom source_wretail source_wlabel

drop source_h1- source_h8
drop source_w1- source_w10
drop source_hfamily source_hfriends source_hretailer source_hinfomats
drop source_wfamily source_wfriends source_wretailer source_winfomats

/*
husband:(1) TV=72%, (2) TV|radio=74%, (3) WOM=81%, (4) retail<1%,  (5) Labels=18%; assessment exclude (4) Retail
wife   :(1) TV=75%, (2) TV|radio=75%, (3) WOM=97%, (4) retail=11%, (5) Labels=43%; assessment exclude (3) WOM
*/

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_inv.dta", replace

*******************************************************************************
*                         Qstnr: 2018 Consumer Survey                         *
*******************************************************************************

**********************DISTRICT**********************
tab District Kolkata
edit 
gen north=0
replace north=1 if District==10|District==13|District==14
tab District north

**********************INCOME**********************
tab s06_urba Kolkata

*for low income group in urban s06: 1/2/3/4/5/6/7/8/9/10/11
	replace low_inc=1 if s06_urba<=11
*for middle income group in urban s06: 12/13/14/15/16/17/18
	replace low_inc=0 if s06_urba>11 & s06_urba<=18

tab s06_urba low_inc

tab s06_rura Kolkata
*for low income group in rural s06: 6/5/4/3/2/1
replace low_inc=1 if s06_rura<=6
*for low income group in rural s06: 7/8/9/10/11/12/13
replace low_inc=0 if s06_rura>6 & s06_rura<=14
*note: s06_rural=14 should not be interviewed during the survey but will still be classified here as mid-income level

tab s06_rura low_inc


/*getting the midpoint of income group for urban*/
gen income=.
replace income=1000 if s06_urba==1
replace income=2500.5 if s06_urba==2
replace income=3500.5 if s06_urba==3
replace income=4500.5 if s06_urba==4
replace income=5500.5 if s06_urba==5
replace income=6500.5 if s06_urba==6
replace income=7500.5 if s06_urba==7
replace income=8500.5 if s06_urba==8
replace income=9500.5 if s06_urba==9
replace income=11000.5 if s06_urba==10
replace income=13500.5 if s06_urba==11
replace income=16500.5 if s06_urba==12
replace income=19000.5 if s06_urba==13
replace income=22500.5 if s06_urba==14
replace income=27500.5 if s06_urba==15
replace income=35000.5 if s06_urba==16
replace income=45000.5 if s06_urba==17
replace income=67500.5 if s06_urba==18

tab s06_urba income

/*getting the midpoint of income group for rural*/
replace income=1000 if s06_rura==1
replace income=2500.5 if s06_rura==2
replace income=3500.5 if s06_rura==3
replace income=4500.5 if s06_rura==4
replace income=5500.5 if s06_rura==5
replace income=6500.5 if s06_rura==6
replace income=8000.5 if s06_rura==7
replace income=9500.5 if s06_rura==8
replace income=12500.5 if s06_rura==9
replace income=17500.5 if s06_rura==10
replace income=22500.5 if s06_rura==11
replace income=27500.5 if s06_rura==12
replace income=40000.5 if s06_rura==13
replace income=50000 if s06_rura==14 /*minimum household income*/

tab s06_rura income

gen incpercap=income/hhsize
summarize income incpercap

gen income000=income/1000
gen incpercap000=incpercap/1000
summarize income000 incpercap000
**********************INCOME********************************
tab low_inc
tab low_inc Kolkata, col

**********************VEGETARIAN********************************
tab vegetarian

replace vegetarian=0 if vegetarian==2

**vegetarian=6%; assessment: exclude in the model

**********************STORE_prod********************************
tab store_veg
replace store_veg=6 if store_veg==7
replace store_veg=. if store_veg==96|store_veg==99

tab store_fruit

tab store_rice
replace store_rice=6 if store_rice==7
replace store_rice=. if store_rice==96|store_rice==97|store_rice==99
tab store_rice


gen wkmarket=1 if s3q2a==1| store_veg==1| store_fruit==1| store_rice==1| s3q2e==1| s3q2f==1
replace wkmarket=0 if wkmarket==.
tab wkmarket

gen grocery=2 if s3q2a==2| store_veg==2| store_fruit==2| store_rice==2| s3q2e==2| s3q2f==2
replace grocery=0 if grocery==.
tab grocery
replace grocery=1 if grocery==2

gen supermarket=3 if s3q2a==3| store_veg==3| store_fruit==3| store_rice==3| s3q2e==3| s3q2f==3
replace supermarket=0 if supermarket==.
tab supermarket
replace supermarket=1 if supermarket==3

gen hypermarket=4 if s3q2a==4| store_veg==4| store_fruit==4| store_rice==4| s3q2e==4| s3q2f==4
replace hypermarket=0 if hypermarket==.
tab hypermarket
replace hypermarket=1 if hypermarket==4

gen online=5 if s3q2a==5| store_veg==5| store_fruit==5| store_rice==5| s3q2e==5| s3q2f==5
replace online=0 if online==.
tab online
replace online=1 if online==5

gen otherstore=6 if s3q2a==6| store_veg==6| store_fruit==6| store_rice==6| s3q2e==6| s3q2f==6| ///
                    s3q2a==7| store_veg==7| store_fruit==7| store_rice==7| s3q2e==7| s3q2f==7
replace otherstore=0 if otherstore==.
tab otherstore
replace otherstore=1 if otherstore==6
	
tab	s3q2a
tab	store_veg
tab	store_fruit
tab	store_rice
tab	s3q2e
tab	s3q2f
tab	store_wkmarket
tab	store_grocery
tab	store_supermarket
tab	store_hypermarket
tab	store_online
tab	store_others

/*
There is discrepancies in the consumer survey and generated variables. 
Consumer survey was not able to capture the stores where food products are purchased.
it is not advisable to use the  store variables (s3q4_1 to s3q4_6_o) and 
distance variables (s3q5_01 to s3q5_06)
*/
gen wkmarket_veg=1 if store_veg==1
replace wkmarket_veg=0 if wkmarket_veg==.
tab wkmarket_veg

gen wkmarket_fruit=1 if store_fruit==1
replace wkmarket_fruit=0 if wkmarket_fruit==.
tab wkmarket_fruit

gen wkmarket_rice=1 if store_rice==1
replace wkmarket_rice=0 if wkmarket_rice==.
tab wkmarket_rice

gen grocery_rice=1 if store_rice==2
replace grocery_rice=0 if grocery_rice==.
tab grocery_rice


**********************STORE********************************
/*STORE_MODERN is not mutually exclusive with other stores*/
gen store_modern=1 if supermarket==1| hypermarket==1 |online==1
replace store_modern=0 if store_modern==.
tab store_modern

/*buy products in modern stores only*/
gen store_modernonly=1 if wkmarket==0& grocery==0& store_modern==1
replace store_modernonly=0 if store_modernonly==.
tab store_modernonly

gen store_tradonly=1 if  store_modern==0 & store_others==.
replace store_tradonly=0 if store_tradonly==.
tab store_tradonly

**********************FREQUENCY OF RICE********************************
gen freq_riceconv=.
replace freq_riceconv=28 if freq_rice==1   /*Everyday*/
replace freq_riceconv=20 if freq_rice==2   /*4–6 times per week*/
replace freq_riceconv=10 if freq_rice==3   /*2–3 times per week*/
replace freq_riceconv=4 if freq_rice==4    /*Once a week*/
replace freq_riceconv=2.5 if freq_rice==5  /*2–3 times per month*/
replace freq_riceconv=1 if freq_rice==6    /*Once a month*/
replace freq_riceconv=0.5 if freq_rice==7  /*Every other month/six times a year */
replace freq_riceconv=0.25 if freq_rice==8 /*Less frequent than every other month*/
tab freq_riceconv freq_rice

**********************DISTANCE**********************
**weekly market
replace dis_wkmarket="500" if dis_wkmarket=="0.5 KM"
replace dis_wkmarket="500" if dis_wkmarket=="0.5 kM"
replace dis_wkmarket="500" if dis_wkmarket=="0.5 KM"
replace dis_wkmarket="500" if dis_wkmarket=="1/2 KM"
replace dis_wkmarket="500" if dis_wkmarket=="1/2 KM"
replace dis_wkmarket="500" if dis_wkmarket=="1/2 KM"
replace dis_wkmarket="1000" if dis_wkmarket=="1 KM"
replace dis_wkmarket="2000" if dis_wkmarket=="2  KM"
replace dis_wkmarket="2000" if dis_wkmarket=="2 KM"
replace dis_wkmarket="2000" if dis_wkmarket=="2 kM"
replace dis_wkmarket="2000" if dis_wkmarket=="2 KM"
replace dis_wkmarket="2000" if dis_wkmarket=="2 KM"
replace dis_wkmarket="2000" if dis_wkmarket=="2 kM"
replace dis_wkmarket="2000" if dis_wkmarket=="2 KM"
replace dis_wkmarket="2500" if dis_wkmarket=="2.5KM"
replace dis_wkmarket="3000" if dis_wkmarket=="3 KM"
replace dis_wkmarket="3000" if dis_wkmarket=="3 KM"
replace dis_wkmarket="3000" if dis_wkmarket=="3 KM"
replace dis_wkmarket="4000" if dis_wkmarket=="4 KM"
replace dis_wkmarket="4000" if dis_wkmarket=="4 km"
replace dis_wkmarket="5000" if dis_wkmarket=="5  KM"
replace dis_wkmarket="5000" if dis_wkmarket=="5 KM"
replace dis_wkmarket="10000" if dis_wkmarket=="10  km"
replace dis_wkmarket="10000" if dis_wkmarket=="10 KM"
replace dis_wkmarket="10000" if dis_wkmarket=="10 KM"
replace dis_wkmarket="10000" if dis_wkmarket=="10 KM"
replace dis_wkmarket="12000" if dis_wkmarket=="12 KM"
replace dis_wkmarket="15000" if dis_wkmarket=="15 KM"
replace dis_wkmarket="15000" if dis_wkmarket=="15 KM."
replace dis_wkmarket="20000" if dis_wkmarket=="20 KM"
replace dis_wkmarket="20000" if dis_wkmarket=="20 KM"
replace dis_wkmarket="30000" if dis_wkmarket=="30 KM"
replace dis_wkmarket="30000" if dis_wkmarket=="30 KM"
replace dis_wkmarket="50000" if dis_wkmarket=="50 KM"
replace dis_wkmarket="0.5" if dis_wkmarket=="0.5 Meter"
replace dis_wkmarket="1" if dis_wkmarket=="1   Meter"
replace dis_wkmarket="1" if dis_wkmarket=="1   Meter"
replace dis_wkmarket="1" if dis_wkmarket=="1  Meter"
replace dis_wkmarket="1" if dis_wkmarket=="1 Meter"
replace dis_wkmarket="2" if dis_wkmarket=="2  Meter"
replace dis_wkmarket="2" if dis_wkmarket=="2  Meter"
replace dis_wkmarket="2" if dis_wkmarket=="2 Meter"
replace dis_wkmarket="2" if dis_wkmarket=="2 meter"
replace dis_wkmarket="3" if dis_wkmarket=="3  Meter"
replace dis_wkmarket="3" if dis_wkmarket=="3  Meter"
replace dis_wkmarket="5" if dis_wkmarket=="5 M"
replace dis_wkmarket="5" if dis_wkmarket=="5  Meter"
replace dis_wkmarket="5" if dis_wkmarket=="5  Meter"
replace dis_wkmarket="5" if dis_wkmarket=="5  Meter"
replace dis_wkmarket="5" if dis_wkmarket=="5 Meter"
replace dis_wkmarket="5" if dis_wkmarket=="5 Meter"
replace dis_wkmarket="7" if dis_wkmarket=="7  Meter"
replace dis_wkmarket="8" if dis_wkmarket=="8  Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10   Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10  Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10  Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10" if dis_wkmarket=="10 Meter"
replace dis_wkmarket="12" if dis_wkmarket=="12 Meter"
replace dis_wkmarket="15" if dis_wkmarket=="15  Meter"
replace dis_wkmarket="15" if dis_wkmarket=="15 Meter"
replace dis_wkmarket="15" if dis_wkmarket=="15 Meter"
replace dis_wkmarket="20" if dis_wkmarket=="20  Meter"
replace dis_wkmarket="20" if dis_wkmarket=="20 Meter"
replace dis_wkmarket="30" if dis_wkmarket=="30 Meter"
replace dis_wkmarket="30" if dis_wkmarket=="30 Meter"
replace dis_wkmarket="50" if dis_wkmarket=="50  Meter"
replace dis_wkmarket="50" if dis_wkmarket=="50  Meter"
replace dis_wkmarket="50" if dis_wkmarket=="50 Meter"
replace dis_wkmarket="50" if dis_wkmarket=="50 Meter"
replace dis_wkmarket="70" if dis_wkmarket=="70  Meter"
replace dis_wkmarket="80" if dis_wkmarket=="80 Meter"
replace dis_wkmarket="100" if dis_wkmarket=="100  Meter"
replace dis_wkmarket="100" if dis_wkmarket=="100 Meter"
replace dis_wkmarket="200" if dis_wkmarket=="200   Mete"
replace dis_wkmarket="200" if dis_wkmarket=="200  Meter"
replace dis_wkmarket="200" if dis_wkmarket=="200  Meter"
replace dis_wkmarket="200" if dis_wkmarket=="200 Meter"
replace dis_wkmarket="300" if dis_wkmarket=="300 Meter"
replace dis_wkmarket="300" if dis_wkmarket=="300 Meter"
replace dis_wkmarket="300" if dis_wkmarket=="300 Meter"
replace dis_wkmarket="500" if dis_wkmarket=="500  Meter"
replace dis_wkmarket="500" if dis_wkmarket=="500 Meter"
replace dis_wkmarket="500" if dis_wkmarket=="500 Meter"

**grocery
replace dis_grocery="500" if dis_grocery=="0.5 KM"
replace dis_grocery="500" if dis_grocery=="0.5 kM"
replace dis_grocery="500" if dis_grocery=="0.5 KM"
replace dis_grocery="500" if dis_grocery=="1/2 KM"
replace dis_grocery="500" if dis_grocery=="1/2 KM"
replace dis_grocery="500" if dis_grocery=="1/2 KM"
replace dis_grocery="1000" if dis_grocery=="1 KM"
replace dis_grocery="2000" if dis_grocery=="2  KM"
replace dis_grocery="2000" if dis_grocery=="2 KM"
replace dis_grocery="2000" if dis_grocery=="2 kM"
replace dis_grocery="2000" if dis_grocery=="2 KM"
replace dis_grocery="2000" if dis_grocery=="2 KM"
replace dis_grocery="2000" if dis_grocery=="2 kM"
replace dis_grocery="2000" if dis_grocery=="2 KM"
replace dis_grocery="2500" if dis_grocery=="2.5KM"
replace dis_grocery="3000" if dis_grocery=="3 KM"
replace dis_grocery="3000" if dis_grocery=="3 KM"
replace dis_grocery="3000" if dis_grocery=="3 KM"
replace dis_grocery="4000" if dis_grocery=="4 KM"
replace dis_grocery="4000" if dis_grocery=="4 km"
replace dis_grocery="5000" if dis_grocery=="5  KM"
replace dis_grocery="5000" if dis_grocery=="5 KM"
replace dis_grocery="10000" if dis_grocery=="10  km"
replace dis_grocery="10000" if dis_grocery=="10 KM"
replace dis_grocery="10000" if dis_grocery=="10 KM"
replace dis_grocery="10000" if dis_grocery=="10 KM"
replace dis_grocery="12000" if dis_grocery=="12 KM"
replace dis_grocery="15000" if dis_grocery=="15 KM"
replace dis_grocery="15000" if dis_grocery=="15 KM."
replace dis_grocery="20000" if dis_grocery=="20 KM"
replace dis_grocery="20000" if dis_grocery=="20 KM"
replace dis_grocery="30000" if dis_grocery=="30 KM"
replace dis_grocery="30000" if dis_grocery=="30 KM"
replace dis_grocery="50000" if dis_grocery=="50 KM"
replace dis_grocery="0.5" if dis_grocery=="0.5 Meter"
replace dis_grocery="1" if dis_grocery=="1   Meter"
replace dis_grocery="1" if dis_grocery=="1   Meter"
replace dis_grocery="1" if dis_grocery=="1  Meter"
replace dis_grocery="1" if dis_grocery=="1 Meter"
replace dis_grocery="2" if dis_grocery=="2  Meter"
replace dis_grocery="2" if dis_grocery=="2  Meter"
replace dis_grocery="2" if dis_grocery=="2 Meter"
replace dis_grocery="2" if dis_grocery=="2 meter"
replace dis_grocery="3" if dis_grocery=="3  Meter"
replace dis_grocery="3" if dis_grocery=="3  Meter"
replace dis_grocery="5" if dis_grocery=="5 M"
replace dis_grocery="5" if dis_grocery=="5  Meter"
replace dis_grocery="5" if dis_grocery=="5  Meter"
replace dis_grocery="5" if dis_grocery=="5  Meter"
replace dis_grocery="5" if dis_grocery=="5 Meter"
replace dis_grocery="5" if dis_grocery=="5 Meter"
replace dis_grocery="7" if dis_grocery=="7  Meter"
replace dis_grocery="8" if dis_grocery=="8  Meter"
replace dis_grocery="10" if dis_grocery=="10   Meter"
replace dis_grocery="10" if dis_grocery=="10  Meter"
replace dis_grocery="10" if dis_grocery=="10  Meter"
replace dis_grocery="10" if dis_grocery=="10 Meter"
replace dis_grocery="10" if dis_grocery=="10 Meter"
replace dis_grocery="10" if dis_grocery=="10 Meter"
replace dis_grocery="10" if dis_grocery=="10 Meter"
replace dis_grocery="10" if dis_grocery=="10 Meter"
replace dis_grocery="12" if dis_grocery=="12 Meter"
replace dis_grocery="15" if dis_grocery=="15  Meter"
replace dis_grocery="15" if dis_grocery=="15 Meter"
replace dis_grocery="15" if dis_grocery=="15 Meter"
replace dis_grocery="20" if dis_grocery=="20  Meter"
replace dis_grocery="20" if dis_grocery=="20 Meter"
replace dis_grocery="30" if dis_grocery=="30 Meter"
replace dis_grocery="30" if dis_grocery=="30 Meter"
replace dis_grocery="50" if dis_grocery=="50  Meter"
replace dis_grocery="50" if dis_grocery=="50  Meter"
replace dis_grocery="50" if dis_grocery=="50 Meter"
replace dis_grocery="50" if dis_grocery=="50 Meter"
replace dis_grocery="70" if dis_grocery=="70  Meter"
replace dis_grocery="80" if dis_grocery=="80 Meter"
replace dis_grocery="100" if dis_grocery=="100  Meter"
replace dis_grocery="100" if dis_grocery=="100 Meter"
replace dis_grocery="200" if dis_grocery=="200   Mete"
replace dis_grocery="200" if dis_grocery=="200  Meter"
replace dis_grocery="200" if dis_grocery=="200  Meter"
replace dis_grocery="200" if dis_grocery=="200 Meter"
replace dis_grocery="300" if dis_grocery=="300 Meter"
replace dis_grocery="300" if dis_grocery=="300 Meter"
replace dis_grocery="300" if dis_grocery=="300 Meter"
replace dis_grocery="500" if dis_grocery=="500  Meter"
replace dis_grocery="500" if dis_grocery=="500 Meter"
replace dis_grocery="500" if dis_grocery=="500 Meter"

*supermarket
replace dis_supermarket="500" if dis_supermarket=="0.5 KM"
replace dis_supermarket="500" if dis_supermarket=="0.5 kM"
replace dis_supermarket="500" if dis_supermarket=="0.5 KM"
replace dis_supermarket="500" if dis_supermarket=="1/2 KM"
replace dis_supermarket="500" if dis_supermarket=="1/2 KM"
replace dis_supermarket="500" if dis_supermarket=="1/2 KM"
replace dis_supermarket="1000" if dis_supermarket=="1 KM"
replace dis_supermarket="2000" if dis_supermarket=="2  KM"
replace dis_supermarket="2000" if dis_supermarket=="2 KM"
replace dis_supermarket="2000" if dis_supermarket=="2 kM"
replace dis_supermarket="2000" if dis_supermarket=="2 KM"
replace dis_supermarket="2000" if dis_supermarket=="2 KM"
replace dis_supermarket="2000" if dis_supermarket=="2 kM"
replace dis_supermarket="2000" if dis_supermarket=="2 KM"
replace dis_supermarket="2500" if dis_supermarket=="2.5KM"
replace dis_supermarket="3000" if dis_supermarket=="3 KM"
replace dis_supermarket="3000" if dis_supermarket=="3 KM"
replace dis_supermarket="3000" if dis_supermarket=="3 KM"
replace dis_supermarket="4000" if dis_supermarket=="4 KM"
replace dis_supermarket="4000" if dis_supermarket=="4 km"
replace dis_supermarket="5000" if dis_supermarket=="5  KM"
replace dis_supermarket="5000" if dis_supermarket=="5 KM"
replace dis_supermarket="10000" if dis_supermarket=="10  km"
replace dis_supermarket="10000" if dis_supermarket=="10 KM"
replace dis_supermarket="10000" if dis_supermarket=="10 KM"
replace dis_supermarket="10000" if dis_supermarket=="10 KM"
replace dis_supermarket="12000" if dis_supermarket=="12 KM"
replace dis_supermarket="15000" if dis_supermarket=="15 KM"
replace dis_supermarket="15000" if dis_supermarket=="15 KM."
replace dis_supermarket="20000" if dis_supermarket=="20 KM"
replace dis_supermarket="20000" if dis_supermarket=="20 KM"
replace dis_supermarket="30000" if dis_supermarket=="30 KM"
replace dis_supermarket="30000" if dis_supermarket=="30 KM"
replace dis_supermarket="50000" if dis_supermarket=="50 KM"
replace dis_supermarket="0.5" if dis_supermarket=="0.5 Meter"
replace dis_supermarket="1" if dis_supermarket=="1   Meter"
replace dis_supermarket="1" if dis_supermarket=="1   Meter"
replace dis_supermarket="1" if dis_supermarket=="1  Meter"
replace dis_supermarket="1" if dis_supermarket=="1 Meter"
replace dis_supermarket="2" if dis_supermarket=="2  Meter"
replace dis_supermarket="2" if dis_supermarket=="2  Meter"
replace dis_supermarket="2" if dis_supermarket=="2 Meter"
replace dis_supermarket="2" if dis_supermarket=="2 meter"
replace dis_supermarket="3" if dis_supermarket=="3  Meter"
replace dis_supermarket="3" if dis_supermarket=="3  Meter"
replace dis_supermarket="5" if dis_supermarket=="5 M"
replace dis_supermarket="5" if dis_supermarket=="5  Meter"
replace dis_supermarket="5" if dis_supermarket=="5  Meter"
replace dis_supermarket="5" if dis_supermarket=="5  Meter"
replace dis_supermarket="5" if dis_supermarket=="5 Meter"
replace dis_supermarket="5" if dis_supermarket=="5 Meter"
replace dis_supermarket="7" if dis_supermarket=="7  Meter"
replace dis_supermarket="8" if dis_supermarket=="8  Meter"
replace dis_supermarket="10" if dis_supermarket=="10   Meter"
replace dis_supermarket="10" if dis_supermarket=="10  Meter"
replace dis_supermarket="10" if dis_supermarket=="10  Meter"
replace dis_supermarket="10" if dis_supermarket=="10 Meter"
replace dis_supermarket="10" if dis_supermarket=="10 Meter"
replace dis_supermarket="10" if dis_supermarket=="10 Meter"
replace dis_supermarket="10" if dis_supermarket=="10 Meter"
replace dis_supermarket="10" if dis_supermarket=="10 Meter"
replace dis_supermarket="12" if dis_supermarket=="12 Meter"
replace dis_supermarket="15" if dis_supermarket=="15  Meter"
replace dis_supermarket="15" if dis_supermarket=="15 Meter"
replace dis_supermarket="15" if dis_supermarket=="15 Meter"
replace dis_supermarket="20" if dis_supermarket=="20  Meter"
replace dis_supermarket="20" if dis_supermarket=="20 Meter"
replace dis_supermarket="30" if dis_supermarket=="30 Meter"
replace dis_supermarket="30" if dis_supermarket=="30 Meter"
replace dis_supermarket="50" if dis_supermarket=="50  Meter"
replace dis_supermarket="50" if dis_supermarket=="50  Meter"
replace dis_supermarket="50" if dis_supermarket=="50 Meter"
replace dis_supermarket="50" if dis_supermarket=="50 Meter"
replace dis_supermarket="70" if dis_supermarket=="70  Meter"
replace dis_supermarket="80" if dis_supermarket=="80 Meter"
replace dis_supermarket="100" if dis_supermarket=="100  Meter"
replace dis_supermarket="100" if dis_supermarket=="100 Meter"
replace dis_supermarket="200" if dis_supermarket=="200   Mete"
replace dis_supermarket="200" if dis_supermarket=="200  Meter"
replace dis_supermarket="200" if dis_supermarket=="200  Meter"
replace dis_supermarket="200" if dis_supermarket=="200 Meter"
replace dis_supermarket="300" if dis_supermarket=="300 Meter"
replace dis_supermarket="300" if dis_supermarket=="300 Meter"
replace dis_supermarket="300" if dis_supermarket=="300 Meter"
replace dis_supermarket="500" if dis_supermarket=="500  Meter"
replace dis_supermarket="500" if dis_supermarket=="500 Meter"
replace dis_supermarket="500" if dis_supermarket=="500 Meter"

*hypermarket
replace dis_hypermarket="500" if dis_hypermarket=="0.5 KM"
replace dis_hypermarket="500" if dis_hypermarket=="0.5 kM"
replace dis_hypermarket="500" if dis_hypermarket=="0.5 KM"
replace dis_hypermarket="500" if dis_hypermarket=="1/2 KM"
replace dis_hypermarket="500" if dis_hypermarket=="1/2 KM"
replace dis_hypermarket="500" if dis_hypermarket=="1/2 KM"
replace dis_hypermarket="1000" if dis_hypermarket=="1 KM"
replace dis_hypermarket="2000" if dis_hypermarket=="2  KM"
replace dis_hypermarket="2000" if dis_hypermarket=="2 KM"
replace dis_hypermarket="2000" if dis_hypermarket=="2 kM"
replace dis_hypermarket="2000" if dis_hypermarket=="2 KM"
replace dis_hypermarket="2000" if dis_hypermarket=="2 KM"
replace dis_hypermarket="2000" if dis_hypermarket=="2 kM"
replace dis_hypermarket="2000" if dis_hypermarket=="2 KM"
replace dis_hypermarket="2500" if dis_hypermarket=="2.5KM"
replace dis_hypermarket="3000" if dis_hypermarket=="3 KM"
replace dis_hypermarket="3000" if dis_hypermarket=="3 KM"
replace dis_hypermarket="3000" if dis_hypermarket=="3 KM"
replace dis_hypermarket="4000" if dis_hypermarket=="4 KM"
replace dis_hypermarket="4000" if dis_hypermarket=="4 km"
replace dis_hypermarket="5000" if dis_hypermarket=="5  KM"
replace dis_hypermarket="5000" if dis_hypermarket=="5 KM"
replace dis_hypermarket="10000" if dis_hypermarket=="10  km"
replace dis_hypermarket="10000" if dis_hypermarket=="10 KM"
replace dis_hypermarket="10000" if dis_hypermarket=="10 KM"
replace dis_hypermarket="10000" if dis_hypermarket=="10 KM"
replace dis_hypermarket="12000" if dis_hypermarket=="12 KM"
replace dis_hypermarket="15000" if dis_hypermarket=="15 KM"
replace dis_hypermarket="15000" if dis_hypermarket=="15 KM."
replace dis_hypermarket="20000" if dis_hypermarket=="20 KM"
replace dis_hypermarket="20000" if dis_hypermarket=="20 KM"
replace dis_hypermarket="30000" if dis_hypermarket=="30 KM"
replace dis_hypermarket="30000" if dis_hypermarket=="30 KM"
replace dis_hypermarket="50000" if dis_hypermarket=="50 KM"
replace dis_hypermarket="0.5" if dis_hypermarket=="0.5 Meter"
replace dis_hypermarket="1" if dis_hypermarket=="1   Meter"
replace dis_hypermarket="1" if dis_hypermarket=="1   Meter"
replace dis_hypermarket="1" if dis_hypermarket=="1  Meter"
replace dis_hypermarket="1" if dis_hypermarket=="1 Meter"
replace dis_hypermarket="2" if dis_hypermarket=="2  Meter"
replace dis_hypermarket="2" if dis_hypermarket=="2  Meter"
replace dis_hypermarket="2" if dis_hypermarket=="2 Meter"
replace dis_hypermarket="2" if dis_hypermarket=="2 meter"
replace dis_hypermarket="3" if dis_hypermarket=="3  Meter"
replace dis_hypermarket="3" if dis_hypermarket=="3  Meter"
replace dis_hypermarket="5" if dis_hypermarket=="5 M"
replace dis_hypermarket="5" if dis_hypermarket=="5  Meter"
replace dis_hypermarket="5" if dis_hypermarket=="5  Meter"
replace dis_hypermarket="5" if dis_hypermarket=="5  Meter"
replace dis_hypermarket="5" if dis_hypermarket=="5 Meter"
replace dis_hypermarket="5" if dis_hypermarket=="5 Meter"
replace dis_hypermarket="7" if dis_hypermarket=="7  Meter"
replace dis_hypermarket="8" if dis_hypermarket=="8  Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10   Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10  Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10  Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10 Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10 Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10 Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10 Meter"
replace dis_hypermarket="10" if dis_hypermarket=="10 Meter"
replace dis_hypermarket="12" if dis_hypermarket=="12 Meter"
replace dis_hypermarket="15" if dis_hypermarket=="15  Meter"
replace dis_hypermarket="15" if dis_hypermarket=="15 Meter"
replace dis_hypermarket="15" if dis_hypermarket=="15 Meter"
replace dis_hypermarket="20" if dis_hypermarket=="20  Meter"
replace dis_hypermarket="20" if dis_hypermarket=="20 Meter"
replace dis_hypermarket="30" if dis_hypermarket=="30 Meter"
replace dis_hypermarket="30" if dis_hypermarket=="30 Meter"
replace dis_hypermarket="50" if dis_hypermarket=="50  Meter"
replace dis_hypermarket="50" if dis_hypermarket=="50  Meter"
replace dis_hypermarket="50" if dis_hypermarket=="50 Meter"
replace dis_hypermarket="50" if dis_hypermarket=="50 Meter"
replace dis_hypermarket="70" if dis_hypermarket=="70  Meter"
replace dis_hypermarket="80" if dis_hypermarket=="80 Meter"
replace dis_hypermarket="100" if dis_hypermarket=="100  Meter"
replace dis_hypermarket="100" if dis_hypermarket=="100 Meter"
replace dis_hypermarket="200" if dis_hypermarket=="200   Mete"
replace dis_hypermarket="200" if dis_hypermarket=="200  Meter"
replace dis_hypermarket="200" if dis_hypermarket=="200  Meter"
replace dis_hypermarket="200" if dis_hypermarket=="200 Meter"
replace dis_hypermarket="300" if dis_hypermarket=="300 Meter"
replace dis_hypermarket="300" if dis_hypermarket=="300 Meter"
replace dis_hypermarket="300" if dis_hypermarket=="300 Meter"
replace dis_hypermarket="500" if dis_hypermarket=="500  Meter"
replace dis_hypermarket="500" if dis_hypermarket=="500 Meter"
replace dis_hypermarket="500" if dis_hypermarket=="500 Meter"

*other stores
replace dis_others="500" if dis_others=="0.5 KM"
replace dis_others="500" if dis_others=="0.5 kM"
replace dis_others="500" if dis_others=="0.5 KM"
replace dis_others="500" if dis_others=="1/2 KM"
replace dis_others="500" if dis_others=="1/2 KM"
replace dis_others="500" if dis_others=="1/2 KM"
replace dis_others="1000" if dis_others=="1 KM"
replace dis_others="2000" if dis_others=="2  KM"
replace dis_others="2000" if dis_others=="2 KM"
replace dis_others="2000" if dis_others=="2 kM"
replace dis_others="2000" if dis_others=="2 KM"
replace dis_others="2000" if dis_others=="2 KM"
replace dis_others="2000" if dis_others=="2 kM"
replace dis_others="2000" if dis_others=="2 KM"
replace dis_others="2500" if dis_others=="2.5KM"
replace dis_others="3000" if dis_others=="3 KM"
replace dis_others="3000" if dis_others=="3 KM"
replace dis_others="3000" if dis_others=="3 KM"
replace dis_others="4000" if dis_others=="4 KM"
replace dis_others="4000" if dis_others=="4 km"
replace dis_others="5000" if dis_others=="5  KM"
replace dis_others="5000" if dis_others=="5 KM"
replace dis_others="10000" if dis_others=="10  km"
replace dis_others="10000" if dis_others=="10 KM"
replace dis_others="10000" if dis_others=="10 KM"
replace dis_others="10000" if dis_others=="10 KM"
replace dis_others="12000" if dis_others=="12 KM"
replace dis_others="15000" if dis_others=="15 KM"
replace dis_others="15000" if dis_others=="15 KM."
replace dis_others="20000" if dis_others=="20 KM"
replace dis_others="20000" if dis_others=="20 KM"
replace dis_others="30000" if dis_others=="30 KM"
replace dis_others="30000" if dis_others=="30 KM"
replace dis_others="50000" if dis_others=="50 KM"
replace dis_others="0.5" if dis_others=="0.5 Meter"
replace dis_others="1" if dis_others=="1   Meter"
replace dis_others="1" if dis_others=="1   Meter"
replace dis_others="1" if dis_others=="1  Meter"
replace dis_others="1" if dis_others=="1 Meter"
replace dis_others="2" if dis_others=="2  Meter"
replace dis_others="2" if dis_others=="2  Meter"
replace dis_others="2" if dis_others=="2 Meter"
replace dis_others="2" if dis_others=="2 meter"
replace dis_others="3" if dis_others=="3  Meter"
replace dis_others="3" if dis_others=="3  Meter"
replace dis_others="5" if dis_others=="5 M"
replace dis_others="5" if dis_others=="5  Meter"
replace dis_others="5" if dis_others=="5  Meter"
replace dis_others="5" if dis_others=="5  Meter"
replace dis_others="5" if dis_others=="5 Meter"
replace dis_others="5" if dis_others=="5 Meter"
replace dis_others="7" if dis_others=="7  Meter"
replace dis_others="8" if dis_others=="8  Meter"
replace dis_others="10" if dis_others=="10   Meter"
replace dis_others="10" if dis_others=="10  Meter"
replace dis_others="10" if dis_others=="10  Meter"
replace dis_others="10" if dis_others=="10 Meter"
replace dis_others="10" if dis_others=="10 Meter"
replace dis_others="10" if dis_others=="10 Meter"
replace dis_others="10" if dis_others=="10 Meter"
replace dis_others="10" if dis_others=="10 Meter"
replace dis_others="12" if dis_others=="12 Meter"
replace dis_others="15" if dis_others=="15  Meter"
replace dis_others="15" if dis_others=="15 Meter"
replace dis_others="15" if dis_others=="15 Meter"
replace dis_others="20" if dis_others=="20  Meter"
replace dis_others="20" if dis_others=="20 Meter"
replace dis_others="30" if dis_others=="30 Meter"
replace dis_others="30" if dis_others=="30 Meter"
replace dis_others="50" if dis_others=="50  Meter"
replace dis_others="50" if dis_others=="50  Meter"
replace dis_others="50" if dis_others=="50 Meter"
replace dis_others="50" if dis_others=="50 Meter"
replace dis_others="70" if dis_others=="70  Meter"
replace dis_others="80" if dis_others=="80 Meter"
replace dis_others="100" if dis_others=="100  Meter"
replace dis_others="100" if dis_others=="100 Meter"
replace dis_others="200" if dis_others=="200   Mete"
replace dis_others="200" if dis_others=="200  Meter"
replace dis_others="200" if dis_others=="200  Meter"
replace dis_others="200" if dis_others=="200 Meter"
replace dis_others="300" if dis_others=="300 Meter"
replace dis_others="300" if dis_others=="300 Meter"
replace dis_others="300" if dis_others=="300 Meter"
replace dis_others="500" if dis_others=="500  Meter"
replace dis_others="500" if dis_others=="500 Meter"
replace dis_others="500" if dis_others=="500 Meter"


destring dis_wkmarket dis_grocery dis_supermarket dis_hypermarket dis_others, replace
gen dis_wkmarketkm= dis_wkmarket/1000
gen dis_grocerykm= dis_grocery/1000
gen dis_supermarketkm= dis_supermarket/1000
gen dis_hypermarketkm= dis_hypermarket/1000
gen dis_otherskm= dis_others/1000

summarize dis_wkmarketkm dis_grocerykm dis_supermarketkm dis_hypermarketkm dis_otherskm
summarize dis_wkmarketkm dis_grocerykm dis_supermarketkm dis_hypermarketkm dis_otherskm, detail

/*generate dummy with S3Q2b and S3Q2c, get the max distance
this is not recommended as the data shows that there are discrepancies in consumer survey and with 
variables generated to check validity of data responses*/

********************importance of health and nutri benefits********************

/*this variable suggests that respondents regards health and nutri benefit very or extremely important*/
tab importance_health
replace importance_health=. if importance_health==9

tab importance_nutricontent
replace importance_nutricontent=. if importance_nutricontent==9

tab importance_health importance_nutricontent

gen importance_healthnutri=1 if (importance_health==4|importance_health==5) & (importance_nutricontent==4| importance_nutricontent==5)
tab importance_health importance_healthnutri
tab importance_nutricontent importance_healthnutri

replace importance_healthnutri=0 if importance_health<=3
replace importance_healthnutri=0 if importance_nutricontent<=3

tab importance_healthnutri

********************caste********************
tab caste
replace caste=0 if caste==2
*do not include in the analysis--sensitive issue

********************occupation: farmer********************
gen farmer =1 if occ==3
replace farmer=0 if farmer==.

tab farmer
/*9.64% farmer, do not include in the model*/
********************own ref********************
tab ref
replace ref=1 if ref==6
replace ref=0 if ref==.
	 
********************LABELLING GENERATED VARIABLES********************

label variable BCC1 "BCC1:ingredient"
label variable BCC2 "BCC2: dish"
label variable BCC3 "BCC3: occasion"

label variable T1 "T1:ingredient"
label variable T2 "T2:ingredient+dish"
label variable T3 "T3:ingredient+dish+occ"

label variable actual_2daybudget "adjusted weekly budget for two days from consumer survey 2018"
label variable act_2daypercapbudget "adjusted weekly per capita budget for two days from consumer survey 2018"
label variable giv_2daypercapbudget "received weeklypercapitabudget for two days (rescaled to account inflation)"

*label variable actual_wkbudget "actual weekly budget recorded from consumer survey 2018"
*label variable given_wkbudget "received weekly budget (rescaled to account inflation)"

label variable PBC "Predicted budget constraint"
label variable PSBC "Predicted status of being budget-constrained"
label variable PBC_00 "Predicted budget constraint (in '00 INR)"

label variable tue2 "Second day - Tuesday"
label variable wed2 "Second day - Wednesday"
label variable thu2 "Second day - Thursday"
label variable fri2 "Second day - Friday"
label variable sat2 "Second day - Saturday"
label variable sun2 "Second day - Sunday"

label variable weekdays "weekdays"
label variable weekends "weekends"
label variable weekends_both "weekends only"

label variable husband0 "Husband0"
label variable wife0 "Wife0"

label variable prop_child "proportion of young children aged below 5 years old"
label variable prop_teens "proportion of physically active in household- 5 to 17 years old"
label variable prop_adult "proportion of physically active in household- 18 to 64 years old"
label variable prop_senior "proportion of physically active in household- 65 years old and above"

label variable highschool_h "At least high school graduate - Husband"
label variable highschool_w "At least high school graduate - Wife"

label variable work_hfull "Husband working full time"
label variable work_whousewife "Wife - housewife"

label variable inv_allh "involvement - do all majority (husband)"
label variable inv_allw "involvement - do all majority (wife)"

label variable train_one "At least one had participated in any training about nutrition"
label variable train_both "Both had participated in any training about nutrition"

label variable source_hTV "trusted sources of information about nutrition - Husband: TV"
label variable source_wTV "trusted sources of information about nutrition - Wife: TV"

label variable source_hTVrad "trusted sources of information about nutrition - Husband: TV and/or radio"
label variable source_wTVrad "trusted sources of information about nutrition - Wife: TV and/or radio"

label variable source_hwom "trusted sources of information about nutrition - Husband: word of mouth"
label variable source_wwom "trusted sources of information about nutrition - Wife: word of mouth"

label variable source_hretail "trusted sources of information about nutrition - Husband: retail"
label variable source_wretail "trusted sources of information about nutrition - Wife: retail"

label variable source_hlabel "trusted sources of information about nutrition - Husband: label"
label variable source_wlabel "trusted sources of information about nutrition - Wife: label"

label variable north "Location: North"

label variable income "monthly household income from consumer survey 2018"
label variable incpercap "monthly household per capita income from consumer survey 2018"

label variable income000 "monthly household income from consumer survey 2018 (INR '000)"
label variable incpercap000 "monthly household per capita income from consumer survey 2018('000 INR)"

label variable wkmarket "household purchase food products in a weekly market"
label variable grocery "household purchase food products in a local grocery"
label variable supermarket "household purchase food products in a supermarket"
label variable hypermarket "household purchase food products in a hypermarket"
label variable online "household purchase food products in online stores"
label variable otherstore "household purchase food products in a other stores"

label variable wkmarket_veg "vegetable product is purchased at weekly market"
label variable wkmarket_fruit "fruit product is purchased at weekly market"
label variable wkmarket_rice "rice product is purchased at weekly market"
label variable grocery_rice "rice product is purchased at local grocery"

label variable store_modern "buy products in modern stores"
label variable store_modernonly "buy products only in modern stores"
label variable store_tradonly "buy products in only in traditional stores"

label variable freq_riceconv "frequency of purchasing rice (days in a month)"

label variable dis_wkmarketkm "distance from house to store (in km)-wet market"
label variable dis_grocerykm "distance from house to store (in km)-grocery"
label variable dis_supermarketkm "distance from house to store (in km)-supermarket"
label variable dis_hypermarketkm "distance from house to store (in km)-hypermarket"
label variable dis_otherskm "distance from house to store (in km)-others"

label variable importance_healthnutri "Health and nutri benefits are very/extremely important."
label variable farmer "Occupation - Agriculture, forestry, fishing, plantation"

**********
label values BCC1 BCC2 BCC3 mon2 tue2 wed2 thu2 fri2 sat2 sun2 weekdays weekends weekends_both ///
			 husband0 wife0 work_hfull work_whousewife ///
			 inv_allh inv_allw train_one train_both source_hTV source_hTVrad ///
			 source_hwom source_hretail source_hlabel source_wTV source_wTVrad source_wwom source_wretail source_wlabel ///
			 north wkmarket grocery supermarket hypermarket online otherstore ///
			 wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
			 store_modern store_modernonly store_tradonly importance_healthnutri farmer yes
			 
label values highschool_h highschool_w yesno
label values PSBC cons

************

sort uniqueID
merge 1:1 session hh round using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_iresid.dta"
drop _merge

merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\occasion_indicator.dta"
drop _merge

tab breakfast 
tab amsnack 
tab lunch 
tab pmsnack 
tab dinner

describe

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_inv.dta", replace


************replacement variables************
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_inv.dta"


***AGE***
gen youngadult_h=1 if age_h<=35
replace youngadult_h=0 if youngadult_h==.
tab youngadult_h

gen youngadult_w=1 if age_w<=35
replace youngadult_w=0 if youngadult_w==.
tab youngadult_w

pwcorr youngadult_h youngadult_w, star(.95)  

/*r=0.4025, VIF(youngadult_h =1.85, youngadult_w = 1.94) */ 
/*assessment: managable VIF*/

***HUNGER***
gen hungry_h=1 if hunger_h<=-20
replace hungry_h=0 if hungry_h==.
tab hungry_h

gen hungry_w=1 if hunger_w<=-20
replace hungry_w=0 if hungry_w==.
tab hungry_w

gen ave_hunger=(hunger_h+hunger_w)/2

collin hungry_h hungry_w hunger_h hunger_w ave_hunger, corr
collin hungry_h hungry_w ave_hunger, corr 

/*r=0.7867, VIF(hungry_h =3.81, hungry_w = 4.23) */ 
/*assessment: high VIF, recommendation: do not include in the model*/
/*include ave_hunger in the analysis*/


****household age categories***
gen adseniors=adult+seniors
gen prop_adseniors=adseniors/hhsize
summarize adseniors prop_adseniors

gen childteens=child+teens
gen prop_childteens=childteens/hhsize
summarize childteens prop_childteens


sort round

summarize prop_child prop_teens prop_adults prop_seniors if round==3
summarize child teens adults seniors if round==3
tabulate child if round==3
tabulate seniors if round==3
tabulate teens if round==3
tabulate adults if round==3

twoway kdensity prop_child if (round==3) || kdensity prop_senior if (round==3)



/*GENERATE DUMMY VARIABLES: FAMILY COMPOSITION*/
gen wchild=1 if child>0
replace wchild=0 if wchild==.
tab child wchild

gen wteens=1 if teens>0
replace wteens=0 if wteens==.
tab teens wteens

gen wadult=1 if adult>0
replace wadult=0 if wadult==.
tab adult wadult

gen wseniors=1 if seniors>0
replace wseniors=0 if wseniors==.
tab seniors wseniors

summarize wchild wteens wadult wseniors


label variable youngadult_h "Husband is a young adult aged 18-35 y/o"
label variable youngadult_w "Wife is a young adult aged 18-35 y/o"
label variable hungry_h "Husband experiences hunger"
label variable hungry_w "Wife experiences hunger"
label variable ave_hunger "Average self-reported hunger of both"
label variable adseniors "physically active in household - 18 y/o and above"
label variable prop_adseniors "proportion of physically active in household- 18 y/o and above"
label variable childteens "physically active in household - below 18 y/o"
label variable prop_childteens "proportion of physically active in household - below 18 y/o"
label variable wchild "Household with child"
label variable wteens "Household with teens"
label variable wadult "Household with adults"
label variable wseniors "Household with seniors"

label values youngadult_h youngadult_w hungry_h hungry_w wchild wteens wadult wseniors yes



save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\10analysis_inv.dta", replace

