#Numerical Analysis Module - Dean Carey
#HSE 2011 Dataset - Assessment 1 (Unit 12)

#Prevent scientific notation in outputs
options(scipen = 999, digits = 4)

#Install and load required packages
#install.packages(c("haven", "dplyr", "ggplot2","gt","forcats","multcomp","patchwork"))

library(tidyverse)   # includes dplyr, ggplot2, tidyr, forcats, etc.
library(haven)
library(gt)
library(multcomp)
library(patchwork)

#Read data
hse <- read_sav(
  "C:/Users/deanc/OneDrive/Documents/Data Science/Module 2 - Numerical Analysis/HSE 2011.sav"
)

#Full sample size
N_full <- nrow(hse)  # should be 10617

#Recode drinking status (using dnnow: 1 = drinker, 2 = non-drinker)
hse <- hse %>%
  mutate(
    drink_status = case_when(
      dnnow == 1 ~ "Drinker",
      dnnow == 2 ~ "Non-drinker",
      TRUE       ~ "Missing"
    )
  )

#Recode gender (1 = Male, 2 = Female)
hse <- hse %>%
  mutate(
    gender = case_when(
      Sex == 1 ~ "Male",
      Sex == 2 ~ "Female",
      TRUE     ~ "Missing"
    )
  )

#Recode highest qualification as factor including “Missing”
hse <- hse %>%
  mutate(
    education_f = as_factor(topqual3) %>% 
      fct_explicit_na(na_level = "Missing")
  )

#Recode marital status as factor
hse <- hse %>%
  mutate(
    marital_f     = as_factor(marstatc) %>% 
      fct_explicit_na(na_level = "Missing"),
    marital_group = fct_collapse(
      marital_f,
      `Divorced/Separated` = c("Separated", "Divorced"),
      Other                = setdiff(levels(marital_f), 
                                     c("Separated", "Divorced", "Missing"))
    )
  )

#Calculate counts, % and labels for drinking status
drink_counts <- hse %>%
  count(drink_status) %>%
  mutate(
    percent = n / N_full * 100,
    label   = paste0(n, " (", sprintf("%.1f%%", percent), ")")
  )

