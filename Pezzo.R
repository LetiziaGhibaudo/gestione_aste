# The class Pezzo contains the information about the pieces (associated vendor ID, piece name, 
# description, dimensions, low and high estimate, date, and ID) and the functions for content 
# serialization; thus we can convert the content of a class into a text string and vice versa
Pezzo <- setRefClass(
  "Pezzo",
  fields = list(
    h_ID = "character",
    # "h_" means "hidden": it is a private field and the end user cannot see it or use it. 
    # Every time a new piece is created we associate a unique ID number
    venditore_ID = "character", 
    p_name = "character",
    description = "character",
    height_cm = "numeric",
    length_cm = "numeric",
    width_cm ="numeric",
    p_lowEstimate = "numeric",
    p_highEstimate = "numeric",
    p_added = "character"
  ),
  methods = list(
    initialize = function(v_ID = "undefined",
                          p_n = "undefined",
                          d = "undefined",
                          h_cm = 0,
                          l_cm = 0,
                          w_cm = 0,
                          p_low_e = 0,
                          p_high_e = 0,
                          p_a = "undefined") {
      h_ID <<- paste0("P", sample(1:1000000, 1))
      venditore_ID <<- v_ID
      p_name <<- p_n
      description <<- d
      height_cm <<- h_cm
      length_cm <<- l_cm
      width_cm <<- w_cm
      p_lowEstimate <<- p_low_e
      p_highEstimate <<- p_high_e
      p_added <<- p_a
    },
    serialize = function() {
      # The serialize function is a method to convert all content (piece) to a csv row
      return(paste(h_ID, venditore_ID, p_name, description, height_cm, length_cm, width_cm, p_lowEstimate, p_highEstimate, p_added, sep = ","))
    },
    getCsvContent = function(anagrafica) {
      venditore_nome_cognome <- anagrafica$resolveID(venditore_ID)
      return(c(h_ID, venditore_nome_cognome[1], venditore_nome_cognome[2], p_name, description, height_cm, length_cm, width_cm, p_lowEstimate, p_highEstimate, p_added))
    },
    unserialize = function(line) {
      # The unserialize function divides the various elements of the csv row and returns a list
      list = strsplit(line, ",")
      if (length(unlist(list)) > 8) {
        h_ID <<- unlist(list)[1]
        venditore_ID <<- unlist(list)[2]
        p_name <<- unlist(list)[3]
        description <<- unlist(list)[4]
        height_cm <<- as.integer(unlist(list)[5])
        length_cm <<- as.integer(unlist(list)[6])
        width_cm <<- as.integer(unlist(list)[7])
        p_lowEstimate <<- as.integer(unlist(list)[8])
        p_highEstimate <<- as.integer(unlist(list)[9])
        if (length(unlist(list)) > 9) {
          p_added <<- unlist(list)[10]
        }
        return(TRUE)
      }
      return(FALSE)
    }
  )
)
