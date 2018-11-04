# DB Creation Nov3 SQLite fm CSV
#reference: https://cran.r-project.org/web/packages/RSQLite/vignettes/RSQLite.html


suppresswarnings (library(RSQLite))# need to add this library first
suppresswarnings (library(sqldf))
library(dplyr)

#setwd ('E:/Proj3 Nov3 Charlie FolderGithub/csvs')
# Physical library on Gracie's PC
getwd()

try(setwd("csvs"))
# Relative path in Github


# Database1: Start with Indeed Data Scraping Data
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



#Database2: continue with the ONET (Labor Dept Data)
characteristics <- read.csv ("characteristics.csv")

characteristics <- characteristics %>% 
  select (Title,SOC ,	OccupationType, 2016Employment,	2026Employment,	2016EmplChange2016-26,	2026EmplChange2016-26,
           2016Self-Empl_Prcnt,	2016-26_AvgAnnual_OccOpenings	,2017MedianAnnualWage,	TypicalEntryLvlEduc,	
           PreEmplExperience,	PostEmplTraining)
head(characteristics)



salary <- read.csv ("salary.csv")
salary <- salary %>% 
  select (	SOC,	No.Employees,	RSE,	Mean.Hourly.Wage,	Mean.Annual.Wage,	Wage.RSE)
head(salary)


skills<- read.csv ("skills.csv")
skills <- skills %>% 
  select (SOC,	Active, Learning,	Active Listening,	Complex Problem Solving,	Coordination,	
          Critical Thinking,	Equipment Maintenance,	Equipment Selection,	Installation,
          Instructing,	Judgment and Decision Making,	Learning Strategies,	Management of Financial Resources,
          Management of Material Resources,	Management of Personnel Resources,
          Mathematics,	Monitoring,	Negotiation,	Operation and Control,
          Operation Monitoring,	Operations Analysis,	Persuasion,	Programming,
          Quality Control Analysis
          Reading Comprehension,	Repairing,	Science,
          Service Orientation,	Social Perceptiveness,	Speaking,	Systems Analysis,
          Systems Evaluation,	Technology Design,	Time Management,	Troubleshooting,	Writing )
head(skills)



# The linkage bw ONET and INDEED data is the technical skills 
## Tech Skill format 1: wide format, each skill is spreaded
skills_sum <- read.csv ('skills_sum.csv')
skills_sum %>% 
  select (jobNoNA,	jobcodeNoNA,	Apache Cassandra,	Apache Hadoop,
          Apache Hive,	Apache Pig,	C,	C#, 	C++ ,	Computational statistics software,	Django,
          Hypertext markup language HTML,	IBM SPSS Statistics,	JavaScript,
          JavaScript Object Notation JSON,	Micosoft SQL Server Analysis Services SSAS,
          Microsoft SQL Server,	Microsoft SQL Server Integration Services SSIS,
          MongoDB,	MySQL,	NCR Teradata Warehouse Miner,	NeuroSolutions for MatLab,	NoSQL,
          Oracle Java	Oracle, JavaServer Pages JSP,	Oracle PL/SQL,
          Oracle SQL Loader,	Oracle SQL Plus,	PostgreSQL,	Python  ,
          R,	Redgate SQL Server,	Ruby,	Ruby on Rails,	SAS,	SAS Enterprise Miner,
          SAS JMP,	SAS/CONNECT,	STATISTICA,	Statistical software,	Statistical Solutions BMDP,
          Structured query language SQL,	Sun Microsystems Java 2 Platform Enterprise Edition J2EE,
          SuperANOVA,	Tableau,	Teradata Enterprise Data Warehouse,
          The MathWorks MATLAB,	UNISTAT Statistical Package)
head(skills_sum)

  
  
## Tech Skill format 1: Long format, each skill is gathered
TechSkillswOccupation <- read.csv("skills_sumcob_TechSkillswOccupation.csv")
TechSkillswOccupation %>% 
  select (Section,	Category,	Example,	job	,jobcode)
head (TechSkillswOccupation)


# Connect to the database
## we create a temporary SQLite database called Proj3_67 (changed name to mydb)
mydb <- dbConnect(RSQLite::SQLite(), "Proj3_607.db")
# List out how many tables are in this object
 dbListTables(mydb)
 
# TEST, to get query from this database (ONET Characteristic table only for now)
dbGetQuery  (mydb,"Select* FROM C") 


# Relational Database 1st set:  Two relational Tables within Indeed Web Scraping, linked by Primary Key and Foreigh Key
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
dbWriteTable(mydb, "TechSkl", skills_sumcob_TechSkillswOccupation, overwrite = TRUE)
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

dbListTables(mydb)
# all tables are displayed here, 6 tables (all relational in total)

setwd('..')
