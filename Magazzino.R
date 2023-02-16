Magazzino <- setRefClass(
  "Magazzino",
  fields = list(pieces = "list"),
  methods = list(
    load = function(file_name) {
      path <- getwd()
      print(paste("load", path))
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      entries = length(lines)
      pieces <<- list()
      for (i in 1:entries) {
        pezzo = Pezzo$new()
        pezzo$unserialize(lines[i])
        pieces <<- c(pieces, pezzo)
      }
      close(myfile)
    },
    getElementsContent = function() {
      data <- c()
      for (pezzo_attuale in pieces) {
        data <- c(pezzo_attuale$serialize(), data)
      }
      return(data)
    },
    getCsvContent = function() {
      i = 1
      data <- matrix(0, length(pieces), 10)
      for (pezzo_attuale in pieces) {
        x <- pezzo_attuale$getCsvContent()
        data[i,] <- x
        i = i + 1
      }
      data = data.frame(data)
      colnames(data) <-
        c("ID", "vendor ID", "name", "description", "height (cm)", "length (cm)", "width (cm)", "low estimate", "high estimate", "added")
      return(data)
    },
    addPezzo = function(pezzo) {
      pieces <<- c(pieces, pezzo)
    },
    save = function(file_name) {
      path <- getwd()
      print(paste("save", path))
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      print(getElementsContent())
      writeLines(getElementsContent(), myfile)
      close(myfile)
    }
  )
)




magazzino = Magazzino$new()
magazzino$load("pezzi.csv")
magazzino$getCsvContent()

nuovoPezzo = Pezzo$new(venditore_ID = 210723, name = "Bruno Gambone (1936-2021) Set of two bottles - Limited edition", description = "Stoneware 
Signed 'Gambone Italy' Creation date: circa 1985-1987", height_cm = 30, length_cm = 13.5, width_cm = 13, lowEstimate = 2500, highEstimate = 3500, added = "16/02/2023")
magazzino$addPezzo(nuovoPezzo)
magazzino$save("pezzi.csv")



