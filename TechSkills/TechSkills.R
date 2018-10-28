
# Dependencies

suppressWarnings(library(XML, quietly =TRUE)) #for reading xml, html
suppressWarnings(library(stringr, quietly =TRUE)) #for regex
suppressWarnings(library(curl, quietly =TRUE)) #for downloading url file
suppressWarnings(library(tidyr, quietly =TRUE)) #for data manipulation
suppressWarnings(library(dplyr, quietly =TRUE)) #for data manipulation
suppressWarnings(library(ggplot2, quietly =TRUE)) #for graphs
suppressWarnings(library(knitr, quietly =TRUE)) #for table design
suppressWarnings(library(kableExtra, quietly =TRUE)) #for table design

# Downloading

#We will use the onet database to generate our list of skills.
############################################

try(setwd('TechSkills'))
# Downloading

#We will use the onet database to generate our list of skills.

curl_download("https://www.onetcenter.org/dl_files/database/db_23_0_text/Tools%20and%20Technology.txt", "TechSkills.txt")

# Reading File

# The code below reads the data and discards all of the non mathematics fields.

df<- read.table("TechSkills.txt", sep = '\t', header = TRUE)

df <- df[grep("15-", df$O.NET.SOC.Code),]


