 /**EXPORTING SPSS FILE TO SASXPORT TO RETAIN VARIABLE LABELS**/
 /*FILENAME: food_habit 2018.xpt*/
 
clear all

import sasxport "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food Habit 2018\food_habit 2018.xpt"

sort vks_id

destring s3q1 s3q2b s3q2c s3q2d s3q4_1 s3q4_2 s3q4_3 s3q4_4 s3q4_5 s3q4_6_o, replace

**********************DISTANCE**********************

label variable s3q5_01 "Distance - Weekly market"
label variable s3q5_02 "Distance - Local Grocery store"
label variable s3q5_03 "Distance - Super markets"
label variable s3q5_04 "Distance - Hyper markets"
label variable s3q5_05 "Distance - Online store/shop"
label variable s3q5_06 "Distance - Others"

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

label define store 1 "Weekly market" 2 "Local Grocery store" 3 "Supermarkets" 4 "Hypermarkets" 5 "Online store/shop" 6 "Others" 97 "Refused" 99 "Don't know"

label define freq 1 "Everyday" 2 "4–6 times per week" 3 "2–3 times per week" 4 "Once a week" 5 "2–3 times per month" ///
                  6 "Once a month" 7 "Every other month/six times a year" 8 "Less frequent than every other month"

label define yes 1 "yes" 0 "otherwise" 
		  
label values freq_rice freq
label values store_veg store_fruit store_rice s3q2a s3q2e s3q2f store


**weekly market
replace dis_wkmarket="500"   if dis_wkmarket=="0.5 KM"
replace dis_wkmarket="500"   if dis_wkmarket=="0.5 kM"
replace dis_wkmarket="500"   if dis_wkmarket=="0.5 KM"
replace dis_wkmarket="500"   if dis_wkmarket=="1/2 KM"
replace dis_wkmarket="500"   if dis_wkmarket=="1/2 KM"
replace dis_wkmarket="500"   if dis_wkmarket=="1/2 KM"
replace dis_wkmarket="1000"  if dis_wkmarket=="1 KM"
replace dis_wkmarket="2000"  if dis_wkmarket=="2  KM"
replace dis_wkmarket="2000"  if dis_wkmarket=="2 KM"
replace dis_wkmarket="2000"  if dis_wkmarket=="2 kM"
replace dis_wkmarket="2000"  if dis_wkmarket=="2 KM"
replace dis_wkmarket="2000"  if dis_wkmarket=="2 KM"
replace dis_wkmarket="2000"  if dis_wkmarket=="2 kM"
replace dis_wkmarket="2000"  if dis_wkmarket=="2 KM"
replace dis_wkmarket="2500"  if dis_wkmarket=="2.5KM"
replace dis_wkmarket="3000"  if dis_wkmarket=="3 KM"
replace dis_wkmarket="3000"  if dis_wkmarket=="3 KM"
replace dis_wkmarket="3000"  if dis_wkmarket=="3 KM"
replace dis_wkmarket="4000"  if dis_wkmarket=="4 KM"
replace dis_wkmarket="4000"  if dis_wkmarket=="4 km"
replace dis_wkmarket="5000"  if dis_wkmarket=="5  KM"
replace dis_wkmarket="5000"  if dis_wkmarket=="5 KM"
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
replace dis_wkmarket="0.5"   if dis_wkmarket=="0.5 Meter"
replace dis_wkmarket="1"     if dis_wkmarket=="1   Meter"
replace dis_wkmarket="1"     if dis_wkmarket=="1   Meter"
replace dis_wkmarket="1"     if dis_wkmarket=="1  Meter"
replace dis_wkmarket="1"     if dis_wkmarket=="1 Meter"
replace dis_wkmarket="2"     if dis_wkmarket=="2  Meter"
replace dis_wkmarket="2"     if dis_wkmarket=="2  Meter"
replace dis_wkmarket="2"     if dis_wkmarket=="2 Meter"
replace dis_wkmarket="2"     if dis_wkmarket=="2 meter"
replace dis_wkmarket="3"     if dis_wkmarket=="3  Meter"
replace dis_wkmarket="3"     if dis_wkmarket=="3  Meter"
replace dis_wkmarket="5"     if dis_wkmarket=="5 M"
replace dis_wkmarket="5"     if dis_wkmarket=="5  Meter"
replace dis_wkmarket="5"     if dis_wkmarket=="5  Meter"
replace dis_wkmarket="5"     if dis_wkmarket=="5  Meter"
replace dis_wkmarket="5"     if dis_wkmarket=="5 Meter"
replace dis_wkmarket="5"     if dis_wkmarket=="5 Meter"
replace dis_wkmarket="7"     if dis_wkmarket=="7  Meter"
replace dis_wkmarket="8"     if dis_wkmarket=="8  Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10   Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10  Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10  Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10 Meter"
replace dis_wkmarket="10"    if dis_wkmarket=="10 Meter"
replace dis_wkmarket="12"    if dis_wkmarket=="12 Meter"
replace dis_wkmarket="15"    if dis_wkmarket=="15  Meter"
replace dis_wkmarket="15"    if dis_wkmarket=="15 Meter"
replace dis_wkmarket="15"    if dis_wkmarket=="15 Meter"
replace dis_wkmarket="20"    if dis_wkmarket=="20  Meter"
replace dis_wkmarket="20"    if dis_wkmarket=="20 Meter"
replace dis_wkmarket="30"    if dis_wkmarket=="30 Meter"
replace dis_wkmarket="30"    if dis_wkmarket=="30 Meter"
replace dis_wkmarket="50"    if dis_wkmarket=="50  Meter"
replace dis_wkmarket="50"    if dis_wkmarket=="50  Meter"
replace dis_wkmarket="50"    if dis_wkmarket=="50 Meter"
replace dis_wkmarket="50"    if dis_wkmarket=="50 Meter"
replace dis_wkmarket="70"    if dis_wkmarket=="70  Meter"
replace dis_wkmarket="80"    if dis_wkmarket=="80 Meter"
replace dis_wkmarket="100"   if dis_wkmarket=="100  Meter"
replace dis_wkmarket="100"   if dis_wkmarket=="100 Meter"
replace dis_wkmarket="200"   if dis_wkmarket=="200   Mete"
replace dis_wkmarket="200"   if dis_wkmarket=="200  Meter"
replace dis_wkmarket="200"   if dis_wkmarket=="200  Meter"
replace dis_wkmarket="200"   if dis_wkmarket=="200 Meter"
replace dis_wkmarket="300"   if dis_wkmarket=="300 Meter"
replace dis_wkmarket="300"   if dis_wkmarket=="300 Meter"
replace dis_wkmarket="300"   if dis_wkmarket=="300 Meter"
replace dis_wkmarket="500"   if dis_wkmarket=="500  Meter"
replace dis_wkmarket="500"   if dis_wkmarket=="500 Meter"
replace dis_wkmarket="500"   if dis_wkmarket=="500 Meter"

