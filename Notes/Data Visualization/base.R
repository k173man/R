library(datasets)

# Note: typing example(points) in R will launch a demo of base plotting system and may provide some helpful tips on graphing 

# type =“n” sets up the plot and does not fill it with data
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
# subsets of data are plotted here using different colors
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))
model <- lm(Ozone ~ Wind, airquality)
# regression line is produced here
abline(model, lwd = 2)

# Multiple Plot Example
# this expression sets up a plot with 1 row 3 columns, sets the margin and outer margins
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
    # here three plots are filled in with their respective titles
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main = "Ozone and Temperature")
    # this adds a line of text in the outer margin*
    mtext("Ozone and Weather in New York City", outer = TRUE)}
)


# Base Graphics Functions and Parameters
# + arguments 
#     * pch: plotting symbol (default = open circle)
#     * lty: line type (default is solid)
#         - 0=blank, 1=solid (default), 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash
#     * lwd: line width (integer)
#     * col: plotting color (number string or hexcode, colors() returns vector of colors)
#     * xlab, ylab: x-y label character strings
#     * cex: numerical value giving the amount by which plotting text/symbols should be magnified relative to the default
#         - cex = 0.15 * variable: plot size as an additional variable
# 
# + par() function = specifies global graphics parameters, affects all plots in an R session (can be overridden) 
#     * las: orientation of axis labels
#     * bg: background color
#     * mar: margin size (order = bottom left top right)
#     * oma: outer margin size (default = 0 for all sides)
#     * mfrow: number of plots per row, column (plots are filled row-wise)
#     * mfcol: number of plots per row, column (plots are filled column-wise)
#     * can verify all above parameters by calling par("parameter")
# 
# + plotting functions 
#     * lines: adds liens to a plot, given a vector of x values and corresponding vector of y values
#     * points: adds a point to the plot
#     * text: add text labels to a plot using specified x,y coordinates
#     * title: add annotations to x,y axis labels, title, subtitles, outer margin
#     * mtext: add arbitrary text to margins (inner or outer) of plot
#     * axis: specify axis ticks
