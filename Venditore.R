Venditore <- setRefClass("Venditore",
                         fields = list(h_ID = "numeric",
                                       name = "character",
                                       surname = "character", 
                                       address = "character"
                         ),
                         methods = list(
                           initialize = function(n = "undefined", s = "undefined",a = "") {
                             h_ID <<- sample(1:1000000, 1)
                             name <<- n
                             surname <<- s
                             address <<- a
                           }, 
                           serialize = function() {
                             return(paste(h_ID, name, surname, address, sep=","))
                           },
                           getCsvContent = function() {
                             return(c(h_ID, name, surname, address))
                           },
                           unserialize = function(line) {
                            list = strsplit(line, ",")
                            print(length(unlist(list)))
                             h_ID <<- as.integer(unlist(list)[1])
                             name <<- unlist(list)[2]
                             surname <<- unlist(list)[3]
                             if (length(unlist(list)) > 3) {
                               address <<- unlist(list)[4]
                             }
                           }
                         ))


