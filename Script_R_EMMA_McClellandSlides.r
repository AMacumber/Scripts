# McClelland Slides

# load in data
dietze <- rbind(mm_bins, emma)  # emma is raw PSA data no headers; mm_bins is the headers
dietze <- t(dietze)

robust <- rbind(mm_bins, EM.rob$loadings$mean)  # EM.rob is the result of robust.EM()
robust <- t(robust)

robust.sd <- t(EM.rob$loadings$sd)  # EM.rob is the result of robust.EM()


# parameters for all slides

# Labeling the grain size ranges
labels_grain_adj = c('Clay', "V Fine", "Fine", "Coarse", "V Fine", "Fine", "Medium", "Coarse", "V Coarse")
labels_grain_group = c('', "Silt", "Silt", "Silt", "Sand", "Sand", "Sand", "Sand", "Sand")

# Coordinates for the above labels
lines_grain_x_coors = c(4, 8, 15, 31, 63 , 125, 250, 500)
labels_grain_x_coors = c(0.4, 5.5, 11, 21, 45 , 90, 175, 350, 1100) 

labels_grain_adj_y_coors = rep(10, length(labels_grain_x_coors))
labels_grain_group_y_coors = rep(9.5, length(labels_grain_x_coors))



### Samples Only - Black

# Create a powerpoint sized window
windows(10, 7.5)

plot(dietze[,1],dietze[,2],  # first column is bin size; second column first sample
     type = "l", col="grey",  
     ylim = c(0,10), ylab = "Frequency (%)",
     xlim = c(0.1,2000), log ="x", xaxt="n", xlab = "",
     
     main = "Harvey Lake Core: Sub Samples")

# add vertical lines to demarcate grain size ranges
abline(v = lines_grain_x_coors, col="grey",lty = 2, lwd = 2)

# add labels for grain size ranges
text(labels_grain_x_coors, labels_grain_adj_y_coors, labels_grain_adj, cex = 0.75)
text(labels_grain_x_coors, labels_grain_group_y_coors, labels_grain_group, cex = 0.75)

# add samples as grey lines
for (i in 3:ncol(dietze)) lines(dietze[,1],dietze[,i],col="black") # plot for every column

# Graph Details
axis (side=1, at = c(0.1,1,10,100,1000)) # add major tick marks
axis (side=1, at = c(seq(0.2,0.9,by = 0.1), seq(2,9, by =1), # add minor tick marks
                     seq(20,90, by = 10), seq(200,900,by=100))
      , labels = NA, tcl=-0.25, lwd=0, lwd.ticks=1) # no labels and shorten tick marks
title(xlab = "Grain size (microns)")

# add a legend
legend(0.1,9,c("Samples","End Member Mean","End Member St. Deviation"), # add a legend at specific spot with labels
       lty=c(1,1,2), col=c("grey","black","black")) # ensure same as lines in plot


### Samples Only - Grey

# Create a powerpoint sized window
windows(10, 7.5)

plot(dietze[,1],dietze[,2],  # first column is bin size; second column first sample
     type = "l", col="grey",  
     ylim = c(0,10), ylab = "Frequency (%)",
     xlim = c(0.1,2000), log ="x", xaxt="n", xlab = "",
     
     main = "Harvey Lake Core: Sub Samples")

# add vertical lines to demarcate grain size ranges
abline(v = lines_grain_x_coors, col="grey",lty = 2, lwd = 2)

# add labels for grain size ranges
text(labels_grain_x_coors, labels_grain_adj_y_coors, labels_grain_adj, cex = 0.75)
text(labels_grain_x_coors, labels_grain_group_y_coors, labels_grain_group, cex = 0.75)

# add samples as grey lines
for (i in 3:ncol(dietze)) lines(dietze[,1],dietze[,i],col="grey") # plot for every column

# Graph Details
axis (side=1, at = c(0.1,1,10,100,1000)) # add major tick marks
axis (side=1, at = c(seq(0.2,0.9,by = 0.1), seq(2,9, by =1), # add minor tick marks
                     seq(20,90, by = 10), seq(200,900,by=100))
      , labels = NA, tcl=-0.25, lwd=0, lwd.ticks=1) # no labels and shorten tick marks
title(xlab = "Grain size (microns)")

# add a legend
legend(0.1,9,c("Samples","End Member Mean","End Member St. Deviation"), # add a legend at specific spot with labels
       lty=c(1,1,2), col=c("grey","black","black")) # ensure same as lines in plot



