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
    v_address = "character",
    v_phone = "character",
    v_mail = "character",
    v_commission = "character"
  ),
  methods = list(
    initialize = function(v_n = "undefined",
                          v_s = "undefined",
                          v_a = "",
                          v_ph = "",
                          v_mail = "",
                          v_comm = "") {
      h_ID <<- paste0("V", sample(1:1000000, 1))
      v_name <<- v_n
      v_surname <<- v_s
      v_address <<- v_a
      v_phone <<- v_ph
      v_mail <<- v_mail
      v_commission <<- paste0(v_comm, "%")
    },
    serialize = function() {
      # The serialize function is a method to convert all content (seller) to a csv row
      return(paste(h_ID, v_name, v_surname, v_address, v_phone, v_mail, v_commission, sep = ","))
    },
    getCsvContent = function() {
      return(c(h_ID, v_name, v_surname, v_address, v_phone, v_mail, v_commission))
    },
    unserialize = function(line) {
      # The unserialize function divides the various elements of the csv row and returns a list 
      list = strsplit(line, ",")
      print(length(unlist(list)))
      if (length(unlist(list)) > 5) {
      h_ID <<- unlist(list)[1]
      v_name <<- unlist(list)[2]
      v_surname <<- unlist(list)[3]
      v_address <<- unlist(list) [4]
      v_phone <<- unlist(list)[5]
      v_mail <<- unlist(list)[6]
      if (length(unlist(list)) > 6) {
        v_commission <<- unlist(list)[7]
      }
      return(TRUE)
      }
      return(FALSE)
    }
  )
)