**grocery
replace dis_grocery="500"    if dis_grocery=="0.5 KM"
replace dis_grocery="500"    if dis_grocery=="0.5 kM"
replace dis_grocery="500"    if dis_grocery=="0.5 KM"
replace dis_grocery="500"    if dis_grocery=="1/2 KM"
replace dis_grocery="500"    if dis_grocery=="1/2 KM"
replace dis_grocery="500"    if dis_grocery=="1/2 KM"
replace dis_grocery="1000"   if dis_grocery=="1 KM"
replace dis_grocery="2000"   if dis_grocery=="2  KM"
replace dis_grocery="2000"   if dis_grocery=="2 KM"
replace dis_grocery="2000"   if dis_grocery=="2 kM"
replace dis_grocery="2000"   if dis_grocery=="2 KM"
replace dis_grocery="2000"   if dis_grocery=="2 KM"
replace dis_grocery="2000"   if dis_grocery=="2 kM"
replace dis_grocery="2000"   if dis_grocery=="2 KM"
replace dis_grocery="2500"   if dis_grocery=="2.5KM"
replace dis_grocery="3000"   if dis_grocery=="3 KM"
replace dis_grocery="3000"   if dis_grocery=="3 KM"
replace dis_grocery="3000"   if dis_grocery=="3 KM"
replace dis_grocery="4000"   if dis_grocery=="4 KM"
replace dis_grocery="4000"   if dis_grocery=="4 km"
replace dis_grocery="5000"   if dis_grocery=="5  KM"
replace dis_grocery="5000"   if dis_grocery=="5 KM"
replace dis_grocery="10000"  if dis_grocery=="10  km"
replace dis_grocery="10000"  if dis_grocery=="10 KM"
replace dis_grocery="10000"  if dis_grocery=="10 KM"
replace dis_grocery="10000"  if dis_grocery=="10 KM"
replace dis_grocery="12000"  if dis_grocery=="12 KM"
replace dis_grocery="15000"  if dis_grocery=="15 KM"
replace dis_grocery="15000"  if dis_grocery=="15 KM."
replace dis_grocery="20000"  if dis_grocery=="20 KM"
replace dis_grocery="20000"  if dis_grocery=="20 KM"
replace dis_grocery="30000"  if dis_grocery=="30 KM"
replace dis_grocery="30000"  if dis_grocery=="30 KM"
replace dis_grocery="50000"  if dis_grocery=="50 KM"
replace dis_grocery="0.5"    if dis_grocery=="0.5 Meter"
replace dis_grocery="1"      if dis_grocery=="1   Meter"
replace dis_grocery="1"      if dis_grocery=="1   Meter"
replace dis_grocery="1"      if dis_grocery=="1  Meter"
replace dis_grocery="1"      if dis_grocery=="1 Meter"
replace dis_grocery="2"      if dis_grocery=="2  Meter"
replace dis_grocery="2"      if dis_grocery=="2  Meter"
replace dis_grocery="2"      if dis_grocery=="2 Meter"
replace dis_grocery="2"      if dis_grocery=="2 meter"
replace dis_grocery="3"      if dis_grocery=="3  Meter"
replace dis_grocery="3"      if dis_grocery=="3  Meter"
replace dis_grocery="5"      if dis_grocery=="5 M"
replace dis_grocery="5"      if dis_grocery=="5  Meter"
replace dis_grocery="5"      if dis_grocery=="5  Meter"
replace dis_grocery="5"      if dis_grocery=="5  Meter"
replace dis_grocery="5"      if dis_grocery=="5 Meter"
replace dis_grocery="5"      if dis_grocery=="5 Meter"
replace dis_grocery="7"      if dis_grocery=="7  Meter"
replace dis_grocery="8"      if dis_grocery=="8  Meter"
replace dis_grocery="10"     if dis_grocery=="10   Meter"
replace dis_grocery="10"     if dis_grocery=="10  Meter"
replace dis_grocery="10"     if dis_grocery=="10  Meter"
replace dis_grocery="10"     if dis_grocery=="10 Meter"
replace dis_grocery="10"     if dis_grocery=="10 Meter"
replace dis_grocery="10"     if dis_grocery=="10 Meter"
replace dis_grocery="10"     if dis_grocery=="10 Meter"
replace dis_grocery="10"     if dis_grocery=="10 Meter"
replace dis_grocery="12"     if dis_grocery=="12 Meter"
replace dis_grocery="15"     if dis_grocery=="15  Meter"
replace dis_grocery="15"     if dis_grocery=="15 Meter"
replace dis_grocery="15"     if dis_grocery=="15 Meter"
replace dis_grocery="20"     if dis_grocery=="20  Meter"
replace dis_grocery="20"     if dis_grocery=="20 Meter"
replace dis_grocery="30"     if dis_grocery=="30 Meter"
replace dis_grocery="30"     if dis_grocery=="30 Meter"
replace dis_grocery="50"     if dis_grocery=="50  Meter"
replace dis_grocery="50"     if dis_grocery=="50  Meter"
replace dis_grocery="50"     if dis_grocery=="50 Meter"
replace dis_grocery="50"     if dis_grocery=="50 Meter"
replace dis_grocery="70"     if dis_grocery=="70  Meter"
replace dis_grocery="80"     if dis_grocery=="80 Meter"
replace dis_grocery="100"    if dis_grocery=="100  Meter"
replace dis_grocery="100"    if dis_grocery=="100 Meter"
replace dis_grocery="200"    if dis_grocery=="200   Mete"
replace dis_grocery="200"    if dis_grocery=="200  Meter"
replace dis_grocery="200"    if dis_grocery=="200  Meter"
replace dis_grocery="200"    if dis_grocery=="200 Meter"
replace dis_grocery="300"    if dis_grocery=="300 Meter"
replace dis_grocery="300"    if dis_grocery=="300 Meter"
replace dis_grocery="300"    if dis_grocery=="300 Meter"
replace dis_grocery="500"    if dis_grocery=="500  Meter"
replace dis_grocery="500"    if dis_grocery=="500 Meter"
replace dis_grocery="500"    if dis_grocery=="500 Meter"

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


