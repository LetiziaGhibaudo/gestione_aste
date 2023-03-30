# The class Anagrafica is responsible for loading and saving the vendors list;
# Furthermore, we can add a new seller and they will be saved in the csv file as a new row
source("~/Documents/GitHub/gestione_aste/Venditore.R")
Anagrafica <- setRefClass(
  "Anagrafica",
  fields = list(vendors = "list"),
  methods = list(
    load = function(file_name) {
      # load is a function that takes the file name as a parameter, for each row creates a 
      # vendor and calls it (unserialize function), prints and processes all rows one by one, 
      # loading the csv file
      path <- getwd()
      print(paste("load", path))
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      entries = length(lines)
      vendors <<- list()
      for (i in 1:entries) {
        venditore = Venditore$new()
        venditore$unserialize(lines[i])
        vendors <<- c(vendors, venditore)
      }
      close(myfile)
    },
    getElementsContent = function() {
      data <- c()
      for (venditore_attuale in vendors) {
        data <- c(venditore_attuale$serialize(), data)
      }
      return(data)
    },
    getCsvContent = function() {
      i = 1
      data <- matrix(0, length(vendors), 4)
      # we create a matrix that will be filled with the vendors data
      for (venditore_attuale in vendors) {
        x <- venditore_attuale$getCsvContent()
        data[i,] <- x
        i = i + 1
      }
      data = data.frame(data)
      colnames(data) <-
        c("ID", "name", "surname", "address")
      return(data)
    },
    getSelectBoxContent = function() {
      v_list <- list()
      for (venditore_attuale in vendors) {
      label <- paste(venditore_attuale$v_name, venditore_attuale$v_surname, venditore_attuale$h_ID, sep = "-")  
      v_list[[label]] <- venditore_attuale$h_ID
      print(label)
      }
      return(v_list)
      },
      
    addVenditore = function(venditore) {
      # the function creates a new seller 
      vendors <<- c(vendors, venditore)
    },
    save = function(file_name) {
      path <- getwd()
      print(paste("save", path))
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      # the mode "w+" opens the file for reading and writing, truncating file initially
      print(getElementsContent())
      writeLines(getElementsContent(), myfile)
      close(myfile)
    }
  )
)


