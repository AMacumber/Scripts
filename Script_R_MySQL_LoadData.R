### Load Datasets from MySQL Database
# Author: Andrew Macumber
# Create dataframes (age_000) from tables (results_14c_model) in a MySQL database (carletondb)
#
# load libraries
library(RMySQL)
#
# create a connection to database (carletondb)
mydb = dbConnect(MySQL(), user= 'root'
                 , password = 'password'
                 , dbname='carletondb', host = 'localhost')
#
# list tables in database (carletondb)
dbListTables(mydb)
#
# create a dataframe (age_000) from table(results_14c_model)
rs_age = dbSendQuery(mydb, "select * from results_14c_model")
age_000 = fetch(rs_age, n=-1) # age depth model
####