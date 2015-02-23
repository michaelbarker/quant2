
* 1. Import, verify, and reorder
import excel using Schools.xlsx, clear firstrow

encode sector_name, gen(sectorid)
regress TOTAL_REVENUE_ALL i.sectorid

gen profit = TOTAL_REVENUE_ALL-TOTAL_EXPENSE_ALL
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
	(23 = 5 "Soccer") ///
	(nonmissing=10 "Other") ///
	, gen(sportcat)

tab sportcat, m

tab sportid sportcat, m

* 5. Bar Graph	
graph bar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(sportcat)
graph bar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(categorical_participants)

graph hbar (mean) TOTAL_REVENUE_ALL TOTAL_EXPENSE_ALL, over(sportcat) over(categorical_participants) 

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
recode EFTotalCount (0/999 = 1 "Small") (1000/4999 = 2 "Medium") (5000/max = 3 "Large") , gen(schoolsize2)

egen numparticipants = rowtotal(PARTIC_MEN PARTIC_WOMEN)
sum numparticipants, detail
* so 17 26 41 seem like cut offs
recode numparticipants  (0/17 = 1 "Small Team") (18/26 = 2 "Mid-Small Team") (27/41 = 3 "Mid-Large Team") (42/max = 4 "Large Team"), gen(categorical_participants)
tab numparticipants, missing

graph hbar (mean) profit, over(sportcat) over(schoolsize)
	

. gen pcpart =  numparticipants / EFTotalCount
. graph hbar (mean) pcpart , over(sportcat) over(schoolsize)


. 
gen revperpart = TOTAL_REVENUE_ALL / numparticipants
graph hbar (mean) revperpart expperpart , over(sportcat) over(schoolsize)

TOTAL_REVENUE_ALL

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

regress profit i.sportcat i.femhdcoach sportcat#femhdcoach 


gen profperstudent = profit / EFTotalCount
twoway scatter profperstudent EFTotalCount
separate profperstudent , by(schoolsize)
twoway scatter profperstudent1-profperstudent3 EFTotalCount
drop profperstudent1-profperstudent3 

gen partprofit = profit / numparticipants
twoway (scatter partprofit EFTotalCount) (lfit partprofit EFTotalCount) 
separate partprofit , by(schoolsize)
twoway (scatter partprofit1-partprofit3 EFTotalCount) 

twoway scatter TOTAL_REVENUE_ALL numparticipants
separate TOTAL_REVENUE_ALL , by(schoolsize) gen(rev_)
twoway scatter rev_* numparticipants

gen asscoach = 

