/**DATA MANAGEMENT BEFORE ANALYSIS**/

clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_mergefile.dta", clear


/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/
keep     uniqueID session hh round day occasion dish quantity ///
         cost hhsize 

sort     uniqueID day occasion

/**generating the deflated budget as the basis for total budget received by the ///
   household, rescaled to account inflation*/
gen      double defdishcost     =round(cost/2.85031581297067,0.0001) 

**investment shares is based on this variable
gen      double amtspentperdish =round(quantity*defdishcost,0.0001) 

/************** DATA MANAGEMENT FOR INDEPENDENT VARIABLES******************/

keep    uniqueID session hh round day dish amtspentperdish hhsize

sort    uniqueID day dish


*computing the total amount spent for a unique dish in one day
collapse (sum) amtspentperdish (mean) hhsize round, by (uniqueID day dish)

*computing the average amount spent for a unique dish for two days
collapse (mean) amtspentperdish hhsize round, by (uniqueID dish)

*recoding in preparation for resharping the data frrom long format to wide format where each dish is a variable
gen     dish_code=.
replace dish_code=1 if dish=="Aloo barbati fry"
replace dish_code=2 if dish=="Aloo bhaja"
replace dish_code=3 if dish=="Aloo bhate"
replace dish_code=4 if dish=="Aloo chokha"
replace dish_code=5 if dish=="Aloo chop"
replace dish_code=6 if dish=="Aloo dum"
replace dish_code=7 if dish=="Aloo kabli"
replace dish_code=8 if dish=="Aloo papaya curry"
replace dish_code=9 if dish=="Aloo paratha"
replace dish_code=10 if dish=="Aloo posto"
replace dish_code=11 if dish=="Aloo tikiya"
replace dish_code=12 if dish=="Amaranth fry"
replace dish_code=13 if dish=="Banana"
replace dish_code=14 if dish=="Bean and radish"
replace dish_code=15 if dish=="Bengal gram dal"
replace dish_code=16 if dish=="Bhel puri"
replace dish_code=17 if dish=="Bitter gourd fry"
replace dish_code=18 if dish=="Boiled eggs"
replace dish_code=19 if dish=="Boiled pulse"
replace dish_code=20 if dish=="Boiled whole Bengal gram"
replace dish_code=21 if dish=="Bori curry"
replace dish_code=22 if dish=="Brinjal bhaja"
replace dish_code=23 if dish=="Brinjal bharta"
replace dish_code=24 if dish=="Brinjal pakoda"
replace dish_code=25 if dish=="Butterscotch pastry"
replace dish_code=26 if dish=="Cabbage curry"
replace dish_code=27 if dish=="Cauliflower curry"
replace dish_code=28 if dish=="Cauliflower pakoda"
replace dish_code=29 if dish=="Chaler payesh"
replace dish_code=30 if dish=="Chana"
replace dish_code=31 if dish=="Chanachur"
replace dish_code=32 if dish=="Chapati"
replace dish_code=33 if dish=="Chatu gola"
replace dish_code=34 if dish=="Chicken biryani"
replace dish_code=35 if dish=="Chicken curry (murgir jhol)"
replace dish_code=36 if dish=="Chicken korma"
replace dish_code=37 if dish=="Chicken momo with thukpa"
replace dish_code=38 if dish=="Chicken tandoori"
replace dish_code=39 if dish=="Chidwa polao"
replace dish_code=40 if dish=="Chili chicken"
replace dish_code=41 if dish=="Chili oil"
replace dish_code=42 if dish=="Chocolate pastry"
replace dish_code=43 if dish=="Chutney"
replace dish_code=44 if dish=="Corn flakes"
replace dish_code=45 if dish=="Cottage cheese"
replace dish_code=46 if dish=="Cucumber"
replace dish_code=47 if dish=="Cutlet (kabab)"
replace dish_code=48 if dish=="Dahivada"
replace dish_code=49 if dish=="Dal kachori"
replace dish_code=50 if dish=="Dal pakoda"
replace dish_code=51 if dish=="Dalia khichdi"
replace dish_code=52 if dish=="Dhokla"
replace dish_code=53 if dish=="Dry Bombay duck"
replace dish_code=54 if dish=="Egg curry"
replace dish_code=55 if dish=="Egg roll"
replace dish_code=56 if dish=="Egg toast"
replace dish_code=57 if dish=="Fish chop"
replace dish_code=58 if dish=="Fish finger"
replace dish_code=59 if dish=="Fish head dal"
replace dish_code=60 if dish=="Fish head vegetables"
replace dish_code=61 if dish=="Fish kachori"
replace dish_code=62 if dish=="French toast"
replace dish_code=63 if dish=="Fried dhoka"
replace dish_code=64 if dish=="Fried fish"
replace dish_code=65 if dish=="Fried lal saak"
replace dish_code=66 if dish=="Fried papad"
replace dish_code=67 if dish=="Fried peanuts"
replace dish_code=68 if dish=="Fried rice"
replace dish_code=69 if dish=="Fruit salad"
replace dish_code=70 if dish=="Gajar halwa"
replace dish_code=71 if dish=="Ghoogni"
replace dish_code=72 if dish=="Gola roti"
replace dish_code=73 if dish=="Guava"
replace dish_code=74 if dish=="Gup chup"
replace dish_code=75 if dish=="Gur"
replace dish_code=76 if dish=="Idli with sambar and coconut chutney"
replace dish_code=77 if dish=="Jalebi"
replace dish_code=78 if dish=="Keema curry"
replace dish_code=79 if dish=="Kellogg's chocos with milk"
replace dish_code=80 if dish=="Khichdi"
replace dish_code=81 if dish=="Khirer chop"
replace dish_code=82 if dish=="Litti"
replace dish_code=83 if dish=="Luchi"
replace dish_code=84 if dish=="Maggi"
replace dish_code=85 if dish=="Malpoa"
replace dish_code=86 if dish=="Mango murabba"
replace dish_code=87 if dish=="Mango pickle"
replace dish_code=88 if dish=="Marie biscuit"
replace dish_code=89 if dish=="Masala dosa"
replace dish_code=90 if dish=="Masoor dal"
replace dish_code=91 if dish=="Misti doi"
replace dish_code=92 if dish=="Mixed pickle"
replace dish_code=93 if dish=="Mixed vegetable curry"
replace dish_code=94 if dish=="Mixed vegetables"
replace dish_code=95 if dish=="Momo"
replace dish_code=96 if dish=="Moori masala"
replace dish_code=97 if dish=="Mung dal"
replace dish_code=98 if dish=="Mutton biryani"
replace dish_code=99 if dish=="Mutton curry"
replace dish_code=100 if dish=="Mutton liver curry"
replace dish_code=101 if dish=="Omelet"
replace dish_code=102 if dish=="Onion pakoda"
replace dish_code=103 if dish=="Orange"
replace dish_code=104 if dish=="Palak paneer"
replace dish_code=105 if dish=="Paneer curry"
replace dish_code=106 if dish=="Panta rice"
replace dish_code=107 if dish=="Papri chat"
replace dish_code=108 if dish=="Paratha"
replace dish_code=109 if dish=="Plain dosa"
replace dish_code=110 if dish=="Poached egg (oil)"
replace dish_code=111 if dish=="Poached egg (water)"
replace dish_code=112 if dish=="Polao"
replace dish_code=113 if dish=="Posto bata"
replace dish_code=114 if dish=="Potato chips"
replace dish_code=115 if dish=="Potato chop with puffed rice"
replace dish_code=116 if dish=="Potato curry"
replace dish_code=117 if dish=="Potato ivy gourd curry"
replace dish_code=118 if dish=="Potato ladies finger curry"
replace dish_code=119 if dish=="Potato paneer"
replace dish_code=120 if dish=="Potato raw banana curry"
replace dish_code=121 if dish=="Puffed rice"
replace dish_code=122 if dish=="Radish potato curry"
replace dish_code=123 if dish=="Raita"
replace dish_code=124 if dish=="Rajma"
replace dish_code=125 if dish=="Rasgolla"
replace dish_code=126 if dish=="Raw rice"
replace dish_code=127 if dish=="Rice papad"
replace dish_code=128 if dish=="Roasted peanut"
replace dish_code=129 if dish=="Roasted potato"
replace dish_code=130 if dish=="Rohu fish"
replace dish_code=131 if dish=="Rohu fish curry"
replace dish_code=132 if dish=="Rohu fish fry"
replace dish_code=133 if dish=="Saag"
replace dish_code=134 if dish=="Salad"
replace dish_code=135 if dish=="Samosa"
replace dish_code=136 if dish=="Sandesh"
replace dish_code=137 if dish=="Sandwich (non-veg)"
replace dish_code=138 if dish=="Semolina halwa"
replace dish_code=139 if dish=="Semolina upma"
replace dish_code=140 if dish=="Simay payesh"
replace dish_code=141 if dish=="Soaked whole Bengal gram"
replace dish_code=142 if dish=="Soya bean curry"
replace dish_code=143 if dish=="Sprouts"
replace dish_code=144 if dish=="Steamed rice"
replace dish_code=145 if dish=="Sukuti"
replace dish_code=146 if dish=="Sweet pancake"
replace dish_code=147 if dish=="Tangra fish curry"
replace dish_code=148 if dish=="Tarka"
replace dish_code=149 if dish=="Thukpa"
replace dish_code=150 if dish=="Uttapam with sambar and coconut chutney"
replace dish_code=151 if dish=="Vanilla cake"
replace dish_code=152 if dish=="Vanilla ice cream"
replace dish_code=153 if dish=="Vegetable chow mein"
replace dish_code=154 if dish=="Vegetable pasta"
replace dish_code=155 if dish=="Vegetable sandwich"
replace dish_code=156 if dish=="Vegetable soup"
replace dish_code=157 if dish=="Vetki fish curry with cauliflower"
replace dish_code=158 if dish=="Yoghurt"

