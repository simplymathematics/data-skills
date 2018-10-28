
# Dependencies

require(XML) #for reading xml, html
require(stringr) #for regex
require(curl) #for downloading url file
require(tidyr) #for data manipulation
require(dplyr) #for data manipulation
require(ggplot2) #for graphs
require(knitr) #for table design
require(kableExtra) #for table design

try(setwd('onet'))
# Downloading

#We will use the onet database to generate our list of skills.

curl_download("https://www.onetcenter.org/dl_files/database/db_23_0_text/Skills.txt", "Skills.txt")

# Reading File

# The code below reads the data and discards all of the non mathematics fields.


df<- read.table("Skills.txt", sep = '\t', header = TRUE)

df <- df[grep("15-", df$O.NET.SOC.Code),]


# Cleaning Data
df <- df[grep(".00$", df$O.NET.SOC.Code),] # limit SOC Code to major groups only
df <- df[grep("IM", df$Scale.ID),] # only cares about importance data
df <- df[grep("N", df$Recommend.Suppress),] # only cares about unsuppressed data
skillsdf <- data.frame(df$O.NET.SOC.Code, df$Element.Name, df$Data.Value) #subsets fields for analysis


wideskills <- skillsdf %>% # Create dataframe
  rename(SOC = df.O.NET.SOC.Code, Element = df.Element.Name, Value = df.Data.Value) %>% # Rename columns
  group_by(SOC) %>% # Create variable groupings
  arrange(SOC, desc(Value)) %>% # Sort elements by Value
  top_n(5, Value) %>% # Includes more than n rows if there are ties
  spread(Element, Value, fill = F) # Create wide dataset and sets NA values to 0
# Knitr Table to view output
#w <- knitr::kable(wideskills, caption = 'Wide Skills Output', format = "html") %>%
#  kable_styling(bootstrap_options = c("condensed"), full_width = F, position = "left") %>%
#  row_spec(row = 0:0, background = "#D4E0F7") %>%
#  column_spec(column = 1, bold = T) 
#w
# This may actually be a better version of the wideskill df, but also requires assistance. 

df.Skills <- skillsdf %>%  # Create dataframe
  rename(SOC = df.O.NET.SOC.Code, Element = df.Element.Name, Value = df.Data.Value) %>% # Rename columns
  group_by(SOC, Element, Value) %>% # Create variable groupings
  count(SOC) %>% # Create column n for every SOC/Element combindation 
  spread(SOC, n, fill = F)  %>% # Create wide dataset and sets NA values to 0
  ungroup(SOC) %>% # Remove SOC from grouping
  arrange(Element, desc(Value)) %>% # Sort elements by Value
  mutate(SOC.Count = rowSums(.[3:18])) %>% # Sum SOC codes counts per element
  filter(Value > 3) %>% # filters for significant values only (3/7 relevance or more) 
  group_by(Element) %>% # new grouping 
  summarise(avgvalue = mean(Value), n = sum(SOC.Count)) %>% # skills summary 
  arrange(desc(avgvalue))%>% # sort
  top_n(5, avgvalue)  # select top 5 avg value skills 

skills.frame <- wideskills
skills.frame$SOC <- substr(skills.frame$SOC, 4, 7)
#TODO skills.frame <- skills.frame$SOC

#t <- knitr::kable(df.Skills, caption = 'Output', format = "html") %>%
# kable_styling(bootstrap_options = c("condensed"), full_width = F, position #= "left") %>%
#  row_spec(row = 0:0, background = "#D4E0F7") %>%
#  column_spec(column = 1, bold = T) 
#t

skills.top <- df.Skills
setwd('..')
