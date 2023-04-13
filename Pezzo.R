Pezzo <- setRefClass(
  "Pezzo",
  fields = list(
    h_ID = "character",
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
      return(paste(h_ID, venditore_ID, p_name, description, height_cm, length_cm, width_cm, p_lowEstimate, p_highEstimate, p_added, sep = ","))
    },
    getCsvContent = function(anagrafica) {
      venditore_nome_cognome <- anagrafica$resolveID(venditore_ID)
      return(c(h_ID, venditore_nome_cognome[1], venditore_nome_cognome[2], p_name, description, height_cm, length_cm, width_cm, p_lowEstimate, p_highEstimate, p_added))
    },
    unserialize = function(line) {
      list = strsplit(line, ",")
      print(length(unlist(list)))
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



#write.table(x = "345678, 224135, Les Mariés au village le soir, Marc CHAGALL signed (lower center) - 
#oil tempera and pencil on canvas, 27, 46, , 30000000, 5000000, 15/02/2023\n
#456789, 123456, Trois danseuses, Edgar DEGAS (1834-1917) signed 'Degas' (lower right) pastel and charcoal on paper laid down on board, 80, 51, 1500000, 2000000, 20/01/2023\n
#567890, 234567, Pair of Chests of Drawers designed circa 1957, Gio PONTI (1891-1979) manufactured by Giordano Chiesa Italy maple laminate brass, 79, 100, 47, 80000, 120000, 15/05/2021",
#            file = paste("~/Documents/GitHub/gestione_aste", "/pezzi.csv", sep = ""),
#            row.names = FALSE, col.names = FALSE, quote = FALSE)

