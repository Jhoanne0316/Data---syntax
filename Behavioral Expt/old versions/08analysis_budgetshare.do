/*DATA ANALYSIS FOR BUDGET SHARES*/
clear all
use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", replace


/*DESCRIPTIVE ANALYSIS*/
edit uniqueID pct_starch- pct_unspent Morning BCC1 BCC2 BCC3  Kolkata urbanity income  weeklypercapitabudget hhsize AH2- AH5 rel_h rel_w AS1_h AS1_w AH6_h AH6_w tue2- sun2
sort round
by round: summarize pct_starch- pct_unspent Morning BCC1 BCC2 BCC3  Kolkata urbanity income  weeklypercapitabudget hhsize AH2- AH5 rel_h rel_w AS1_h AS1_w AH6_h AH6_w tue2- sun2

PSBC incomegrp

  */
  /**---------------------------correlation analysis---------------------------**/
/*
dichotomous vs continuous-pwcorr/point-biserial
ordinal vs (continuous or dichotomous)-spearman
binary vs binary - pwcorr/phi coefficient
*/

pwcorr hhsize weeklypercapitabudget hhsize Kolkata Morning ///
       AH2 AH3 AH4 AH5 AH6_h AH6_w AS1_h AS1_w D3_h D3_w ///
	   urbanity s07 income tue2 wed2 thu2 fri2 sat2 sun2 ///
	   BCC1 BCC2 BCC3 wkpercapbudget PSBC , star (0.95)
*results: all are significantly correlated with each other
*suggestion: remove AH2-AH5 due since this is a function of hhsize

**---------------------------multicolinearity using VIF---------------------------**/
/**http://www.math.kth.se/matstat/gru/sf2930/papers/VIF%20article.pdf**/
/*constraint - binary*/

*for general prod+mktg VIF=1.39
collin Morning BCC1 BCC2 BCC3 ///
	   AH2 AH3 AH4 AH5  D3_h D3_w ///
	   urbanity s07  tue2 wed2 thu2 fri2 sat2 sun2 ///
	   wkpercapbudget PSBC, corr
	   

	   
*remove: hhsize Kolkata AH6_h AH6_w income
/*initial results
 (obs=523)

  Collinearity Diagnostics

                        SQRT                   R-
  Variable      VIF     VIF    Tolerance    Squared
----------------------------------------------------
   Morning      1.20    1.10    0.8329      0.1671
      BCC1      1.91    1.38    0.5231      0.4769
      BCC2      2.52    1.59    0.3967      0.6033
      BCC3      1.90    1.38    0.5263      0.4737
       AH2      1.43    1.20    0.7001      0.2999
       AH3      1.32    1.15    0.7554      0.2446
       AH4      1.41    1.19    0.7108      0.2892
       AH5      1.16    1.08    0.8585      0.1415
      D3_h      1.13    1.06    0.8825      0.1175
      D3_w      1.08    1.04    0.9258      0.0742
  urbanity      2.31    1.52    0.4324      0.5676
       s07      1.80    1.34    0.5555      0.4445
      tue2      1.63    1.28    0.6150      0.3850
      wed2      1.69    1.30    0.5919      0.4081
      thu2      1.77    1.33    0.5634      0.4366
      fri2      1.79    1.34    0.5589      0.4411
      sat2      1.60    1.26    0.6253      0.3747
      sun2      1.66    1.29    0.6024      0.3976
wkpercapbudget      2.06    1.44    0.4846      0.5154
      PSBC      1.24    1.11    0.8067      0.1933
----------------------------------------------------
  Mean VIF      1.63

*/

/*---------Corr with depvars------------------ */
pwcorr pct_starch pct_pulses pct_dairy pct_veg pct_fruit pct_unspent ///
	   Morning BCC1 BCC2 BCC3 ///
	   AH2 AH3 AH4 AH5  ///
	   urbanity s07  tue2 wed2 thu2 fri2 sat2 sun2 ///
	   wkpercapbudget PSBC if round==3, star (0.95)

	   
/*model 2*/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", clear
sort uniqueID


*gen iresid form Excel, copy paste

