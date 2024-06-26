library(tidyverse)
library(knitr)
clean <- read_csv("data/clean.csv")

# Overview of NA values in the dataset ----
sapply(clean, function(x) sum(is.na(x)))
# Gender, fulltime, fam_inc, law_school_tier, race, and birth_year have NA values

# Race ----
clean |> 
  drop_na(race) |> 
  ggplot(aes(x = race))+
  geom_bar(fill = "blue", color = "black") +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5) +
  labs(title = "Law School Entrants in 1991: Race",
       x = "Race",
       y = "Number of Students")
ggsave("plots/race_distribution.png")

# pass bar? ----
clean |> 
  ggplot(aes(x = pass_bar)) +
  geom_bar() +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5) +
  labs(title = "Law School Entrants in 1991: Pass Rates",
       x = "Bar Exam Passed",
       y = "Number of Students")
ggsave("plots/pass_bar_distribution.png")

# birthyear/age ----

clean |> 
  filter(birth_year > 1940) |> 
  mutate(age = 1991 - birth_year) |> 
  ggplot(aes(x = age)) +
  geom_histogram(binwidth = 1, fill = "purple", color = "black") +
  labs(title = "Law School Entrants in 1991: Age",
       x = "Age in 1991",
       y = "Number of Students")
ggsave("plots/age_distribution.png")

clean |> 
  filter(birth_year > 1940) |> 
  ggplot(aes(x = birth_year)) +
  geom_bar(fill = "blue", color = "black")


# graduate law school ----
clean |> 
  drop_na(grad) |> 
  ggplot(aes(x = grad))+
  geom_bar() +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5) +
  labs(title = "Law School Entrants in 1991: Graduation Rate",
       x = "Law School Graduate",
       y = "Number of Students")
ggsave("plots/grad_distribution.png")

clean |> 
  drop_na(grad) |> 
  group_by(grad) |> 
  summarize(
    count = n()
  ) |> 
  kable()
# family income ----
clean |> 
  ggplot(aes(x = fam_inc))+
  geom_bar() +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5) +
  labs(title = "Law School Entrants in 1991: Family Income",
       x = "Family Income",
       y = "Number of Students")
ggsave("plots/fam_inc_distribution.png")

# gender ----
clean |> 
  ggplot(aes(x = gender))+
  geom_bar(fill = "yellow")

# ugpa ----
clean |> 
  ggplot(aes(x = ugpa))+
  geom_boxplot(fill = "yellow") +
  labs(title = "Law School Entrants in 1991: Undergraduate GPA",
       x = "Undergraduate GPA")
ggsave("plots/ugpa_distribution.png")

clean |> 
  summarise(
    "Median UGPA" = median(ugpa),
    "Highest UGPA" = max(ugpa),
    "Lowest UGPA" = min(ugpa)) |> 
  kable()

# law school tier ----
clean |> 
  ggplot(aes(x = law_school_tier))+
  geom_bar(fill = "orange") +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5) +
  labs(title = "Law School Entrants in 1991: Law School Tier",
       x = "Law School Tier",
       y = "Number of Students") +
  scale_x_continuous(breaks = unique(clean$law_school_tier))
ggsave("plots/law_tier_distribution.png")

# bar pass attempt ----
clean |> 
  group_by(bar_passed_attempt) |> 
  summarise(n = n()) |> 
  kable()
