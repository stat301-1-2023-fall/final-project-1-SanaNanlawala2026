library(tidyverse)
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

# birthyear ----
clean |> 
  filter(birth_year > 1940) |> 
  ggplot(aes(x = birth_year)) +
  geom_histogram(binwidth = 1, fill = "purple", color = "black") +
  labs(title = "Law School Entrants in 1991: Birth Year",
       x = "Birth Year",
       y = "Number of Students")
ggsave("plots/birth_year_distribution.png")

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

# family income ----
clean |> 
  ggplot(aes(x = fam_inc))+
  geom_bar()
ggsave("fam_inc/grad_distribution.png")

# gender ----
clean |> 
  ggplot(aes(x = gender))+
  geom_bar()

# ugpa ----
clean |> 
  ggplot(aes(x = ugpa))+
  geom_bar()

# as a density plot
clean |> 
  ggplot(aes(x = ugpa))+
  geom_density(fill = "pink")

clean |> 
  summarise(
    "Mean UGPA" = mean(ugpa),
    "Highest UGPA" = max(ugpa),
    "Lowest UGPA" = min(ugpa)) |> 
  kable()


