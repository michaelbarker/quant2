# Project 1: Ambulatory Care Medical Data
McCourt School of Public Policy, Georgetown University

## Week 3: Postestimation commands 
### Key Ideas:

 - estimation results
 - postestimation  
 - outreg2 

### Overview

- This week, it is very important to save all project files to a dedicated folder 
- We will be creating several output files this week, and they will save to your working directory, wherever that may be 
- If you're unsure about the location of your working directory, please ask.

### Questions

1.21 Review Question
- 

1.22 Update Sample
- It's a fact of life, we all make mistakes
- Sometimes you make a choice at the beginning of your analysis that you later regret
- For example, in week 1 we limited our sample to patients age 18 and older 
- We have just realized that we want to look at patients age 16 and older
- Fortunately, this mistake is easy to fix.
- Just go back in your do-file and change the relevant line of code, then re-run the entire do-file.
- Question: Update your sample to include all patients age 16 and up. 
- Rerun the entire do-file to make sure all of the variables you created are up-to-date with the new sample.

1.22 Linear Combinations of Coefficients
- Run regression and test sum of indicator variables
- Suppose we want to know the combined effect of being both x and x.
- We could just calculate the sum of the coefficients:
- Run the following line of code to calculate the sum:
- display "The total effect of x and x is: " _b[x] + _b[x]
- We could also test if the combined effect is different from zero:
- test x + x = 0
- But, what if we want to know the confidence interval around the combined effect?
- We need to calculate statistics for a "linear combination" of coefficients, using lincom:
- lincom x+x
- Try it:

1.23 Other Postestimation Tests
- We have covered two postestimation tests so far: test and lincom
- In general, postestimation refers to commands that are run after an estimation command such as regress, and use the results from that command. 
- You will be learning other estimation commands this semester, in addition to regress. (probit, logit)
- The postestimation commands available after each command are different 
- Look at the postestimation commands available after regress with: `help regress postestimation`
- You will be using a few of these postestimation commands throughout quant classes and thesis
- Try running the following tests, but don't worry about the meaning of the output.
hettest , linktest, ovtest 

1.24 Predicted Values 
- Another popular activity after estimation is generating predicted values.
- You can generate the predicted value of y or the residual using different predict options.
- Regress bmi on wtlb  
- predict pr_bmi , xb
- twoway scatter bmi pr_bmi wtlb
- summarize predicted values for different categories 

1.25 Margins 
- Another way to calculate average predicted outcomes over categories

1.26 Estimates
- replay
- ereturn list

1.25 Outreg2 

1.26 Outreg2 - Summary Statistics 

1.27 Estimates Store 

1.28 Estimates Table 

1.29 Outreg2 Fancy







