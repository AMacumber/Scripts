
### Basic Biplot in R


### Set working directory
setwd("C:/Users/Andy/Dropbox/FactoryFloor/Offline/HarveyLake/Chapter01_Surface")
###


### Import Data
#
# Station depth and freqency of wave base mixing
depth_frequency <- read.csv(file = "Mazzella_Chap01_Biplot_DataDepthProbability.csv"
                            , fileEncoding="UTF-8-BOM"
                            , row.names = 1)
###


### Window
windows()
###


### Set Plot Parameters
#
# X-axis
xticks <- seq(0,12, by = 2)
#
# Y-axis
yticks <- seq(0,40, by = 5)
###


### Biplot
plot(depth_frequency
     , pch = 20
     , xlim = c(0,12),xaxt = "n", xlab = ""
     , ylim = c(0,40), yaxt = "n", ylab="")
axis(1, at=xticks, labels=xticks)
axis(2, at = yticks, labels = yticks)
title(xlab="Depth (m)", ylab = "Probability of Mixing (%)", main="Probality of Wave Base Mixing")
abline(h = 3.4, lty = 3)
legend(8,38, legend = c("Harvey Lake Stations", "Deposition Cutoff (3.4%)")
       , pch = c(20,NA), lty = c(NA, 3), y.intersp =2)
###