################################################################
## Statistical Significance Tests for Arcellinida Enumeration ##
################################################################


### Load Data (v000)
library(RMySQL)
#
mydb = dbConnect(MySQL(), user= 'root'
                 , password = 'password'
                 , dbname='carletondb', host = 'localhost')
#
dbListTables(mydb)
#
rs = dbSendQuery(mydb, "select * from results_arcellinida")
#
arc_v000 = fetch(rs, n=-1)
##
rm(mydb, rs)
###


### Data Wrangling (v003)
##
# Set depth as index, remove depth column
depth <- arc_v000$depth_cm
rownames(arc_v000) <- depth
arc_v000$depth_cm <- NULL
##
##
# Remove non species columns
arc_v001 <- arc_v000[,-c(1:5)]
##
##
# Check data types
sapply(arc_v001, mode) # they are type character
#
# Transform to numeric
arc_v002 <- as.data.frame(lapply(arc_v001, function(x) as.numeric(as.character(x))))
rownames(arc_v002) <- depth
##
##
# Check for zero sum species columns and remove
spe_zero <- colSums(arc_v002) > 0
arc_v003 <- arc_v002[spe_zero]
##
arc_counts <- arc_v003
##
# Remove objects that are no longer needed
rm(arc_v000, arc_v001, arc_v002, arc_v003, spe_zero)
###


### Probable Error
# Create a vector of sample count totals, and a place holder for probable error
total_counts <- rowSums(arc_counts)
prob_error <- rowSums(arc_counts)
##
##
# Calculate probable error for each sample count
prob_error <- as.numeric(lapply(prob_error, function(x) 1.96*(sd(prob_error)/sqrt(x))))
##
##
# Create a dataframe with total counts and probable error for each sample
prob_error_df <- as.data.frame(cbind(total_counts, prob_error))
##
##
# Calculate percent probable error for each sample
prob_error_df[,"percent"] <- (prob_error_df[,"prob_error"] / prob_error_df[,"total_counts"])*100
##
##
# Check for rows with greater than 50% probably error
max(prob_error_df[,"percent"]) # all samples are above probable error
prob_error_df[prob_error_df[, "percent"] >= 50,]
##
rm(total_counts, prob_error)
##


### Fractional Abundance (v004)
arc_fract <- arc_counts/rowSums(arc_counts) 
#
rowSums(arc_fract)
###


### Standard Error: Species (arc_keep)
# Use fractional abundance (arc_fract) for two steps to calculate standard error (sterr)
arc_v005 <- as.data.frame(lapply(arc_fract, function(x) x *(1-x))) / rowSums(arc_counts)
arc_stderr <- as.data.frame(lapply(arc_v005, function(x) 1.96*(sqrt(x))))
rownames(arc_stderr) <- depth
##
##
# Create the threshold to compare the standard error against (v007)
arc_threshold <- as.data.frame(lapply(arc_fract, function(x) 0.7 * x))
rownames(arc_threshold) <- depth
##
##
# Standard error must be less than 0.7 of fractional abundance
arc_statsig <- (as.matrix(arc_stderr) < as.matrix(arc_threshold))*1
##
##
# Species with zero sums should be removed
spe_kick <- colSums(arc_statsig) == 0
arc_kick <- arc_counts[spe_kick] 
##
##
# All other species should be kept
spe_keep <- colSums(arc_statsig) > 0
arc_keep <- arc_counts[spe_keep]
##
##
rm(depth, arc_counts, arc_fract, arc_v005, arc_threshold, arc_statsig, spe_keep, spe_kick, )
###


### Write Files
# Kept Taxa
write.csv(data.frame("Depth"=rownames(arc_keep), arc_keep)
          , file = "R10P49_Arcellinida_StatSig_Kept.csv"
          , row.names = FALSE)
##
##
# Removed Taxa
write.csv(data.frame("Depth"=rownames(arc_kick), arc_kick)
          , file = "R10P49_Arcellinida_StatSig_Removed.csv"
          , row.names = FALSE)
##
##
# Probable Error
write.csv(data.frame("Depth"=rownames(prob_error_df), prob_error_df)
          , file = "R10P49_Arcellinida_StatSig_ProbableError.csv"
          , row.names = FALSE)
##
##
# Standard Error
write.csv(data.frame("Depth"=rownames(arc_stderr),arc_stderr)
                     , file = "R10P49_Arcellinida_StatSig_StandardError.csv"
                     , row.names = FALSE)
###