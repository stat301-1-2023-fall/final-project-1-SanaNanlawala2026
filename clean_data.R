library(tidyverse)
bar_pass_prediction <- read_csv("data/bar_pass_prediction.csv")

raw <- bar_pass_prediction
write_csv(raw, "data/raw.csv")
clean <- bar_pass_prediction |> 
  select(ID, gender, DOB_yr, ugpa, lsat, grad, fulltime, fam_inc, tier, race1, pass_bar, bar)
clean <- clean
#Kept Variables:

#ID, keeps each person unique, might remove later
#Gender, distinguishes between male/female.
#DOB_yr, all in the 1900s, some outliers older than the 1920s. 
#ugpa, undergrad gpa
#lsat, score that was scaled (needs to be changed back to raw lsat score)
#grad, did the student graduate law school? (some examples of not graduating but passing the bar)
#fulltime, is the student fulltime.
#fam_inc, separated by tiers (1-5). What is highest? 5?
#tier, what tier law school did the student attend by quintile
#race1, accurate assessment of race without the extra, unnecessary columns,
#pass_bar, most important for analysis.
# bar attempt 

#research was done on this study: the data collected was on students starting law school in 1991.
#Adding the full year to the birth year

clean <- clean |> 
  mutate(DOB_yr = str_c("19", DOB_yr),
         birth_year = as.numeric(DOB_yr)) |> 
  select(!DOB_yr)

#where number values are assigned to yes/no columns, according to trends in the observation:
# 1 = yes ; 0 = no ; 2 = no

clean$fulltime <- ifelse(clean$fulltime == 1, "yes", "no")

clean$pass_bar <- ifelse(clean$pass_bar == 1, "yes", "no")

#rename factors in bar
unique(clean$bar)
# "a Passed 1st time" ; "c Failed" ; "b Passed 2nd time" ; "e non-Grad"
clean <- clean |> 
  mutate(
    bar = fct_recode(bar,
                         "first attempt" = "a Passed 1st time",
                         "no pass" = "c Failed",
                         "second attempt" = "b Passed 2nd time",
                         "no pass" = "e non-Grad"
    )) |> 
  rename(bar_passed_attempt = bar)
  

#rename factors in grad
unique(clean$grad)
# "Y" "X" NA "O"
clean$grad <- ifelse(clean$grad == "Y", "yes", "no")

#rename race1
unique(clean$race1)
#"white" "hisp"  "asian" "black" NA      "other"
clean <- clean |> 
  rename(race = race1)

#rename tier
clean <- clean |> 
  rename(law_school_tier = tier)


write_csv(clean,"data/clean.csv")


