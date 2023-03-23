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
    
     getElementsContent = function() {
       data <- c()
       for (asta_attuale in auctions) {
         data <- c(asta_attuale$serialize(), data)
       }
       return(data)
     },
     getCsvContent = function() {
       i = 1
       data <- matrix(0, length(auctions), 5)
       for (asta_attuale in auctions) {
         x <- asta_attuale$getCsvContent()
         data[i,] <- x
         i = i + 1
       }
       data = data.frame(data)
       colnames(data) <-
         c("auction ID", "start time", "end time", "lot", "lot number")
       return(data)
     },
#     addLot = function(lotto) {
#       lots <<- c(lots, lotto)
#     },
#     addAuction = function(asta) {
#       auctions <<- c(auctions, asta)
#     },
#     saveLots = function(file_name) {
#       path <- getwd()
#       print(paste("save", path))
#       myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
#       print(getElementsContent())
#       writeLines(getElementsContent(), myfile)
#       close(myfile)
#     },
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


aste = Aste$new()
aste$loadAuctions("aste.csv", "lotti.csv")

aste$getElementsContent()
aste$getCsvContent()
aste$saveAuctions("aste.csv")
