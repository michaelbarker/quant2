
* 1. Import, verify, and reorder
 * do "C:\Users\mdb96\git\msppstata\quant2\Do-files\project2_solution_01.do" 
* do "project2_solution_01.do" 

import excel Schools.xlsx, clear firstrow

gen double profit = TOTAL_REVENUE_ALL-TOTAL_EXPENSE_ALL
graph hbar (sum) profit,  over(Sports)

* 4. Recode sports categories without labels
encode Sports, gen(sportid)
label list sportid
* 10 category recode command
/*
recode sportid ///
	(4 24 = 1 "Base/Softball") ///
	(5 = 2 "Basketball") ///
	(12 = 3 "Football") ///
	(13 = 4 "Golf") ///
	(23 = 5 "Soccer") ///
	(26/28 8 = 6 "Swimming") ///
	(30 25 3 = 7 "Tennis") ///
	(6 34 = 8 "Volleyball") ///
	(1 31/33 = 9 "Track") ///
	(nonmissing=10 "Other") ///
	, gen(sportcat)
*/

recode sportid ///
	(4 24 = 1 "Base/Softball") ///
	(5 = 2 "Basketball") ///
	(12 = 3 "Football") ///
	(23 = 4 "Soccer") ///
	(nonmissing=5 "Other") ///
	, gen(sportcat)

tab sportcat, m

tab sportid sportcat, m

gen femhdcoach = SUM_FTHDCOACH_FEM>0 | SUM_PTHDCOACH_FEM>0	
tab femhdcoach

regress profit i.sportcat i.femhdcoach sportcat#femhdcoach 
exit

/*
* 5. Bar Graph	
graph bar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(sportcat)
graph bar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(categorical_participants)

graph hbar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(sportcat) over(categorical_participants) 
*/
* 7. Suppose we want to run a regression on sports categories
* Begin one way:
* Instead use factor variables
regress TOTAL_REVENUE_ALL i.sportcat

* 8. Testing using factor variables
regress , coefl
testparm i.sportcat

* 9. 

* Outreg2 
* Show value labels on output.




// 2.10
* recode EFTotalCount (0/999 = 1 "Small") (1000/4999 = 2 "Medium") (5000/max = 3 "Large") , gen(schoolsize2)

* egen numparticipants = rowtotal(PARTIC_MEN PARTIC_WOMEN)
sum numparticipants, detail
* so 17 26 41 seem like cut offs
tab numparticipants, missing

graph hbar (mean) profit, over(sportcat) over(schoolsize)
	

. gen pcpart =  numparticipants / EFTotalCount
. graph hbar (mean) pcpart , over(sportcat) over(schoolsize)


. 
gen revperpart = TOTAL_REVENUE_ALL / numparticipants
* graph hbar (mean) revperpart expperpart , over(sportcat) over(schoolsize)


gen multicoach = (SUM_TOTAL_HDCOACH>1)
graph hbar (mean) profit, over(multicoach) 
graph hbar (mean) profit, over(sportcat) over(multicoach) 	

gen multiascoach = (SUM_TOTAL_ASSTCOACH>1)
graph hbar (mean) profit, over(multicoach) 
graph hbar (mean) profit, over(sportcat) over(multicoach) 	


gen femhdcoach = SUM_FTHDCOACH_FEM>0 | SUM_PTHDCOACH_FEM>0	
tab femhdcoach
graph hbar (mean) profit, over(femhdcoach) 
graph hbar (mean) profit, over(femhdcoach) 	over(sportcat) 

graph hbar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL , over(femhdcoach)
graph hbar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL , over(femhdcoach) 	over(sportcat) 
graph hbar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL , over(femhdcoach) 	over(schoolsize) 

graph hbar (mean) REVENUE_MENALL EXPENSE_MENALL REVENUE_WOMENALL  EXPENSE_WOMENALL , over(femhdcoach) 	over(sportcat) 

gen ftfemcoach = (SUM_FTHDCOACH_FEM>0)
tab ftfemcoach 
tab sportcat ftfemcoach
graph hbar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL , over(ftfemcoach)
graph hbar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL , over(ftfemcoach) 	over(sportcat) 

/*
 femhdcoach

    RECODE of |
      sportid |      femhdcoach
     (Sports) |         0          1 |     Total
--------------+----------------------+----------
Base/Softball |     2,371        962 |     3,333 
   Basketball |     1,083        913 |     1,996 
     Football |       881          0 |       881 
       Soccer |     1,209        435 |     1,644 
        Other |     6,165      3,115 |     9,280 
--------------+----------------------+----------
        Total |    11,709      5,425 |    17,134 
		*/

