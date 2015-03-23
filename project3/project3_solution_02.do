set more off
use card.dta, clear
de

probit libcrd14 educ IQ
probit, coefl

display normprob(-2.074503 + .1095198*12 + .0127187*102.4498)
display normprob(_b[_cons] + _b[educ]*12 + _b[IQ]*102.4498)
margins , atmeans at(educ=12)


margins , atmeans at(educ=(8 10 12 14 16) )
margins , atmeans at(educ=(8(2)16))
marginsplot


gen preduc12 = normprob(_b[_cons] + _b[educ]*12 + _b[IQ]*IQ)
sum preduc12 if e(sample)
margins , at(educ=12)

sum preduc12 
sum preduc12 if libcrd14!=. 


margins , at(educ=(8(2)16))
* Or, same thing
margins , asobserved at(educ=(8(2)16))
marginsplot

margins, dydx(*)
margins, dydx(*) atmeans


logit libcrd14 educ IQ lwage exper
outreg2 using mylogitregs , excel word replace ctitle(Coefficients)
outreg2 using mylogitregs , excel word append eform ctitle(Odds Ratios)
margins , dydx(*) post
outreg2 using mylogitregs , excel word append ctitle(Marginal FX)

* Q 19
recode educ ///
	(1/11  = 1 "Not HS Grad") ///
	(12    = 2 "HS Grad") ///
	(13/15 = 3 "Some College") ///
	(16/18 = 4 "BA plus")  ///
	, gen(educcat)

logit libcrd14 i.educcat IQ black 
margins i.educcat
margins i.educcat, at(IQ=(50(10)150))
marginsplot

* Q 20
margins, dydx(black)
logit libcrd14 i.educcat IQ i.black 
margins, dydx(black)

* Q 21
reg lwage exper expersq 
margins , at(exper=(0(5)25))
marginsplot

reg lwage c.exper c.exper#c.exper
margins , at(exper=(0(5)25))
marginsplot




