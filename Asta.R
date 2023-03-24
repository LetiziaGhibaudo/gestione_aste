source("~/Documents/GitHub/gestione_aste/Lotto.R")
Asta <- setRefClass(
  "Asta",
  fields = list(
    h_ID = "character",
    dataInizio = "character",
    dataFine = "character",
    lotti = "list",
    contatore = "numeric"
  ),
  methods = list(
    initialize = function(dataI = "undefined",
                          dataF = "undefined",
                          l = list(),
                          contatore = 1
                          ) {
      h_ID <<- paste0("A", sample(1:1000000, 1))
      dataInizio <<- dataI
      dataFine <<- dataF
      lotti <<- l
      contatore <<- 1
    },
    serialize = function() {
      return(paste(h_ID, dataInizio, dataFine, lotti, contatore, sep = ","))
    },
    getElementsContentLotti = function() {
      data <- c()
      for (lotto_attuale in lotti) {
        data <- c(lotto_attuale$serialize(), data)
      }
      return(data)
    },
    getCsvContent = function() {
      return(c(h_ID, dataInizio, dataFine, contatore))
    },
    getCsvContentLotti = function() {
      i = 1
      data <- matrix(0, length(lotti), 5)
      for(lotto in lotti) {
        x <- lotto$getCsvContent()
        data[i,] <- x
        i = i + 1
      }
      return(data)
    },
    unserialize = function(line, file_name) {
      list = strsplit(line, ",")
      print(length(unlist(list)))
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
      print(paste("load", path))
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      close(myfile)
      entries = length(lines)
      for (i in 1:entries) {
        lotto = Lotto$new()
        lotto$unserialize(lines[i])
        print(h_ID)
        print(lotto$asta_ID)
        if(lotto$asta_ID == h_ID) {
          lotti <<- c(lotti, lotto)
        } 
      }
      
    }
    
  )
)


lotto = Lotto$new()
asta = Asta$new()
asta$loadLots("lotti.csv")
asta$getCsvContentLotti()