destring  dis_wkmarket dis_grocery dis_supermarket dis_hypermarket dis_others, replace
gen       dis_wkmarketkm= dis_wkmarket/1000
gen       dis_grocerykm= dis_grocery/1000
gen       dis_supermarketkm= dis_supermarket/1000
gen       dis_hypermarketkm= dis_hypermarket/1000
gen       dis_otherskm= dis_others/1000


label variable dis_wkmarketkm "distance from house to store (in km)-wet market"
label variable dis_grocerykm "distance from house to store (in km)-grocery"
label variable dis_supermarketkm "distance from house to store (in km)-supermarket"
label variable dis_hypermarketkm "distance from house to store (in km)-hypermarket"
label variable dis_otherskm "distance from house to store (in km)-others"

summarize dis_wkmarketkm dis_grocerykm dis_supermarketkm dis_hypermarketkm dis_otherskm
summarize dis_wkmarketkm dis_grocerykm dis_supermarketkm dis_hypermarketkm dis_otherskm, detail


/*generate dummy with S3Q2b and S3Q2c, get the max distance
this is not recommended as the data shows that there are discrepancies in consumer survey and with 
variables generated to check validity of data responses*/


**********************STORE_prod********************************
tab      store_veg
replace  store_veg=6 if store_veg==7
replace  store_veg=. if store_veg==96|store_veg==99

