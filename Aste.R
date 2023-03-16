Aste <- setRefClass(
  "Aste",
  fields = list(
    lots = "list",
    auctions = "list",
    isLot = "logical"
  ),
  methods = list(
    is_lot = function() {
      if (a_ID == h_ID) { #controllare a_ID e h_ID <- funzionano ?
        isLot <<- TRUE
      } else {
        isLot <<- FALSE
      }
    },
    loadLots = function(file_name) {
      path <- getwd()
      print(paste("load", path))
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      entries = length(lines)
      lots <<- list()
      for (i in 1:entries) {
        lotto = Lotto$new()
        if((lotto$unserialize(lines[i])) && (lotto$a_ID == asta$h_ID) == TRUE) {
          lots <<- c(lots, lotto)
        }
      }
      close(myfile)
    },
    
    loadAuctions = function(file_name) {
      path <- getwd()
      print(paste("load", path))
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      entries = length(lines)
      auctions <<- list()
      for (i in 1:entries) {
        asta = Asta$new()
        if((asta$unserialize(lines[i])) == TRUE) {
          auctions <<- c(auctions, asta)
        }
      }
      close(myfile)
    },
    getElementsContent = function() {
      data <- c()
      for (asta_attuale in auctions) {
        data <- c(asta_attuale$serialize(), data)
      }
      return(data)
    },
    getCsvContent = function() {
      i = 1
      data <- matrix(0, length(auctions), 4)
      for (asta_attuale in auctions) {
        x <- asta_attuale$getCsvContent()
        data[i,] <- x
        i = i + 1
      }
      data = data.frame(data)
      colnames(data) <-
        c("auction ID", "start time", "end time", "lots")
      return(data)
    },
    addLot = function(lotto) {
      lots <<- c(lots, lotto)
    },
    addAuction = function(asta) {
      auctions <<- c(auctions, asta)
    },
    saveLots = function(file_name) {
      path <- getwd()
      print(paste("save", path))
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      print(getElementsContent())
      writeLines(getElementsContent(), myfile)
      close(myfile)
    },
    saveAuctions = function(file_name) {
      path <- getwd()
      print(paste("save", path))
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      print(getElementsContent())
      writeLines(getElementsContent(), myfile)
      close(myfile)
    }
  )
)


asta = Asta$new()
asta$loadAuctions("aste.csv")
asta$getCsvContent()

lotto = Lotto$new()
lotto$loadLots("lotti.csv")
lotto$getCsvContent()

