library(ggplot2)

qplot(displ, hwy, data = mpg, color = drv, shape = drv)

# adding statistics: geom = c("points", "smooth") = add a smoother/'low S' 
# + 'points' plots the data themselves, 'smooth' plots a smooth mean line in blue with an area of 95% confidence interval shaded in dark gray
# + method = "lm" = additional argument method can be specified to create different lines/confidence intervals 
#     * lm = linear regression
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"), method="lm")

# histograms: if only one value is specified, a histogram is produced 
# + fill = factor1 = can be used to fill the histogram with different colors for the subsets (legend automatically generated)
qplot(hwy, data = mpg, fill = drv)

# facets: similar to panels in lattice, split data according to factor variables 
# + facets = rows ~ columns = produce different subplots by factor variables specified (rows/columns)
# + "." indicates there are no addition row or column
# + facets = . ~ columns = creates 1 by col subplots
# + facets = row ~ . = creates row row by 1 subplots
# + labels get generated automatically based on factor variable values
# Scatter Plot w/ Facets
qplot(displ, hwy, data = mpg, facets = . ~ drv)

# Historgram w/ Facets
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)

# density smooth: smooths the histograms into a line tracing its shape
# + geom = "density" = replaces the default scatterplot with density smooth curve
qplot(hwy, data = mpg, geom = "density", color = drv)


# ggplot2 Functions and Parameters
# + basic components of a ggplot2 graphic 
#     * data frame = source of data
#     * aesthetic mappings = how data are mappped to color/size (x vs y)
#     * geoms = geometric objects like points/lines/shapes to put on page
#     * facets = conditional plots using factor variables/multiple panels
#     * stats = statistical transformations like binning/quantiles/smoothing
#     * scales = scale aesthetic map uses (i.e. male = red, female = blue)
#     * coordinate system = system in which data are plotted
# + qplot(x, y, data , color, geom) = quick plot, analogous to base system's plot() function 
#     * default style: gray background, white gridlines, x and y labels automatic, and solid black circles for data points
#     * data always comes from data frame (in unspecified, function will look for data in workspace)
#     * plots are made up of aesthetics (size, shape, color) and geoms (points, lines)
#     * Note: capable of producing quick graphics, but difficult to customize in detail
# + factor variables: important for graphing subsets of data = they should be labelled with specific information, and not just 1, 2, 3 
#     * color = factor1 = use the factor variable to display subsets of data in different colors on the same plot (legend automatically generated)
#     * shape = factor2 = use the factor variable to display subsets of data in different shapes on the same plot (legend automatically generated)
