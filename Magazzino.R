# The class Magazzino is responsible for loading and saving the pieces list;
# Furthermore, we can add a new piece and it will be saved in the csv file as a new row
source("~/Documents/GitHub/gestione_aste/Pezzo.R")
Magazzino <- setRefClass(
  "Magazzino",
  fields = list(pieces = "list"),
  methods = list(
    load = function(file_name) {
      # load is a function that takes the file name as a parameter, for each row creates a 
      # piece and calls it (unserialize function), prints and processes all rows one by one, 
      # loading the csv file
      path <- getwd()
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      entries = length(lines)
      pieces <<- list()
      for (i in 1:entries) {
        pezzo = Pezzo$new()
        if((pezzo$unserialize(lines[i])) == TRUE) {
          pieces <<- c(pieces, pezzo)
        }
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
    getCsvContent = function(anagrafica) {
      i = 1
      data <- matrix(0, length(pieces), 11)
      # we create a matrix that will be filled with the pieces data
      for (pezzo_attuale in pieces) {
        x <- pezzo_attuale$getCsvContent(anagrafica)
        data[i,] <- x
        i = i + 1
      }
      data = data.frame(data)
      colnames(data) <-
        c("ID", "Vendor name", "Vendor surname", "Name", "Description", "Height (cm)", "Length (cm)", "Width (cm)", "Low estimate", "High estimate", "Added")
      return(data)
    },
    getSelectBoxContentPezzo = function() {
      p_list <- list()
      for (pezzo_attuale in pieces) {
        p_label <- paste(pezzo_attuale$p_name, pezzo_attuale$h_ID, sep = "-")  
        p_list[[p_label]] <- pezzo_attuale$h_ID
      }
      return(p_list)
    },
    addPezzo = function(pezzo) {
      # the function creates a new piece
      pieces <<- c(pieces, pezzo)
    },
    save = function(file_name) {
      path <- getwd()
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      # the mode "w+" opens the file for reading and writing, truncating file initially
      writeLines(getElementsContent(), myfile)
      close(myfile)
    },
    verifyName = function(name) {
      # verifyName is a function that takes the piece name as a parameter and for the selected piece 
      # verifies if it already exist. If the piece already exists the function returns TRUE, 
      # if not it will return FALSE. We will use this function to make sure that we add a new piece and 
      # not an already existing one
      for (pezzo_attuale in pieces) {
        if (pezzo_attuale$p_name == name) {
          return(TRUE)
        } 
      } 
      return(FALSE)
    },
    resolveID = function(ID) {
      # resolveID is a function that takes the ID as a parameter, for the selected piece verifies that 
      # the ID corresponds and returns the piece name with an array. We will use this function to obtain the piece name
      # and add it into the lots table
      for (pezzo_attuale in pieces) {
        if (pezzo_attuale$h_ID == ID) {
          return(c(pezzo_attuale$p_name))
        }
      }
      return(c("unknown")) 
    }
  )
)

