
* 1. Import, verify, and reorder
import excel using Schools.xlsx, clear firstrow
de, short
order institution_name Sports , first

* 2. Sample Selection
* Keep only 4-year Public and Private Universities
tab sector_name
keep if sector_name=="Private nonprofit, 4-year or above" | sector_name=="Public, 4-year or above"
* Keep only NCAA-governed athletic programs
tab classification_name
keep if strmatch(classification_name, "*NCAA*")

* 3. Classify Colleges and Universities

* Drop mining schools or other special cases. 

/*
gen unicol = 0
* First Round
replace unicol = 1 if strmatch(institution_name, "*University*")
replace unicol = 2 if strmatch(institution_name, "*College*")

* Check for any remaining unclassified
tab unicol
tab institution_name if unicol==0
* More Universities
replace unicol = 1 if strmatch(institution_name, "*SUNY*")
replace unicol = 1 if strmatch(institution_name, "*Institute*")
replace unicol = 1 if strmatch(institution_name, "*LIU*")
* More Colleges
replace unicol = 2 if strmatch(institution_name, "*Academy*")
replace unicol = 2 if strmatch(institution_name, "*School*")
*/


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






