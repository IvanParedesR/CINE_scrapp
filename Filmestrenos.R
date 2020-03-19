#rvest es un paquete que facilita el raspado (o la recolección) de datos de páginas web html, inspirado en bibliotecas como la hermosa sopa . Está diseñado para trabajar con magrittr para que pueda expresar operaciones complejas como tuberías elegantes compuestas de piezas simples y fáciles de entender. Instalarlo con:
#install.packages("rvest")

#Paquetenes necesarios
library("rvest")
library("XML")
library("xml2")
library(magrittr, lib.loc = "C:/Users/iparedes/Documents/R/R-3.6.2/library")

#The html_nodes() function turns each HTML tag into a row in an R dataframe.
url = "https://www.filmaffinity.com/mx/rdcat.php?id=upc_th_mx"
film1 = read_html(url)

#This grabs all the nodes that have links in them.
film1 %>%
  html_nodes("a") %>%
  head()

#Every div on the page:
film1 %>%
  html_nodes("div") %>%
  head()

#the nav-tools div. This calls by css where class=nav-tools.

film1 %>%
  html_nodes("div.nav-tools") %>%
  head()

#We can call the nodes by id as follows.

film1 %>%
  html_nodes("div#project-listing") %>%
  head()

#All the tables as follows:

film1 %>%
  html_nodes("table") %>%
  head()

film1 %>%
  html_nodes("a") %>%
  html_nodes("div") %>%
  html_nodes("table") %>%
  html_table() %>%
  "["(1) %>% str()

film1 %>%
  html_nodes("a") %>% #filter to the projec-listing div
  html_nodes("div") # filter the tables in the project-listing div 

film1 %>%
  html_nodes("a") %>% #filter to the projec-listing div
  html_nodes("div") %>% # filter the tables in the project-listing div 
  html_text() %>%                       #get the text, not the HTML tags
  gsub("^\\s+|\\s+$", "", .)            #strip the white space from the beginning and end of a string.

film1 %>%
  html_nodes("td") %>% #grab the <td> tags
  html_text() %>% # isolate the text from the html tages
  gsub("^\\s+|\\s+$", "", .) %>% #strip the white space from the beginning and end of a string.
  head(n=12) # take a peek at the first 12 records

film1 %>%
  html_nodes("td") %>% #grab the <td> tags
  html_text() %>% # isolate the text from the html tages
  gsub("^\\s+|\\s+$", "", .," ", ":") %>% #strip the white space from the beginning and end of a string.
  head(n=12) # take a peek at the first 12 records
