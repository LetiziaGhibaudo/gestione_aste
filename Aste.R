source("~/Documents/GitHub/gestione_aste/Asta.R")
Aste <- setRefClass(
  "Aste",
  fields = list(
    auctions = "list"
  ),
  methods = list(
    loadAuctions = function(file_name_aste, file_name_lotti) {
      path <- getwd()
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
      data_aste <- c()
      for (asta_attuale in auctions) {
        data_aste <- c(asta_attuale$serialize(), data_aste)
      }
      return(data_aste)
    },
    getElementsContentLotti = function() {
      data_lotti <- c()
      for (asta_attuale in auctions) {
        data_lotti <- c(asta_attuale$getElementsContentLotti(), data_lotti)
      }
      return(data_lotti)
    },
    getCsvContentAste = function() {
      i = 1
      data_aste <- matrix(0, length(auctions), 3)
      for (asta_attuale in auctions) {
        x <- asta_attuale$getCsvContent()
        data_aste[i,] <- x
        i = i + 1
      }
      data_aste = data.frame(data_aste)
      colnames(data_aste) <-
        c("auction ID", "start time", "end time")
      return(data_aste)
    },
    getCsvContentLotti = function(magazzino) {
      data_lotti <- matrix(0, 0, 6)
      for (asta_attuale in auctions) {
        x <- asta_attuale$getCsvContentLotti(magazzino)
        data_lotti <- rbind(data_lotti, x)
      }
      data_lotti = data.frame(data_lotti)
      colnames(data_lotti) <-
        c("Piece ID", "Piece name","Lot ID", "Auction ID", "Start price", "Hammer price")
      return(data_lotti)
    },
    getSelectBoxContentAste = function() {
      a_list <- list()
      for (asta_attuale in auctions) {
        a_label <- paste(asta_attuale$h_ID)  
        a_list[[a_label]] <- asta_attuale$h_ID
      }
      return(a_list)
    },
    addLot = function(lotto) {
      for (asta_attuale in auctions) {
        if (asta_attuale$h_ID == lotto$asta_ID) {
          asta_attuale$addLotto(lotto)
        }
      }
    },
    addAuction = function(asta) {
      auctions <<- c(auctions, asta)
    },
    save = function(file_name_aste, file_name_lotti) {
      path <- getwd()
      if (length(getElementsContentAste()) > 0) {
        myfile_aste = file(paste(path, "/", file_name_aste, sep = ""), open = "w+")
        writeLines(getElementsContentAste(), myfile_aste)
        close(myfile_aste)
      }
      if (length(getElementsContentLotti()) > 0) {
        myfile_lotti = file(paste(path, "/", file_name_lotti, sep = ""), open = "w+")
        writeLines(getElementsContentLotti(), myfile_lotti)
        close(myfile_lotti)
      }
    }
  )
)

