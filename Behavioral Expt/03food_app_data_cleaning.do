clear all

import excel "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\ALL_Food_Survey_Report.xls", sheet("Worksheet") firstrow


table session
/**
min session no.: 1
max session no.: 7200
invalid sessions: sessions 15 to 7200--> for deletion
**/

table tablenumber 
/**
min: 1
max: 30
invalid entries: 18 to 30--> for deletion
**/

table round 
/** there are 3 rounds**/

table householdsize 

/**
there are Language entries "ben and "eng" --for deletion
**/

table language 
/**
there are numerical entries --for deletion
**/

table agent 
/**
Claire and Matty's entries -- for deletion
Arindam's entries are for checking. few entries of agents used Arindam's username
**/

table status 
/**
in process entries--for checking, there might be entries that needed to be merged with completed entries
**/

table day 
/**
day"0" entry-- for deletion
**/

table occasion 
/**
occasion "0" entry-- for deletion
**/

table foodgroup
/**
foodgroup "0" entry-- for deletion
**/

/**------------deletion------------**/


edit if foodgroup=="0" /*since no data about dishes were capture, for deletion*/
drop if foodgroup=="0" /*(14 observations deleted)*/

edit if status=="In Process" /*since no data about dishes were capture, for deletion*/
drop if status=="In Process" /*(38 observations deleted)*/

edit if session>14
table agent if session>14 /*since this is Arindam and Claire's data, for deletion*/
drop if session>14 /*(48 observations deleted)*/
drop if session==1 /*(28 observations deleted)*/

edit if tablenumber>15 /**no observation*/

table householdsize /*language entries were deleted*/
table language

/**
freq table were generated to check status, day, occassion, and foodgroup. all responses are valid.
**/


/**------------editing based on progress report v7_final------------**/


tabulate weeklypercapitabudget if session==4 & tablenumber==1
replace weeklypercapitabudget=360 if session==4 & tablenumber==1 /*(24 real changes made)*/

edit if tablenumber==5 & session==5 & uniquekey=="WBS000173W5"
replace round=3 if tablenumber==5 & session==5 & uniquekey=="WBS000173W5" /*(21 real changes made)*/

table tablenumber round if session==5
tabulate weeklypercapitabudget if session==5 & tablenumber==6 
replace weeklypercapitabudget=240 if session==5 & tablenumber==6 /*(17 real changes made)*/

tabulate weeklypercapitabudget if session==5 & tablenumber==9 
edit if session==5 & tablenumber==9 & round==2 
tabulate weeklypercapitabudget if session==5 & tablenumber==9 & round==2 /*no discrepancies found in weeklypercapitabudget*/

edit if session==6 & tablenumber==9 & uniquekey=="WBS000048H9"
replace round=3 if session==6 & tablenumber==9  & uniquekey=="WBS000048H9" /*(27 real changes made)*/
table tablenumber round if session==6

tabulate day if session==6 & tablenumber==2 &round==2 /**change day in round3 from Tue to Thu*/
replace day="Thursday" if session==6 & tablenumber==2 & round==3 & day=="Tuesday"
tabulate status if session==6 & tablenumber==3 /*all are in complete status*/

edit if agent=="Arindam" /*session7 round2 table number 10,11,12 were logged as Arindam. change to Mitali Das */
replace agent = "Mitali Das" if session==7 & round==2 & tablenumber==10 /*(20 real changes made)*/
replace agent = "Mitali Das" if session==7 & round==2 & tablenumber==11 /*(12 real changes made)*/
replace agent = "Mitali Das" if session==7 & round==2 & tablenumber==12 /*(18 real changes made)*/

table tablenumber round if session==8 
tabulate session if uniquekey=="WBS000125J9"
replace session=8 if uniquekey=="WBS000125J9" /*(17 real changes made)*/

table tablenumber round if session==9
table status round if session==9 /*no action was made since all cases are completed*/

table tablenumber round if session==10
table status round if session==10

table tablenumber round if session==11
table uniquekey if session==11 & round==3 /*no action was made since all cases are completed*/

table tablenumber round if session==12
table status round if session==12 /*no action was made since all cases are completed*/

table tablenumber round if session==13
table uniquekey if session==13 & tablenumber==15 & round==1
replace tablenumber=14 if uniquekey=="WBS000298H15" /*(18 real changes made)*/
table tablenumber round if session==13
table uniquekey if session==13 & tablenumber==14
table uniquekey if session==13 & tablenumber==15

