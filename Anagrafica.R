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
                              header <- "ID, name, surname, address"
                              print(header)
                              for(venditore_attuale in vendors) {
                                print(venditore_attuale$serialize())
                              }
                                
                              
                            },
                            getCsvContent = function() {
                              i= 1
                              data <- matrix(0, length(vendors), 4)
                              
                              for(venditore_attuale in vendors) {
                                x <- venditore_attuale$getCsvContent()
                                data[i, ] <- x
                                
                                i = i+1
                                
                              }
                              data = data.frame(data)
                             colnames(data) <- c("ID", "name", "surname", "address")
                              return(data)
                            },
                            
                            addVenditore = function(venditore) {
                              vendors <<- c(vendors, venditore)
                            }
                        
                                
                              
                              
                             
                            
                            
                             
                          
                          )
)
                          



