/******* SAMPLE SIZE **********/
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

/*note: this should be household level/per round. n=177*/
sort uniqueID foodgroup_dish
by uniqueID foodgroup_dish: generate dup = cond(_N==1,0,_n)
drop if dup>1

/***************************************************ANALYSIS***************************************************/

/***************round(food group)***************/
/*by round X food group (all)*/
tabulate foodgroup_dish if share_proround!=. & round==1
tabulate foodgroup_dish if share_proround!=. & round==2
tabulate foodgroup_dish if share_proround!=. & round==3

/*by round X food group X Urbanity*/
tabulate foodgroup_dish urbanity if share_proround!=. & round==1
tabulate foodgroup_dish urbanity if share_proround!=. & round==2
tabulate foodgroup_dish urbanity if share_proround!=. & round==3

/*by round X food group X treatment*/
tabulate foodgroup_dish treatment if share_proround!=. & round==1
tabulate foodgroup_dish treatment if share_proround!=. & round==2
tabulate foodgroup_dish treatment if share_proround!=. & round==3

/***************round(food groupXbfast)***************/
/*by round X food group (all)*/
tabulate foodgroup_dish if share_proround!=. & round==1 & occasion=="01Breakfast"
tabulate foodgroup_dish if share_proround!=. & round==2 & occasion=="01Breakfast"
tabulate foodgroup_dish if share_proround!=. & round==3 & occasion=="01Breakfast"


/*by round X food group X Urbanity*/
tabulate foodgroup_dish urbanity if share_proround!=. & round==1 & occasion=="01Breakfast"
tabulate foodgroup_dish urbanity if share_proround!=. & round==2 & occasion=="01Breakfast"
tabulate foodgroup_dish urbanity if share_proround!=. & round==3 & occasion=="01Breakfast"

/*by round X food group X treatment*/
tabulate foodgroup_dish treatment if share_proround!=. & round==1 & occasion=="01Breakfast"
tabulate foodgroup_dish treatment if share_proround!=. & round==2 & occasion=="01Breakfast"
tabulate foodgroup_dish treatment if share_proround!=. & round==3 & occasion=="01Breakfast"



/***************round(food groupX02Morning Snack)***************/
/*by round X food group (all)*/
tabulate foodgroup_dish if share_proround!=. & round==1 & occasion=="02Morning Snack"
tabulate foodgroup_dish if share_proround!=. & round==2 & occasion=="02Morning Snack"
tabulate foodgroup_dish if share_proround!=. & round==3 & occasion=="02Morning Snack"


/*by round X food group X Urbanity*/
tabulate foodgroup_dish urbanity if share_proround!=. & round==1 & occasion=="02Morning Snack"
tabulate foodgroup_dish urbanity if share_proround!=. & round==2 & occasion=="02Morning Snack"
tabulate foodgroup_dish urbanity if share_proround!=. & round==3 & occasion=="02Morning Snack"

/*by round X food group X treatment*/
tabulate foodgroup_dish treatment if share_proround!=. & round==1 & occasion=="02Morning Snack"
tabulate foodgroup_dish treatment if share_proround!=. & round==2 & occasion=="02Morning Snack"
tabulate foodgroup_dish treatment if share_proround!=. & round==3 & occasion=="02Morning Snack"

/***************round(food groupX03Lunch)***************/
/*by round X food group (all)*/
tabulate foodgroup_dish if share_proround!=. & round==1 & occasion=="03Lunch"
tabulate foodgroup_dish if share_proround!=. & round==2 & occasion=="03Lunch"
tabulate foodgroup_dish if share_proround!=. & round==3 & occasion=="03Lunch"


/*by round X food group X Urbanity*/
tabulate foodgroup_dish urbanity if share_proround!=. & round==1 & occasion=="03Lunch"
tabulate foodgroup_dish urbanity if share_proround!=. & round==2 & occasion=="03Lunch"
tabulate foodgroup_dish urbanity if share_proround!=. & round==3 & occasion=="03Lunch"

/*by round X food group X treatment*/
tabulate foodgroup_dish treatment if share_proround!=. & round==1 & occasion=="03Lunch"
tabulate foodgroup_dish treatment if share_proround!=. & round==2 & occasion=="03Lunch"
tabulate foodgroup_dish treatment if share_proround!=. & round==3 & occasion=="03Lunch"


/***************round(food groupX04Afternoon Snack)***************/
/*by round X food group (all)*/
tabulate foodgroup_dish if share_proround!=. & round==1 & occasion=="04Afternoon Snack"
tabulate foodgroup_dish if share_proround!=. & round==2 & occasion=="04Afternoon Snack"
tabulate foodgroup_dish if share_proround!=. & round==3 & occasion=="04Afternoon Snack"


/*by round X food group X Urbanity*/
tabulate foodgroup_dish urbanity if share_proround!=. & round==1 & occasion=="04Afternoon Snack"
tabulate foodgroup_dish urbanity if share_proround!=. & round==2 & occasion=="04Afternoon Snack"
tabulate foodgroup_dish urbanity if share_proround!=. & round==3 & occasion=="04Afternoon Snack"

/*by round X food group X treatment*/
tabulate foodgroup_dish treatment if share_proround!=. & round==1 & occasion=="04Afternoon Snack"
tabulate foodgroup_dish treatment if share_proround!=. & round==2 & occasion=="04Afternoon Snack"
tabulate foodgroup_dish treatment if share_proround!=. & round==3 & occasion=="04Afternoon Snack"
