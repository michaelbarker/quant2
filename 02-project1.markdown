# Project 1: Ambulatory Care Medical Data
McCourt School of Public Policy, Georgetown University

## Week 2: Complex Variable Creation 
### Key Ideas:

 - Egen command 
 - bysort prefix 

### Overview

- We will continue with the project we started last week 
- You may have to re-download the data set and documentation from Blackboard
- Like last week, save all project files to a dedicated folder 
- Download the provided solutions from last week to your project folder
- Review the solution and ask questions if there is anything you don't understand
- For the questions this week, do not start a new do-file
- Continue adding commands, either to your previous do-file from last week or to the solution do-file from Blackboard 

### Questions

1.11. Confirm Sample
- Last week we restricted our data set to patients age 18 and older. 
- Re-run the do-file and verify that you are working with the restricted data set.
- After running the do-file, your data set should have 3,885 observations.

1.12. Recode missing
- We will be working with the following variables this week
  - bpsys bpdias
- For each variable, check for negative values 
- Recode -7, -8, and -9 to missing for each of these variables

1.13. Regressions on dummies
- The question uses the three indicator variables that you created in Question 1.8
- Verfy your variable creation:

. tab overwt current_tobac

           |     current_tobac
    overwt |         0          1 |     Total
-----------+----------------------+----------
         0 |       454        113 |       567 
         1 |       594        135 |       729 
-----------+----------------------+----------
     Total |     1,048        248 |     1,296 


. tab overwt_current_tobac

overwt_curr |
  ent_tobac |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      1,161       89.58       89.58
          1 |        135       10.42      100.00
------------+-----------------------------------
      Total |      1,296      100.00

- Run a regression of systolic blood pressure on the indicators for current tobacco use and overweight
- The `test` command allows you to perform hypothesis tests using results from the most recent regression
- `test` performs an F-test, which you will learn about in Quant class. For now, just focus on p-values
- Test the hypothesis that the coefficient on currenttobac is equal to zero.
- test currenttobac==0 
- Compare to the p-value reported in the regression results

- Unless you run another regression, any test commands will continue to apply to the last one run.
- Test the null-hypothesis that the coefficient on currenttobac is equal to 7. Can you reject this hypothesis?
- Test the null-hypothesis that the coefficient on currenttobac is equal to 2. Can you reject this hypothesis?
- What null-hypothesis is tested if you don't specify a number? Run the command: `test currenttobac`

1.14 Testing with multiple restrictions 
- The test command can be used to test hypotheses with multiple variables 
- Run a regression of diastolic blood pressure on the indicators for current tobacco use and overweight.
- What null-hypothesis is tested by the following command? `test currenttobac overwt` 
- Test the null-hypothesis that the coefficient on `currenttobac` is equal to the coefficient on `overwt`
- Run the test command: `test currenttobac = overwt = 0`. How is this different from the previous test? 

1.15 Regressions with dummies and interactions and testing
- Run a regression of diastolic blood pressure on currenttobac, overwt, and the indicator for overwt and currenttobac.
- Is the currenttobac indicator significantly different from zero? How about the indicator for overwt and currenttobac?
- Test the null-hypothesis that both of the two currenttobac indicators are jointly equal to zero.  

1.16 Quadratic terms
- Create a new variable equal to age-squared.
- Run a regression of systolic blood pressure on currenttobac, overwt, age, and age-squared.
- Test the null-hypothesis that age and age-squared are jointly equal to zero. 
- Test the null-hypothesis that the coefficient on currenttobac is equal to the coefficient on overwt.

1.17 egen Variable Creation 
- Create a new variable called `bpave` equal to the average of systolic and diastolic blood pressure.
- Another way to create this variable is with egen: `egen bpave2 = rowmean(bpsys bpdias)` 
- Egen gives you access to many different functions that make complex variable creation easier.
- Look throught the various functions on the help page: `help egen`
- Create a new variable equal to the average 


1.18 bysort
- bysort allows you to repeat a command for 

1.19 egen and bysort

1.20 Challenge question



