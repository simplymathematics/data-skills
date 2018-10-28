# U.S. Bureau of Labor Statistics, Employment Projection Survey
# 2016-20126 Occupational projections and worker characteristics of 15-000 Computer and Mathematical Occupations Serires. 


require(rvest)
require(dplyr)
require(stringr)
require(tidyr)
require(dplyr)
require(ggplot2)
require(curl)

try(setwd("outlook"))
curl_download("https://www.bls.gov/emp/tables/occupational-projections-and-characteristics.htm", "outlook.html")
BLS_EP_URL <- read_html("https://www.bls.gov/emp/tables/occupational-projections-and-characteristics.htm")


OccProj <- html_nodes(BLS_EP_URL, "table")
head(OccProj)

OccProj <- BLS_EP_URL %>%
  html_nodes("table") %>%
  .[2] %>%
  html_table(fill = TRUE)


OccProj[[1]] <- OccProj[[1]][-1,]

colnames(OccProj[[1]]) <- c("Title", "SOC", "OccupationType", "2016Employment", "2026Employment", "2016EmplChange2016-26", "2026EmplChange2016-26", "2016Self-Empl_Prcnt", "2016-26_AvgAnnual_OccOpenings", "2017MedianAnnualWage", "TypicalEntryLvlEduc", "PreEmplExperience", "PostEmplTraining")  

OccProjTbl <- dplyr::tbl_df(OccProj[[1]]) 
outlook.frame <- OccProjTbl
outlook.frame$SOC <- substr(outlook.frame$SOC, 4, 7)

Series15 <- dplyr::filter(OccProjTbl, grepl('15-', SOC)) %>%
  filter(grepl('Line item', OccupationType))

outlook.graphic2 <- ggplot(Series15, aes(x = TypicalEntryLvlEduc, y = frequency(SOC), fill=TypicalEntryLvlEduc)) + 
  guides(fill=FALSE, color=FALSE)+
  geom_bar(stat="identity") +
  scale_fill_brewer(palette="Set1")+
  labs(title = "Typical education needed for entry for 15-000 Computer Occupation", x = "Education", y = "Frequency") 

outlook.graphic <- ggplot(Series15, aes(x = PreEmplExperience, y = frequency(SOC), fill=PreEmplExperience)) + 
  guides(fill=FALSE, color=FALSE)+
  geom_bar(stat="identity") +
  scale_fill_brewer(palette="Set1")+
  labs(title = "Work experience in a related occupation for 15-000 Computer Occupation", x = "Experience", y = "Frequency") 
outlook.graphic

setwd('..')

