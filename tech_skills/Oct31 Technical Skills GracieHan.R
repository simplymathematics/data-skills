

# file name: Oct31 Technical Skills GracieHan

require(rvest)
require(dplyr)
require(stringr)
require(tidyr)
require(dplyr)
require(ggplot2)

#setwd('E:/8-607 Proj3 Week8 607 GH TO Do Scraping WebPage/Oct28 FInal Charlie Folder/skills/TEMP10282018')
getwd()
try(setwd("tech_skills/TempUpload"))  # same as my physial library


# below codes reads everything inside the folder (all of these CSVs, nothing else)
#https://towardsdatascience.com/using-r-to-merge-the-csv-files-in-code-point-open-into-one-massive-file-933b1808106

filenames <- list.files(full.names=TRUE)
All <- lapply(filenames,function(i){
  read.csv(i, header=FALSE, skip=4)
})
df <- do.call(rbind.data.frame, All)
head(df)
tail(df)


#Our partener has orgnized a bunch of key skills for data scientists.  Later, we will see the match to our mass dataframe of 33 occupations.
 
skills_Ravi<- c("AWS", "Python","AI", "SQL", "R", "SAS", "Tableau", "AZURE", "SparkML", "Spark","Hadoop", "Machine Learning", "Shiny","Statistics","Probability")
  

#After, review Ravi's key skills and O.NET website.  Gracie and Jun has pulled out a set of skills as backup plan for this study.
 
skills_Jun <- c("C", "C#","Cassandra", "Django", "Hadoop", "Hive", "HTML", "Java", "MangoDB", "Matlab", "Python", "Pig", "SAS", "R",  "Ruby", "SAS", "SQL", "Statistics","Tableau","Teradata")
  

#Using the filter function of dplyr packge to get the data of our mass dataframe matched with Ravi's key skills.
 
#df_Ravi <- df %>% filter (Example %in% skills_Ravi)
df_Ravi <- df %>% filter (V3 %in% skills_Ravi) # now example is V3
  
 head (df_Ravi)
  


#Data visulization using ggplot2.  We can find that according to Ravi's skills, we can find that the top 4 skills for data scientists are the follwoing: SAS, Python, Tableau and R.
 
#pl <- ggplot(df_Ravi, aes(x = Example, color = Example, fill = Example)) + geom_bar()
pl <- ggplot(df_Ravi, aes(x = V3, color = V3, fill = V3)) + geom_bar()
print(pl)
  

#Similar finding were observed using Gracie and Jun's key words for data scientist.  The top 8 key skills for data scientist are SAS, Pythone, Tableau, R, C, Ruby, Diango.  
 
#df_Jun <- df %>% filter (Example %in% skills_Jun)
df_Jun <- df %>% filter (V3 %in% skills_Jun)


 
#pl_Jun <- ggplot(df_Jun, aes(x = Example, color = Example, fill = Example)) + geom_bar()
pl_Jun <- ggplot(df_Jun, aes(x = V3, color = V3, fill = V3)) + geom_bar()
print(pl_Jun)
Techskills.graphic <- pl_Jun
  

#Those are the very preliminary data from our analysis.  
 
Techskill.frame <- df_Ravi
Techskills.graphic
  

setwd('..')