### First End Member & Samples Grey

# Create a powerpoint sized window
windows(10, 7.5)

plot(dietze[,1],dietze[,2],  # first column is bin size; second column first sample
     type = "l", col="grey",  
     ylim = c(0,10), ylab = "Frequency (%)",
     xlim = c(0.1,2000), log ="x", xaxt="n", xlab = "",
     
     main = "Harvey Lake Core: Robust End Members")

# add vertical lines to demarcate grain size ranges
abline(v = lines_grain_x_coors, col="grey",lty = 2, lwd = 2)

# add labels for grain size ranges
text(labels_grain_x_coors, labels_grain_adj_y_coors, labels_grain_adj, cex = 0.75)
text(labels_grain_x_coors, labels_grain_group_y_coors, labels_grain_group, cex = 0.75)

for (i in 3:ncol(dietze)) lines(dietze[,1],dietze[,i],col="grey") # plot for every column

## The End Member
lines(robust[,1],robust[,2],type="l",col="red",lty = 1, lwd = 2)
lines(robust[,1],robust[,2]-robust.sd[,1],type="l",col="red",lty = 2, lwd = 2)
lines(robust[,1],robust[,2]+robust.sd[,1],type="l",col="red",lty = 2, lwd = 2)

## Graph Details
axis (side=1, at = c(0.1,1,10,100,1000)) # add major tick marks
axis (side=1, at = c(seq(0.2,0.9,by = 0.1), seq(2,9, by =1), # add minor tick marks
                     seq(20,90, by = 10), seq(200,900,by=100))
      , labels = NA, tcl=-0.25, lwd=0, lwd.ticks=1) # no labels and shorten tick marks
title(xlab = "Grain size (microns)")


legend(0.1,9,c("Samples","End Member Mean","End Member St. Deviation"), # add a legend at specific spot with labels
       lty=c(1,1,2), col=c("grey","black","black")) # ensure same as lines in plot


### First, Second End Member & Samples Grey

# Create a powerpoint sized window
windows(10, 7.5)

plot(dietze[,1],dietze[,2],  # first column is bin size; second column first sample
     type = "l", col="grey",  
     ylim = c(0,10), ylab = "Frequency (%)",
     xlim = c(0.1,2000), log ="x", xaxt="n", xlab = "",
     
     main = "Harvey Lake Core: Robust End Members")

# add vertical lines to demarcate grain size ranges
abline(v = lines_grain_x_coors, col="grey",lty = 2, lwd = 2)

# add labels for grain size ranges
text(labels_grain_x_coors, labels_grain_adj_y_coors, labels_grain_adj, cex = 0.75)
text(labels_grain_x_coors, labels_grain_group_y_coors, labels_grain_group, cex = 0.75)

for (i in 3:ncol(dietze)) lines(dietze[,1],dietze[,i],col="grey") # plot for every column

## The End Member 1
lines(robust[,1],robust[,2],type="l",col="red",lty = 1, lwd = 2)
lines(robust[,1],robust[,2]-robust.sd[,1],type="l",col="red",lty = 2, lwd = 2)
lines(robust[,1],robust[,2]+robust.sd[,1],type="l",col="red",lty = 2, lwd = 2)

## The End Member 2
lines(robust[,1],robust[,3],type="l",col="blue",lty = 1, lwd = 2)
lines(robust[,1],robust[,3]-robust.sd[,2],type="l",col="blue",lty = 2, lwd = 2)
lines(robust[,1],robust[,3]+robust.sd[,2],type="l",col="blue",lty = 2, lwd = 2)

## Graph Details
axis (side=1, at = c(0.1,1,10,100,1000)) # add major tick marks
axis (side=1, at = c(seq(0.2,0.9,by = 0.1), seq(2,9, by =1), # add minor tick marks
                     seq(20,90, by = 10), seq(200,900,by=100))
      , labels = NA, tcl=-0.25, lwd=0, lwd.ticks=1) # no labels and shorten tick marks
title(xlab = "Grain size (microns)")

legend(0.1,9,c("Samples","End Member Mean","End Member St. Deviation"), # add a legend at specific spot with labels
       lty=c(1,1,2), col=c("grey","black","black")) # ensure same as lines in plot


### First, Second, Third  End Member & Samples Grey

# Create a powerpoint sized window
windows(10, 7.5)

