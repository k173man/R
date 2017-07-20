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

ggplot(aes(supp, len), data = ToothGrowth) + 
  geom_boxplot(aes(fill = supp)) + facet_grid(. ~ dose) + 
  labs(x = "Supplement", y = "Length", title = "Tooth Growth - OJ vs. VC by Dose")

d05 <- filter(ToothGrowth, dose == .5)
t05 <- t.test(len ~ supp, data = d05)

d10 <- filter(ToothGrowth, dose == 1)
t10 <- t.test(len ~ supp, data = d10)

d20 <- filter(ToothGrowth, dose == 2)
d20oj <- d20$len[d20$supp == "OJ"]; d20vc <- d20$len[d20$supp == "VC"]
t20 <- t.test(d20vc, d20oj)

oj <- filter(ToothGrowth, supp == "OJ")
oj05 <- filter(oj, dose == .5); oj10 <- filter(oj, dose == 1); oj20 <- filter(oj, dose == 2)
tOj10_05 <- t.test(oj10$len, oj05$len)
tOj20_05 <- t.test(oj20$len, oj05$len)
tOj20_10 <- t.test(oj20$len, oj10$len)

vc <- filter(ToothGrowth, supp == "VC")
vc05 <- filter(vc, dose == .5); vc10 <- filter(vc, dose == 1); vc20 <- filter(vc, dose == 2)
tVc10_05 <- t.test(vc10$len, vc05$len)
tVc20_05 <- t.test(vc20$len, vc05$len)
tVc20_10 <- t.test(vc20$len, vc10$len)

