# The class Aste is responsible for loading and saving the auctions list;
# Furthermore, we can add new auctions (and associate lots) and they will be saved 
# in the csv file as new rows
source("~/Documents/GitHub/gestione_aste/Asta.R")
Aste <- setRefClass(
  "Aste",
  fields = list(
    auctions = "list"
  ),
  methods = list(
    loadAuctions = function(file_name_aste, file_name_lotti) {
      # loadAuctions is a function that takes the auctions file name and the lots file name as 
      # parameters, for each row creates an auction and calls it (unserialize function), prints and 
      # processes all rows one by one, loading the csv file
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
    getCsvContentAste = function(showExpired) {
      i = 1
      # we create a matrix that will be filled with the auctions data
      for (asta_attuale in auctions) {
        if ((showExpired == TRUE) || (asta_attuale$isExpired() == FALSE)) {
          ongoing_auctions <- c(asta_attuale$isExpired())
          data_aste <- matrix(0, length(ongoing_auctions), 3)
          x <- asta_attuale$getCsvContent()
          data_aste[i,] <- x
          i = i + 1
        } 
      }
      data_aste = data.frame(data_aste)
      colnames(data_aste) <-
        c("auction ID", "start time", "end time")
      return(data_aste)
    },
    getCsvContentLotti = function(magazzino) {
      data_lotti <- matrix(0, 0, 6)
      # we create a matrix that will be filled with the lots data
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
      # the function creates a new lot 
      for (asta_attuale in auctions) {
        if (asta_attuale$h_ID == lotto$asta_ID) {
          asta_attuale$addLotto(lotto)
        }
      }
    },
    addAuction = function(asta) {
      # the function creates a new auction
      auctions <<- c(auctions, asta)
    },
    save = function(file_name_aste, file_name_lotti) {
      path <- getwd()
      if (length(getElementsContentAste()) > 0) {
        myfile_aste = file(paste(path, "/", file_name_aste, sep = ""), open = "w+")
        # the mode "w+" opens the file for reading and writing, truncating file initially
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

