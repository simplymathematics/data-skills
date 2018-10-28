# Dependencies

suppressWarnings(library(XML, quietly =TRUE)) #for reading xml, html
suppressWarnings(library(stringr, quietly =TRUE)) #for regex
suppressWarnings(library(curl, quietly =TRUE)) #for downloading url file
suppressWarnings(library(tidyr, quietly =TRUE)) #for data manipulation
suppressWarnings(library(dplyr, quietly =TRUE)) #for data manipulation
suppressWarnings(library(ggplot2, quietly =TRUE)) #for graphs
suppressWarnings(library(knitr, quietly =TRUE)) #for table design
suppressWarnings(library(kableExtra, quietly =TRUE)) #for table design

try(setwd('tech-skills'))


# Downloading
#We will use the onet database to generate our list of skills.

#################################################################
#Uncomment the below line to download the file again
#curl_download("https://www.onetcenter.org/dl_files/database/db_23_0_text/Tools%20and%20Technology.txt", "TechSkills.txt")

# Reading File
# The code below reads the data and discards all of the non mathematics fields.

df<- read.csv("TechSkills.txt", sep = '\t', header = TRUE, quote = "")
df <- df[grep("15-", df$O.NET.SOC.Code),]
head(df)

# Cleaning Data

df$O.NET.SOC.Code <- substr(x = df$O.NET.SOC.Code, 4, 7) #drops sub occupation data

df <- df[grep("Technology", df$T2.Type),] # only cares about technology data

head(df)



# Subsetting Data 


techexample <- data.frame(df$O.NET.SOC.Code, df$T2.Example) %>% #subsets fields for analysis
  rename(SOC = df.O.NET.SOC.Code, Example = df.T2.Example) %>% # Rename columns
  group_by(Example) %>%
  tally() %>%
  arrange(desc(n))
techexample

techtype <- data.frame(df$O.NET.SOC.Code, df$Commodity.Title) %>% #subsets fields for analysis
  rename(SOC = df.O.NET.SOC.Code, Commodity.Title = df.Commodity.Title) %>% # Rename columns
  group_by(Commodity.Title) %>% # Create variable groupings
  tally() %>%
  arrange(desc(n))

tech.frame <- techtype
tech.top <- head(tech.frame, 5)
setwd('..')

write.csv(techtype,'TechSkills.csv')