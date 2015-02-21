# Project 2: Equity in Athletics Data Analysis 
McCourt School of Public Policy, Georgetown University

### Overview
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

 - Categorical variables: Data management, graphing, and analysis 
 - Import excel data into Stata

### Key Commands / Concepts:

 - import excel
 - encode/decode
 - bar graph 
 - factor variable notation (help fvvarlist)
 - recode 
 - string functions

### Questions

2.1. Download the data set and documentation from the website given above.  
Extract all files into a new folder for this project. 
The files we are interested in are Schools.xlsx and SchoolsDoc2014.doc.
Open Stata and set up your new do-file, including a command to change the working directory to the location where you extracted the data files.
 - Open the data file Schools.xlsx in Stata using either the dialogue window or the `import excel` command.
 - If you used the dialogue window, be sure to include the resulting `import excel` command in your do-file.
 - Verify that the variable names were imported correctly.
 - Verify that your data set has 17,134 observations and 128 variables.
 - What does one observation in this data set represent? (Hint: `browse institution_name Sports`)
 - The id variables in this data set are `institution_name` and  `Sports`. Use the `order` command to move these two variables to the first two columns of the data set. For more information on the `order` command, type `help order`.   

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
















2.2. First Sample Selection
We want to limit the analysis sample to a subset of schools. 
First, consider the variable `sector_name`, which describes the category of the academic institution.
Based on this variable, limit the sample to 4-year institutions that are publically owned or non-profit.
You can use either the `keep` or `drop` command to do this.
Make sure you consider the storage type of the variable (string or numeric).
You may want to use copy/paste to make sure you don't make any mistakes when you type the various values of `sector_name`.
 - Use the variable `sector_name` to limit the sample to nonprofit and public 4-year institutions.
 - Verify that your data set now has 13,708 observations.











2.3. Second Sample Selection
We will continue to refine our sample based on `classification_name`. 
There are several organizations that set rules for college athletics. 
This variable specifies the governing body that each institution belongs to.
We want to keep only schools that belong to the "NCAA", in any division.
Like `sector_name`, this variable is a string, but it has many entries. 
We don't want to have to type all of those entries, so we will use a short-cut.
We will keep only those schools where the letters "NCAA" appear anywhere in the name.
We will use the string function `strmatch()`. 
Read about this function, and other string functions, on the help page for string functions.
```
help string functions
describe classification_name
tab classification_name
tab classification_name if strmatch(classification_name, "*NCAA*")
keep if strmatch(classification_name, "*NCAA*")
```
There are several schools we want to drop based on institution_name.
We don't think that mining or maritime schools are comparable to the other schools in our sample.
Use the `strmatch()` function to drop these two type of schools.
 - Drop all schools that have the word "Mines" in their name. 
 - Use the strmatch() function to drop schools that have the word "Maritime" in their name. 










This variable 


