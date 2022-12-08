Anagrafica <- setRefClass("Anagrafica",
                          fields = list(vendors = "list" ), 
                          methods = list(
                          
                          
                            load = function(file_name) {
                            path <- getwd()
                            myfile = file(paste(path,"/prova.txt", sep = ""))
                            lines = readLines(myfile)
                            entries = length(lines)
                            for (i in 1:entries) {
                              venditore = venditore$new()
                              venditore$unserialize(lines[i])
                              vendors <<- c(vendors, venditore)
                             print(lines)
                             }
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


