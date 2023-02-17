Pezzo <- setRefClass(
  "Pezzo",
  fields = list(
    h_ID = "numeric",
    venditore_ID = "numeric", 
    name = "character",
    description = "character",
    height_cm = "numeric", # load function non carica (l'assegnazione non valida per il campo della classe riferimento ‘height_cm’, dovrebbe appartenere alla classe “numeric” o a una sottoclasse (era la classe “character”))
    length_cm = "numeric",
    width_cm ="numeric",
    lowEstimate = "numeric",
    highEstimate = "numeric",
    added = "character"
  ),
  methods = list(
    initialize = function(v_ID = 0,
                          n = "undefined",
                          d = "undefined",
                          h_cm = 0,
                          l_cm = 0,
                          w_cm = 0,
                          low_e = 0,
                          high_e = 0,
                          a = "undefined") {
      h_ID <<- sample(1:1000000, 1)
      venditore_ID <<- v_ID
      name <<- n
      description <<- d
      height_cm <<- h_cm
      length_cm <<- l_cm
      width_cm <<- w_cm
      lowEstimate <<- low_e
      highEstimate <<- high_e
      added <<- a
    },
    serialize = function() {
      return(paste(h_ID, venditore_ID, name, description, height_cm, length_cm, width_cm, lowEstimate, highEstimate, added, sep = ","))
    },
    getCsvContent = function() {
      return(c(h_ID, venditore_ID, name, description, height_cm, length_cm, width_cm, lowEstimate, highEstimate, added))
    },
    unserialize = function(line) {
      list = strsplit(line, ",")
      print(length(unlist(list)))
      if (length(unlist(list)) > 8) {
        h_ID <<- as.integer(unlist(list)[1])
        venditore_ID <<- as.integer(unlist(list)[2])
        name <<- unlist(list)[3]
        description <<- unlist(list)[4]
        height_cm <<- as.integer(unlist(list)[5])
        length_cm <<- as.integer(unlist(list)[6])
        width_cm <<- as.integer(unlist(list)[7])
        lowEstimate <<- as.integer(unlist(list)[8])
        highEstimate <<- as.integer(unlist(list)[9])
        if (length(unlist(list)) > 9) {
          added <<- unlist(list)[10]
        }
        return(TRUE)
      }
      return(FALSE)
    }
  )
)



#write.table(x = "345678, 224135, Les Mariés au village le soir, Marc CHAGALL signed (lower center) - 
#oil tempera and pencil on canvas, 27, 46, , 30000000, 5000000, 15/02/2023\n
#456789, 123456, Trois danseuses, Edgar DEGAS (1834-1917) signed 'Degas' (lower right) pastel and charcoal on paper laid down on board, 80, 51, 1500000, 2000000, 20/01/2023\n
#567890, 234567, Pair of Chests of Drawers designed circa 1957, Gio PONTI (1891-1979) manufactured by Giordano Chiesa Italy maple laminate brass, 79, 100, 47, 80000, 120000, 15/05/2021",
#            file = paste("~/Documents/GitHub/gestione_aste", "/pezzi.csv", sep = ""),
#            row.names = FALSE, col.names = FALSE, quote = FALSE)

