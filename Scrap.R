#rvest es un nuevo paquete que facilita el raspado (o la recolección) de datos de páginas web html, inspirado en bibliotecas como la hermosa sopa . Está diseñado para trabajar con magrittr para que pueda expresar operaciones complejas como tuberías elegantes compuestas de piezas simples y fáciles de entender. Instalarlo con:

install.packages("rvest")

library("rvest")
library("XML")
library("xml2")

url = "http://www.imdb.com/chart/top?ref_=nv_wl_img_3"

page = read_html(url)

movie.nodes <- html_nodes(page,'.titleColumn a')

movie.link = sapply(html_attrs(movie.nodes),`[[`,'href')
movie.link = paste0("http://www.imdb.com",movie.link)
movie.cast = sapply(html_attrs(movie.nodes),`[[`,'title')
movie.name = html_text(movie.nodes)

#html_nodes(x, css, xpath)
#html_node(x, css, xpath)

#Arguments
#x Either a document, a node set or a single node.
#css, xpath Nodes to select. Supply one of css or xpath depending on whether you want to use a CSS or XPath 1.0 selector.

sec <- html_nodes(page,'.secondaryInfo')

year = as.numeric(gsub(")","",                          # Removing )
                       gsub("\\(","",                   # Removing (
                            html_text( sec )                 # get text of HTML node  
                       )))

rating.nodes = html_nodes(page,'.imdbRating')
# Check One node
xmlTreeParse(rating.nodes[[20]])

rating.nodes = html_nodes(page,'.imdbRating strong')
votes = as.numeric(gsub(',','',
                        gsub(' user ratings','',
                             gsub('.*?based on ','',
                                  sapply(html_attrs(rating.nodes),`[[`,'title')
                             ))))

rating = as.numeric(html_text(rating.nodes))

top250 <- data.frame(movie.name, movie.cast, movie.link,year,votes,rating)
