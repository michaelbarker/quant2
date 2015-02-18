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
 - string functions
 - recode 
 - factor variable notation (help fvvarlist)
 - bar graph 

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

2.2. Sample Selection
 - 




