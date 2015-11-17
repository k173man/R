# ****** Part 2 *****
#   Now in the second portion of the class, we're going to analyze the ToothGrowth data in the R datasets package. 
# 1.Load the ToothGrowth data and perform some basic exploratory data analyses 
# 2.Provide a basic summary of the data.
# 3.Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. (Only use the techniques from class, even if there's other approaches worth considering)
# 4.State your conclusions and the assumptions needed for your conclusions. 
# 
# ***** Evaluation - Part 2 *****
# Did the student perform an exploratory data analysis of at least a single plot or table highlighting basic features of the data?
# Did the student perform some relevant confidence intervals and/or tests?
# Did the student perform some relevant confidence intervals and/or tests?
# Did the student describe the assumptions needed for their conclusions?

library(dplyr)

data("ToothGrowth")

coplot(
  len ~ dose | supp, 
  data = ToothGrowth, 
  panel = panel.smooth,
  xlab = "ToothGrowth data: length vs dose, given type of supplement"
)

cnts <- ToothGrowth %>% 
  mutate(obs = 1) %>% 
  group_by(supp, dose) %>% 
  summarize(Total = sum(obs))

xtabs(len ~ supp + dose, data = ToothGrowth)/10