table tablenumber round if session==14
table uniquekey agent if session==14 & tablenumber==3 &round==1
replace round=2 if session==14 & uniquekey=="WBS000364H3" /*(18 real changes made)*/


table tablenumber round if session==14
table uniquekey if session==14 & tablenumber==9
replace round=2 if session==14 & uniquekey=="WBS000382H9" /*(14 real changes made)*/

drop language status
rename tablenumber hh


/*CHECKING CONSISTENCY OF THE DISH NAMES*/
table dish occasion
replace dish="CHAPATI (ROTI)" if dish=="CHAPATI (ROTI) " /*(225 real changes made)*/
replace dish="SOYA BEAN CURRY" if dish=="SOYABEAN CURRY" /*(13 real changes made)*/
replace dish="SUKUTI/JERKI/DRY MEAT" if dish=="SUKUTI/JERKY/DRY MEAT" /*(1 real changes made)*/
replace dish="KHICHDI" if dish=="KICHDI" /*(8 real changes made)*/
sort dish occasion
	
tabulate quantity
drop if quantity==0 /*dishes which were not consumed --> for deletion*/

destring householdsize, generate(hhsize)

***cleaning weekly percapita budget
 tabulate session round, summarize ( weeklypercapitabudget ) mean 
	/*
		round two is different due to data loss of hh1
		round two is different due to data loss of hh12
	*/
	
	
***cleaning hhsize
sort session hh round

edit session hh round weeklypercapitabudget hhsize if session==4 & hh==15
replace hhsize=5 if session==4 & hh==15 & round==1 /*(19 real changes made)*/

edit session hh round weeklypercapitabudget hhsize if session==5 & hh==3
replace hhsize=3 if session==5 & hh==3 & round==2 /*(10 real changes made)*/



