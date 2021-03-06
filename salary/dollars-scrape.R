
# Dependencies

suppressWarnings(library(curl, quietly =TRUE))
suppressWarnings(library(stringr, quietly =TRUE))
suppressWarnings(library(XML, quietly =TRUE))

# Downloading Data

#This section downloads a single page. However, it can be modified to work across similar pages. Notice how that would only require changing the code  in the URL. TODO get a list of pertinent OES codes. 
try(setwd("salary"))

# From: https://www.bls.gov/oes/current/oes_stru.htm#15-0000
##  List of URLS
# IT was fastest to type these by hand
raw.data <- readLines("https://www.bls.gov/oes/current/oes151111.htm")
numbers.list <- c(1133, 1134, 1141, 1142, 1143, 1151, 1152, 1199,  2011, 2021, 2031, 2041, 2090)
urls <- c()
i = 1
for (number in numbers.list){
  url = paste(c("https://www.bls.gov/oes/current/oes15",number,".htm"),collapse = "")
  urls[i] <- url
  i = i + 1
}
urls

#Since we're only interested in the first table, we'll cut everything else out.

# Regex for all text between two table
first <- which(grepl("<table border=\"1\"", raw.data))[1]
last <- which(grepl("</table>", raw.data))[1]
truncated.data <- raw.data[first:last]



html.data <- data.frame(readHTMLTable(truncated.data))
colnames(html.data) <- c("No. of Employees", "RSE", "Mean Hourly Wage", "Mean Annual Wage", "Wage RSE")
html.data


#Below is an attempt to automate the above process to work with a list of URLs. 

oes_scrape <- function(URLs){
  big.data <- data.frame()
  for (url in URLs){
    raw.data <- readLines(url)
    first <- which(grepl("<table border=\"1\"", raw.data))[1]
    last <- which(grepl("</table>", raw.data))[1]
    truncated.data <- raw.data[first:last]
    html.data <- data.frame(readHTMLTable(truncated.data))
    colnames(html.data) <- c("No.Employees", "RSE", "Mean.Hourly.Wage", "Mean.Annual.Wage", "Wage.RSE")
    big.data <- rbind(big.data, html.data)
  }
  return(big.data)
  
  
}
salary.frame <- oes_scrape(urls)
SOC <- numbers.list
salary.frame <- cbind(SOC, salary.frame)

tmp <- substr(salary.frame$Mean.Annual.Wage, 2, 15)
tmp <- gsub(x = tmp, pattern = ",", replacement ="")
salary.frame$Mean.Annual.Wage <- as.numeric(tmp)

write.csv(salary.frame, file="../csvs/salary.csv")
setwd("..")
