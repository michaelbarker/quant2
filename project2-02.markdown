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

 - Interaction terms 
 -  

### Key Commands / Concepts:


### Questions

2.11 Sport profitability 
 - Last week we looked at two continuous outcome variables: total revenue and total expenditures.
 - This week, we will look at total profit.
 - Create a new variable for total profit for each sports team, equal to (total revenue - total expenditure).
 - Create a bar graph of the average profit for each type of sports team.
 - Make sure you choose the appropriate orientation, vertical or horizontal.
 - Are most college sports teams profitable?
 - Which type of sports team is the most profitable, on average?

2.12 Sport categories 
 - We are interested in the profitability of different types of sports, but there are currently too many different sports here.
 - We need to group some sports together into larger categories.
 - First, use the `encode` command to create a labeled numeric variable named `sportid`.
 - Then use the `recode` command to generate a new variable named `sportcat` containing the categories below.
 - See the final example given on the `recode` help page for a useful tip on organizing a long recode command.
 - You may want to use `label list` to list the value labels of the `sportid` variable before starting the recode.
 - Sport Categories (Some sports will be in their own category)
   - Baseball/Softball
   - Basketball
   - Football
   - Soccer
   - Other
 - Verify your variable creation with the following command: `bysort sportcat: tab sportid, m` 
 - Create a bar graph of total revenue and total expenses over the new sport categories.

2.13 Female Head Coach
 - Investigate the following two variables: 
   - `SUM_FTHDCOACH_FEM` Number of full-time female head coaches for sports team 
   - `SUM_PTHDCOACH_FEM` Number of part-time female head coaches for sports team 
 - Create a new indicator variable, `femhdcoach`, that is equal to one if a team has either a full-time or part-time female head coach, and zero otherwise.
 - Create a bar graph showing average profit for teams with a female head coach and for those without a female head coach.
 - Are teams with a female head coach profitable, on average?

2.14 Categorical-Categorical Interactions 
 - As we saw last week, the idea behind dummy variables is to allow the average value of a variable to change over categories.
 - Categorical-categorical interaction terms allow the average value of a variable to change for every unique combination of the categories. 
 - Suppose we want to look at the average profit of teams with and withoug a female head coach, separately for each sport category. 
 - You can visualize these relationships in a bar graph with multiple over() categories.  
 - Create a bar graph of average profitability over `femhdcoach`, then over `sportcat`. 
 - Is the relationship between having a female head coach and team profit the same for each sport category? 

2.15 Factor Variable Interactions
 - Interaction terms, like dummy variables, can be included in a regression using factor variable notation.  
 - To include interaction terms, just include both variable names, jointed by the symbol `#`.
 - You also need to include the dummy variables using `i.` notation, so each variable name will appear twice.
 - Run a regression of profit on sport category dummies, the female head coach dummy, and interactions for all sports.
 - One interaction term is omitted, because there are no football teams with female head coaches.
 
2.16 Testing Interactions 
 - Testing factor variable interaction terms works just like testing factor variable dummy variables.
 - You can use the `coeflegend` option to get the names of individual interaction coeffiecients.
 - Or you can test all the interactions as a group using the `testparm` command.
 - Test the null hypothesis that 
 - Test the null hypothesis that all the interaction terms are jointly equal to zero.




2.6 Postestimation testing with factor variables
 - Suppose you want to test the hypothesis that the coefficients on medium and large schools are jointly equal to zero.
 - Unfortunately, the test command does not recognize factor variable notation. 
 - Rerun (or replay) the previous regression and try: `test i.schoolsize`
 - Instead, you have to use the names of the hidden dummy variables that we saw in Question 2.4.
 - Test the hypothesis that the coefficients on 2.schoolsize and 3.schoolsize are jointly equal to zero.
 - You can also test this hypothesis using `testparm`, an alternate version of the `test` command. 
 - The `testparm` version of the command accepts factor variables, so you can just use `i.schoolsize` directly.
 - Retry the hypothesis test of `i.schoolsize` using `testparm` instead of `test`.
 - Notice the names of the hidden dummy variables appear in the output of the testparm command, where the two hypotheses being tested are listed.
 - The command name `testparm` is not easy to remember, but it is listed on the help page for `test`.
 - So if you ever need to remember the `testparm` command, just look at: `help test`. 


2.7 Encode String Variables 
 - Examine the existing categorical variable, `sector_name`. 
 - Suppose we want to run a regression of total revenue on the dummy variables for each sector.  
 - Try regressing `TOTAL_REVENUE_ALL` on the categories of `sector_name` using factor variable notation (i.sector_name). 
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
 - But, there is a much easier way, using the command `encode`.
 - Review the help page for this command: `help encode`.
 - Use the encode command to create a new, labeled numeric variable called `sectorid`.
 - Regress `TOTAL_REVENUE_ALL` on `sectorid` using factor variable notation. 

2.7 Test and testparm 
 - Use the `regress , coeflegend` command to replay the regression results showing the factor variable names.
 - Test the hypothesis that the coefficient on private nonprofit 2-year schools is equal to the coefficient on public two-year schools.
 - Test the hypothesis that the coefficients on all 5 dummy variables are jointly equal to zero.

2.8 Bar graph
 - Create a bar graph of average total revenue and average total expenditure over the categories of sectorid. 
 - When you have many categories, a horizontal bar graph is often more clear.
 - Change your bar graph to a horizontal layout. 

2.9 Labels/Recode 
 - Notice the value labels of `sectorid` are automatically included in regression output and bar graphs. 
 - You can add value labels manually, using the commands `label define` and `label values`.
 - Alternatively, the `recode` command provides a way to recode variables and label them in one step. 
 - Here is an example using the recode command to generate the school size categorical variable. 
```
recode EFTotalCount (0/999 = 1 "Small") (1000/4999 = 2 "Medium") (5000/max = 3 "Large") , gen(schoolsize)
``` 
 - Create a new categorical variable based on the number of participants in each type of sport including male and female teams.
 - First, add the number of participants in the two variables, `PARTIC_MEN` and `PARTIC_WOMEN`.
 - Hint: Consider an egen function to deal with missing values.
 - Choose the cutoff values for the new variable to divide the data into quartiles.
 - Make sure your new variable has value labels.
 - Verify the creation of your variable with a two-way tabulation.
 - Create a bar graph and run a regression of your choosing with your new categorical variable.

2.10 Reporting Results
 - Go back through your do-file and add outreg2 commands to create a table (or multiple tables) reporting your regression results.
 - Use the `label` option to use value labels for your factor variables.


