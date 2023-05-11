# The class Asta contains the information about the auctions (associated lots, starting and ending time, 
# and ID) and the functions for content serialization; thus we can convert the content of a class into 
# a text string and vice versa
source("~/Documents/GitHub/gestione_aste/Lotto.R")
Asta <- setRefClass(
  "Asta",
  fields = list(
    h_ID = "character",
    # "h_" means "hidden": it is a private field and the end user cannot see it or use it. 
    # Every time a new auction is created we associate a unique ID number
    dataInizio = "character",
    dataFine = "character",
    lotti = "list",
    contatore = "numeric"
  ),
  methods = list(
    initialize = function(dataI = "undefined",
                          dataF = "undefined",
                          l = list(),
                          contatore = 1) {
      h_ID <<- paste0("A", sample(1:1000000, 1))
      dataInizio <<- dataI
      dataFine <<- dataF
      lotti <<- l
      contatore <<- 1
    },
    serialize = function() {
      # The serialize function is a method to convert all content (auction) to a csv row
      return(paste(h_ID, dataInizio, dataFine, contatore, sep = ","))
    },
    getElementsContentLotti = function() {
      data <- c()
      for (lotto_attuale in lotti) {
        data <- c(lotto_attuale$serialize(), data)
      }
      return(data)
    },
    getCsvContent = function() {
      return(c(h_ID, dataInizio, dataFine))
    },
    getCsvContentLotti = function(magazzino) {
      i = 1
      data_lotti <- matrix(0, length(lotti), 6)
      for(lotto_attuale in lotti) {
        x <- lotto_attuale$getCsvContent(magazzino)
        data_lotti[i,] <- x
        i = i + 1
      }
      return(data_lotti)
    },
    unserialize = function(line, file_name) {
      # The unserialize function divides the various elements of the csv row and returns a list
      list = strsplit(line, ",")
      if (length(unlist(list)) > 2) {
        h_ID <<- unlist(list)[1]
        dataInizio <<- unlist(list)[2]
        dataFine <<- unlist(list)[3]
        if (length(unlist(list)) > 3) {
          contatore <<- as.integer(unlist(list)[4])
        }
        loadLots(file_name)
      }
    },
    loadLots = function(file_name) {
      path <- getwd()
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      close(myfile)
      entries = length(lines)
      for (i in 1:entries) {
        lotto = Lotto$new()
        lotto$unserialize(lines[i])
        if(lotto$asta_ID == h_ID) {
          lotti <<- c(lotti, lotto)
        } 
      }
    },
    addLotto = function(lotto) {
      lotto$lotto_ID <- as.character(contatore)
      contatore <<- contatore +1
      lotti <<- c(lotti, lotto)
    }
  )
)

