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


#States that do not require you to GO to law school to take the bar exam: 
#California, Vermont, Virginia, Washington

#States that require SOME law school (applicable to this dataset):
#New York, Maine, West Virginia