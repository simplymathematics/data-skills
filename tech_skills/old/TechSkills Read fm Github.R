#title: TechSkills Read fm Github-DATA 607 Project 3 Collaboration and Team Work"


# For this project, we are going to do research about data scientists' career future, necessary skill and salary.
# Data were colllected from Indeed, O*NET, Bureau of Labor Statistics website by webscaping using R.
# 
# Hui (Gracie) Han and Jun Pan) were focused on the data analysis of 31 data science related jobs and necessary hard skills.
# 
# Firstly, 31 data science related jobs and required skills were downloaded from O*NET website and saved in github repository.
# Load csv files for occupations and skills from github

#try(setwd("tech_skills/old"))

f1<- read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_11-3111-00.csv")
f3<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_13-1141-00.csv")
f4<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_13-1161-00.csv")
f5<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_13-2011-02.csv")
f6<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_13-2041-00.csv")
f7<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_13-2051-00.csv")
f8<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_13-2053-00.csv")
f9<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_13-2099-02.csv")
f10<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-1111-00.csv")
f11<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-1121-00.csv")
f12<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-1131-00.csv")
f13<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-1133-00.csv")
f14<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-1134-00.csv")
f15<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-1141-00.csv")
f17<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-2021-00.csv")
f18<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-2031-00.csv")
f19<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-2041-00.csv")
f20<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-2041-01.csv")
f21<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-2041-02.csv")
f22<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_19-2099-01.csv")
f23<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_19-3011-00.csv")
f24<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_19-3022-00.csv")
f25<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_19-4061-00.csv")
f26<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_25-1021-00.csv")
f27<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_27-4011-00.csv")
f28<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_27-4012-00.csv")
f29<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_43-9011-00.csv")
f30<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_49-2011-00.csv")
f31<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_25-9011-00.csv")
f32<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-1151-00.csv")
f33<-read.csv("https://raw.githubusercontent.com/simplymathematics/data-skills/master/tech_skills/old/technology_skills_15-2011-00.csv")
 

# load libraries
require(rvest)
require(stringr)
require(dplyr)
require(wordcloud)
require(dplyr)
require(RColorBrewer)
require(ggplot2)
 

#combined all information of 33 jobs into one mass dataframe 
df<-bind_rows(f1,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f17,f18,f19,f20,f21,f22,f23,f24,f25,f26,f27,f28,f29,f30, f31, f32, f33)
head (df)
tail(df)
dim(df)
 
#Our partners have orgnized a bunch of key skills for data scientists.  Later, we will see the match to our mass dataframe of 33 occupations.
 
skills_Ravi<- c("AWS", "Python","AI", "SQL", "R", "SAS", "Tableau", "AZURE", "SparkML", "Spark","Hadoop", "Machine Learning", "Shiny","Statistics","Probability")
 

#After, review Ravi's key skills and O.NET website.  Gracie and Jun has pulled out a set of skills as backup plan for this study.
 
skills_Jun <- c("C", "C#","Cassandra", "Django", "Hadoop", "Hive", "HTML", "Java", "MangoDB", "Matlab", "Python", "Pig", "SAS", "R",  "Ruby", "SAS", "SQL", "Statistics","Tableau","Teradata")
 

# Using the filter function of dplyr packge to get the data of our mass dataframe matched with Ravi's key skills.
df_Ravi <- df %>% filter (Example %in% skills_Ravi)
print(df_Ravi)
 


#Data visulization using ggplot2.  We can find that according to Ravi's skills, we can find that the top 4 skills for data scientists are the follwoing: SAS, Python, Tableau and R.
 
pl <- ggplot(df_Ravi, aes(x = Example, color = Example, fill = Example)) + geom_bar()
print(pl)
 
#Similar finding were observed using Gracie and Juns key words for data scientist.  
# The top 8 key skills for data scientist are SAS, Pythone, Tableau, R, C, Ruby, Diango.  

df_Jun <- df %>% filter (Example %in% skills_Jun)
 
 
pl_Jun <- ggplot(df_Jun, aes(x = Example, color = Example, fill = Example)) + geom_bar()
print(pl_Jun)
Techskills.graphic <- pl_Jun
 

#Those are the very preliminary data from our analysis.  
 
Techskill.frame <- df_Ravi
Techskills.graphic
 

setwd('..')

