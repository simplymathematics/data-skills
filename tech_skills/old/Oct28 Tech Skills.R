
# Oct28 Tech Skills 
# combine all CSV Files (33 together)


library (ggplot2)
library (dplyr)
library (tidyr)

try(setwd ('/skills/TEMP10282018' ))


filenames <- list.files(full.names=TRUE)

All <- lapply(filenames,function(i){
  read.csv(i, header=FALSE, skip=4)
})
df <- do.call(rbind.data.frame, All)

print (df)


#write.csv(df,'all_tempfiles.csv', row.names=FALSE)

Techskills <- c( 'C', 'C#', 'Cassandra', 'Django', 'Hadoop','Hive','HTML','Java', 'MangoDB', 'Matlab', 'Pig', 'Python', 'R', ' ruby'
,'SAS','SQL','Statistics','Tableau','Teradata')


 df.ij<-inner_join (Techskills.df, df, by = c ('Techskills'='V3'))

head(df.ij)
df<-df.ij


df %>% 
  count(Techskills) %>% 
  arrange(desc(n))


as.factor(df$Techskills)

pl <- ggplot(df, aes(x = Techskills, color = Techskills, fill = Techskills)) + geom_bar()


