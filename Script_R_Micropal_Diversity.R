##################################
## Species Richness & Diveristy ##
##################################


### Table of Contents
#
# Notes
# Set Working Directory
# Load Data
# Data Wrangling
# Richness
# Diversity
# Save File
#
###


### Notes
# This is based on Tuomisto 2010 and 2011 and Vegan diversity
###


### Set working directory
setwd("C:/")
###


### Load Data (000, 001)
library(RMySQL)
#
mydb = dbConnect(MySQL(), user= 'root'
                 , password = 'password'
                 , dbname='carletondb', host = 'localhost')
#
dbListTables(mydb)
#
rs = dbSendQuery(mydb, "select * from results_arcellinida")
rs = dbSendQuery(mydb, "select * from results_arcellinida_statsig")
#
raw_000 = fetch(rs, n=-1) # all taxa
sig_000 = fetch(rs, n=-1) # taxa that pass significance test
##
rm(mydb, rs)
###


### Data Wrangling (003)
##
# Set depth as index, remove depth column
depth <- raw_000$depth_cm
#
rownames(raw_000) <- depth
raw_000$depth_cm <- NULL
#
rownames(sig_000) <- depth
sig_000$depth_cm <- NULL
##
##
# Remove non species columns
raw_001 <- raw_000[,-c(1:5)]
sig_001 <- sig_000[,-1]
##
##
# Check data types
sapply(raw_001, mode) # they are type character
sapply(sig_001, mode) # they are type numeric
#
# Transform to numeric
raw_002 <- as.data.frame(lapply(raw_001, function(x) as.numeric(as.character(x))))
rownames(raw_002) <- depth
##
##
# Check for zero sum species columns and remove
raw_zero <- colSums(raw_002) > 0
raw_003 <- raw_002[raw_zero] # one zero sum column
#
sig_zero <- colSums(sig_000) > 0
sig_001 <- sig_000[sig_zero] # no zero sum columns
##
raw_counts <- raw_003
sig_counts <- sig_000
##
# Remove objects that are no longer needed
rm(raw_000, raw_001, raw_002, raw_003, sig_000, sig_001, raw_zero, sig_zero)
###


### Richness
library("vegan")
#
# uses presence-absense data (binary)
raw_rich <- specnumber(raw_counts)
sig_rich <- specnumber(sig_counts)
###


### Diversity
#
# uses count data
#
# modulate importance of rare vs abundant taxa
# by using varying values of k (0 - 2)
# the default k = 2 is equivalent to the Simpson index
#
# Simpson Diversity Index
raw_simp <- diversity(raw_counts, index = "simpson")
sig_simp <- diversity(sig_counts, index = "simpson")
#
# Shannon Diversity Index
raw_shan <- diversity(raw_counts, index = "shannon")
sig_shan <- diversity(sig_counts, index = "shannon")
#
# unbiased simpson
raw_uSimp <- rarefy(raw_counts, 2) - 1
sig_uSimp <- rarefy(sig_counts, 2) - 1
#
# Fisher alpha
#
# Appropriate when total number of individuals / species > 1.44
# Independent of sample size when individuals exceeds 1000
#
raw_alpha_test <- rowSums(raw_counts) / raw_rich
raw_alpha_test
#
raw_fish <- fisher.alpha(raw_counts)
sig_fish <- fisher.alpha(sig_counts)
#
#
# Plot Diversity Indices
windows()
#
# raw dataset
pairs(cbind(raw_simp, raw_shan, raw_uSimp, raw_fish), pch="+", col="blue")
# simpson, shannon, unbiased simposon all show strong positive correlations
#
# sig dataset
pairs(cbind(sig_simp, sig_shan, sig_uSimp, sig_fish), pch="+", col="blue")
# simpson, shannon, unbiased simposon all show strong positive correlations
#
# compare raw vs sig
pairs(cbind(raw_simp, sig_simp, raw_fish, sig_fish), pch="+", col="blue")
# simpson (raw and sig) show strong positive correlation
# fisher (raw and Sig) show a medium positive correlation
# i think keeping simpson and fisher is important
#
# Remove
rm(raw_alpha_test)
###


### Save File
# create a dataset to output
output <- cbind(raw_rich, sig_simp, sig_fish)
colnames(output) <- c("spe_rich_raw", "simpson_sig", "fisher_sig")
#
write.csv(data.frame("Depth"=rownames(output),output)
          , file = "R10P49_Arcellinida_Diversity.csv"
          , row.names = FALSE)
###
