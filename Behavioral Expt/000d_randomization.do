
*********
* RANDOMIZATION
*********
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta", clear

**************************
* descriptive statistics
**************************


*https://stats.idre.ucla.edu/stata/faq/everything-you-always-wanted-to-know-about-contrasts-but-were-afraid-to-ask/

sort    iresid
drop    if round!=1


sort treatment
by treatment: summarize defbudget     PBC_00        weekends_both Morning       Kolkata  ///
		      hunger_h      hunger_w          highschool_h  highschool_w   ///
		      agriocc_h     employed_w        inv_allw      ref           ///
		      incpercap000  wkbudgetpercap00  source_hlabel source_wlabel ///
			  hhsize        wchild            wseniors
			  
  
**************************
*  regression
**************************
regress defbudget    ///
		weekends_both Morning       Kolkata                               ///
		T1            T2            T3                                    ///
		hunger_h      hunger_w                            ///
		highschool_h  highschool_w  agriocc_h      employed_w                  ///
		inv_allw      ref           incpercap000   wkbudgetpercap00      ///
		source_hlabel source_wlabel hhsize         wchild     wseniors
		
eststo defbudget
esttab using C:\Users\jynion\Desktop\000c_random.rtf, mtitles title(Randomization)label star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) pr2(3) onecell nogaps



			  

**************************
clear all

use "D:\GoogleDrive\jy_mrt_files\MRT - DFC (2017-2018)\Data analysis\DFC - data\merged files\000a_models.dta", clear

sort    iresid
drop    if round!=1

**************************
* ANOVA
**************************
			  
anova PBC_00 treatment
pwcompare treatment, mcompare(tukey) effects group

anova hunger_h treatment
pwcompare treatment, mcompare(tukey) effects group

anova hunger_w treatment
pwcompare treatment, mcompare(tukey) effects group


anova incpercap000 treatment
pwcompare treatment, mcompare(tukey) effects group


anova wkbudgetpercap00 treatment
pwcompare treatment, mcompare(tukey) effects group

anova hhsize treatment
pwcompare treatment, mcompare(tukey) effects group

*********
* chi-square
*********

proportion weekends_both, over(treatment)
proportion Morning, over(treatment)
proportion Kolkata, over(treatment)
proportion highschool_h, over(treatment)
proportion highschool_w, over(treatment)
proportion agriocc_h, over(treatment)
proportion employed_w, over(treatment)
proportion inv_allw, over(treatment)
proportion ref, over(treatment)
proportion source_hlabel, over(treatment)
proportion source_wlabel, over(treatment)
proportion wchild, over(treatment)
proportion wseniors, over(treatment)


tabulate weekends_both treatment, chi all exact
tabulate Morning treatment, chi all exact
tabulate Kolkata treatment, chi all exact
tabulate highschool_h treatment, chi all exact
tabulate highschool_w treatment, chi all exact
tabulate agriocc_h treatment, chi all exact
tabulate employed_w treatment, chi all exact
tabulate inv_allw treatment, chi all exact
tabulate ref treatment, chi all exact
tabulate source_hlabel treatment, chi all exact
tabulate source_wlabel treatment, chi all exact
tabulate wchild treatment, chi all exact
tabulate wseniors treatment, chi all exact

/*
PAIRWISE COMPARISON
Morning
Kolkata
agriocc_h
highschool_h
inv_allw

*/

*control vs T1
prtesti 44 0.6363636 44 0.2727273 ,level (95)
prtesti 44 0.3636364 44 0.3409091 ,level (95)
prtesti 44 0.3181818 44 0.1363636 ,level (95) 
prtesti 44 0.4772727 44 0.4318182 ,level (95)
prtesti 44 0.6136364 44 0.6363636 ,level (95)


*control vs T2
prtesti 44 0.6363636 44 0.6590909 ,level (95)
prtesti 44 0.3636364 44 0.3181818 ,level (95)
prtesti 44 0.3181818 44 0.0909091 ,level (95)
prtesti 44 0.4772727 44 0.4318182 ,level (95)
prtesti 44 0.6136364 44 0.6363636 ,level (95)


*control vs T3
prtesti 44 0.6363636 45 0.2666667 ,level (95)
prtesti 44 0.3636364 45 0.6666667 ,level (95)
prtesti 44 0.3181818 45 0.2888889 ,level (95)
prtesti 44 0.4772727 44 0.4318182 ,level (95)
prtesti 44 0.6136364 44 0.6363636 ,level (95)


*T1 vs T2
prtesti 44 0.2727273 44 0.6590909 ,level (95)
prtesti 44 0.3409091 44 0.3181818 ,level (95)
prtesti 44 0.1363636 44 0.0909091 ,level (95)
prtesti 44 0.4772727 44 0.4318182 ,level (95)
prtesti 44 0.6136364 44 0.6363636 ,level (95)


*T1 vs T3
prtesti 44 0.2727273 45 0.2666667 ,level (95)
prtesti 44 0.3409091 45 0.6666667 ,level (95)
prtesti 44 0.1363636 45 0.2888889 ,level (95)
prtesti 44 0.4772727 44 0.4318182 ,level (95)
prtesti 44 0.6136364 44 0.6363636 ,level (95)



*T2 vs T3
prtesti 44 0.6590909 45 0.2666667 ,level (95)
prtesti 44 0.3181818 45 0.6666667 ,level (95)
prtesti 44 0.0909091 45 0.2888889 ,level (95)
prtesti 44 0.4772727 44 0.4318182 ,level (95)
prtesti 44 0.6136364 44 0.6363636 ,level (95)



