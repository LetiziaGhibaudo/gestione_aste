rm(list = ls())
setwd("~/Documents/GitHub/gestione_aste")
source("~/Documents/GitHub/gestione_aste/Venditore.R")
Anagrafica <- setRefClass("Anagrafica",
                          fields = list(vendors = "list" ), 
                          methods = list(
                          
                          
                            load = function(file_name) {
                            path <- getwd()
                            myfile = file(paste(path,"/", file_name, sep = ""))
                            lines = readLines(myfile)
                            entries = length(lines)
                            #print(lines)
                            for (i in 1:entries) {
                              venditore = Venditore$new()
                              venditore$unserialize(lines[i])
                              vendors <<- c(vendors, venditore)
                             
                             }
                            },
                            show = function() {
                              heather <- "ID, name, surname, address"
                              print(heather)
                              for(venditore_attuale in vendors) {
                                print(venditore_attuale$serialize())
                              }
                                
                              
                            },
                            addVenditore = function(venditore) {
                              vendors <<- c(vendors, venditore)
                            }
                                
                              
                              
                             
                            
                            
                             
                          
                          )
)
                          


# Example test                               
path <- getwd()


write.table(x = "987654, Mario, Rossi, Via Roma 1\n123456, Irene, Bianchi, Via Garibaldi 2\n234567, Elisa, Verdi, Via Marconi 3",
            file = paste(path, "/prova.txt", sep = ""),
            row.names = FALSE, col.names = FALSE, quote = FALSE)

# readLines function
#prova_txt <- readLines(paste(path, "/prova.txt", sep = ""))
#prova_txt

anagrafica = Anagrafica$new()
anagrafica$load("prova.txt")
anagrafica$show()


nuovoVenditore = Venditore$new(n = "Filippo", s = "Verdi", a = "Casa di Filippo 55")
anagrafica$addVenditore(nuovoVenditore)
anagrafica$show()


