### Save Datasets
# Author: Andrew Macumber
# Save R dataframes (p49_004) as tables (data_consolidated) in a MySQL database (carletondb)
#
# load libraries
library(RMySQL)
#
# open a connection to the database
mydb = dbConnect(MySQL(), user= 'root'
                 , password = 'password'
                 , dbname='carletondb', host = 'localhost')
#
# list the tables in your database
dbListTables(mydb)
#
# save a dataframe to your database
# overwrite will create a new table; append will add rows to an existing
dbWriteTable(mydb, name='data_consolidated', value=p49_004
             , overwrite = TRUE, append = FALSE)
#
# if you get a permission error
## log into MySQL terminal
## type GLOBAL local_infile = true;
## type SHOW GLOBAL VARIABLES LIKE 'local_infile';
#
# You can check to see if there were any issues
rs_save = dbSendQuery(mydb, "select * from data_consolidated")
p49_save = fetch(rs_save, n=-1) # age depth model
###