drop dish

* restructuring the data converting the dish spent to variable
reshape wide amtspentperdish, i(uniqueID) j (dish_code)

**adding uniqueID for each hh using iresid var
merge 1:1 uniqueID using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta"

keep uniqueID- amtspentperdish158 hhsize round session hh

merge 1:1 session hh round using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\00a_iresid.dta"
drop _merge uniqueID hhsize session hh

*replacing the value of the variable round in preparation for reshaping the data creating dish variable for each round
replace round=101 if round==1
replace round=102 if round==2
replace round=103 if round==3


*restructuring the data to household level
reshape wide amtspentperdish1- amtspentperdish158, i(iresid) j (round)



**computing distance for husband
gen double hdis_1  =  (amtspentperdish1101-amtspentperdish1103)^2
gen double hdis_2  =  (amtspentperdish2101-amtspentperdish2103)^2
gen double hdis_3  =  (amtspentperdish3101-amtspentperdish3103)^2
gen double hdis_4  =  (amtspentperdish4101-amtspentperdish4103)^2
gen double hdis_5  =  (amtspentperdish5101-amtspentperdish5103)^2
gen double hdis_6  =  (amtspentperdish6101-amtspentperdish6103)^2
gen double hdis_7  =  (amtspentperdish7101-amtspentperdish7103)^2
gen double hdis_8  =  (amtspentperdish8101-amtspentperdish8103)^2
gen double hdis_9  =  (amtspentperdish9101-amtspentperdish9103)^2
gen double hdis_10  =  (amtspentperdish10101-amtspentperdish10103)^2
gen double hdis_12  =  (amtspentperdish12101-amtspentperdish12103)^2
gen double hdis_13  =  (amtspentperdish13101-amtspentperdish13103)^2
gen double hdis_14  =  (amtspentperdish14101-amtspentperdish14103)^2
gen double hdis_15  =  (amtspentperdish15101-amtspentperdish15103)^2
gen double hdis_16  =  (amtspentperdish16101-amtspentperdish16103)^2
gen double hdis_17  =  (amtspentperdish17101-amtspentperdish17103)^2
gen double hdis_18  =  (amtspentperdish18101-amtspentperdish18103)^2
gen double hdis_19  =  (amtspentperdish19101-amtspentperdish19103)^2
gen double hdis_20  =  (amtspentperdish20101-amtspentperdish20103)^2
gen double hdis_21  =  (amtspentperdish21101-amtspentperdish21103)^2
gen double hdis_22  =  (amtspentperdish22101-amtspentperdish22103)^2
gen double hdis_23  =  (amtspentperdish23101-amtspentperdish23103)^2
gen double hdis_24  =  (amtspentperdish24101-amtspentperdish24103)^2
gen double hdis_26  =  (amtspentperdish26101-amtspentperdish26103)^2
gen double hdis_27  =  (amtspentperdish27101-amtspentperdish27103)^2
gen double hdis_28  =  (amtspentperdish28101-amtspentperdish28103)^2
gen double hdis_29  =  (amtspentperdish29101-amtspentperdish29103)^2
gen double hdis_30  =  (amtspentperdish30101-amtspentperdish30103)^2
gen double hdis_31  =  (amtspentperdish31101-amtspentperdish31103)^2
gen double hdis_32  =  (amtspentperdish32101-amtspentperdish32103)^2
gen double hdis_33  =  (amtspentperdish33101-amtspentperdish33103)^2
gen double hdis_34  =  (amtspentperdish34101-amtspentperdish34103)^2
gen double hdis_35  =  (amtspentperdish35101-amtspentperdish35103)^2
gen double hdis_37  =  (amtspentperdish37101-amtspentperdish37103)^2
gen double hdis_39  =  (amtspentperdish39101-amtspentperdish39103)^2
gen double hdis_40  =  (amtspentperdish40101-amtspentperdish40103)^2
gen double hdis_43  =  (amtspentperdish43101-amtspentperdish43103)^2
gen double hdis_44  =  (amtspentperdish44101-amtspentperdish44103)^2
gen double hdis_46  =  (amtspentperdish46101-amtspentperdish46103)^2
gen double hdis_47  =  (amtspentperdish47101-amtspentperdish47103)^2
gen double hdis_48  =  (amtspentperdish48101-amtspentperdish48103)^2
gen double hdis_51  =  (amtspentperdish51101-amtspentperdish51103)^2
gen double hdis_53  =  (amtspentperdish53101-amtspentperdish53103)^2
gen double hdis_54  =  (amtspentperdish54101-amtspentperdish54103)^2
gen double hdis_55  =  (amtspentperdish55101-amtspentperdish55103)^2
gen double hdis_56  =  (amtspentperdish56101-amtspentperdish56103)^2
gen double hdis_57  =  (amtspentperdish57101-amtspentperdish57103)^2
gen double hdis_58  =  (amtspentperdish58101-amtspentperdish58103)^2
gen double hdis_59  =  (amtspentperdish59101-amtspentperdish59103)^2
gen double hdis_60  =  (amtspentperdish60101-amtspentperdish60103)^2
gen double hdis_63  =  (amtspentperdish63101-amtspentperdish63103)^2
gen double hdis_64  =  (amtspentperdish64101-amtspentperdish64103)^2
gen double hdis_65  =  (amtspentperdish65101-amtspentperdish65103)^2
gen double hdis_66  =  (amtspentperdish66101-amtspentperdish66103)^2
gen double hdis_67  =  (amtspentperdish67101-amtspentperdish67103)^2
gen double hdis_68  =  (amtspentperdish68101-amtspentperdish68103)^2
gen double hdis_69  =  (amtspentperdish69101-amtspentperdish69103)^2
gen double hdis_70  =  (amtspentperdish70101-amtspentperdish70103)^2
gen double hdis_71  =  (amtspentperdish71101-amtspentperdish71103)^2
gen double hdis_72  =  (amtspentperdish72101-amtspentperdish72103)^2
gen double hdis_73  =  (amtspentperdish73101-amtspentperdish73103)^2
gen double hdis_74  =  (amtspentperdish74101-amtspentperdish74103)^2
gen double hdis_75  =  (amtspentperdish75101-amtspentperdish75103)^2
gen double hdis_77  =  (amtspentperdish77101-amtspentperdish77103)^2
gen double hdis_78  =  (amtspentperdish78101-amtspentperdish78103)^2
gen double hdis_80  =  (amtspentperdish80101-amtspentperdish80103)^2
gen double hdis_81  =  (amtspentperdish81101-amtspentperdish81103)^2
gen double hdis_83  =  (amtspentperdish83101-amtspentperdish83103)^2
gen double hdis_84  =  (amtspentperdish84101-amtspentperdish84103)^2
gen double hdis_85  =  (amtspentperdish85101-amtspentperdish85103)^2
gen double hdis_87  =  (amtspentperdish87101-amtspentperdish87103)^2
gen double hdis_88  =  (amtspentperdish88101-amtspentperdish88103)^2
gen double hdis_89  =  (amtspentperdish89101-amtspentperdish89103)^2
gen double hdis_90  =  (amtspentperdish90101-amtspentperdish90103)^2
gen double hdis_91  =  (amtspentperdish91101-amtspentperdish91103)^2
gen double hdis_92  =  (amtspentperdish92101-amtspentperdish92103)^2
gen double hdis_93  =  (amtspentperdish93101-amtspentperdish93103)^2
gen double hdis_94  =  (amtspentperdish94101-amtspentperdish94103)^2
gen double hdis_95  =  (amtspentperdish95101-amtspentperdish95103)^2
gen double hdis_96  =  (amtspentperdish96101-amtspentperdish96103)^2
gen double hdis_97  =  (amtspentperdish97101-amtspentperdish97103)^2
gen double hdis_99  =  (amtspentperdish99101-amtspentperdish99103)^2
gen double hdis_101  =  (amtspentperdish101101-amtspentperdish101103)^2
gen double hdis_102  =  (amtspentperdish102101-amtspentperdish102103)^2
gen double hdis_103  =  (amtspentperdish103101-amtspentperdish103103)^2
gen double hdis_104  =  (amtspentperdish104101-amtspentperdish104103)^2
gen double hdis_105  =  (amtspentperdish105101-amtspentperdish105103)^2
gen double hdis_106  =  (amtspentperdish106101-amtspentperdish106103)^2
gen double hdis_107  =  (amtspentperdish107101-amtspentperdish107103)^2
gen double hdis_108  =  (amtspentperdish108101-amtspentperdish108103)^2
gen double hdis_110  =  (amtspentperdish110101-amtspentperdish110103)^2
gen double hdis_111  =  (amtspentperdish111101-amtspentperdish111103)^2
gen double hdis_112  =  (amtspentperdish112101-amtspentperdish112103)^2
gen double hdis_113  =  (amtspentperdish113101-amtspentperdish113103)^2
gen double hdis_114  =  (amtspentperdish114101-amtspentperdish114103)^2
gen double hdis_115  =  (amtspentperdish115101-amtspentperdish115103)^2
gen double hdis_116  =  (amtspentperdish116101-amtspentperdish116103)^2
gen double hdis_117  =  (amtspentperdish117101-amtspentperdish117103)^2
gen double hdis_118  =  (amtspentperdish118101-amtspentperdish118103)^2
gen double hdis_119  =  (amtspentperdish119101-amtspentperdish119103)^2
gen double hdis_120  =  (amtspentperdish120101-amtspentperdish120103)^2
gen double hdis_121  =  (amtspentperdish121101-amtspentperdish121103)^2
gen double hdis_122  =  (amtspentperdish122101-amtspentperdish122103)^2
gen double hdis_123  =  (amtspentperdish123101-amtspentperdish123103)^2
gen double hdis_124  =  (amtspentperdish124101-amtspentperdish124103)^2
gen double hdis_125  =  (amtspentperdish125101-amtspentperdish125103)^2
gen double hdis_126  =  (amtspentperdish126101-amtspentperdish126103)^2
gen double hdis_129  =  (amtspentperdish129101-amtspentperdish129103)^2
gen double hdis_130  =  (amtspentperdish130101-amtspentperdish130103)^2
gen double hdis_131  =  (amtspentperdish131101-amtspentperdish131103)^2
gen double hdis_132  =  (amtspentperdish132101-amtspentperdish132103)^2
gen double hdis_133  =  (amtspentperdish133101-amtspentperdish133103)^2
gen double hdis_134  =  (amtspentperdish134101-amtspentperdish134103)^2
gen double hdis_135  =  (amtspentperdish135101-amtspentperdish135103)^2
gen double hdis_136  =  (amtspentperdish136101-amtspentperdish136103)^2
gen double hdis_138  =  (amtspentperdish138101-amtspentperdish138103)^2
gen double hdis_139  =  (amtspentperdish139101-amtspentperdish139103)^2
gen double hdis_140  =  (amtspentperdish140101-amtspentperdish140103)^2
gen double hdis_141  =  (amtspentperdish141101-amtspentperdish141103)^2
gen double hdis_142  =  (amtspentperdish142101-amtspentperdish142103)^2
gen double hdis_144  =  (amtspentperdish144101-amtspentperdish144103)^2
gen double hdis_145  =  (amtspentperdish145101-amtspentperdish145103)^2
gen double hdis_146  =  (amtspentperdish146101-amtspentperdish146103)^2
gen double hdis_147  =  (amtspentperdish147101-amtspentperdish147103)^2
gen double hdis_148  =  (amtspentperdish148101-amtspentperdish148103)^2
gen double hdis_151  =  (amtspentperdish151101-amtspentperdish151103)^2
gen double hdis_153  =  (amtspentperdish153101-amtspentperdish153103)^2
gen double hdis_154  =  (amtspentperdish154101-amtspentperdish154103)^2
gen double hdis_157  =  (amtspentperdish157101-amtspentperdish157103)^2
gen double hdis_158  =  (amtspentperdish158101-amtspentperdish158103)^2

