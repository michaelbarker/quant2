/*******************************************************************************
 Recitation 2: Complex variable creation 
 - egen 
 - bysort 
 
 SWBAT: Create variables using egen and bysort constructions 
*******************************************************************************/

/*************************/
*Review Problems using the example data set nlsw88.dta:

*1. Use the recode command to generate a new variable called AgeCat with the following categories: 
	*(1) subjects age 35 or younger
	*(2) subjects  ages 36 to 39 
	*(3) subjects  ages 40 to 44
	*(4) subjects  ages 45 or older
sysuse nlsw88.dta
tab age
recode age (34/35 = 1) (36/39 = 2) (40/44 = 3) (45/46 = 4), generate(AgeCat)
	
*2. Label the variable AgeCat with the description "Age Group/Category"

label variable AgeCat "Age Group/Category"


*3. Create a two-way scatter graphs showing the wage on the y-axis and total experience on the x-axis. 

 
twoway (scatter wage ttl_exp)

   

*4. Create the same graph as above but with separate subgraphs for each age group specified by AgeCat

twoway (scatter wage ttl_exp), by(AgeCat)

/*****************************************/


* We have created new variables with simple functions and arithmetic operations.

* This class, we will cover two powerful tools for variable creation.

* First, extensions to generate, egen
help egen

* egen functions allow you to work easily with many variables at the same time across each observation

** Example 1: Create a new variable equal to the sum of years of schooling completed, total work experience, and job tenure: 

*Using generate:
gen AllExp=grade+ttl_exp+tenure
*However, a missing value is generated for the new variable in any observation where grade, total experience, or job tenure has a missing value.

*If we use egen's rowtotal function, missing values in the three variables will automatically be treated as 0 when calculating the sum:
help egen 

egen AllExp2 =rowtotal(grade ttl_exp tenure)
*Now, there are no missing values in the new variable. Compare when the results differ for the version created with generate and the version created using egen
browse grade ttl_exp tenure AllExp AllExp2 if AllExp == .


**Example 2:
*Similarly, using egen's rowmax function, we can create a new variable set equal to the value that is the highest out of the three variables:
egen MaxExp =rowmax(grade ttl_exp tenure)

browse grade ttl_exp tenure MaxExp

* The description in each egen function explains how it treats missing data


/*******************************************************/
* egen functions can also work with information from many observations at the same time (down a column rather than across a row)

* Example: Use egen to quickly create a new variable set equal to the mean of hours for the entire sample: 
egen AvgWage = mean(hours)

*Again, observations with missing values for the hours variable are ignored when calculating the mean


*Value of AvgHours is the same for all observations. It is equal to the mean of hours for the entire sample
browse AvgHours
sum hours


*******************************
* See help file and manual for description of each function as well as additional detailed examples.

* When you have a complex variable creation task, read through egen help page to 
* find commands that can help you.



/****IN-CLASS EXERCISES 1*******/

*1. Create a new variable called AvgExp that is equal to the average of job tenure, years of education completed, and total work experience. 
   *Whenever any of the three variables has a missing value, omit it from the calculation of average experience for that observation.
   egen AvgExp = rowmax(grade ttl_exp tenure)
   
*2. What is the mean of AvgExp?
   
   sum AvgExp
   
*3. Create a new variable called MedianWage, that for all observations is set equal to the median wage of the entire sample. 
   
   egen MedianWage = median(wage)
   

*4. How many never-married individuals have a wage that is lower than the median wage of the entire sample?

   count  if never_married == 1 & wage<MedianWage

   
/***************************************************/   
* SECOND TOOL: BY PREFIX

* The by: prefix allows you to repeat a command for different groups within a data set.
help by
* Data must be sorted before using "by".
* The bysort: prefix sorts the data, automatically.

* bysort can be used with summary stats commands:
bysort union: sum wage hours

* Notice if we look at the help file:
help bysort
* Bysort accepts a varlist. We can specify groups using multiple variables:
bysort married union : sum wage hours

* or estimation commands, estimates the relationships separately for each subgroup:
bysort union: reg wage ttl_exp

* or, especially useful, combined with egen:
*sets the new variable for the average value of hours for their subgroup (married vs. not married) rather than the average value of hours for the entire sample
bysort married: egen AvgWageByMarr = mean(wage)

*Value of AvgWageByMarr is different for observations that are married vs. single
browse married wage AvgWageByMarr 



/*****IN-CLASS EXERCISES 2:******************/

*1. Show summary statistics for years of education completed and total work experience by industry. 

bysort industry: sum grade ttl_exp 

*2. Create a new variable, AvgTenureByOcc, set equal to the average job tenure of the subject's occupation.

bysort occupation: egen AvgTenureByOcc = mean(tenure)

*Value of AvgTenureByOCc is different for observations that are in different occupational groups
browse occupation tenure  AvgTenureByOcc









