Lotto <- setRefClass(
  "Lotto",
  fields = list(
    pezzo_ID = "character",
    lotto_ID = "character",
    asta_ID = "character",
    l_prezzoIniziale = "numeric",
    l_prezzoMartello = "numeric"
  ),
  methods = list(
    initialize = function(p_ID = "undefined",
                          l_ID = "undefined",
                          a_ID = "undefined",
                          l_pI = 0,
                          l_pM = 0
    ) {
      pezzo_ID <<- p_ID
      lotto_ID <<- l_ID
      asta_ID <<- a_ID
      l_prezzoIniziale <<- l_pI
      l_prezzoMartello <<- l_pM
    },
    serialize = function() {
      return(paste(pezzo_ID, lotto_ID, asta_ID, l_prezzoIniziale, l_prezzoMartello, sep = ","))
    },
    getCsvContent = function(magazzino) {
      pezzo_nome <- magazzino$resolveID(pezzo_ID)
      return(c(pezzo_ID, pezzo_nome[1], lotto_ID, asta_ID, l_prezzoIniziale, l_prezzoMartello))
    },
    unserialize = function(line) {
      list = strsplit(line, ",")
      if (length(unlist(list)) > 3) {
        pezzo_ID <<- unlist(list)[1]
        lotto_ID <<- unlist(list)[2]
        asta_ID <<- unlist(list)[3]
        l_prezzoIniziale <<- as.integer(unlist(list)[4])
        if (length(unlist(list)) > 4) {
          l_prezzoMartello <<- as.integer(unlist(list)[5])
        }
      }
    }
  )
)

