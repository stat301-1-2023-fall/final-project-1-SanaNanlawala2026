library(tidyverse)
clean <- read_csv("data/clean.csv")

#race
clean |> 
  ggplot(aes(x = race))+
  geom_bar(fill = "pink", color = "black")
ggsave("plots/race_distribution.png")
#pass bar?
clean |> 
  ggplot(aes(x = pass_bar)) +
  geom_bar()
ggsave("plots/pass_bar_distribution.png")

#birthyear
clean |> 
  filter(birth_year > 1940) |> 
  ggplot(aes(x = birth_year)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black")

clean |> 
  filter(birth_year > 1940) |> 
  ggplot(aes(x = birth_year)) +
  geom_bar( fill = "blue", color = "black")
ggsave("plots/birth_year_distribution.png")

#graduate law school
clean |> 
  ggplot(aes(x = grad))+
  geom_bar()
ggsave("plots/grad_distribution.png")

#family income
clean |> 
  ggplot(aes(x = fam_inc))+
  geom_bar()
ggsave("fam_inc/grad_distribution.png")


