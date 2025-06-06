# Numerical Analysis - Dean Carey
#Data Activity 5
#Using the Health_Data, please perform the following functions in R:
#Find out mean, median and mode of variables sbp, dbp and income.
#Find out the five-figure summary of income variable and present it using a Boxplot.
#Run a suitable hypothesis test to see if there is any association between systolic
#blood pressure and presence and absence of peptic ulcer.

library(haven)
library(dplyr)
hd<-(Health_Data)

#generate mean and median for sbp, dbp and income
mean_sbp<- mean(hd$sbp, na.rm = TRUE)
median_sbp<- median(hd$sbp, na.rm = TRUE)

mean_dbp<- mean(hd$dbp, na.rm = TRUE)
median_dbp<- median(hd$dbp, na.rm = TRUE)

mean_income<- mean(hd$income, na.rm = TRUE)
median_income<- median(hd$income, na.rm = TRUE)

#Create a mode function - built in functions in R don't generate a proper statistical mode
Mode <- function(x) {
  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  modes <- ux[tab == max(tab)]
  if (length(modes) > 1) {
    return(modes)
  } else {
    return(modes)
  }
}

mode_sbp<- Mode(hd$sbp)
mode_dbp<- Mode(hd$dbp)
mode_income<- Mode(hd$income)

#Just observing the health data table directly and looking at the frequency of values, the income
#values look fairly unique so a mode will tell us nothing useful or at least it will suggest just continuous values

{
cat("SBP:\n")
cat("  Mean   =", mean_sbp,    "\n")
cat("  Median =", median_sbp,  "\n")
cat("  Mode   =", paste(mode_sbp, collapse = ", "), "\n\n")

cat("DBP:\n")
cat("  Mean   =", mean_dbp,    "\n")
cat("  Median =", median_dbp,  "\n")
cat("  Mode   =", paste(mode_dbp, collapse = ", "), "\n\n")

cat("Income:\n")
cat("  Mean   =", mean_income,    "\n")
cat("  Median =", median_income,  "\n")
cat("  Mode   =", if (length(mode_income) > 1) "No unique mode" else mode_income, "\n")
}

#Calc the five‐number summary for 'income'
mins   <- min(hd$income, na.rm = TRUE)
q1     <- quantile(hd$income, probs = 0.25, na.rm = TRUE)
median <- median(hd$income, na.rm = TRUE)
q3     <- quantile(hd$income, probs = 0.75, na.rm = TRUE)
maxs   <- max(hd$income, na.rm = TRUE)

#Create a small data-frame to display values
summary <- data.frame(
Statistic = c("Minimum", "Q1 (25%)", "Median", "Q3 (75%)", "Maximum"),
Value     = c(mins, q1, median, q3, maxs)
)
print(summary)

#Draw a boxplot for 'income'
boxplot(
  hd$income,
  main = "Income",
  ylab = "Income",
  col  = "lightgreen",
  notch = TRUE
)

table(hd$pepticulcer)

hd$pepticulcer <- factor(
  hd$pepticulcer,
  levels = c(1, 2),
  labels = c("Ulcer", "No Ulcer")
)

table(hd$pepticulcer)

stats <- hd %>%
  group_by(pepticulcer) %>%
  summarise(
    Count    = n(),
    Mean_SBP = round(mean(sbp, na.rm = TRUE), 4),
    SD_SBP   = round(sd(sbp,   na.rm = TRUE), 4)
  )

print(stats)
#print is truncating the display of decimals so adding the dataframe method to the print
print(as.data.frame(stats))

help("t.test")
#Looking at the help for t.test, it suggests using the 'formula' approach i.e. lhs ~ rhs where lhs is our data values for sbp
#and rhs is our grouping of pepticulcer i.e. Ulcer or No Ulcer
#also, given the sample, mean and SD in the group counts vary considerably, the Welch 'degrees of freedom' needs applying
tt <- t.test(sbp ~ pepticulcer, data = hd, var.equal = FALSE, conf.level = 0.95)
print(tt)

#p = 0.2296 > 0.05, so we fail to reject Ho


