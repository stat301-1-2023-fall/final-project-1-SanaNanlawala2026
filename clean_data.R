library(tidyverse)
bar_pass_prediction <- read_csv("data/bar_pass_prediction.csv")

raw <- bar_pass_prediction
#write_csv(raw, "raw.csv")
clean <- bar_pass_prediction |> 
  select(ID, gender, DOB_yr, ugpa, lsat, grad, fulltime, fam_inc, tier, race1, sex, pass_bar)

#Kept Variables:

#ID, keeps each person unique, might remove later
#Gender, distinguishes between male/female, will cross-reference with sex (1=female, 2=male).
#DOB_yr, all in the 1900s, some outliers older than the 1920s. 
#ugpa, undergrad gpa
#lsat, score that was scaled (needs to be changed back to raw lsat score)
#grad, did the student graduate law school? (some examples of not graduating but passing the bar)
#fulltime, is the student fulltime.
#fam_inc, separated by tiers (1-5). What is highest? 5?
#tier, what tier law school did the student attend by quintile
#race1, accurate assessment of race without the extra, unnecessary columns,
#sex, assigns number to sex, only keeping for cross-reference with gender,
#pass_bar, most important for analysis.

#research was done on this study: the data collected was on students starting law school in 1991.

clean <- clean |> 
  mutate(DOB_yr = str_c("19", DOB_yr),
         birth_year = as.numeric(DOB_yr)) |> 
  select(!DOB_yr)

#where number values are assigned to yes/no columns, according to trends in the observation:
# 1 = yes ; 0 = no ; 2 = no

clean$fulltime <- ifelse(clean$fulltime == 1, "yes", "no")

clean$pass_bar <- ifelse(clean$pass_bar == 1, "yes", "no")