plot(dietze[,1],dietze[,2],  # first column is bin size; second column first sample
     type = "l", col="grey",  
     ylim = c(0,10), ylab = "Frequency (%)",
     xlim = c(0.1,2000), log ="x", xaxt="n", xlab = "",
     
     main = "Harvey Lake Core: Robust End Members")

# add vertical lines to demarcate grain size ranges
abline(v = lines_grain_x_coors, col="grey",lty = 2, lwd = 2)

# add labels for grain size ranges
text(labels_grain_x_coors, labels_grain_adj_y_coors, labels_grain_adj, cex = 0.75)
text(labels_grain_x_coors, labels_grain_group_y_coors, labels_grain_group, cex = 0.75)

for (i in 3:ncol(dietze)) lines(dietze[,1],dietze[,i],col="grey") # plot for every column

## The End Member 1
lines(robust[,1],robust[,2],type="l",col="red",lty = 1, lwd = 2)
lines(robust[,1],robust[,2]-robust.sd[,1],type="l",col="red",lty = 2, lwd = 2)
lines(robust[,1],robust[,2]+robust.sd[,1],type="l",col="red",lty = 2, lwd = 2)

## The End Member 2
lines(robust[,1],robust[,3],type="l",col="blue",lty = 1, lwd = 2)
lines(robust[,1],robust[,3]-robust.sd[,2],type="l",col="blue",lty = 2, lwd = 2)
lines(robust[,1],robust[,3]+robust.sd[,2],type="l",col="blue",lty = 2, lwd = 2)

## The End Member 2
lines(robust[,1],robust[,4],type="l",col="green",lty = 1, lwd = 2)
lines(robust[,1],robust[,4]-robust.sd[,3],type="l",col="green",lty = 2, lwd = 2)
lines(robust[,1],robust[,4]+robust.sd[,3],type="l",col="green",lty = 2, lwd = 2)

## Graph Details
axis (side=1, at = c(0.1,1,10,100,1000)) # add major tick marks
axis (side=1, at = c(seq(0.2,0.9,by = 0.1), seq(2,9, by =1), # add minor tick marks
                     seq(20,90, by = 10), seq(200,900,by=100))
      , labels = NA, tcl=-0.25, lwd=0, lwd.ticks=1) # no labels and shorten tick marks
title(xlab = "Grain size (microns)")

legend(0.1,9,c("Samples","End Member Mean","End Member St. Deviation"), # add a legend at specific spot with labels
       lty=c(1,1,2), col=c("grey","black","black")) # ensure same as lines in plot


### First, Second, Third  End Member

# Create a powerpoint sized window
windows(10, 7.5)

plot(robust[,1],robust[,2],  # first column is bin size; second column first sample
     type = "l", col="red",  
     ylim = c(0,10), ylab = "Frequency (%)",
     xlim = c(0.1,2000), log ="x", xaxt="n", xlab = "",
     
     main = "Harvey Lake Core: Robust End Members")

# add vertical lines to demarcate grain size ranges
abline(v = lines_grain_x_coors, col="grey",lty = 2, lwd = 2)

# add labels for grain size ranges
text(labels_grain_x_coors, labels_grain_adj_y_coors, labels_grain_adj, cex = 0.75)
text(labels_grain_x_coors, labels_grain_group_y_coors, labels_grain_group, cex = 0.75)

## End Member 1
#text(5, )

## The End Member 2
lines(robust[,1],robust[,3],type="l",col="blue",lty = 1, lwd = 2)

## The End Member 2
lines(robust[,1],robust[,4],type="l",col="green",lty = 1, lwd = 2)

## Graph Details
axis (side=1, at = c(0.1,1,10,100,1000)) # add major tick marks
axis (side=1, at = c(seq(0.2,0.9,by = 0.1), seq(2,9, by =1), # add minor tick marks
                     seq(20,90, by = 10), seq(200,900,by=100))
      , labels = NA, tcl=-0.25, lwd=0, lwd.ticks=1) # no labels and shorten tick marks
title(xlab = "Grain size (microns)")

legend(0.1,9,  # coordinates
       c("Fine Silt EM (5 microns; 21%)", "Coarse Silt EM (27 microns; 42%)", "Very Coarse Silt EM (58 Microns; 33%)"), 
       lty=c(1,1,1),  # thickness
       col=c("red","blue","green"),  # colour
       cex = 0.8) 