tab      store_fruit

tab      store_rice
replace  store_rice=6 if store_rice==7
replace  store_rice=. if store_rice==96|store_rice==97|store_rice==99
tab      store_rice

gen      wkmarket=1 if s3q2a==1| store_veg==1| store_fruit==1| store_rice==1| s3q2e==1| s3q2f==1
replace  wkmarket=0 if wkmarket==.
tab      wkmarket

gen      grocery=2 if s3q2a==2| store_veg==2| store_fruit==2| store_rice==2| s3q2e==2| s3q2f==2
replace  grocery=0 if grocery==.
tab      grocery
replace  grocery=1 if grocery==2

gen      supermarket=3 if s3q2a==3| store_veg==3| store_fruit==3| store_rice==3| s3q2e==3| s3q2f==3
replace  supermarket=0 if supermarket==.
tab      supermarket
replace  supermarket=1 if supermarket==3

gen      hypermarket=4 if s3q2a==4| store_veg==4| store_fruit==4| store_rice==4| s3q2e==4| s3q2f==4
replace  hypermarket=0 if hypermarket==.
tab      hypermarket
replace  hypermarket=1 if hypermarket==4

gen      online=5 if s3q2a==5| store_veg==5| store_fruit==5| store_rice==5| s3q2e==5| s3q2f==5
replace  online=0 if online==.
tab      online
replace  online=1 if online==5

gen      otherstore=6 if s3q2a==6| store_veg==6| store_fruit==6| store_rice==6| s3q2e==6| s3q2f==6| ///
         s3q2a==7| store_veg==7| store_fruit==7| store_rice==7| s3q2e==7| s3q2f==7
replace  otherstore=0 if otherstore==.
tab      otherstore
replace  otherstore=1 if otherstore==6
	
tab	     s3q2a
tab	     store_veg
tab	     store_fruit
tab	     store_rice
tab	     s3q2e
tab      s3q2f
tab	     store_wkmarket
tab	     store_grocery
tab	     store_supermarket
tab	     store_hypermarket
tab	     store_online
tab	     store_others

/*
There is discrepancies in the consumer survey and generated variables. 
Consumer survey was not able to capture the stores where food products are purchased.
it is not advisable to use the  store variables (s3q4_1 to s3q4_6_o) and 
distance variables (s3q5_01 to s3q5_06)
*/
gen      wkmarket_veg=1 if store_veg==1
replace  wkmarket_veg=0 if wkmarket_veg==.
tab      wkmarket_veg

gen      wkmarket_fruit=1 if store_fruit==1
replace  wkmarket_fruit=0 if wkmarket_fruit==.
tab      wkmarket_fruit

gen      wkmarket_rice=1 if store_rice==1
replace  wkmarket_rice=0 if wkmarket_rice==.
tab      wkmarket_rice

gen      grocery_rice=1 if store_rice==2
replace  grocery_rice=0 if grocery_rice==.
tab      grocery_rice


**********************STORE********************************
/*STORE_MODERN is not mutually exclusive with other stores*/
gen      store_modern=1 if supermarket==1| hypermarket==1 |online==1
replace  store_modern=0 if store_modern==.
tab      store_modern

/*buy products in modern stores only*/
gen      store_modernonly=1 if wkmarket==0& grocery==0& store_modern==1
replace  store_modernonly=0 if store_modernonly==.
tab      store_modernonly

gen      store_tradonly=1 if  store_modern==0 & store_others==.
replace  store_tradonly=0 if store_tradonly==.
tab      store_tradonly

label variable wkmarket_veg "vegetable product is purchased at weekly market"
label variable wkmarket_fruit "fruit product is purchased at weekly market"
label variable wkmarket_rice "rice product is purchased at weekly market"
label variable grocery_rice "rice product is purchased at local grocery"

label variable wkmarket "household purchase food products in a weekly market"
label variable grocery "household purchase food products in a local grocery"
label variable supermarket "household purchase food products in a supermarket"
label variable hypermarket "household purchase food products in a hypermarket"
label variable online "household purchase food products in online stores"
label variable otherstore "household purchase food products in a other stores"
label variable store_modern "buy products in modern stores"
label variable store_modernonly "buy products only in modern stores"
label variable store_tradonly "buy products in only in traditional stores"




label values wkmarket grocery supermarket hypermarket online otherstore ///
			 wkmarket_veg wkmarket_fruit wkmarket_rice grocery_rice ///
			 store_modern store_modernonly store_tradonly yes

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food Habit 2018\dataset01_foodhabit.dta", replace
