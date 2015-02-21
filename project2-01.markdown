# Project 2: Equity in Athletics Data Analysis 
McCourt School of Public Policy, Georgetown University

### Overview
This project will focus on categorical variables.
In quant class, you've likely discussed categorical variables such as race and highest level of education completed.

We will be investigating data collected from college athletic programs. 
Look for Download Data files on the page linked below.
http://ope.ed.gov/athletics
Download the "Data for academic year 2013-2014"

Alternatively, the direct link is: 
http://ope.ed.gov/athletics/dataFiles/EADA%202013-2014.zip

Background information on this data can be found here:
http://www2.ed.gov/finaid/prof/resources/athletics/eada.html

## Week 1: 
### Key Ideas:

 - Categorical variables: analysis, graphing, and data management
 - Import excel data into Stata

### Key Commands / Concepts:

 - import excel
 - encode/decode
 - bar graph 
 - factor variable notation (help fvvarlist)
 - recode 
 - string functions

### Questions

2.1. 
 - Download the data set and documentation from the website given above.  
 - Extract all files into a new folder for this project. 
 - The files we are interested in are Schools.xlsx and SchoolsDoc2014.doc.
 - Open Stata and set up your new do-file, including a command to change the working directory to the location where you extracted the data files.
 - Open the data file Schools.xlsx in Stata using either the dialogue window or the `import excel` command.
 - If you used the dialogue window, be sure to include the resulting `import excel` command in your do-file.
 - Verify that the variable names were imported correctly.
 - Verify that your data set has 17,134 observations and 128 variables.
 - What does one observation in this data set represent? (Hint: `browse institution_name Sports`)
 - The id variables in this data set are `institution_name` and  `Sports`. 
 - Use the `order` command to move these two variables to the first two columns of the data set. 
 - For more information on the `order` command, type `help order`.   

2.2. 
 - Suppose we want to run a regression of total expense for each sport on the size of the academic institution.
 - We can judge size by the number of enrolled students, `EFTotalCount`.
 - We want to include school size as a categorical variable with three values:
 - Small = 0 to 999 students, Medium = 1000 to 4999 students, and Large = 5000 or more students.
 - Create two new dummy variables for medium and large schools.
 - Run a regression of total expenditure, `TOTAL_EXPENSE_ALL` on the school-size dummies, leaving small schools as the baseline category.
 - Instead of creating dummy variables directly, first create a new categorical variable for the different school sizes. 
 - The new variable should have values of 1 for small schools, 2 for medium schools, and 3 for large schools.
 - This new categorical variable can be used for graphing.
 - Create a bar graph of total expenditure and total revenue over each school category.

2.3. 
 - Typically, to run regressions on categorical variables, first you create dummies, then you include the dummies in the regression.
 - But, a better approach is to first create a new categorical variable for the categories you want.
 - Then, Stata has shortcuts to create dummy variables automatically. 
 - First, we will see how this approach works. Then we will see several examples where this approach makes things easier. 
 - Create a new categorical variable called `schoolsize` based on school size using the categories above.
 - The new variable should have values of 1 for small schools, 2 for medium schools, and 3 for large schools.
 - Confirm the creation of your new variable with a two-way tabulation.
 - Run the following regression and compare the results to the previous regression:
 ```
 regress TOTAL_EXPENSE_ALL i.schoolsize
 ```
 - This is called factor variable notation. Details can be found on the help page: `help fvvarlist`.
 
2.4. Details of factor variables 
 - When you use factor variable notation, Stata creates a hidden dummy variable for each category of the original variable.
 - You can see the names of the hidden dummy variables by replaying the previous regression results with the option `coeflegend`.
 - Look up the `coeflegend` on the help page for regress to see a description of the option.
 - Try it out by typing: `regress , coeflegend`.
 - The name of each hidden dummy variable appears between the brackets, e.g. _b[2.schoolsize]
 - You can use these dummy variable names directly in some commands. 
 - Try it out: `list EFTotalCount schoolsize 1.schoolsize 2.schoolsize 3.schoolsize in 1/50` 

2.5 
 - Postestimation testing with factor variables.
 - Suppose you want to test the hypothesis that the coefficients on medium and large schools are jointly equal to zero.
 - Unfortunately, the test command does not recognize factor variable notation. 
 - Rerun (or replay) the previous regression and try: `test i.schoolsize`
 - Instead, you have to use the names of the hidden dummy variables that we used in Question 2.4.
 - Test the hypothesis that the coefficients on 2.schoolsize and 3.schoolsize are jointly equal to zero.
 - You can also test this hypothesis using `testparm`, an alternate version of the `test` command. 
 - The `testparm` version of the command accepts factor variables, so you can just use `i.schoolsize` directly.
 - Retry the hypothesis test of `i.schoolsize` using `testparm` instead of `test`.
 - Notice the names of the hidden dummy variables appear in the output of the testparm command, where the two hypotheses being tested are listed.
 - The command name `testparm` is not easy to remember, but it is listed on the help page for `test`.
 - So if you ever need to remember the `testparm` command, just look at: `help test`. 


2.5 
 - Examine the existing categorical variable, `sector_name`. Suppose we want to run a regression of total revenue on the dummy variables for each sector.  
 - Try regressing `TOTAL_REVENUE_ALL` on the categories of `sector_name` using factor variable notation (i.). 
 - You should receive an error, because `sector_name` is a string variable.
 - The i. notation can only be used with numeric variables. 
 - This is a very common problem when transfering data from Excel to Stata.
 - You could create a new numeric variable manually, like this:
```
gen sectorid = .
replace sectorid = 1 if sector_name=="
replace sectorid = 1 if sector_name=="
etc...
```
But, there is a much easier way, using the command `encode`.
Review the help page for this command: `help encode`.
Use the encode command to create a new, labeled numeric variable called `sectorid`.
Regress `TOTAL_REVENUE_ALL` on `sectorid` using factor variable notation. 

2.7 Testing 

2.8 Bar graph

2.9 Labels/Recode 

2.10 Bonus 
The combination of encode and factor variables can greatly simplify difficult tasks.  
They are particularly important when considering many categories. 
Let's look at the profitability of each type of sports program.
Create a new variable equal to total revenue - total expenditure.
Create a horizontal bar graph of average profit over all different sports.

2.7 
Run a regression of total profit on a set of dummy variables representing all sports.
Hint: First use `encode` on the `Sports` variable, then use factor variable notation.



2.2. Graphing with Categorical Variables 
Make an hbar graph of something

2.3 Encode ID Variables
The ID variables in this data set are currently strings (How do you know that?).
For many things that we do in Stata, ID variables should be numbers, not strings. 
Stata provides the `encode` and `decode` functions to convert between strings and labeled numbers.
For details on these functions, see `help encode`
 - Create two new labeled numeric variables based on the existing id variables, `institution_name` and `Sports`.
 - Name the two new variables `schoolid` and `sportid`.
 - Order the new variables so they are at the beginning of the data set.

2.4. Factor Variable Regression
help fvvarlist

2.4. Condense Sports Categories using Recode
Consider the variable `Sports`. 
classify by frequency
Give partial recode command 

2.5. Rerun bar graph and regression with new categories

2.6. Add labels to your recode command
Then re-run bar graph and regressions


