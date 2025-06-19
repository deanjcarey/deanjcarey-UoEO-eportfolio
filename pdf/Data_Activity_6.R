#Numercial Analysis Module - Dean Carey
#Data Activity 6
#Find out whether median diastolic blood pressure is same among diabetic and non-diabetic participants.

#Checking normality of sample data first to determine whether parametric or nonparametric tests are
#best choice to interpret BP results

h <- hist(
  hd$dbp,
  breaks = 20,
  freq   = TRUE,                # use counts on the y‐axis
  main   = "Histogram of Diastolic BP",
  xlab   = "Diastolic BP (mm Hg)",
  ylab   = "Count",
  col    = "lightblue",
  border = "white"
)

#Extract mid‐points and counts
midpoints <- h$mids
counts    <- h$counts

#Add a smooth trend line through the counts
lines(
  midpoints,
  lowess(midpoints, counts)$y,  # smoothed counts
  col    = "red",
  lwd    = 2
)

str(hd$diabetes)

#The distribution of BP is slightly right-skewed - shows a tail toward higher values.
#The bars don't form a symmetric bell shape therefore we can say the data does not show normality.

#Split into diabetic vs. non-diabetic
diab <- hd$dbp[hd$diabetes == 1]    # diabetics
non_diab <- hd$dbp[hd$diabetes == 2]    # non-diabetics

n1 <- length(diab)
n2 <- length(non_diab)

#Calc medians
med_diab <- median(diab, na.rm = TRUE)
med_non_diab <- median(non_diab, na.rm = TRUE)

#Rank all values
all_vals <- c(diab, non_diab)
ranks   <- rank(all_vals)

#Calc sum of ranks for group 1
R1 <- sum(ranks[1:n1])

#Calc U1 and U2
U1 <- n1 * n2 + n1 * (n1 + 1) / 2 - R1
U2 <- n1 * n2 - U1
U  <- min(U1, U2)

#Wilcox test (Mann-Whitney)
test <- wilcox.test(diab, non_diab, ediabact = FALSE, correct = FALSE)

#Results
cat("n1 =", n1, "  n2 =", n2, "\n")
cat("Median dbp (diabetic): ", med_diab, "mm Hg\n")
cat("Median dbp (non-diabetic):", med_non_diab, "mm Hg\n\n")

cat("R1 =", R1, "\n")
cat("U1 =", U1, "  U2 =", U2, "\n")
cat("U =", U, "\n")
cat("Observed U =", test$statistic, "\n")
cat("p-value =", format.pval(test$p.value), "\n")
