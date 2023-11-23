
library(tidyverse)
library(knitr)

clean <- read_csv("data/clean.csv")
raw<- read_csv("data/raw.csv")
#States that do not require you to GO to law school to take the bar exam: 
#California, Vermont, Virginia, Washington

#States that require SOME law school (applicable to this dataset):
#New York, Maine, West Virginia

#grad vs pass_bar
grad_bar_cleaned <- na.omit(clean[c("pass_bar", "grad")])
grad_bar_cleaned |> 
ggplot(aes(x = grad, fill = pass_bar)) +
  geom_bar(position = "dodge")
ggsave("plots/grad_bar_distribution.png")

grad_bar_cleaned |> 
  group_by(pass_bar,grad) |> 
  summarize(count = n()) |> 
  kable()

#family income and law school tier
#law school tiers (1 is the highest) is established by clusers 1-6 with ugpas and lsat scores
#highest to lowest. 
fam_inc_tier <- na.omit(clean[c("fam_inc", "law_school_tier")])

fam_inc_tier |> 
  group_by(fam_inc)  |> 
  summarize(count = n()) |> 
  kable()

fam_inc_tier |> 
  group_by(law_school_tier)  |> 
  summarize(count = n()) |> 
  kable()

fam_inc_tier |> 
  group_by(law_school_tier,fam_inc) |> 
  summarize(count = n()) |> 
  print(n = 30)

fam_inc_tier |> 
  ggplot(aes(x = fam_inc)) +
  geom_histogram() +
  facet_wrap(~law_school_tier)
ggsave("plots/fam_inc_tier_distribution.png")


#Race vs. Family Income
race_fam_inc <- na.omit(clean[c("fam_inc", "race")])

race_fam_inc |> 
  ggplot(aes(x = race, y = fam_inc)) +
  geom_boxplot()
ggsave("plots/race_fam_inc_distribution.png")

# fulltime vs. fam_income
fulltime_fam_inc <- na.omit(clean[c("fam_inc", "fulltime")])

fulltime_fam_inc |> 
  ggplot(aes(x = fulltime, y = fam_inc)) +
  geom_boxplot()
ggsave("plots/fulltime_fam_inc.png")
