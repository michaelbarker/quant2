# Project 1: Data set name 
McCourt School of Public Policy, Georgetown University

### Overview

Investigate medical data
This project will be on-going for the next three weeks
Remember to save your do-file each week so you can pick up where you left off

## Week 1: Review
### Key Ideas:
 - Review Stata commands from last semester 
 - Practice working on a large project in a do-file

### Questions

1. Download the data set and documentation from Blackboard. 
Save the data set and documentation in a new folder dedicated to this project.
Take a few minutes to look at the documentation before opening the data set.
  - What type of data is in this data set?
  - What does one line of the data set represent?
  - What types of variables are in this data set?

2. Open Stata and start a new do-file for this project
The first command in your new do-file should change the working directory to your dedicated project folder. 
You can get this command from the drop-down menu `File >> Change Working Directory`.
Add a `use` command to open up the data set.
Save your do-file and make sure it runs before moving on.

    ```
    cd "C:\Users\hoya99\Desktop\project1"  
    use NAMCS2010.dta, clear
    ```

> Tip: Another command you may want at the beginning of your do-file is `set more off`. 

3. Use your basic descriptive commands to answer some questions about the data.
These questions can all be answered with `summarize` and `tabulate`.
You might have to use some options, which are described on the help page for each command.
The commands that you use to answer these questions should be in your do-file.
  - Does this sample contain more males or females?
  - What is the average age of patients in this data set?
  - What is the median value of age in this data set?
  - What is the most common age of patients in this data set?
  - In descending order, what are the five most common ages of patients in this data set? 

> Tip: Some people don't like typing capital letters all the time in Stata.
Use the command `rename * , lower` to change all variable names to lower case.
For more advanced uses of rename type `help rename group`. 

4. We learned a lot about the distribution of age from the previous question. 
We can get a picture of the overall distribution using histogram.
  - Generate a histogram showing the distribution of the age of patients in this data set. 
  - Generate a second histogram treating age as a discrete variable and add a normal density line to the graph for comparison.
  - Does it look like age is distributed normally in this sample?

5. We want to learn about the height and weight of patients in this data set.
Find the two variables that give "Height in inches" and "Weight in pounds".
hint: Don't scroll through the variable window searching for these variables.
Instead you can 
  - Use the Filter Bar on the variable window
  - Use the `lookfor` command to search variable names and labels
  - Search the documentation

6. What are the maximum and minimum values of the weight variable?
For both weight and height, recode the "Blank" entries to Stata missing. 
These are both labeled numeric variables.
To find the underlying numeric values, first find the label name with `describe`.
Then get the label values with `label list`.

7. Variable transformations 
- recalculate BMI from components, then compare
- create log versions of bmi, height, and weight

8. If-statements and indicators
 - fix missing values in usetobac
 - create indicator for current tobac
 - check creation with two-way tab
 - create indicator for overweight based on bmi
 - check creation with two summarize bmi if overweight==1 / 0 

9. Regressions and testing
 basic regression
 basic ftest
 basic lincom


* Week 1
Open data with use 
data manipulation from Quant 1
create log variables
regression
test
lincom

* Week 2
Add data manipulation with egen and bysort
create quadratic terms
create indicator variables
include in regressions
test with multiple restrictions
test linear combinations

* Week 3
More testing and linear combinations
Other postestimation tests
estimates store/use
regression table output with outreg2 possibly estout
outreg2 summary statistics





