# The class Venditore contains the information about the sellers (name, surname, address, and ID)
# and the functions for content serialization; thus we can convert the content of a class into a 
# text string and vice versa
Venditore <- setRefClass(
  "Venditore",
  fields = list(
    h_ID = "numeric",
    # "h_" means "hidden": it is a private field and the end user cannot see it or use it, 
    # Every time a new seller is created we associate a unique ID number
    name = "character",
    surname = "character",
    address = "character"
  ),
  methods = list(
    initialize = function(n = "undefined",
                          s = "undefined",
                          a = "") {
      h_ID <<- sample(1:1000000, 1)
      name <<- n
      surname <<- s
      address <<- a
    },
    serialize = function() {
      # The serialize function is a method to convert all content (seller) to a csv row
      return(paste(h_ID, name, surname, address, sep = ","))
    },
    getCsvContent = function() {
      return(c(h_ID, name, surname, address))
    },
    unserialize = function(line) {
      # The unserialize function divides the various elements of the csv row and returns a list 
      list = strsplit(line, ",")
      print(length(unlist(list)))
      h_ID <<- as.integer(unlist(list)[1])
      name <<- unlist(list)[2]
      surname <<- unlist(list)[3]
      if (length(unlist(list)) > 3) {
        address <<- unlist(list)[4]
      }
    }
  )
)