/*
. reg profit i.sportcat femhdcoach sportcat#femhdcoach
note: 3.sportcat#1.femhdcoach identifies no observations in the sample
note: 5.sportcat#1.femhdcoach omitted because of collinearity

      Source |       SS       df       MS              Number of obs =   17134
-------------+------------------------------           F(  8, 17125) =   96.05
       Model |  2.1671e+15     8  2.7089e+14           Prob > F      =  0.0000
    Residual |  4.8301e+16 17125  2.8205e+12           R-squared     =  0.0429
-------------+------------------------------           Adj R-squared =  0.0425
       Total |  5.0468e+16 17133  2.9456e+12           Root MSE      =  1.7e+06

--------------------------------------------------------------------------------------
              profit |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
---------------------+----------------------------------------------------------------
            sportcat |
         Basketball  |   98972.09   61594.51     1.61   0.108    -21759.46    219703.6
           Football  |    1591771   66264.72    24.02   0.000      1461885     1721657
             Soccer  |  -17764.65   59350.37    -0.30   0.765    -134097.5    98568.15
              Other  |  -25312.56   40584.08    -0.62   0.533    -104861.5     54236.4
                     |
          femhdcoach |  -6852.136   36918.09    -0.19   0.853    -79215.38    65511.11
                     |
 sportcat#femhdcoach |
Baseball/Softball#1  |  -5563.347   74056.72    -0.08   0.940    -150722.1    139595.4
       Basketball#1  |   64069.42   84002.93     0.76   0.446    -100584.9    228723.8
         Football#1  |          0  (empty)
           Soccer#1  |  -7779.688   100894.4    -0.08   0.939    -205543.1    189983.7
            Other#1  |          0  (omitted)
                     |
               _cons |  -29224.38   34490.15    -0.85   0.397     -96828.6    38379.84
--------------------------------------------------------------------------------------

. tab sportcat femhdcoach if e(sample)

RECODE of sportid |      femhdcoach
         (Sports) |         0          1 |     Total
------------------+----------------------+----------
Baseball/Softball |     2,371        962 |     3,333 
       Basketball |     1,083        913 |     1,996 
         Football |       881          0 |       881 
           Soccer |     1,209        435 |     1,644 
            Other |     6,165      3,115 |     9,280 
------------------+----------------------+----------
            Total |    11,709      5,425 |    17,134 
*/

gen profperstudent = profit / EFTotalCount
twoway scatter profperstudent EFTotalCount
separate profperstudent , by(schoolsize)
twoway scatter profperstudent1-profperstudent3 EFTotalCount
twoway (lfit profperstudent1 EFTotalCount) (lfit profperstudent2 EFTotalCount) (lfit profperstudent3 EFTotalCount)
drop profperstudent1-profperstudent3 

gen partprofit = profit / numparticipants
twoway (scatter partprofit EFTotalCount) (lfit partprofit EFTotalCount) 
separate partprofit , by(schoolsize)
twoway (scatter partprofit1-partprofit3 EFTotalCount) 
twoway (scatter partprofit1-partprofit3 EFTotalCount) (lfit partprofit1 EFTotalCount) (lfit partprofit2 EFTotalCount) (lfit partprofit3 EFTotalCount)


twoway scatter TOTAL_REVENUE_ALL numparticipants
separate TOTAL_REVENUE_ALL , by(schoolsize) gen(rev_)
twoway scatter rev_* numparticipants

separate profit , by(ftfemcoach) gen(prof_)
twoway scatter prof_* TOTAL_REVENUE_ALL
twoway (scatter prof_* TOTAL_EXPENSE_ALL) (lfit prof_0 TOTAL_EXPENSE_ALL) (lfit prof_1 TOTAL_EXPENSE_ALL)

regress profit TOTAL_REVENUE_ALL ftfemcoach  c.TOTAL_REVENUE_ALL#ftfemcoach 

twoway scatter prof_* numparticipants
twoway (scatter prof_* numparticipants) (lfit prof_0 numparticipants) (lfit prof_1 numparticipants)

regress profit numparticipants ftfemcoach  c.numparticipants#ftfemcoach 

local var TOTAL_EXPENSE_ALL
twoway scatter prof_* `var'
local var "TOTAL_EXPENSE_ALL"
twoway (scatter prof_* `var') (lfit prof_0 `var') (lfit prof_1 `var')
regress profit `var' ftfemcoach  c.`var'#ftfemcoach 


local var EFTotalCount
twoway scatter prof_* `var'
local var "EFTotalCount"
twoway (scatter prof_* `var') (lfit prof_0 `var') (lfit prof_1 `var')
regress profit `var' ftfemcoach  c.`var'#ftfemcoach 

local yvar "profit"
local cvar "numparticipants"
local dvar "sportcat"
capture: drop `yvar'_*
separate `yvar' , by(`dvar') gen(`yvar'_) short
twoway scatter `yvar'_* `cvar' , scheme(sj)
regress `yvar' `cvar'
regress `yvar' `cvar' i.`dvar'  `cvar'#`dvar' 
predict `yvar'_pr 
separate `yvar'_pr , by(`dvar') gen(`yvar'_pr_) short
twoway line `yvar'_pr_* `cvar' 

capture: drop prof_*
separate profit , by(sportcat) gen(prof_)
twoway scatter prof_* numparticipants

