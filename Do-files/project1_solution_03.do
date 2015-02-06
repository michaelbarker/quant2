* Tell Stata not pause for -more- messages
clear
set more off

*1.2
* Change working directory
use "../Data/NAMCS2010.dta", clear
* use "/Users/michael/Dropbox/Spring 15/Recitation/NAMCS2010_sample.dta"

{
*1.3
* Change variable name to lower case
rename *, lower

* Get mean and median of age
sum age, detail

* Get mode of age
* Get 5 most common ages
tab age, sort

* Histogram 1
* histogram age

* Histogram 2
* histogram age, discrete normal

* Check missing values of age
tab age, m

* Check missing values of all variables
misstable summarize

* Patient race
tab raceun

* Relationship between sex and race
tab2 sex raceun, chi2
* Ans: the null hypothesis that the two attributes are 
* independent of each other is rejected.

*1.4
* Drop patients if their age is less than 18 years old.
drop if age<16

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
* mvdecode varlist, mv(-9)

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
gen overwt_current_tobac=0
replace overwt_current_tobac=1 if current_tobac==1 & overwt==1
replace overwt_current_tobac=. if current_tobac==. | overwt==.

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
* browse bmi bmi2 diffbmi

* Summary of diffbmi
sum diffbmi

* Histogram of diffbmi
* histogram diffbmi

* Round bmi2 to bmi
gen bmi3=floor(bmi2)
replace diffbmi=bmi-bmi3
* browse bmi bmi3 diffbmi

* Hint: compare
compare bmi bmi2
}

*1.11 - confirm sample
*make sure we have 3885 observations
count

*1.12 - recode missing
*check for negative values by lookin gat the negative
sum bpsys bpdias htin wtlb, detail
*remove missing values from bpdias
recode bpdias (-9 = .)
*or 
replace bpdias = . if bpdias == -9

*1.13
tab overwt current_tobac
tab overwt_current_tobac
reg bpsys overwt current_tobac
test current_tobac==0 
*so same p-value

test current_tobac==7 
*reject null
test current_tobac==2
*fail to reject null
test current_tobac 
*tests that it is equal to 0

*1.14
reg bpdias current_tobac overwt

test current_tobac overwt
* ^this tests that coefficients are equal to 0
test current_tobac = overwt
* ^this tests that coefficients are equal
test current_tobac = overwt = 0
* ^ this test appears equivalent to the first test


*1.15
reg bpdias overwt current_tobac  overwt_current_tobac
test current_tobac
*not significantly different
test overwt_current_tobac
*not significantly different
test overwt_current_tobac + current_tobac = 0
* together they are

*1.16
gen age2 = .
replace age2 = age*age
reg bpsys current_tobac overwt age age2
test age age2 
test current_tobac = overwt

*1.17/////////////////////////////////////////////
gen bpave = .
replace bpave = (bpsys + bpdias)/2

egen bpave2 = rowmean(bpsys bpdias)

* help egen
* browse xray-othimage
describe xray-othimage
tab1 xray-othimage , nolabel missing
egen numimage = rowtotal(xray-othimage)
* browse xray-othimage numimage 

* browse med1-med8
describe med1-med8
tab med1 if med1 < 0
tab med1 if med1 < 0 , nol
mvdecode med1-med8 , mv(-9) 
egen nummeds = rownonmiss(med1-med8) 
* browse med1-med8 nummeds

*1.18
sum wtlb
egen meanwtlb = mean(wtlb)
egen sdwtlb = sd(wtlb)
* browse wtlb meanwtlb sdwtlb
gen stdwtlb = (wtlb-meanwtlb) / sdwtlb
sum wtlb stdwtlb

*method above
sum htin
egen meanhtin = mean(htin)
egen sdhtin = sd(htin)
* browse htin meanhtin sdhtin
gen stdhtin = (htin-meanhtin) / sdhtin
sum htin stdhtin

*alternate easier method
egen stdhtin_alt = std(htin)

*1.19 - introduction to bysort
summarize htin wtlb bpsys bpdias if sex==1
summarize htin wtlb bpsys bpdias if sex==2
* Alternative Method
bysort sex: summarize htin wtlb bpsys bpdias

bysort sex raceun: tab current_tobac
*** summarizing bpdias and bpsys 
bysort current_tobac overwt: summ bpdias bpsys

*1.20
*example
bysort sex: egen mfaveht = mean(htin)
gen mftall = .
replace mftall = 1 if htin > mfaveht
replace mftall = 0 if htin <= mfaveht
replace mftall = . if htin==. | mfaveht==.

* browse sex htin mfaveht mftall

*creating age variable
bysort age: egen avgwtlb  = mean(wtlb)
gen ageheavy = .
replace ageheavy = 1 if wtlb > avgwtlb
replace ageheavy = 0 if wtlb <= avgwtlb
replace ageheavy = . if wtlb==. | avgwtlb==.

* A few commands from week 3:
codebook sex
gen male = sex==2
gen male_overwt = male*overwt
regress bpsys male overwt male_overwt

regress bmi wtlb
predict pr_bmi , xb
predict resid , re
twoway scatter bmi pr_bmi resid wtlb

* 1.28 Outreg2 Table
reg bpsys current_tobac overwt numimage nummeds mftall ageheavy
outreg2 using bpbasic , replace excel word
reg bpdias current_tobac overwt numimage nummeds mftall ageheavy
outreg2 using bpbasic , append excel word

* 1.29 Fancy Outreg2 Table
lab var current_tobac "Uses Tobacco"
lab var overwt "BMI above 27"
lab var numimage "Number Image Tests"
lab var nummeds "Number Medications"
lab var mftall "Above Ave. Height for Gender"
lab var ageheavy "Above Ave. Weight for Age"

reg bpsys current_tobac overwt numimage nummeds mftall ageheavy
outreg2 using bpfancy , replace excel label ctitle(BP Systolic) dec(2) word pvalue
reg bpdias current_tobac overwt numimage nummeds mftall ageheavy
outreg2 using bpfancy , append excel label ctitle(BP Diastolic) dec(2) word pvalue


