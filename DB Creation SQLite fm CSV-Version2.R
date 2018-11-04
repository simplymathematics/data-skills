
 # DB Creation SQLite fm CSV-Version2

  # RPub for RMarkdown:http://rpubs.com/ghh2001/436301
  
library(RSQLite)
# need to add this library first
library(sqldf)
library(dplyr)
library (tidyverse)
  

#setwd ('C:/Users/User/Desktop/To Email DeskTop')
# Physical library on Gracie's PC

getwd()

try(setwd("csvs"))
# Relative path in Github
  

#Database1: Start with Indeed Data Scraping Data
# Load csv file containing foreign key into a dataframe
Keyword_Search_csv_df <- read.csv("Indeed_Keyword_Search_data.csv")

# Load csv file containing primary key into a dataframe
keywords_csv_df <- read.csv("Indeed_Keyword.csv")

# Select relevent columns for database table insert
Keyword_Search_csv_df <- Keyword_Search_csv_df %>% 
  select(Data_Scientist_Skills_ID, Company, Web_scrape_date, state, job_post_link)
head(Keyword_Search_csv_df)

# Select relevent columns for database table insert
keywords_csv_df <- keywords_csv_df %>% 
  select(ID, Keyword)
head(keywords_csv_df)
  

# Database2: continue with the ONET (Labor Dept Data)
# ONET Characteristics table is the main table from ONET database, then Salary table, then Skills (Soft) table
 
characteristics <- read.csv ("characteristics.csv")

characteristics <- characteristics %>% 
  select (Title,SOC ,	OccupationType, 	TypicalEntryLvlEduc,	
          PreEmplExperience,	PostEmplTraining)
head(characteristics)


salary <- read.csv ("salary.csv")
salary <- salary %>% 
  select (	SOC,	No.Employees,	RSE,	Mean.Hourly.Wage,	Mean.Annual.Wage,	Wage.RSE)
head(salary)
  



# The linkage bw ONET and INDEED data is the technical skills 
## Tech Skill format 1: wide format, each skill is spreaded
 

skills_sum <- read.csv ('skills_sum.csv')
skills_sum %>% 
  select (jobNoNA,	jobcodeNoNA,		C,		Django,         	JavaScript,
          MongoDB,	MySQL,		NoSQL,         	PostgreSQL,	Python  ,
          R,	Ruby          ,SAS,	         	STATISTICA,	          SuperANOVA,	Tableau	)
#head(skills_sum)
str(skills_sum)

  

## Tech Skill format 2: Long format, each skill is gathered
 
TechSkillswOccupation <- read.csv("skills_sumcob_TechSkillswOccupation.csv")
TechSkillswOccupation %>% 
  select (Section,	Category,	Example,	job	,jobcode)
#head (TechSkillswOccupation)
str(TechSkillswOccupation)
  

# Connect to the database
## we create a temporary SQLite database called Proj3_67 (changed name to mydb)
 
mydb <- dbConnect(RSQLite::SQLite(), "Proj3_607.db")
# List out how many tables are in this object
dbListTables(mydb)

# TEST, to get query from this database (ONET Characteristic table only for now)
dbGetQuery  (mydb,"Select* FROM C") 
  

# Relational Database 1st set
#  Two relational Tables within Indeed Web Scraping, linked by Primary Key and Foreigh Key
 

# Create/Populate tables with data from the dataframes
dbWriteTable(mydb, "webscrapes", Keyword_Search_csv_df, overwrite = TRUE)
dbWriteTable(mydb, "keywords", keywords_csv_df, overwrite = TRUE)

# Join the two tables using the primary and foreing key(relational database)
join_tb_indeed <- "select keywords.Keyword, webscrapes.Company, webscrapes.Web_scrape_date,webscrapes.state 
from webscrapes 
inner join keywords
on keywords.ID = webscrapes.Data_Scientist_Skills_ID"

head(dbGetQuery(mydb, join_tb_indeed))
tail(dbGetQuery(mydb, join_tb_indeed))

  

# Relational Database 2nd set:  
  #Two relational Tables within ONET (Labor dept) Web Scraping, linked by Primary Key and Foreigh Key
   

# ONET Characteristics table is the main table from ONET database,
dbWriteTable(mydb,"C", characteristics, overwrite = TRUE)  
dbWriteTable(mydb,"salary", salary, overwrite = TRUE)

join_tb_onetsalary <- "select C.title, C.SOC, 	C.OccupationType, 	C.TypicalEntryLvlEduc,	
C.PreEmplExperience,	C.PostEmplTraining,
salary.SOC,  RSE
from C
inner join salary
on C.SOC = salary.SOC"

head (dbGetQuery(mydb,join_tb_onetsalary))

  

# Join the ONET SKILLS (soft Skills) with ONET Characteristics TABLES

dbWriteTable(mydb,"C", characteristics, overwrite = TRUE)
dbWriteTable(mydb, "TechSkl", TechSkillswOccupation, overwrite = TRUE)
join_tb_onetTechSkl <- 
  "select C.title, C.SOC, 	C.OccupationType, 	C.TypicalEntryLvlEduc,	
C.PreEmplExperience,	C.PostEmplTraining,
TechSkl.job, TechSkl.jobcode,TechSkl.Example
from C
inner join  TechSkl
on C.Title = TechSkl.job"

head (dbGetQuery(mydb,join_tb_onetTechSkl))

  

# Relational Database 3rd set: Link INDEED web scraping and Labor Dept ONET webscraping
 
# Linkage between those two sets: using the Technical Skills 
# Tech Skills linked with ONET Database
join_tb_ONETTechSkl <- 
  "select C.title, C.SOC, 	C.OccupationType, 	C.TypicalEntryLvlEduc,	
C.PreEmplExperience,	C.PostEmplTraining,
TechSkl.job, TechSkl.jobcode,TechSkl.Example
from C
inner join  TechSkl
on C.Title = TechSkl.job"
head (dbGetQuery(mydb,join_tb_ONETTechSkl))

  

# Tech Skills linked with Indeed Database
 
join_tb_IndeedTechSkl <- "select keywords.Keyword, 
TechSkl.job, TechSkl.jobcode,TechSkl.Example
from TechSkl
inner join keywords
on keywords.Keyword = TechSkl.Example"
head (dbGetQuery(mydb,join_tb_IndeedTechSkl))

  
# List all the relational tables within the SQlite database
 
dbListTables(mydb)
# all tables are displayed here, 6 tables (all relational in total)
  

# List the column fields within each individual tables within the SQLite Database
 
dbListFields(mydb,"C")
  

 
dbListFields(mydb,"SftSkl")
  

 
dbListFields(mydb,"TechSkillswOccupation")
  

 
dbListFields(mydb,"salary")

  

 
dbListFields(mydb,"TechSkl")

  

 
dbListFields(mydb,"keywords")

  

 
dbListFields(mydb,"webscrapes")
  

 
setwd('..')
  

