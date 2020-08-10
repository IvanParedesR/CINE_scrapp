#rvest es un paquete que facilita el raspado (o la recolecci?n) de datos de p?ginas web html, inspirado en bibliotecas como la hermosa sopa . Est? dise?ado para trabajar con magrittr para que pueda expresar operaciones complejas como tuber?as elegantes compuestas de piezas simples y f?ciles de entender. Instalarlo con:
#install.packages("rvest")

#Paquetenes necesarios
library("rvest")
library("XML")
library("xml2")
library(magrittr, lib.loc = "C:/Users/iparedes/Documents/R/R-3.6.2/library")

#The basic functions in rvest are powerful, and you should try to utilize the following functions when starting out a new project.

# html_nodes(): identifies HTML wrappers.
# html_nodes(".class"): calls node based on css class
# html_nodes("#id"): calls node based on <div> id
# html_nodes(xpath="xpath"): calls node based on xpath (we’ll cover this later)
# html_attrs(): identifies attributes (useful for debugging)
# html_table(): turns HTML tables into data frames
# html_text(): strips the HTML tags and extracts only the text

#The html_nodes() vuelve los datos de la página en un dataframe.
url = "https://www.filmaffinity.com/mx/rdcat.php?id=upc_th_mx"
film1 = read_html(url)

#Todo lo que tenga un enlace lo saca.
film2 <- film1 %>%
  html_nodes("a") %>%
  head()


#Every div on the page:
film3 <- film1 %>%
  html_nodes("div") %>%
  head()

#the nav-tools div. This calls by css where class=nav-tools.

film4 <- film1 %>%
  html_nodes("div.nav-tools") %>%
  head()

#We can call the nodes by id as follows.

film5 <- film1 %>%
  html_nodes("div#project-listing") %>%
  head()

#All the tables as follows:

film6 <- film1 %>%
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
