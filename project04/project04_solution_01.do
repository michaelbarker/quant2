* Download data from http://catalog.data.gov/dataset/school-improvement-2010-grants
* Or, go to data.gov and search for "School Improvement 2010 Grants"
import delimited userssharedsdfschoolimprovement2010grants.csv , clear varnames(1)

import delimited userssharedsdfschoolimprovement2010grants.csv , clear bindquotes(strict) varnames(1)

destring v5 , gen(grantamt) ignore($ ,)
encode modelselected, gen(model)

summarize grantamt model
misstable summarize grantamt model

* Dealing with missing data
* Step 1:
egen numbermissing = rowmiss(grantamt model)

browse if numbermissing > 0

gen  nomiss = 0
replace nomiss = 1 if numbermissing==0

summarize grantamt model if nomiss==1

* Step 2: Create missing variable dummies
* Fill actual missing values with zero 
misstable summarize grantamt model, gen(miss_)
recode grantamt model (.=0)


* End of Missing Data: Moving on to macros and loops

* Sometimes you have to repeat a command many times on different variables.
* One way to make this faster is to use a loop.
* We will learn how to work with loops soon.
* The easiest approach, though, is to find a command that takes a varlist.
* Look at the help file for encode. It takes a "varname"
* In contrast, misstable summarize and recode both take varlists.
* This allowed us to apply the command to many variables with one command, in essence looping over them. 

* Find a command that takes a varlist and will allow you to produce 1-way tabulations for all of your missing value dummy variables
tab1 miss_*

* Sometimes you won't be able to find a command that does exactly what you need.
* In that case, you may want to use a loop.
* Loops use local macros, so before we get into loops, we have to start with macros. 

* Simple examples using local and display
* Local macros are only defined in the do-file, cannot put them into the command window.

* When might you use a local macro? 
* Define a list of states to use in an "if" statement.
* Use a list of control variables

local ctrlvars i.model miss_grantamt miss_model
reg grantamt `ctrlvars'

local states MA CT ME
reg grantamt i.model if state == "`states'"

local states `" "MA", "CT", "ME" "'

help quotes


display `"sum grantamt if inlist(state, `states') "'
sum grantamt if inlist(state, `states')



