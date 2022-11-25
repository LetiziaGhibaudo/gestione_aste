Anagrafica <- setRefClass("Anagrafica",
                          fields = list(vendors = "list" ), 
                          methods = list(
                            upload = function(vendors) {
                              read.csv("Path to File")
                            },
                            save = function(vendors) {
                              write.csv(DataFrame,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)
                            }
                          ))