*********************Data cleaning: 12 May 2020**********************
replace dish="Aloo barbati fry" if dish=="ALOO BARBATI FRY (FRIED POTATO CUBES AND BEANS)"
replace dish="Aloo bhaja" if dish=="ALOO BHAJA (FRIED POTATO)"
replace dish="Aloo bhate" if dish=="ALOO BHATE (BOILED AND MASHED POTATO)"
replace dish="Aloo chokha" if dish=="ALOO CHOKHA "
replace dish="Aloo chop" if dish=="ALOO CHOP (POTATO MIX FRIED WITH GRAM FLOUR COATING)"
replace dish="Aloo dum" if dish=="ALOO DUM (BOILED POTATOES IN SPICY GRAVY)"
replace dish="Aloo kabli" if dish=="ALOO KABLI (BOILED POTATO AND CHICKPEAS MIX WITH SPICES)"
replace dish="Aloo kabli" if dish=="ALOO KABLI ( BOILED POTATO AND CICKPEAS MIX WITH SPICES)"
replace dish="Aloo papaya curry" if dish=="ALOO PAPAYA CURRY"
replace dish="Aloo paratha" if dish=="ALOO PARATHA"
replace dish="Aloo posto" if dish=="ALOO POSTO (POPPY SEEDS PASTE WITH POTATO CUBES)"
replace dish="Aloo tikiya" if dish=="ALOO TIKIYA"
replace dish="Amaranth fry" if dish=="AMARANTH FRY"
replace dish="Banana" if dish=="BANANA"
replace dish="Bean and radish" if dish=="BEAN AND RADDISH"
replace dish="Bengal gram dal" if dish=="BENGAL GRAM DAL"
replace dish="Bhel puri" if dish=="BHEL PURI"
replace dish="Bitter gourd fry" if dish=="BITTER GOURD FRY"
replace dish="Boiled eggs" if dish=="BOILED EGGS"
replace dish="Boiled pulse" if dish=="BOILED PULSE"
replace dish="Boiled whole Bengal gram" if dish=="BOILED WHOLE BENGAL GRAM"
replace dish="Bori curry" if dish=="BORI CURRY (SUNDRIED LENTIL BALLS IN SPICY GRAVY)"
replace dish="Brinjal bhaja" if dish=="BRINJAL BHAJA"
replace dish="Brinjal bharta" if dish=="BRINJAL BHARTA"
replace dish="Brinjal pakoda" if dish=="PAKODA/PEYANJI - BRINJAL"
replace dish="Butterscotch pastry" if dish=="BUTTER SCOTCH PASTRY"
replace dish="Cabbage curry" if dish=="CABBAGE CURRY"
replace dish="Cauliflower curry" if dish=="CAULIFLOWER CURRY"
replace dish="Cauliflower pakoda" if dish=="CAULIFLOWER PAKODA"
replace dish="Chaler payesh" if dish=="CHALER PAYESH (RICE DESSERT IN SWEETENED MILK)"
replace dish="Chana" if dish=="CHANA"
replace dish="Chanachur" if dish=="CHANACHUR (SPICY SAVOURY WITH LENTILS & DRY FRUITS)"
replace dish="Chapati" if dish=="CHAPATI (ROTI)"
replace dish="Chatu gola" if dish=="CHATU GOLA (BENGAL GRAM FLOUR SHARBET)"
replace dish="Chicken biryani" if dish=="BIRIYANI (CHICKEN)"
replace dish="Chicken curry (murgir jhol)" if dish=="CURRY - CHICKEN/MURGIR JHOL"
replace dish="Chicken korma" if dish=="KORMA - CHICKEN"
replace dish="Chicken momo with thukpa" if dish=="CHICKEN MOMO WITH THUKPA"
replace dish="Chicken tandoori" if dish=="CHICKEN TANDOORI"
replace dish="Chidwa polao" if dish=="CHIDWA POLAO (FLATTENED RICE COOKED WITH VEGETABLES & DRY FRUITS)"
replace dish="Chili chicken" if dish=="CHILLI CHICKEN"
replace dish="Chili oil" if dish=="CHILI OIL"
replace dish="Chocolate pastry" if dish=="CHOCOLATE PASTRY"
replace dish="Chutney" if dish=="CHUTNEY"
replace dish="Chutney" if dish=="CHUTNEY (WITH TOMATO, DATES)"
replace dish="Corn flakes" if dish=="CORN FLAKES"
replace dish="Cottage cheese" if dish=="COTTAGE CHEESE"
replace dish="Cucumber" if dish=="CUCUMBER"
replace dish="Cutlet (kabab)" if dish=="CUTLET/KABAB"
replace dish="Dahivada" if dish=="DAHIVADA (FRIED URAD DAL BALLS IN YOGHURT GRAVY)"
replace dish="Dal kachori" if dish=="DAL KACHORI (FRIED FLOUR BALLS WITH LENTILS)"
replace dish="Dal pakoda" if dish=="DAL PAKODA (FRIED LENTIL BALLS)"
replace dish="Dalia khichdi" if dish=="DALIA KHICHDI"
replace dish="Dhokla" if dish=="DHOKLA (FERMENTED LENTIL CAKES)"
replace dish="Dry Bombay duck" if dish=="DRY BOMBAY DUCK"
replace dish="Egg curry" if dish=="EGG CURRY"
replace dish="Egg roll" if dish=="EGG ROLL"
replace dish="Egg toast" if dish=="EGG (TOAST)"
replace dish="Fish chop" if dish=="FISH CHOP"
replace dish="Fish finger" if dish=="FISH FINGER"
replace dish="Fish head dal" if dish=="FISH HEAD DAL (LENTIL SOUP WITH FISH HEAD AND BONES)"
replace dish="Fish head vegetables" if dish=="FISH HEAD VEGETABLES"
replace dish="Fish kachori" if dish=="FISH KACHORI"
replace dish="French toast" if dish=="FRENCH TOAST"
replace dish="Fried dhoka" if dish=="FRIED DHOKA (FRIED LENTIL CAKES)"
replace dish="Fried fish" if dish=="FISH FRY"
replace dish="Fried lal saak" if dish=="FRIED LAL SAAK (FRIED RED AMARANTH)"
replace dish="Fried papad" if dish=="PAPAD FRY"
replace dish="Fried peanuts" if dish=="FRIED PEANUTS"
replace dish="Fried rice" if dish=="FRIED RICE"
replace dish="Fruit salad" if dish=="FRUIT SALAD"
replace dish="Gajar halwa" if dish=="GAJAR HALWA (DESSERT WITH CARROTS)"
replace dish="Ghoogni" if dish=="GHOOGNI (CHICKPEAS / BENGAL GRAM IN SPICY GRAVY)"
replace dish="Gola roti" if dish=="GOLA ROTI ( WHEAT FLOUR PAN CAKE)"
replace dish="Guava" if dish=="GUAVA"
replace dish="Gup chup" if dish=="GUP CHUP/PANI PURI/PHUCHKA"
replace dish="Gur" if dish=="GUR (JAGGERY)"
replace dish="Idli with sambar and coconut chutney" if dish=="IDLY WITH SAMBAR & COCONUT CHUTNEY"
replace dish="Jalebi" if dish=="JALEBI (FRIED FLOUR RINGS DIPPED IN SUGAR SYRUP)"
replace dish="Keema curry" if dish=="KEEMA CURRY"
replace dish="Kellogg's chocos with milk" if dish=="KELLOG'S CHOCOS WITH MILK"
replace dish="Khichdi" if dish=="KHICHDI"
replace dish="Khirer chop" if dish=="KHIRER CHOP"
replace dish="Litti" if dish=="LITTI"
replace dish="Luchi" if dish=="LUCHI"
replace dish="Maggi" if dish=="MAGGI"
replace dish="Malpoa" if dish=="MALPOA (FRIED FLOUR CAKES IN SUGAR SYRUP)"
replace dish="Mango murabba" if dish=="MANGO MURABBA"
replace dish="Mango pickle" if dish=="MANGO PICKLE"
replace dish="Mango pickle" if dish=="MANGO PICKLE (AAM TEL - GREEN MANGO SOAKED IN OIL AND SPICE MIXTURE)"
replace dish="Marie biscuit" if dish=="MARIE BISCUIT"
replace dish="Masala dosa" if dish=="MASALA DOSA (FLAKY RICE BREADS WITH SPICY FILLING)"
replace dish="Masoor dal" if dish=="MASOOR DAL (LENTIL BROTH)"
replace dish="Misti doi" if dish=="MISTI DOI (SWEETENED CURD)"
replace dish="Mixed pickle" if dish=="MIXED PICKLE"
replace dish="Mixed vegetable curry" if dish=="MIXED VEG CURRY"
replace dish="Mixed vegetables" if dish=="MIXED VEGETABLES"
replace dish="Momo" if dish=="MOMO"
replace dish="Moori masala" if dish=="MOORI/PUFFED RICE MASALA"
replace dish="Mung dal" if dish=="MUNG DAL"
replace dish="Mutton biryani" if dish=="BIRIYANI (MUTTON)"
replace dish="Mutton curry" if dish=="MUTTON CURRY"
replace dish="Mutton liver curry" if dish=="MUTTON LIVER CURRY"
replace dish="Omelet" if dish=="OMELETTE"
replace dish="Onion pakoda" if dish=="ONION PAKODA"
replace dish="Orange" if dish=="ORANGE"
replace dish="Palak paneer" if dish=="PALAK PANEER"
replace dish="Paneer curry" if dish=="PANEER CURRY (COTTAGE CHEESE CURRY)"
replace dish="Panta rice" if dish=="PANTA RICE (FERMENTED RICE SOAKED IN WATER)"
replace dish="Papri chat" if dish=="PAPRI CHAT (LENTIL FLAKES WITH SPICE AND VEGETABLE MIX IN YOGHURT)"
replace dish="Paratha" if dish=="PARATHA"
replace dish="Plain dosa" if dish=="PLAIN DOSA"
replace dish="Poached egg (oil)" if dish=="EGG POACH (OIL)"
replace dish="Poached egg (water)" if dish=="EGG POACH (WATER)"
replace dish="Polao" if dish=="POLAO (FLAVOUR PILAF RICE)"
replace dish="Posto bata" if dish=="POSTO BATA (GROUND POPPY SEEDS WITH MUSTARD OIL)"
replace dish="Potato chips" if dish=="POTATO CHIPS"
replace dish="Potato chop with puffed rice" if dish=="POTATO CHOP WITH PUFFED RICE"
replace dish="Potato curry" if dish=="POTATO CURRY"
replace dish="Potato ivy gourd curry" if dish=="POTATO, IVY GOURD CURRY"
replace dish="Potato ladies finger curry" if dish=="POTATO LADIES FINGER CURRY"
replace dish="Potato paneer" if dish=="PANEER - POTATO"
replace dish="Potato raw banana curry" if dish=="POTATO RAW BANANA CURRY"
replace dish="Puffed rice" if dish=="PUFFED RICE"
replace dish="Radish potato curry" if dish=="RADDISH, POTATO CURRY"
replace dish="Raita" if dish=="RAITA (CURD MIXED WITH VEGETABLES)"
replace dish="Rajma" if dish=="RAJMA/KIDNEY BEAN"
replace dish="Rasgolla" if dish=="RASAGOLLA (COTTAGE CHEES BALLS DIPPED IN SUGAR SYRUP)"
replace dish="Raw rice" if dish=="RICE (RAW RICE)"
replace dish="Rice papad" if dish=="RICE PAPAD"
replace dish="Roasted peanut" if dish=="NUTS - PEANUT (ROASTED)"
replace dish="Roasted potato" if dish=="POTATO (ROAST)"
replace dish="Rohu fish" if dish=="ROHU FISH"
replace dish="Rohu fish curry" if dish=="ROHU FISH CURRY"
replace dish="Rohu fish fry" if dish=="ROHU FISH FRY"
replace dish="Saag" if dish=="SAAG/DRUMSTICK LEAVES"
replace dish="Salad" if dish=="SALAD"
replace dish="Samosa" if dish=="SAMOSA (FLOUR ENVELOPES WITH VEGETABLE FILLING)"
replace dish="Sandesh" if dish=="SANDESH (SWEETENED COTTAGE CHEESE SWEET MEATS)"
replace dish="Sandwich (non-veg)" if dish=="BREAD - SANDWICH (NONVEG)"
replace dish="Semolina halwa" if dish=="SEMOLINA HALWA (DESSERT)"
replace dish="Semolina upma" if dish=="SEMOLINA UPMA"
replace dish="Simay payesh" if dish=="SIMAY PAYESH"
replace dish="Soaked whole Bengal gram" if dish=="SOAKED WHOLE BENGAL GRAM"
replace dish="Soya bean curry" if dish=="SOYA BEAN CURRY"
replace dish="Sprouts" if dish=="VEGETABLE - SPROUTS"
replace dish="Steamed rice" if dish=="RICE (STEAMED RICE)"
replace dish="Sukuti" if dish=="SUKUTI/JERKI/DRY MEAT"
replace dish="Sweet pancake" if dish=="SWEET PANCAKE"
replace dish="Tangra fish curry" if dish=="TANGRA FISH CURRY"
replace dish="Tarka" if dish=="TARKA "
replace dish="Thukpa" if dish=="NOODLE - THUKPA"
replace dish="Uttapam with sambar and coconut chutney" if dish=="UTTAPAM WITH SAMBAR AND COCONUT CHUTNEY (WATER SOAKED RICE CAKES WITH CONDIMENTS)"
replace dish="Vanilla cake" if dish=="VANILLA CAKE"
replace dish="Vanilla ice cream" if dish=="VANILLA ICE CREAM"
replace dish="Vegetable chow mein" if dish=="VEGETABLE CHOWMEIN"
replace dish="Vegetable pasta" if dish=="VEGETABLE PASTA"
replace dish="Vegetable sandwich" if dish=="VEGETABLE SANDWICH"
replace dish="Vegetable soup" if dish=="VEGETABLE SOUP"
replace dish="Vetki fish curry with cauliflower" if dish=="VETKI FISH CURRY WITH CAULIFLOWER"
replace dish="Yoghurt" if dish=="YOGHURT"

replace day="Saturday" if serialnumber==1 & uniquekey=="WBS000002W9"
replace day="Saturday" if serialnumber==2 & uniquekey=="WBS000002W9"

/**************end of data cleaning***********************/

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\Food app 2018\dataset03_foodapp.dta", replace

/**************descriptive stats***********************/

tabulate session round 

/* results
          |              round
   session |         1          2          3 |     Total
-----------+---------------------------------+----------
         3 |       353        311        365 |     1,029 higher compared to other sessions; more dishes were selected
         4 |       337        350        350 |     1,037 higher compared to other sessions; more dishes were selected
*/


. tabulate agent round if session==2
/*
                   |              round
             agent |         1          2          3 |     Total
-------------------+---------------------------------+----------
Jyoti Prava Poddar |       190          0          0 |       190 ==> high frequency compared to others
        Mitali Das |         0        154          0 |       154 
   Naba Kumar Bain |         0          0        184 |       184 ==> high frequency compared to others 
      Rupali Dutta |         0        159          0 |       159 
    Subrata Mandal |       149          0          0 |       149 
     Sunita Mandal |         0          0        135 |       135 
-------------------+---------------------------------+----------
             Total |       339        313        319 |       971 
*/
