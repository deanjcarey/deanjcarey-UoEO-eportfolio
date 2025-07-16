# Numerical Analysis Units 6-12

Outputs for activities can be seen in the links below.

## Unit 6
- [Seminar 6 Activity](/pdf/Unit_6_Seminar_Activity.pdf)

## Unit 7
- [Data Activity 5 - R code](/pdf/Data_Activity_5.R)
- [Data Activity 5 - boxplot](/images/DataActivity5.png)
- [Data Activity 5 - Hypothesis](/images/DataActivity5_hypothesis.png)

### Reflection on Data Activity 5

I discovered that R doesn't have a built in statistical mode function. The mode function in the DescTools library is quick one line of code — but as I understand it, it never tells you if there is more than one mode (multimodal). I found a custom mode function script using a Google search and it only takes a few more lines to write, but it will do a proper statistical mode i.e. including all ties. Because I wanted to see every mode when there’s a tie I chose the custom version.

The second part of the activity was to produce a five-figure summary of income and present it using a Boxplot. I interpreted the purpose of the boxplot visualisation as showing the raw data rather than just using the five individual figures from the summary which didn't seem to be a useful visualisation.

On the hypothesis part of the activity, firstly the resources Sabeen provided e.g. https://www.statisticshowto.com/probability-and-statistics/t-test/ were very useful to further understand the concepts and why one might chose different types of t-test. Looking at the two groups i.e. those with an ulcer and those without, the counts (sample size and mean sbp in each group) appear significantly different therefore the standard deviation is likely to be different, hence using the Welch degrees of freedom approximation in the t-test command arguments.

The test outcome was: p = 0.2296 which is greater than our 0.05 CI, so we fail to reject Ho - therefore we don’t have strong enough evidence to suggest ulcer patients and non‐ulcer patients have different average systolic blood pressures.

## Unit 8
- [Data Activity 6 - Answers](/pdf/Data_Activity_6.2.txt)
- [Data Activity 6.2a - histogram](/images/DataActivity6.2a.png)
- [Data Activity 6.2b - Mann-Whitney](/images/DataActivity6.2b.png)
- [Data Activity 6.2 - R code](/pdf/Data_Activity_6.R)

I found the Powers aspect of this unit very interesting, particularly where you have to adapt the inputs/criteria to gain a more robust outcome or be confident of the true effect, especially in STEM fields. For example where you may wish to reduce the confidence interval below the "typical" 95% e.g. 0.01 (99%) to gain more confidence but this will likely reduce the power of your study. To increase the power, you may need to increase the sample size or increase the desired effect size. I did enjoy studying this aspect of stats.

There is a great deal to examine within statistics and more broadly in the numerical analysis module, in such a short window i.e. 12 weeks. I do have concerns that I will miss or not fully understand some of these key topics but it is a fascinating component of Data Science that has sparked my curiousity to learn more.

## Unit 9
- [Data Activity 7 - crosstab output](/images/DataActivity7.png)
- [Data Activity 7 - R code](/pdf/Data_Activity_7.R)

### Analysis from the activity:
- The most likely age group to be victims of crime was age group 2 (25–34 years).
- 22.42% of people in this group said they experienced crime in the past 12 months.
- The least likely age group to be victims was age group 7 (75+ years).
- Only 4.84% of people in this group reported being victims.
- Age group 6 (65–74 years) also had a low percentage: 8.75%
- Data suggests that younger and middle-aged adults were more likely to report being victims of crime, while older adults were less likely.


## Unit 10
- 

## Unit 11
- 

## Unit 12
- [Assessment 1 - R code](/pdf/HSE_Assignmentv2.R)


## Reflection on Units 6 to 12:
