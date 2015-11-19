library(ggplot2)
# the maacs dataset is not available
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point(alpha = 1/3) 					        # adds points
    + facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4)     # make panels
    + geom_smooth(method="lm", se=FALSE, col="steelblue") # adds smoother
    + theme_bw(base_family = "Avenir", base_size = 10)    # change theme
    + labs(x = expression("log " * PM[2.5]))   		    # add labels
    + labs(y = "Nocturnal Symptoms")
    + labs(title = "MAACS Cohort")

# ggplot
# + built up in layers/modularly (similar to base plotting system)
#     * data => overlay summary => metadata/annotation
# + g <- ggplot(data, aes(var1, var2))
#     * initiates call to ggplot and specifies the data frame that will be used
#     * aes(var1, var2) = specifies aesthetic mapping, or var1 = x variable, and var2 = y variable
#     * summary(g) = displays summary of ggplot object
#     * print(g) = returns error ("no layer on plot") which means the plot does know how to draw the data yet
# + g <- g + geom_point() = takes information from g object and produces scatter plot
# + g <- g + geom_smooth() = adds low S mean curve with confidence interval
#     * method = "lm" = changes the smooth curve to be linear regression
#     * size = 4, linetype = 3 = can be specified to change the size/style of the line
#     * se = FALSE = turns off confidence interval
# + g <- g + facet_grid(row ~ col) = splits data into subplots by factor variables (see facets from qplot())
#     * conditioning on continous variables is possible through cutting/making a new categorical variable
#     * cutPts <- quantiles(df$cVar, seq(0, 1, length=4), na.rm = TRUE) = creates quantiles where the continuous variable will be cut
#         - seq(0, 1, length=4) = creates 4 quantile points
#         - na.rm = TRUE = removes all NA values
#     * df$newFactor <- cut(df$cVar, cutPts) = creates new categorical/factor variable by using the cutpoints
#         - creates n-1 ranges from n points = in this case 3
# + annotations
#     * xlab(), ylab(), labs(), ggtitle() = for labels and titles
#         - labs(x = expression("log " * PM[2.5]), y = "Nocturnal") = specifies x and y labels
#         _ expression() = used to produce mathematical expressions
#     * geom functions = many options to modify
#     * theme() = for global changes in presentation
#         - ***example***: theme(legend.position = "none")
#     * two standard themes defined: theme_gray() and theme_bw()
#     * base_family = "Times" = changes font to Times
# + aesthetics
#         * + geom_point(color, size, alpha) = specifies how the points are supposed to be plotted on the graph (style)
#         * ***Note**: this translates to geom_line()/other forms of plots *
#         * color = "steelblue" = specifies color of the data points
#         * aes(color = var1) = wrapping color argument this way allows a factor variable to be assigned to the data points, thus subsetting it with different colors based on factor variable values
#         * size = 4 = specifies size of the data points
#         * alpha = 0.5 = specifies transparency of the data points