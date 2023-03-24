source("~/Documents/GitHub/gestione_aste/Asta.R")
Aste <- setRefClass(
  "Aste",
  fields = list(
    lots = "list",
    auctions = "list"
  ),
  methods = list(
    loadAuctions = function(file_name_aste, file_name_lotti) {
      path <- getwd()
      print(paste("load", path))
      myfile = file(paste(path, "/", file_name_aste, sep = ""))
      lines = readLines(myfile)
      close(myfile)
      entries = length(lines)
      auctions <<- list()
      for (i in 1:entries) {
        asta = Asta$new()
        asta$unserialize(lines[i], file_name_lotti)
        auctions <<- c(auctions, asta)
      }
    },
    
    getElementsContentAste = function() {
      data <- c()
      for (asta_attuale in auctions) {
        data <- c(asta_attuale$serialize(), data)
      }
      return(data)
    },
    getElementsContentLotti = function() {
      data <- c()
      for (asta_attuale in auctions) {
        data <- c(asta_attuale$getElementsContentLotti(), data)
      }
      return(data)
    },
    getCsvContentAste = function() {
      i = 1
      data <- matrix(0, length(auctions), 4)
      for (asta_attuale in auctions) {
        x <- asta_attuale$getCsvContent()
        data[i,] <- x
        i = i + 1
      }
      data = data.frame(data)
      colnames(data) <-
        c("auction ID", "start time", "end time", "contatore")
      return(data)
    },
    getCsvContentLotti = function() {
      data <- matrix(0, 0, 5)
      for (asta_attuale in auctions) {
        x <- asta_attuale$getCsvContentLotti()
        data <- rbind(data, x)
      }
      data = data.frame(data)
      colnames(data) <-
        c("piece ID", "lot ID", "auction ID", "start price", "hammer price")
      return(data)
    },
    addLot = function(lotto) {
           lots <<- c(lots, lotto)
         },
    addAuction = function(asta) {
           auctions <<- c(auctions, asta)
         },
    save = function(file_name_aste, file_name_lotti) {
      path <- getwd()
      print(paste("save", path))
      myfile_aste = file(paste(path, "/", file_name_aste, sep = ""), open = "w+")
      writeLines(getElementsContentAste(), myfile_aste)
      close(myfile_aste)
      myfile_lotti = file(paste(path, "/", file_name_lotti, sep = ""), open = "w+")
      writeLines(getElementsContentLotti(), myfile_lotti)
      close(myfile_lotti)
    }
  )
)


aste = Aste$new()
aste$loadAuctions("aste.csv", "lotti.csv")


aste$getCsvContent()
aste$save("aste2.csv", "lotti2.csv")
