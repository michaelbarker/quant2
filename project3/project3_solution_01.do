//PROJECT 3: Library Card Data
/*
- Run LPM/Probit/Logit commands 
- Use postestimation commands for above 
*/
*******************************************************************************/


* Today we will talk about regression models that you can use with 
* binary (0/1) dependent variables.
* Look at the relationship between education and whether or not a person had
* a library card at age 14.
* We want to answer the following question: Given the number of year's of education
* someone has, what is the proability that he or she had a library card at age 14?

//  3.1 
clear
*cd
use card.dta
//  3.2
* Linear Probability Model just uses regress
reg libcrd14 educ , robust
* Now calculate predicted probabilities with the predict postestimation command:
help regress postestimation
* We want linear predication, the xb option
predict lpm_libcrd14, xb
* Label and graph new variable
label variable lpm_libcrd14 "LPM"
*Remember, if we make a connected line graph, the points are connected in 
* whichever order they appear in the data set.
* To get a nice graph, sort the data by the X-variable before graphing
sort educ
*or add it into the command
twoway line lpm_libcrd14 educ, name(LPM, replace) sort(educ)
* note: name lets you have multiple graph windows open(need to name each one something different)

// 3.3
* Probit command is very similar to regress
help probit
* You can also find full examples and a review of probit in the pdf-manual entry
probit libcrd14 educ
* Again, calculate predicted probabilities. For probit, use the pr option of predict
help probit postestimation
predict probit_libcrd14, pr
* Label and graph new variable
label variable probit_libcrd14 "Probit"
twoway line probit_libcrd14 educ, name(Probit, replace) sort(educ)

// 3.4
* Logit command is also very similar:
help logit
logit libcrd14 educ
* To get predicted values, use predict with the pr option, just like probit
help logit postestimation
predict logit_libcrd14, pr
* Label and graph new variable
label variable logit_libcrd14 "Logit"
* Note, we already sorted the data by education, so we don't have to sort it again.
twoway line logit_libcrd14 educ, name(Logit, replace) sort(educ)

// 3.5
* Now graph all predicted values together
twoway line lpm_libcrd14 probit_libcrd14 logit_libcrd14 educ 

// 3.6
* Add horizontal lines at predicted probabilities of zero and one
twoway line lpm_libcrd14 probit_libcrd14 logit_libcrd14 educ , yline(0) yline(1)
* Notice the logit and probit predicted values will never cross the 0 or 1 line.
twoway line lpm_libcrd14 probit_libcrd14 logit_libcrd14 educ , yline(0) yline(1) scheme(s1mono)
*or try out 
twoway line lpm_libcrd14 probit_libcrd14 logit_libcrd14 educ , yline(0) yline(1) scheme(sj)

// 3.7
graph export filename.suffix

// 3.8
*mean
sum libcrd14 
* mean of the predicted probabilities of logit
sum logit_libcrd14
*make sure we have the logit active
logit
margins
*no it is not - different number of missing data
sum logit_libcrd14 if libcrd14 != . 
* note: if x values are missing predict will not predict them

// 3.9
logit libcrd14 educ
margins
outreg2
logit libcrd14 educ
margins, post 
outreg2

// 3.10
*rerun because I have overwritten stored values with margins, post
logit libcrd14 educ
margins, atmeans


*Challenge
sum educ if libcrd14 !=.
display r(mean)
logit libcrd14 educ
*manual
sum educ if libcrd14 !=.
display r(mean)
display invlogit(_b[educ]* r(mean) + _b[_cons]) 

*** manual with probit
probit libcrd14 educ
margins, atmeans
*same as 
sum educ if libcrd14 !=.
display r(mean)
display normprob(_b[educ]* r(mean) + _b[_cons]) 
***
