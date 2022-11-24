Venditore <- setRefClass("Venditore",
                         fields = list(h_ID = "numeric",
                                       name = "character",
                                       surname = "character", 
                                       address = "character"
                         ),
                         methods = list(
                           initialize = function(n, s) {
                             h_ID <<- sample(1:1000000, 1)
                             name <<- n
                             surname <<- s
                           }, serialize = function() {
                             return(paste(h_ID, name, surname, address, sep=","))
                           },
                           unserialize = function(line) {
                             list = strsplit(line, ",")
                             h_ID <<- as.integer(unlist(list)[1])
                             name <<- unlist(list)[2]
                             surname <<- unlist(list)[3]
                             if (size(unist(list)) > 3) {
                               address <<- unlist(list)[4]
                             }
                           }
                         ))