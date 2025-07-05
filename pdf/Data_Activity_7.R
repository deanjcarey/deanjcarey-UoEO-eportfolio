#Dean Carey - Numerical Analysis
#Data Activity 7

# Create a crosstab to assess how individuals’ experience of any crime in the previous 12 months bcsvictim vary by age group agegrp7. Create the crosstab with bcsvictim in the rows and agegrp7 in the columns, and produce row percentages, rounded to 2 decimal places.
# Looking at the crosstab you have produced, which age groups were the most likely, and least likely, to be victims of crime?
  

library(haven)
#cd <- read_sav("R Course Files/Module 2 - Numerical Analysis/csew1314teachingopen.sav")
#View(csew1314teachingopen)
cd <-(csew1314teachingopen)
library(tidyverse)
library(janitor)

#Create crosstab with percentages
cd %>%
  tabyl(bcsvictim, agegrp7) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 2) %>%
  adorn_ns() 

