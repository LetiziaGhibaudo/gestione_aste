Anagrafica <- setRefClass("Anagrafica",
                          fields = list(vendors = "list" ), 
                          methods = list(
                          
                          
                            load = function(file_name) {
                            path <- getwd()
                            myfile = file(paste(path,"/prova.txt", sep = ""))
                            lines = readLines(myfile)
                            entries = length(lines)
                            #print(lines)
                            for (i in 1:entries) {
                              venditore = venditore$new()
                              venditore$unserialize(lines[i])
                              vendors <<- c(vendors, venditore)
                             
                             }
                            },
                            show = function() {
                              heather <- "ID, name, surname, address"
                              x <- c(heather, lines)
                              writeLines(x)
                            },
                            addVenditore = function() {
                                newvendor <- append(x, nuovoVenditore, after = length(x))
                                #newvendor <- append(x, Venditore$new, after = length(x))
                            }
                                
                              
                              
                             
                            
                            
                             
                          
                          )
)
                          


# Example test                               
path <- getwd()


write.table(x = "987654, Mario Rossi, Via Roma 1\n123456 Irene Bianchi, Via Garibaldi 2\n234567, Elisa Verdi, Via Marconi 3",
            file = paste(path, "/prova.txt", sep = ""),
            row.names = FALSE, col.names = FALSE, quote = FALSE)

# readLines function
#prova_txt <- readLines(paste(path, "/prova.txt", sep = ""))
#prova_txt

anagrafica = Anagrafica$new()
anagrafica$load("/Users/god/Download/venditori_ufficiale.csv")
anagrafica$show()


nuovoVenditore = Venditore$new(n = "Filippo", s = "Verdi", address = "Casa di Filippo 55")
anagrafica$addVenditore(nuovoVenditore)
anagrafica$show()


