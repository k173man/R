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
library(ggplot2)

data("ToothGrowth")

# coplot(
#   len ~ dose | supp, 
#   data = ToothGrowth, 
#   panel = panel.smooth,
#   xlab = "ToothGrowth data: length vs dose, given type of supplement"
# )

# qplot(supp, len, data = ToothGrowth, facets = . ~ dose, geom = "boxplot", 
#       main = "Tooth Growth\r\nOJ vs. VC by Dose", 
#       xlab = "Supplement", ylab = "Length"
# )

ggplot(aes(supp, len), data = ToothGrowth) + 
  geom_boxplot(aes(fill = supp)) + facet_wrap(~ dose) + 
  labs(x = "Supplement", y = "Length", title = "Tooth Growth - OJ vs. VC by Dose")

dose05 <- filter(ToothGrowth, dose == .5)
t05 <- t.test(len ~ supp, data = dose05)

dose10 <- filter(ToothGrowth, dose == 1)
t10 <- t.test(len ~ supp, data = dose10)

dose20 <- filter(ToothGrowth, dose == 2)
t20 <- t.test(len ~ supp, data = dose20)

t05$p.values
t05$conf.int[1]
t05$conf.int[2]
t05$null.value
t05$alternative
t05$statistic[[1]]
names(t05$statistic)



