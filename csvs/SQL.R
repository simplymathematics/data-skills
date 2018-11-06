---
title: "DB Creation SQLite fm CSV-Version2"
output: html_document
---

# Dependencies


library (tidyverse)
library(RSQLite)
library(DBI)



try(setwd(dir = "csvs/"))


# Connect to the database

data.skills.db <- dbConnect(SQLite(), "db.sqlite")
dbListTables(data.skills.db)


# Load Data: Here, we load the indeed data into indeed dataframes.
 

# Load csv file containing foreign key into a dataframe
indeed.ca <- read.csv("indeed_keyword_count_ca.csv")
indeed.ny <- read.csv("indeed_keyword_count_ny.csv")


# Here, we load the variosu ONET/BLS data into various objects.

characteristics <- read.csv ("characteristics.csv")
salary <- read.csv ("salary.csv")
skills <- read.csv ('skills.csv')
tech.skills <- read.csv('TechSkills.csv')


# Here we write the Indeed data as two separate tables

# Create/Populate tables with data from the dataframes
dbWriteTable(data.skills.db,"indeed.ca", indeed.ca, overwrite = TRUE)
dbWriteTable(data.skills.db,"indeed.ny", indeed.ny, overwrite = TRUE)


# Here we write the ONET/BLS data

dbWriteTable(data.skills.db,"characteristics", characteristics, overwrite = TRUE)  
dbWriteTable(data.skills.db,"salary", salary, overwrite = TRUE)
dbWriteTable(data.skills.db,"skills", skills, overwrite = TRUE)
dbWriteTable(data.skills.db,"tech.skills", tech.skills, overwrite = TRUE)


# Check in on the database
 

dbListTables(data.skills.db)


#The SQLite documentation says that, 

#"It is not possible to use the "ALTER TABLE ... ADD COLUMN" syntax to add a column that includes a REFERENCES clause, unless the default value of the new column is NULL. Attempting to do so returns an error." 

#This means that we would need to relate these through another means. Given time restrictions and the fact that our related data is all binned by a 4 digit SOC code, this seems like it would suffice.  