**computing distance for wife
gen double wdis_1  =  (amtspentperdish1102-amtspentperdish1103)^2
gen double wdis_2  =  (amtspentperdish2102-amtspentperdish2103)^2
gen double wdis_3  =  (amtspentperdish3102-amtspentperdish3103)^2
gen double wdis_4  =  (amtspentperdish4102-amtspentperdish4103)^2
gen double wdis_5  =  (amtspentperdish5102-amtspentperdish5103)^2
gen double wdis_6  =  (amtspentperdish6102-amtspentperdish6103)^2
gen double wdis_7  =  (amtspentperdish7102-amtspentperdish7103)^2
gen double wdis_8  =  (amtspentperdish8102-amtspentperdish8103)^2
gen double wdis_9  =  (amtspentperdish9102-amtspentperdish9103)^2
gen double wdis_10  =  (amtspentperdish10102-amtspentperdish10103)^2
gen double wdis_12  =  (amtspentperdish12102-amtspentperdish12103)^2
gen double wdis_13  =  (amtspentperdish13102-amtspentperdish13103)^2
gen double wdis_14  =  (amtspentperdish14102-amtspentperdish14103)^2
gen double wdis_15  =  (amtspentperdish15102-amtspentperdish15103)^2
gen double wdis_16  =  (amtspentperdish16102-amtspentperdish16103)^2
gen double wdis_17  =  (amtspentperdish17102-amtspentperdish17103)^2
gen double wdis_18  =  (amtspentperdish18102-amtspentperdish18103)^2
gen double wdis_19  =  (amtspentperdish19102-amtspentperdish19103)^2
gen double wdis_20  =  (amtspentperdish20102-amtspentperdish20103)^2
gen double wdis_21  =  (amtspentperdish21102-amtspentperdish21103)^2
gen double wdis_22  =  (amtspentperdish22102-amtspentperdish22103)^2
gen double wdis_23  =  (amtspentperdish23102-amtspentperdish23103)^2
gen double wdis_24  =  (amtspentperdish24102-amtspentperdish24103)^2
gen double wdis_26  =  (amtspentperdish26102-amtspentperdish26103)^2
gen double wdis_27  =  (amtspentperdish27102-amtspentperdish27103)^2
gen double wdis_28  =  (amtspentperdish28102-amtspentperdish28103)^2
gen double wdis_29  =  (amtspentperdish29102-amtspentperdish29103)^2
gen double wdis_30  =  (amtspentperdish30102-amtspentperdish30103)^2
gen double wdis_31  =  (amtspentperdish31102-amtspentperdish31103)^2
gen double wdis_32  =  (amtspentperdish32102-amtspentperdish32103)^2
gen double wdis_33  =  (amtspentperdish33102-amtspentperdish33103)^2
gen double wdis_34  =  (amtspentperdish34102-amtspentperdish34103)^2
gen double wdis_35  =  (amtspentperdish35102-amtspentperdish35103)^2
gen double wdis_37  =  (amtspentperdish37102-amtspentperdish37103)^2
gen double wdis_39  =  (amtspentperdish39102-amtspentperdish39103)^2
gen double wdis_40  =  (amtspentperdish40102-amtspentperdish40103)^2
gen double wdis_43  =  (amtspentperdish43102-amtspentperdish43103)^2
gen double wdis_44  =  (amtspentperdish44102-amtspentperdish44103)^2
gen double wdis_46  =  (amtspentperdish46102-amtspentperdish46103)^2
gen double wdis_47  =  (amtspentperdish47102-amtspentperdish47103)^2
gen double wdis_48  =  (amtspentperdish48102-amtspentperdish48103)^2
gen double wdis_51  =  (amtspentperdish51102-amtspentperdish51103)^2
gen double wdis_53  =  (amtspentperdish53102-amtspentperdish53103)^2
gen double wdis_54  =  (amtspentperdish54102-amtspentperdish54103)^2
gen double wdis_55  =  (amtspentperdish55102-amtspentperdish55103)^2
gen double wdis_56  =  (amtspentperdish56102-amtspentperdish56103)^2
gen double wdis_57  =  (amtspentperdish57102-amtspentperdish57103)^2
gen double wdis_58  =  (amtspentperdish58102-amtspentperdish58103)^2
gen double wdis_59  =  (amtspentperdish59102-amtspentperdish59103)^2
gen double wdis_60  =  (amtspentperdish60102-amtspentperdish60103)^2
gen double wdis_63  =  (amtspentperdish63102-amtspentperdish63103)^2
gen double wdis_64  =  (amtspentperdish64102-amtspentperdish64103)^2
gen double wdis_65  =  (amtspentperdish65102-amtspentperdish65103)^2
gen double wdis_66  =  (amtspentperdish66102-amtspentperdish66103)^2
gen double wdis_67  =  (amtspentperdish67102-amtspentperdish67103)^2
gen double wdis_68  =  (amtspentperdish68102-amtspentperdish68103)^2
gen double wdis_69  =  (amtspentperdish69102-amtspentperdish69103)^2
gen double wdis_70  =  (amtspentperdish70102-amtspentperdish70103)^2
gen double wdis_71  =  (amtspentperdish71102-amtspentperdish71103)^2
gen double wdis_72  =  (amtspentperdish72102-amtspentperdish72103)^2
gen double wdis_73  =  (amtspentperdish73102-amtspentperdish73103)^2
gen double wdis_74  =  (amtspentperdish74102-amtspentperdish74103)^2
gen double wdis_75  =  (amtspentperdish75102-amtspentperdish75103)^2
gen double wdis_77  =  (amtspentperdish77102-amtspentperdish77103)^2
gen double wdis_78  =  (amtspentperdish78102-amtspentperdish78103)^2
gen double wdis_80  =  (amtspentperdish80102-amtspentperdish80103)^2
gen double wdis_81  =  (amtspentperdish81102-amtspentperdish81103)^2
gen double wdis_83  =  (amtspentperdish83102-amtspentperdish83103)^2
gen double wdis_84  =  (amtspentperdish84102-amtspentperdish84103)^2
gen double wdis_85  =  (amtspentperdish85102-amtspentperdish85103)^2
gen double wdis_87  =  (amtspentperdish87102-amtspentperdish87103)^2
gen double wdis_88  =  (amtspentperdish88102-amtspentperdish88103)^2
gen double wdis_89  =  (amtspentperdish89102-amtspentperdish89103)^2
gen double wdis_90  =  (amtspentperdish90102-amtspentperdish90103)^2
gen double wdis_91  =  (amtspentperdish91102-amtspentperdish91103)^2
gen double wdis_92  =  (amtspentperdish92102-amtspentperdish92103)^2
gen double wdis_93  =  (amtspentperdish93102-amtspentperdish93103)^2
gen double wdis_94  =  (amtspentperdish94102-amtspentperdish94103)^2
gen double wdis_95  =  (amtspentperdish95102-amtspentperdish95103)^2
gen double wdis_96  =  (amtspentperdish96102-amtspentperdish96103)^2
gen double wdis_97  =  (amtspentperdish97102-amtspentperdish97103)^2
gen double wdis_99  =  (amtspentperdish99102-amtspentperdish99103)^2
gen double wdis_101  =  (amtspentperdish101102-amtspentperdish101103)^2
gen double wdis_102  =  (amtspentperdish102102-amtspentperdish102103)^2
gen double wdis_103  =  (amtspentperdish103102-amtspentperdish103103)^2
gen double wdis_104  =  (amtspentperdish104102-amtspentperdish104103)^2
gen double wdis_105  =  (amtspentperdish105102-amtspentperdish105103)^2
gen double wdis_106  =  (amtspentperdish106102-amtspentperdish106103)^2
gen double wdis_107  =  (amtspentperdish107102-amtspentperdish107103)^2
gen double wdis_108  =  (amtspentperdish108102-amtspentperdish108103)^2
gen double wdis_110  =  (amtspentperdish110102-amtspentperdish110103)^2
gen double wdis_111  =  (amtspentperdish111102-amtspentperdish111103)^2
gen double wdis_112  =  (amtspentperdish112102-amtspentperdish112103)^2
gen double wdis_113  =  (amtspentperdish113102-amtspentperdish113103)^2
gen double wdis_114  =  (amtspentperdish114102-amtspentperdish114103)^2
gen double wdis_115  =  (amtspentperdish115102-amtspentperdish115103)^2
gen double wdis_116  =  (amtspentperdish116102-amtspentperdish116103)^2
gen double wdis_117  =  (amtspentperdish117102-amtspentperdish117103)^2
gen double wdis_118  =  (amtspentperdish118102-amtspentperdish118103)^2
gen double wdis_119  =  (amtspentperdish119102-amtspentperdish119103)^2
gen double wdis_120  =  (amtspentperdish120102-amtspentperdish120103)^2
gen double wdis_121  =  (amtspentperdish121102-amtspentperdish121103)^2
gen double wdis_122  =  (amtspentperdish122102-amtspentperdish122103)^2
gen double wdis_123  =  (amtspentperdish123102-amtspentperdish123103)^2
gen double wdis_124  =  (amtspentperdish124102-amtspentperdish124103)^2
gen double wdis_125  =  (amtspentperdish125102-amtspentperdish125103)^2
gen double wdis_126  =  (amtspentperdish126102-amtspentperdish126103)^2
gen double wdis_129  =  (amtspentperdish129102-amtspentperdish129103)^2
gen double wdis_130  =  (amtspentperdish130102-amtspentperdish130103)^2
gen double wdis_131  =  (amtspentperdish131102-amtspentperdish131103)^2
gen double wdis_132  =  (amtspentperdish132102-amtspentperdish132103)^2
gen double wdis_133  =  (amtspentperdish133102-amtspentperdish133103)^2
gen double wdis_134  =  (amtspentperdish134102-amtspentperdish134103)^2
gen double wdis_135  =  (amtspentperdish135102-amtspentperdish135103)^2
gen double wdis_136  =  (amtspentperdish136102-amtspentperdish136103)^2
gen double wdis_138  =  (amtspentperdish138102-amtspentperdish138103)^2
gen double wdis_139  =  (amtspentperdish139102-amtspentperdish139103)^2
gen double wdis_140  =  (amtspentperdish140102-amtspentperdish140103)^2
gen double wdis_141  =  (amtspentperdish141102-amtspentperdish141103)^2
gen double wdis_142  =  (amtspentperdish142102-amtspentperdish142103)^2
gen double wdis_144  =  (amtspentperdish144102-amtspentperdish144103)^2
gen double wdis_145  =  (amtspentperdish145102-amtspentperdish145103)^2
gen double wdis_146  =  (amtspentperdish146102-amtspentperdish146103)^2
gen double wdis_147  =  (amtspentperdish147102-amtspentperdish147103)^2
gen double wdis_148  =  (amtspentperdish148102-amtspentperdish148103)^2
gen double wdis_151  =  (amtspentperdish151102-amtspentperdish151103)^2
gen double wdis_153  =  (amtspentperdish153102-amtspentperdish153103)^2
gen double wdis_154  =  (amtspentperdish154102-amtspentperdish154103)^2
gen double wdis_157  =  (amtspentperdish157102-amtspentperdish157103)^2
gen double wdis_158  =  (amtspentperdish158102-amtspentperdish158103)^2


drop amtspentperdish1101- amtspentperdish158103

*reshaping to long format to easily compute the  Euclidean distances per household
reshape long hdis_ wdis_, i(iresid) j (dish)

    **computing the sum distances
      collapse (sum)hdis_ wdis_ , by (iresid)

    **computing Euclidean distance

    gen double hed=round(sqrt(hdis_),0.0001)
    gen double wed=round(sqrt(wdis_),0.0001)


** computing intrahousehold decision making power using the amount spent on dish
gen  double midmp_dishspent=round((wed/(hed+wed)),0.0001)
gen  double widmp_dishspent=round((hed/(hed+wed)),0.0001)

merge   1:m iresid using "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\05dfc_masterfile.dta"
drop    _merge hdis_ wdis_

sort    iresid
drop    if round!=1

label variable hed "Euclidean distance for husband"
label variable wed "Euclidean distance for wife"

label variable midmp_dishspent "Men’s intrahousehold decision making power (amount spent per dish)"
label variable widmp_dishspent "Women’s intrahousehold decision making power using (amount spent per dish)"

save "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\12analysis_idmpdishspent.dta", replace
****
