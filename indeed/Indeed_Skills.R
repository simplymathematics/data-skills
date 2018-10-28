
# load libraries
suppressWarnings(library(rvest, quietly =TRUE))
suppressWarnings(library(stringr, quietly =TRUE))
suppressWarnings(library(dplyr, quietly =TRUE))
suppressWarnings(library(wordcloud, quietly =TRUE))
suppressWarnings(library(RColorBrewer, quietly =TRUE))
suppressWarnings(library(ggplot2, quietly =TRUE))
suppressWarnings(library(sqldf, quietly =TRUE))


# For detailed documentation, consult the Rmd file of the same name. For run-time optimizatiions, we will read from a previously-generated csv.

#Both csv data are reloaded into a single dataframe using the inner join command from sqldf to form one table with all the necessary columns for analyzing.

try(setwd("indeed"))
Keyword_Search_csv_df <- read.csv("Indeed_Keyword_Search_data.csv")
keywords_csv_df <- read.csv("Indeed_Keyword.csv")


join_tb1 <- "select keywords_csv_df.Keyword, Keyword_Search_csv_df.Company, Keyword_Search_csv_df.Web_scrape_date, Keyword_Search_csv_df.State from Keyword_Search_csv_df inner join keywords_csv_df on keywords_csv_df.ID = Keyword_Search_csv_df.Data_Scientist_Skills_ID"

relational_data <- sqldf(join_tb1, stringsAsFactors = FALSE)
head(relational_data)
tail(relational_data)

# Seperate the NY and CA data for easier processing

query_relational_data_ny <- "Select * from relational_data Where State = 'NY'"
relational_data_NY <- sqldf(query_relational_data_ny, stringsAsFactors = FALSE)
indeed.ny.frame <- relational_data_NY

query_relational_data_ca <- "Select * from relational_data Where State = 'CA'"
relational_data_ca <- sqldf(query_relational_data_ca, stringsAsFactors = FALSE)
indeed.ca.frame <- relational_data_ca


#Top 3 Skill sets found in Jobpostings in NY for Senior Level Datascientists.


job_listings_keyword_count_ny <- relational_data_NY %>%
  group_by(Keyword) %>% count(Keyword) %>% arrange(desc(n))
knitr::kable(head(job_listings_keyword_count_ny, 3))


#Top 3 Skill sets found in Jobpostings in CA for Senior Level Datascientists.


job_listings_keyword_count_ca <- relational_data_ca %>%
  group_by(Keyword) %>% count(Keyword) %>% arrange(desc(n))
knitr::kable(head(job_listings_keyword_count_ca, 3))



#Visually compare the barlots for NY and CA to learn which requested skill sets are more popular.

bplotNY<-ggplot(relational_data_NY, aes(x=factor(Keyword, levels=names(sort(table(Keyword),decreasing=FALSE))), y=1, fill = Keyword)) +
  geom_bar(stat="identity")+theme_minimal() + geom_text(aes(label = ..count.., y= ..prop..), stat= "count", vjust = -.5, colour = "black") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + coord_flip() +  xlab("Skills") + ylab("Count") +
  ggtitle("Senior Level Data Scientist Skills search from Indeed NY")
bplotNY

bplotCA<-ggplot(relational_data_ca, aes(x=factor(Keyword, levels=names(sort(table(Keyword),decreasing=FALSE))), y=1, fill = Keyword)) +
  geom_bar(stat="identity")+theme_minimal() + geom_text(aes(label = ..count.., y= ..prop..), stat= "count", vjust = -.5, colour = "black") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + coord_flip() +  xlab("Skills") + ylab("Count") +
  ggtitle("Senior Data Scientist Skills search from Indeed CA")
bplotCA
write.csv(job_listings_keyword_count_ny,'../csvs/indeed_keyword_count_ny.csv')
write.csv(job_listings_keyword_count_ca,'../csvs/indeed_keyword_count_ca.csv')
setwd("..")




