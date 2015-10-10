# installing/loading the package:
if(!require(installr)) {
    install.packages("installr")
    require(installr)
}

# this will check for newer versions, and if one is available, will guide you through the decisions you'd need to make
updateR()