#Pie chart for Drinkers vs Non-drinkers vs Missing with counts and %
ggplot(drink_counts, aes(x = "", y = percent, fill = drink_status)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  geom_text(aes(label = label), position = position_stack(vjust = 0.5)) +
  labs(
    title = paste0("Drinking Status (N = ", N_full, ")"),
    fill  = "Status"
  ) +
  theme_void()

#Calculate counts, % and labels for gender breakdown
gender_counts <- hse %>%
  count(gender) %>%
  mutate(
    percent = n / N_full * 100,
    label   = paste0(n, " (", sprintf("%.1f%%", percent), ")")
  )

#Bar chart for gender breakdown with counts and %
ggplot(gender_counts, aes(x = gender, y = percent, fill = gender)) +
  geom_col() +
  geom_text(aes(label = label), vjust = -0.5) +
  labs(
    title = paste0("Gender Breakdown (N = ", N_full, ")"),
    x     = "Gender",
    y     = "Percent of sample"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

###########################################

# — Education distribution —

#Count, percentage and label
edu_counts <- hse %>%
  count(education_f) %>%
  arrange(desc(n)) %>%
  mutate(
    percent = n / N_full * 100,
    label   = paste0(n, " (", sprintf("%.1f%%", percent), ")")
  )

#Horizontal bar chart
ggplot(edu_counts, aes(x = reorder(education_f, n), y = n, fill = education_f)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = label), hjust = 1.1) +
  labs(
    title = paste0("Highest Qualification (N = ", N_full, ")"),
    x     = "Qualification",
    y     = "Count"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

###########################################

# — Marital status: Divorced/Separated vs Other —

#Count, percentage and label
mar_counts <- hse %>%
  count(marital_group) %>%
  mutate(
    percent = n / N_full * 100,
    label   = paste0(n, " (", sprintf("%.1f%%", percent), ")"),
    ypos    = cumsum(percent) - 0.5 * percent
  )

#Donut chart
ggplot(mar_counts, aes(x = 2, y = percent, fill = marital_group)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  xlim(0.5, 2.5) +
  geom_text(aes(x = 2, y = ypos, label = label), color = "white") +
  labs(
    title = paste0("Divorced or Separated vs Other (N = ", N_full, ")"),
    fill  = ""
  ) +
  theme_void()

###########################################

# Summary stats

#Create custom mode function (to account for ties)
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

#Calculate summary statistics for each variable
summary_df <- data.frame(
  Variable = c("Household size", "BMI", "Age"),
  Mean     = c(
    mean(hse$HHSize, na.rm = TRUE),
    mean(hse$bmival, na.rm = TRUE),
    mean(hse$Age, na.rm = TRUE)
  ),
  Median   = c(
    median(hse$HHSize, na.rm = TRUE),
    median(hse$bmival, na.rm = TRUE),
    median(hse$Age, na.rm = TRUE)
  ),
  Mode     = c(
    get_mode(hse$HHSize),
    get_mode(hse$bmival),
    get_mode(hse$Age)
  ),
  Minimum  = c(
    min(hse$HHSize, na.rm = TRUE),
    min(hse$bmival, na.rm = TRUE),
    min(hse$Age, na.rm = TRUE)
  ),
  Maximum  = c(
    max(hse$HHSize, na.rm = TRUE),
    max(hse$bmival, na.rm = TRUE),
    max(hse$Age, na.rm = TRUE)
  ),
  Range    = c(
    diff(range(hse$HHSize, na.rm = TRUE)),
    diff(range(hse$bmival, na.rm = TRUE)),
    diff(range(hse$Age, na.rm = TRUE))
  ),
  SD       = c(
    sd(hse$HHSize, na.rm = TRUE),
    sd(hse$bmival, na.rm = TRUE),
    sd(hse$Age, na.rm = TRUE)
  ),
  stringsAsFactors = FALSE
)

#Build the table using gt library
tbl <- gt(summary_df) %>%
  cols_width(
    c(Variable) ~ px(200),
    everything() ~ px(80)
  ) %>%
  cols_align(
    align   = "right",
    columns = c("Mean", "Median", "Mode", "Minimum", "Maximum", "Range", "SD")
  ) %>%
  tab_style(
    style = cell_borders(
      sides  = "all",
      color  = "grey80",
      weight = px(1)
    ),
    locations = cells_body()
  ) %>%
  tab_style(
    style     = cell_text(weight = "bold"),
    locations = cells_column_labels()
  ) %>%
  cols_label(
    Variable = "Measure",
    Mean     = "Mean",
    Median   = "Median",
    Mode     = "Mode",
    Minimum  = "Min",
    Maximum  = "Max",
    Range    = "Range",
    SD       = "SD"
  ) %>%
  tab_header(
    title    = "Descriptive Statistics",
    subtitle = md("Household size, BMI & Age (N = 10,617)")
  )

# Print the table
print(tbl)

#########################################

#Inferential Statistics

#########################################

#Calc means and CIs
gender_stats <- hse %>%
  filter(!is.na(totalwu), Sex %in% c(1,2)) %>%
  mutate(gender = if_else(Sex==1, "Male", "Female")) %>%
  group_by(gender) %>%
  summarise(
    mean_units = mean(totalwu, na.rm=TRUE),
    se         = sd(totalwu, na.rm=TRUE)/sqrt(n()),
    lower      = mean_units - qt(0.975, df=n()-1)*se,
    upper      = mean_units + qt(0.975, df=n()-1)*se
  )

#Plot data
ggplot(gender_stats, aes(x=gender, y=mean_units, fill=gender)) +
  geom_col() +
  geom_errorbar(aes(ymin=lower, ymax=upper), width=0.2) +
  geom_text(aes(label=sprintf("%.1f", mean_units)), vjust=-0.5) +
  labs(
    title="Mean Weekly Alcohol Units by Gender",
    x="Gender", y="Units per week"
  ) +
  theme_minimal() +
  theme(legend.position="none")

#####################################

#Get 'region' factor from gor1
hse_reg <- hse %>%
  filter(!is.na(totalwu), !is.na(gor1)) %>%
  mutate(region = as_factor(gor1))

#Run ANOVA and Tukey HSD for pairwise letters
aov1    <- aov(totalwu ~ region, data = hse_reg)
tuk     <- glht(aov1, linfct = mcp(region = "Tukey"))
letters <- multcomp::cld(tuk)$mcletters$Letters

#Summarise means, SEs, n_obs and attach letters
region_means <- hse_reg %>%
  group_by(region) %>%
  summarise(
    mean_units = mean(totalwu, na.rm = TRUE),
    n_obs      = n(),
    se         = sd(totalwu, na.rm = TRUE) / sqrt(n())
  ) %>%
  ungroup() %>%
  mutate(letter = letters[as.character(region)]) %>%
  arrange(desc(mean_units))

#Calc the x-position for letters - the standard output kept obscuring the Tukey letters
region_means <- region_means %>%
  mutate(
    ci_upper = mean_units + qt(0.975, df = n_obs - 1) * se,
    letter_x = ci_upper + 0.3
  )

#Plot data
ggplot(region_means, aes(x = mean_units, y = reorder(region, mean_units))) +
  geom_col(fill = "steelblue") +
  geom_errorbarh(aes(
    xmin = mean_units - qt(0.975, df = n_obs - 1) * se,
    xmax = ci_upper
  ), height = 0.2) +
  geom_text(aes(label = sprintf("%.2f", mean_units)), 
            hjust = -0.1, size = 3) +
  geom_text(aes(x = letter_x, label = letter), 
            hjust = 0, size = 3, fontface = "bold") +
  coord_cartesian(xlim = c(0, max(region_means$letter_x) + 0.5)) +
  labs(
    title   = "Mean Weekly Alcohol Units by Region",
    x       = "Units per week",
    y       = "Region",
    caption = sprintf("Note: Total sample N = %d; valid responses n = %d", 
                      nrow(hse), nrow(hse_reg))
  ) +
  theme_minimal()

##############################

#Calc group means and t-tests
height_stats <- hse %>%
  filter(gender %in% c("Male","Female")) %>%
  group_by(gender) %>%
  summarise(
    mean_ht = mean(htval, na.rm = TRUE),
    .groups = "drop"
  )

t_height <- t.test(htval ~ gender, data = hse)

weight_stats <- hse %>%
  filter(gender %in% c("Male","Female")) %>%
  group_by(gender) %>%
  summarise(
    mean_wt = mean(wtval, na.rm = TRUE),
    .groups = "drop"
  )

t_weight <- t.test(wtval ~ gender, data = hse)

#Plot boxplots
p_height <- ggplot(hse, aes(x = gender, y = htval, fill = gender)) +
  geom_boxplot() +
  geom_text(
    data = height_stats,
    aes(x = gender, y = mean_ht, label = sprintf("%.1f cm", mean_ht)),
    vjust = -0.5, size = 3
  ) +
  labs(title = "Height by Gender", x = NULL, y = "Height (cm)") +
  theme_minimal() +
  theme(legend.position = "none")

p_weight <- ggplot(hse, aes(x = gender, y = wtval, fill = gender)) +
  geom_boxplot() +
  geom_text(
    data = weight_stats,
    aes(x = gender, y = mean_wt, label = sprintf("%.1f kg", mean_wt)),
    vjust = -0.5, size = 3
  ) +
  labs(title = "Weight by Gender", x = NULL, y = "Weight (kg)") +
  theme_minimal() +
  theme(legend.position = "none")

#Combine plots and annotate with t-test results
p_height + p_weight +
  plot_annotation(
    title    = "Gender Differences in Height and Weight",
    subtitle = sprintf(
      "Height: t(%.0f) = %.2f, p = %.3f   |   Weight: t(%.0f) = %.2f, p = %.3f",
      t_height$parameter, t_height$statistic, t_height$p.value,
      t_weight$parameter, t_weight$statistic, t_weight$p.value
    )
  )

#############################################

#Build correlation data frame
hse_corr <- hse %>%
  dplyr::mutate(
    Drinking = if_else(dnnow == 1, 1, 0),
    Gender   = if_else(gender == "Male", 1, 0),
    Income   = totinc
  ) %>%
  dplyr::filter(
    !is.na(Drinking), !is.na(Income),
    !is.na(Age),      !is.na(Gender)
  ) %>%
  dplyr::select(Drinking, Income, Age, Gender)

#Create correlation
corr_mat <- round(cor(hse_corr), 3)

#Reshape matrix and keep only unique pairs
vars    <- colnames(corr_mat)
corr_df <- as.data.frame(as.table(corr_mat))
names(corr_df) <- c("Var1", "Var2", "r")

corr_df <- corr_df %>%
  dplyr::filter(Var1 != Var2) %>%  # Remove self-correlations so only unique pairs remain
  dplyr::mutate(
    Var1 = factor(Var1, levels = vars),
    Var2 = factor(Var2, levels = vars)
  )

#Plot correlation
ggplot(corr_df, aes(x = Var2, y = Var1, fill = r)) +
  geom_tile(colour = "black", linewidth = 0.3) +
  geom_text(aes(label = sprintf("%.3f", r)), size = 3) +
  scale_fill_gradient2(
    low      = "blue",
    mid      = "grey90",
    high     = "red",
    midpoint = 0,
    limits   = c(-1, 1),
    name     = "r"
  ) +
  labs(
    x       = NULL,
    y       = NULL,
    caption = sprintf("Valid cases n = %d (of N = %d)", nrow(hse_corr), nrow(hse))
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid  = element_blank()
  )
