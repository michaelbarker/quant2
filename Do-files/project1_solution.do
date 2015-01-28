* Tell Stata not pause for more messages
set more off

*1.2
* Change working directory
cd "/Users/huadehuo/Dropbox/MSPP/Stata_Recitation/quant2/Data/"
use "NAMCS2010.dta", clear

*1.3
* Change variable name to lower case
rename *, lower

* Get mean and median of age
sum age, detail

* Get mode of age
* Get 5 most common ages
tab age, sort

* Histogram 1
histogram age

* Histogram 2
histogram age, discrete normal

* Check missing values of age
tab age, m

* Check missing values of all variables
net install mdesc.pkg
mdesc

* Patient race
tab raceun

* Relationship between sex and race
tab2 sex raceun, chi2
* Ans: the null hypothesis that the two attributes are 
* independent of each other is rejected.

*1.4
* Drop patients if their age is less than 18 years old.
drop if age<18

*1.5
* Height and weight?
lookfor weight
lookfor height

*1.6
* Numeric with lable
codebook wtlb

* tabulate command without value labels.
tab wtlb
tab wtlb, nolabel
tab htin
tab htin, nolabel
*  get the label values with describe
des wtlb
label list WTLBF
des htin
label list HTINF

* Recode "Blank" as missing
codebook wtlb
replace wtlb=. if wtlb==-9
replace htin=. if htin==-9

* Max and min
sum wtlb htin

* Hint: Use mvdecode to generate missing values
* mvdecode _all, mv(-9)

*1.7
* Recode "Missing data" or "Not calculated" as Stata missing value `.`
des bmi
label list BMIF
replace bmi=. if bmi==-9 | bmi==-7

* Log variables
gen bmi_log=log(bmi)
gen wtlb_log=log(wtlb)
gen htin_log=log(htin)

* Label new variables
label variable htin_log "Log value of Height in inches"
label variable wtlb_log "Log value of Weight in pounds"
label variable bmi_log "Log value of Body-Mass index"

* Summarize the three original and three log variables in a single table.
* Verify observation number
sum bmi bmi_log wtlb wtlb_log htin htin_log, sep(2)

*1.8
* Get codebook of usetobac
codebook usetobac

* Generate dummy variable
gen current_tobac=.
replace current_tobac=1 if usetobac==2
replace current_tobac=0 if usetobac==1

* two-way tabulation with missing value
tab2 usetobac current_tobac,m

* Generate overweight dummy variable
gen overwt=.
replace overwt=1 if bmi>=27 & bmi!=.
replace overwt=0 if bmi<27

* two-way tabulation with missing value
tab bmi overwt,m

* both overweight and current tobacco users
gen overwt_current_tobac=.
replace overwt_current_tobac=1 if current_tobac==1 & overwt==1
count if overwt_current_tobac==1

*1.9
* Examine missing values
codebook age htin wtlb bmi bpsys

* Recode -9 in bpsys to .
replace bpsys=. if bpsys==-9

* regression of systolic blood pressure on age, height, weight, and bmi.
reg bpsys age htin wtlb bmi

* test coefficients
test wtlb

*1.10
* Generate BMI
gen bmi2=(0.453592*wtlb)/(0.0254*htin)^2

* new variable compare to the existing BMI variable
sum bmi bmi2

* Difference between bmi and bmi2
gen diffbmi=bmi-bmi2

* Browse them all
browse bmi bmi2 diffbmi

* Summary of diffbmi
sum diffbmi

* Histogram of diffbmi
histogram diffbmi

* Round bmi2 to bmi
gen bmi3=floor(bmi2)
replace diffbmi=bmi-bmi3
browse bmi bmi3 diffbmi
