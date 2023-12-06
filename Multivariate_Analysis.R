
library(tidyverse)
library(knitr)

clean <- read_csv("data/clean.csv")
raw<- read_csv("data/raw.csv")


# Grad vs pass_bar ----

clean |>  
  na.omit(clean[c("pass_bar", "grad")]) |> 
ggplot(aes(x = grad, fill = pass_bar)) +
  geom_bar(position = "dodge") +
  geom_text(stat = "count", aes(label = after_stat(count)), position = position_dodge(width = 0.9), vjust = -0.5) +
  labs(title = "Distribution of Law School Graduation Status and Bar Exam Pass Rates",
       x = "Law School Graduate",
       y = "Number of Students",
       fill = "Bar Exam Passed")
ggsave("plots/grad_bar_distribution.png")

# family income and law school tier ----

clean |> 
  na.omit(c("fam_inc", "law_school_tier")) |> 
  group_by(law_school_tier, fam_inc) |> 
  summarise(frequency = n()) |> 
  group_by(fam_inc) |> 
  mutate(proportion = frequency / sum(frequency)) |> 
  ggplot(aes(x = fam_inc, y = proportion, fill = law_school_tier)) +
  geom_bar(stat = "identity") +
  labs(title = "Proportions of Law School Tier by Family Income", 
       y = "Proportion", 
       x = "Family Income") +
  theme_minimal() +
  labs(fill = "Law School Tier")
ggsave("plots/fam_inc_tier_distribution.png")


#Race vs. Family Income ----

race_fam_inc <- clean |> 
  na.omit(clean[c("fam_inc", "race")]) |> 
  group_by(race, fam_inc) |> 
  summarise(frequency = n()) |> 
  group_by(race) |> 
  mutate(proportion = frequency / sum(frequency))

# stacked bar plot
race_fam_inc |> 
ggplot(aes(x = race, y = proportion, fill = fam_inc)) +
  geom_bar(stat = "identity") +
  labs(title = "Proportions of Family Income by Race", y = "Proportion", x = "Race") +
  theme_minimal() +
  labs(fill = "Family Income")
ggsave("plots/race_fam_inc_distribution.png")

# fulltime vs. fam_income ----

## stacked bar plot 
clean |> 
  na.omit(c("fam_inc", "fulltime")) |> 
  ggplot(aes(x = fam_inc, fill = fulltime)) +
  geom_bar(position = "stack", color = "white")+
  coord_flip() +
  labs(title = "Distribution of Family Income by Fulltime Status", 
       y = "Number of Students", 
       x = "Family Income") 
ggsave("plots/fulltime_fam_inc.png")


# lsat scores vs. ugpa ----

# lsat scoes from 1981 (?) to 1991 were on a 10-48 point scale. 
# It is not worth it to scale/convert to today's scales since the tests have gotten much harder.
# very little correlation between ugpa and lsat: 
# weak positive (0.2430694)
clean |> 
  na.omit(clean[c("ugpa", "bar_passed_attempt", "lsat")]) |> 
  ggplot(aes(x = lsat, y = ugpa, color = factor(bar_passed_attempt)))+
  geom_jitter(alpha=0.3) + 
  facet_wrap(~bar_passed_attempt)

cor(clean$ugpa, clean$lsat)


# Bar Status and LSAT ----
clean |> 
  mutate(bar_passed_attempt = factor(
    bar_passed_attempt, levels = c(
      "first attempt", "second attempt", "no pass"))) |> 
  ggplot(aes(x = bar_passed_attempt, y = lsat)) +
  geom_boxplot(fill = "pink") +
  labs(title = "Distribution of LSAT Scores by Bar Passed Attempt",
       x = "Bar Passed Attempt",
       y = "LSAT Score")
ggsave("plots/lsat_bar_attempt.png")

# Bar Status and UGPA ----

clean |> 
  mutate(bar_passed_attempt = factor(
    bar_passed_attempt, levels = c(
      "first attempt", "second attempt", "no pass"))) |> 
  ggplot(aes(x = bar_passed_attempt, y = ugpa)) +
  geom_boxplot(fill = "violet") +
  labs(title = "Distribution of Undergraduate GPAs by Bar Passed Attempt",
       x = "Bar Passed Attempt",
       y = "Undergraduate GPA")
ggsave("plots/ugpa_bar_attempt.png")

