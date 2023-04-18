source("~/Documents/GitHub/gestione_aste/Asta.R")
Aste <- setRefClass(
  "Aste",
  fields = list(
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
    getCsvContentLotti = function() {
      data_lotti <- matrix(0, 0, 5)
      for (asta_attuale in auctions) {
        x <- asta_attuale$getCsvContentLotti()
        data_lotti <- rbind(data_lotti, x)
      }
      data_lotti = data.frame(data_lotti)
      colnames(data_lotti) <-
        c("piece ID", "lot ID", "auction ID", "start price", "hammer price")
      return(data_lotti)
    },
    getSelectBoxContentAste = function() {
      a_list <- list()
      for (asta_attuale in auctions) {
        a_label <- paste(asta_attuale$h_ID)  
        a_list[[a_label]] <- asta_attuale$h_ID
        print(a_label)
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
      print(paste("save", path))
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

# setwd("~/Documents/GitHub/gestione_aste")
# aste = Aste$new()
# aste$loadAuctions("aste.csv", "lotti.csv")
# #aste$auctions
# 
# aste$getCsvContentLotti()
# aste$getElementsContentLotti()
# aste$getCsvContentAste()
# aste$getElementsContentAste()
# 
# nuovaAsta = Asta$new(dataI= "30-03-2023", dataF = "31-03-2023")
# aste$addAuction(nuovaAsta)
# 
# nuovoLotto = Lotto$new (p_ID = "P390249",
#                         l_ID = "1",
#                         a_ID = nuovaAsta$h_ID,
#                         l_pI = 100,
#                         l_pM = 1000)
# aste$addLot(nuovoLotto)
# nuovoLotto2 = Lotto$new (p_ID = "P943254",
#                         l_ID = "2",
#                         a_ID = nuovaAsta$h_ID,
#                         l_pI = 200,
#                         l_pM = 300)
# aste$addLot(nuovoLotto2)
# 
# aste$save("aste2.csv", "lotti2.csv")
