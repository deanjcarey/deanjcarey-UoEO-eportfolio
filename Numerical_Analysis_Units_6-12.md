# Numerical Analysis Units 6-12

Outputs for activities can be seen in the links below.

## Unit 6
- [Seminar 6 Activity](/pdf/Unit_6_Seminar_Activity.pdf)

## Unit 7
- [Data Activity 5](/pdf/Data_Activity_5.R)
- [Data Activity 5](/images/DataActivity5.png)
- [Data Activity 5a](/images/DataActivity5_hypothesis.png)

### Reflection on Data Activity 5

I discovered that R doesn't have a built in statistical mode function. The mode function in the DescTools library is quick one line of code — but as I understand it, it never tells you if there is more than one mode (multimodal). I found a custom mode function script using a Google search and it only takes a few more lines to write, but it will do a proper statistical mode i.e. including all ties. Because I wanted to see every mode when there’s a tie I chose the custom version.

The second part of the activity was to produce a five-figure summary of income and present it using a Boxplot. I interpreted the purpose of the boxplot visualisation as showing the raw data rather than just using the five individual figures from the summary which didn't seem to be a useful visualisation.

On the hypothesis part of the activity, firstly the resources Sabeen provided e.g. https://www.statisticshowto.com/probability-and-statistics/t-test/ were very useful to further understand the concepts and why one might chose different types of t-test. Looking at the two groups i.e. those with an ulcer and those without, the counts (sample size and mean sbp in each group) appear significantly different therefore the standard deviation is likely to be different, hence using the Welch degrees of freedom approximation in the t-test command arguments.

The test outcome was: p = 0.2296 which is greater than our 0.05 CI, so we fail to reject Ho - therefore we don’t have strong enough evidence to suggest ulcer patients and non‐ulcer patients have different average systolic blood pressures.

## Unit 8
- 

## Unit 9
- 

## Unit 10
- 

## Unit 11
- 

## Unit 12
- 


## Reflection on Units 6 to 12:
In Units 1 to 5, I was introduced to the basics of using R, including how to navigate RStudio, import data, and carry out descriptive statistics. I also learned about different data structures, how to explore and clean datasets, and how to perform simple statistical operations. Using R has been surprisingly straightforward—once I got used to the syntax, things like plotting data and manipulating variables became quite intuitive.

The course also covered probability and sampling methods, which were manageable with practice. However, when it came to calculus — particularly differentiation and integration — I found it much harder to grasp. Unlike the coding parts, which I could try out and see results instantly, the calculus concepts felt abstract, and I’m still not confident I fully understand them. I think I’ll need a lot more hands-on examples and practical applications before it really starts to make sense.
