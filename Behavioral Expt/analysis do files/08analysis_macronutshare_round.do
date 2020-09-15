/******* MACRONUTRIENT shares**********/
clear all

use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_masterfile.dta", clear
sort uniqueID
keep uniqueID session hh round treatment urbanity carbkcal prokcal fatkcal energytotal share_carb share_pro share_fat

/*******************/
sort uniqueID
by uniqueID: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

merge 1:m uniqueID using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\collapsed data\merge_collapseALL.dta"
sort uniqueID
drop _merge


gen foodgroup=1 if foodgroup_dish=="Starch"
replace foodgroup=2 if foodgroup_dish=="Non-vegetarian"
replace foodgroup=3 if foodgroup_dish=="Pulses"
replace foodgroup=4 if foodgroup_dish=="Dairy"
replace foodgroup=5 if foodgroup_dish=="Vegetables"
replace foodgroup=6 if foodgroup_dish=="Fruit"


replace foodgroup_dish=""
replace foodgroup_dish="01Starch" if foodgroup==1
replace foodgroup_dish="02Non-vegetarian" if foodgroup==2
replace foodgroup_dish="03Pulses" if foodgroup==3
replace foodgroup_dish="04Dairy" if foodgroup==4
replace foodgroup_dish="05Vegetables" if foodgroup==5
replace foodgroup_dish="06Fruit" if foodgroup==6

tab foodgroup foodgroup_dish

gen occ=1 if occasion=="Breakfast"
replace occ=2 if occasion=="Morning Snack"
replace occ=3 if occasion=="Lunch"
replace occ=4 if occasion=="Afternoon Snack"
replace occ=5 if occasion=="Dinner"

tab occ occasion

replace occasion=""
replace occasion="01Breakfast" if occ==1
replace occasion="02Morning Snack" if occ==2
replace occasion="03Lunch" if occ==3
replace occasion="04Afternoon Snack" if occ==4
replace occasion="05Dinner" if occ==5

replace share_carbocc=. if share_carbocc==0
replace share_proocc=. if share_proocc==0
replace share_fatocc=. if share_fatocc==0

replace share_carbround=. if share_carbround==0
replace share_proround=. if share_proround==0
replace share_fatround=. if share_fatround==0


/***************************************************ANALYSIS***************************************************/

***frequency distribution
tabulate occasion foodgroup_dish if share_proocc!=. & round==3
/*
                      |                               type
             occasion |  01Starch  02Non-v..   03Pulses    04Dairy  05Veget..    06Fruit |     Total
----------------------+------------------------------------------------------------------+----------
          01Breakfast |       174         15         34          4         32          7 |       266 
      02Morning Snack |        60          3         39          2         10          9 |       123 
              03Lunch |       177        147        145         12        140         28 |       649 
    04Afternoon Snack |       130          4         56          1          1          8 |       200 
             05Dinner |       177         53         89         44        128          8 |       499 
----------------------+------------------------------------------------------------------+----------
                Total |       718        222        363         63        311         60 |     1,737 

*/


/*share of energy during an occasion comes from foodgroup*/
sort occasion foodgroup_dish


***BY FOODGROUP x OCCASION***
by occasion foodgroup_dish:summarize share_carbocc share_proocc share_fatocc if round==3 

sort occasion foodgroup_dish urbanity
by occasion foodgroup_dish urbanity:summarize share_carbocc share_proocc share_fatocc if round==3


sort occasion foodgroup_dish treatment
by occasion foodgroup_dish treatment:summarize share_carbocc share_proocc share_fatocc if round==3





/*share of of energy during a round (H,W,J) comes from foodgroup*/
/*note: this should be household level/per round. n=177*/
sort uniqueID foodgroup_dish
by uniqueID foodgroup_dish: generate dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

label variable share_carbround "share of of carb in a food group during a round (H,W,J) "
label variable share_proround "share of of protein in a food group during a round (H,W,J) "
label variable share_fatround "share of of fat in a food group during a round (H,W,J) "



tabulate foodgroup_dish if share_proround!=. & round==3
/*
            type |      Freq.     Percent        Cum.
-----------------+-----------------------------------
        01Starch |        177       23.29       23.29
02Non-vegetarian |        149       19.61       42.89
        03Pulses |        167       21.97       64.87
         04Dairy |         51        6.71       71.58
    05Vegetables |        170       22.37       93.95
         06Fruit |         46        6.05      100.00
-----------------+-----------------------------------
           Total |        760      100.00
*/
tabulate foodgroup_dish urbanity if share_proround!=. & round==3
/*
                 |    Record Urbanity
            type |     RURAL      URBAN |     Total
-----------------+----------------------+----------
        01Starch |       102         75 |       177 
02Non-vegetarian |        76         73 |       149 
        03Pulses |        95         72 |       167 
         04Dairy |        12         39 |        51 
    05Vegetables |        98         72 |       170 
         06Fruit |        13         33 |        46 
-----------------+----------------------+----------
           Total |       396        364 |       760 

*/

tabulate foodgroup_dish treatment if share_proround!=. & round==3
/*
                 |                  treatment
            type |         1          2          3          4 |     Total
-----------------+--------------------------------------------+----------
        01Starch |        39         42         42         54 |       177 
02Non-vegetarian |        32         36         39         42 |       149 
        03Pulses |        38         40         39         50 |       167 
         04Dairy |         8         15         12         16 |        51 
    05Vegetables |        37         42         39         52 |       170 
         06Fruit |         9          9         12         16 |        46 
-----------------+--------------------------------------------+----------
           Total |       163        184        183        230 |       760 
*/

***ALL OCCASION
sort foodgroup_dish
by foodgroup_dish:summarize share_carbround share_proround share_fatround if round==3 

***ALL OCCASION
sort foodgroup_dish urbanity
by foodgroup_dish urbanity:summarize share_carbround share_proround share_fatround if round==3 

***ALL OCCASION
sort foodgroup_dish treatment
by foodgroup_dish treatment:summarize share_carbround share_proround share_fatround if round==3 



export sasxport "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - syntax\dfc macronutrient_per round.xpt", rename
/*the following variable(s) were renamed in the output file:

                     energytotal -> ENERGYTO
                      share_carb -> SHARE_CA
                       share_pro -> SHARE_PR
                       share_fat -> SHARE_FA
                       treatment -> TREATMEN
                        uniqueID -> UNIQUEID
                  foodgroup_dish -> FOODGROU
                       cost_days -> COST_DAY
                      value_days -> VALUE_DA
                       carb_days -> CARB_DAY
                     energy_days -> ENERGY_D
                       value_occ -> VALUE_OC
                      energy_occ -> ENERGY_O
                    shareqty_occ -> SHAREQTY
                   sharecost_occ -> SHARECOS
                    shareval_occ -> SHAREVAL
                   sharecarb_occ -> SHARECAR
                    sharepro_occ -> SHAREPRO
                    sharefat_occ -> SHAREFAT
                 shareenergy_occ -> SHAREENE
                   share_carbocc -> SHARE_C2
                    share_proocc -> SHARE_P2
                    share_fatocc -> SHARE_F2
                     qty_foodgrp -> QTY_FOOD
                    cost_foodgrp -> COST_FOO
                   value_foodgrp -> VALUE_FO
                    carb_foodgrp -> CARB_FOO
                     pro_foodgrp -> PRO_FOOD
                     fat_foodgrp -> FAT_FOOD
                  energy_foodgrp -> ENERGY_F
                       qty_round -> QTY_ROUN
                      cost_round -> COST_ROU
                     value_round -> VALUE_RO
                      carb_round -> CARB_ROU
                       pro_round -> PRO_ROUN
                       fat_round -> FAT_ROUN
                    energy_round -> ENERGY_R
                  shareqty_round -> SHAREQT2
                 sharecost_round -> SHARECO2
                  shareval_round -> SHAREVA2
                 sharecarb_round -> SHARECA2
                  sharepro_round -> SHAREPR2
                  sharefat_round -> SHAREFA2
               shareenergy_round -> SHAREEN2
                 share_carbround -> SHARE_C3
                  share_proround -> SHARE_P3
                  share_fatround -> SHARE_F3
                       foodgroup -> FOODGRO2
*/
