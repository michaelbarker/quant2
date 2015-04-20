set more off

* 4.11
local mylocalexample hello, world
display "The text of the local macro, mylocalexample, is: ||`mylocalexample'||"

* 4.12
webuse nhanes2, clear
local ctrlvars age bpsystol bpdiast tcresult
display "ctrlvars: `ctrlvars'"
summarize `ctrlvars'
reg weight `ctrlvars'

* 4.13
foreach mylname in dog cat chicken mouse { 
 display "The next animal is: --`mylname'--"
}

* 4.14
summ hgb-iron
foreach yvar in hgb hct tibc iron {
 regress `yvar' weight height 
}

* 4.15
foreach var in hgb hct tibc iron {
 display "Command to run: ln_`var' = ln(`var')"
 gen ln_`var' = ln(`var')
 label variable ln_`var' "Log of `var'"
}
de ln_*
sum ln_*

* 4.16
foreach command in probit logit regress {
     `command' heartatk weight height 
}

* 4.17
foreach var in ln_hgb ln_hct ln_tibc ln_iron {
     display "The next variable is: `var'"
     summarize `var'
}
de ln_* 
foreach var of varlist ln_* {
     display "The next variable is: `var'"
     summarize `var'
}

* 4.18
local appendreplace replace
foreach command in probit logit regress {
     display "Value of appendreplace: ||`appendreplace'||"
     `command' heartatk weight height 
     outreg2 using "results", `appendreplace' ctitle(`command') excel
     local appendreplace append
}

* 4.20
global myproject4dataset nhanes2
display "Data set for Project 4: $myproject4dataset" 
webuse $myproject4dataset , clear
