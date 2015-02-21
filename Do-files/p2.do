
* 1. Import, verify, and reorder
import excel using Schools.xlsx, clear firstrow
bysort sector_name: gen numsports = _N
drop if numsports < 100
tab sector_name , m
drop if sector_name==



* 4. Recode sports categories without labels
encode Sports, gen(sportid)
label list sportid

recode sportid (1/15 = 1) (16/25 = 2) (26/max = 3), gen(sportcat)

* 5. Bar Graph
graph bar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(sportcat)

* 7. Suppose we want to run a regression on sports categories
* Begin one way:
* Instead use factor variables
regress TOTAL_REVENUE_ALL i.sportcat

* 8. Testing using factor variables
regress , coefl
testparm i.sportcat

* 6. Add value labels and re-run bar graph
recode sportid (1/15 = 1 "Sport 1") (16/25 = 2 "Sport 2") (26/max = 3 "Sport 3"), gen(sportcat)
graph bar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(sportcat)

* 9. 

* Outreg2 
* Show value labels on output.






