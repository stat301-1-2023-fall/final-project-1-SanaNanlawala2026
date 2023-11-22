

#States that do not require you to GO to law school to take the bar exam: 
#California, Vermont, Virginia, Washington

#States that require SOME law school (applicable to this dataset):
#New York, Maine, West Virginia

#grad vs pass_bar
grad_bar_cleaned <- na.omit(clean[c("pass_bar", "grad")])
grad_bar_cleaned |> 
ggplot(aes(x = grad, fill = pass_bar)) +
  geom_bar(position = "dodge", color = "black")
