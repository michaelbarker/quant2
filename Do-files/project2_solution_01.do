clear

cd "....."

// 2.1 Import, verify, and reorder
import excel using Schools.xlsx, clear firstrow
*so each observation is a sport at a particular school
order institution_name Sports

// 2.2
* creating dummies
gen medSchool = 0
gen largeSchool = 0
replace medSchool = 1 if EFTotalCount >=1000 & EFTotalCount <4999
replace largeSchool = 1 if EFTotalCount >=5000
replace medSchool = . if EFTotalCount ==.
replace largeSchool = . if EFTotalCount ==.
*verify dummies
tab  medSchool , missing
tab  largeSchool, missing

reg TOTAL_EXPENSE_ALL medSchool largeSchool

// 2.3 bar graph
*creating school categorical variable
gen schoolsize = .
replace schoolsize = 1 if EFTotalCount >=0 & EFTotalCount < 1000
replace schoolsize = 2 if EFTotalCount >=1000 & EFTotalCount <4999
replace schoolsize = 3 if EFTotalCount >=5000 & EFTotalCount !=.

*check categorical against dummies
tab2 schoolsize largeSchool medSchool

*bar graph
graph bar (mean) TOTAL_REVENUE_ALL (mean) TOTAL_EXPENSE_ALL, over(schoolsize)

// 2.4
reg TOTAL_EXPENSE_ALL i.schoolsize
help fvvarlist

// 2.5
regress, coeflegend

list EFTotalCount schoolsize 1.schoolsize 2.schoolsize 3.schoolsize in 1/50

// 2.6
regress
*  test i.schoolsize - test does not recognize i notation
test 2.schoolsize 3.schoolsize
testparm i.schoolsize

// 2.7
* reg TOTAL_REVENUE_ALL i.sector_name - can only use i.notation with numeric vars
encode sector_name, gen(sectorid)
tab sectorid
tab sectorid, nolabel
regress TOTAL_REVENUE_ALL i.sectorid

// 2.8
reg, coeflegend
test 3.sectorid 5.sectorid
test 2.sectorid 3.sectorid 4.sectorid 5.sectorid 6.sectorid
*or
testparm i.sectorid

// 2.9
graph bar (mean) TOTAL_REVENUE_ALL (mean) TOTAL_EXPENSE_ALL, over(sectorid)
graph bar (mean) TOTAL_REVENUE_ALL (mean) TOTAL_EXPENSE_ALL, over(sectorid) horizontal

// 2.10
recode EFTotalCount (0/999 = 1 "Small") (1000/4999 = 2 "Medium") (5000/max = 3 "Large") , gen(schoolsize2)

egen numparticipants = rowtotal(PARTIC_MEN PARTIC_WOMEN)
sum numparticipants, detail
* so 17 26 41 seem like cut offs
recode numparticipants  (0/17 = 1 "Small Team") (18/26 = 2 "Mid-Small Team") (27/41 = 3 "Mid-Large Team") (42/max = 4 "Large Team"), gen(categorical_participants)
tab numparticipants, missing
	
graph bar (mean) TOTAL_EXPENSE_ALL, over(categorical_participants)
reg TOTAL_EXPENSE_ALL i.categorical_participants

// 2.11 - expansion
	* outreg2 everything
	* Show value labels on output

	*from 2.2
	reg TOTAL_EXPENSE_ALL medSchool largeSchool
	outreg2

	*from 2.3
	label  define schoolsize 1 "small" 2 "medium" 3 "large"

	*from 2.4
	reg TOTAL_EXPENSE_ALL i.schoolsize
	outreg2

	*from 2.7
	regress TOTAL_REVENUE_ALL i.sectorid
	outreg2
	
	*from 2.10
	reg TOTAL_EXPENSE_ALL i.categorical_participants
	outreg2


