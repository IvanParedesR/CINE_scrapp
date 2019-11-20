install.packages("xml2")
install.packages("rvest")
install.packages("stringr")
library(xml2)
library(rvest)
library(stringr)

#Specifying the url for desired website to be scrapped
url <- ‘https://cinemex.com/’

#Reading the html content from Amazon
webpage <- read_html(url)