fmlogit pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent, ///
		eta(Morning BCC1 BCC2 BCC3 ///
	   AH2 AH3 AH4 AH5  ///
	   urbanity s07  tue2 wed2 thu2 fri2 sat2 sun2 ///
	   wkpercapbudget PSBC) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v2.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
quietly margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv2.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps


/*model 3*/
clear all
use "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\08analysis_budgetshare.dta", clear
sort uniqueID


*gen iresid form Excel, copy paste

fmlogit pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent, ///
		eta(Morning BCC1 BCC2 BCC3 ///
	   AH2 AH3 AH4 AH5  ///
	   urban s07   ///
	   wkpercapbudget PSBC) cluster(iresid)
		

eststo fmlogit
esttab fmlogit using D:\data\DFCdepvars_v3.0.rtf , title (Fractional multinomial logit coefficients) mtitles ("Parameter estimate") label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps scalars (chi2 p ll N_clust) unstack


foreach o in pct_starch pct_nonveg pct_pulses pct_dairy pct_veg pct_fruit pct_unspent {
quietly margins, dydx(*) predict(outcome(`o')) post
eststo, title(`o')
estimates restore fmlogit
}
eststo drop fmlogit
esttab using D:\data\DFCdepvars_MEBDv3.0.rtf, mtitles title(Average Marginal Effects)label star(* 0.10 ** 0.05 *** 0.01) b(4) se(4) pr2(4) onecell nogaps





/*
export sasxport "D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - syntax\08analysis_budgetshare.xpt", rename replace

*transfer to spss for descriptive statistics


/* SPSS syntax*/

GET
  SAS DATA='D:\Google Drive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - syntax\08analysis_budgetshare.xpt'.



* Custom Tables.
CTABLES
  /VLABELS VARIABLES=ROUND KOLKATA URBANITY S07 HHSIZE AH2 AH3 AH4 AH5 INCOME
    DISPLAY=DEFAULT
  /TABLE HHSIZE [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + AH2 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + AH3
  [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + AH4 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + AH5 [COUNT F40.0,
  MINIMUM, MAXIMUM, MEAN, STDDEV] + INCOME [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] BY ROUND [C] > (KOLKATA [C] +
  URBANITY [C] + S07 [C] + URBANITY [C] > S07 [C])
  /SLABELS POSITION=ROW
  /CATEGORIES VARIABLES=ROUND KOLKATA URBANITY S07 ORDER=A KEY=VALUE EMPTY=EXCLUDE.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=ROUND KOLKATA URBANITY S07 MORNING REL_H REL_W BCC1 BCC2 BCC3
    DISPLAY=DEFAULT
  /TABLE MORNING [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + REL_H [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + REL_W
  [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + BCC1 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + BCC2 [COUNT F40.0,
  MINIMUM, MAXIMUM, MEAN, STDDEV] + BCC3 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] BY ROUND [C] > (KOLKATA [C] + URBANITY
  [C] + S07 [C] + URBANITY [C] > S07 [C])
  /SLABELS POSITION=ROW
  /CATEGORIES VARIABLES=ROUND KOLKATA URBANITY S07 ORDER=A KEY=VALUE EMPTY=EXCLUDE.

/*budget share by food group*/
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=ROUND KOLKATA URBANITY S07 PERCNTAM PERCNTA2 PERCNTA3 PERCNTA4 PERCNTA5 PERCNTA6 PERCNTA8
    DISPLAY=DEFAULT
  /TABLE PERCNTAM [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + PERCNTA2 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] +
  PERCNTA3 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + PERCNTA4 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + PERCNTA5
  [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + PERCNTA6 [COUNT F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] + PERCNTA8 [COUNT
  F40.0, MINIMUM, MAXIMUM, MEAN, STDDEV] BY ROUND [C] > (KOLKATA [C] + URBANITY [C] + S07 [C] + URBANITY [C] > S07 [C])
  /SLABELS POSITION=ROW
  /CATEGORIES VARIABLES=ROUND KOLKATA URBANITY S07 ORDER=A KEY=VALUE EMPTY=EXCLUDE.

