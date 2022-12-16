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
                          



