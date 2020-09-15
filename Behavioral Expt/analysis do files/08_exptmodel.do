/*DATA ANALYSIS FOR BUDGET SHARES*/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", replace
sort session hh round
merge 1:1 session hh round using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_iresid.dta"


/*DESCRIPTIVE ANALYSIS*/
sort round
by round: summarize pct_starch- pct_unspent Morning BCC1 BCC2 BCC3 PSBC Kolkata urbanity income incomegrp weeklypercapitabudget hhsize AH2- AH5 rel_h rel_w AS1_h AS1_w AH6_h AH6_w tue2- sun2

**---------------------------MODEL 1---------------------------**/

pwcorr pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent ///
       Morning BCC1 BCC2 BCC3 PSBC ///
       Kolkata urbanity income incomegrp weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 rel_h rel_w ///
	   AS1_h AS1_w AH6_h AH6_w tue2- sun2, star (0.95)

**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

collin Morning BCC1 BCC2 BCC3 PSBC ///
       Kolkata urbanity income incomegrp weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 rel_h rel_w ///
	   AS1_h AS1_w AH6_h AH6_w tue2- sun2, corr
	   
	   *initial results: corr(): matrix has zero or negative values on diagonal

*remove religion, Kolkata, hhsize; Mean VIF      2.17
collin Morning BCC1 BCC2 BCC3 PSBC ///
       urbanity income incomegrp weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w  tue2- sun2, corr
	   
*model 1

fmlogit pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent, ///
		eta(Morning BCC1 BCC2 BCC3 PSBC ///
       urbanity income incomegrp weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w  tue2- sun2) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v1.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
quietly margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv1.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


**---------------------------MODEL 2---------------------------**/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", replace
sort session hh round
merge 1:1 session hh round using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_iresid.dta"

**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*remove religion, Kolkata, hhsize, income; Mean VIF      
collin Morning BCC1 BCC2 BCC3 PSBC ///
       urbanity incomegrp weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w  tue2- sun2, corr
	   
*model 2

fmlogit pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent, ///
		eta(Morning BCC1 BCC2 BCC3 PSBC ///
       urbanity incomegrp weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w  tue2- sun2) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v2.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv2.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

**---------------------------MODEL 3---------------------------**/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", replace
sort session hh round
merge 1:1 session hh round using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_iresid.dta"

**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*remove religion, Kolkata, hhsize, income; Mean VIF      
collin BCC1 BCC2 BCC3 PSBC ///
       urbanity weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w  tue2- sun2, corr
	   
*model 3

fmlogit pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent, ///
		eta(BCC1 BCC2 BCC3 PSBC ///
       urbanity weeklypercapitabudget ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w  tue2- sun2) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v3.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv3.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

**---------------------------MODEL 4---------------------------**/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", replace
sort session hh round
merge 1:1 session hh round using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_iresid.dta"

**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*remove religion, Kolkata, hhsize, , tue2- sun2 ; Mean VIF      
collin BCC1 BCC2 BCC3 PSBC ///
       urbanity ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w, corr
	   
*model 4

fmlogit pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent, ///
		eta(BCC1 BCC2 BCC3 PSBC ///
       urbanity ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v4.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv4.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps

**---------------------------MODEL 5---------------------------**/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", replace
sort session hh round
merge 1:1 session hh round using "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\dfc_iresid.dta"

**----------------multicolinearity using VIF--------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/

*remove religion, Kolkata, hhsize, , tue2- sun2 ; Mean VIF      
collin BCC1 BCC2 BCC3 PSBC ///
       urbanity ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w, corr
	   
*model 4

fmlogit pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent, ///
		eta(BCC1 BCC2 BCC3 PSBC ///
       urbanity ///
	   AH2 AH3 AH4 AH5 ///
	   AS1_h AS1_w) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v5.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
margins, dydx(*) post predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv5.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps
