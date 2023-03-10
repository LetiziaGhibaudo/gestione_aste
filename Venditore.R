# The class Venditore contains the information about the sellers (name, surname, address, and ID)
# and the functions for content serialization; thus we can convert the content of a class into a 
# text string and vice versa
Venditore <- setRefClass(
  "Venditore",
  fields = list(
    h_ID = "character",
    # "h_" means "hidden": it is a private field and the end user cannot see it or use it, 
    # Every time a new seller is created we associate a unique ID number
    v_name = "character",
    v_surname = "character",
    v_address = "character"
  ),
  methods = list(
    initialize = function(v_n = "undefined",
                          v_s = "undefined",
                          v_a = "") {
      h_ID <<- paste0("V", sample(1:1000000, 1))
      v_name <<- v_n
      v_surname <<- v_s
      v_address <<- v_a
    },
    serialize = function() {
      # The serialize function is a method to convert all content (seller) to a csv row
      return(paste(h_ID, v_name, v_surname, v_address, sep = ","))
    },
    getCsvContent = function() {
      return(c(h_ID, v_name, v_surname, v_address))
    },
    unserialize = function(line) {
      # The unserialize function divides the various elements of the csv row and returns a list 
      list = strsplit(line, ",")
      print(length(unlist(list)))
      h_ID <<- unlist(list)[1]
      v_name <<- unlist(list)[2]
      v_surname <<- unlist(list)[3]
      if (length(unlist(list)) > 3) {
        v_address <<- unlist(list)[4]
      }
    }
  )
)
