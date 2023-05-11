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
      data <- matrix(0, length(vendors), 7)
      # we create a matrix that will be filled with the vendors data
      for (venditore_attuale in vendors) {
        x <- venditore_attuale$getCsvContent()
        data[i,] <- x
        i = i + 1
      }
      data = data.frame(data)
      colnames(data) <-
        c("ID", "Name", "Surname", "Address", "Phone number", "E-mail address", "Commission")
      return(data)
    },
    getSelectBoxContent = function() {
      v_list <- list()
      for (venditore_attuale in vendors) {
        label <- paste(venditore_attuale$v_name, venditore_attuale$v_surname, venditore_attuale$h_ID, sep = "-")  
        v_list[[label]] <- venditore_attuale$h_ID
      }
      return(v_list)
    },
    addVenditore = function(venditore) {
      # the function creates a new seller 
      vendors <<- c(vendors, venditore)
    },
    save = function(file_name) {
      path <- getwd()
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      # the mode "w+" opens the file for reading and writing, truncating file initially
      writeLines(getElementsContent(), myfile)
      close(myfile)
    },
    verifyNameSurname = function(name, surname) {
      # verifyNameSurname is a function that takes the name and surname as parameters and for the selected vendor 
      # verifies if their name and surname already exist. If the vendor already exists the function returns TRUE, 
      # if not it will return FALSE. We will use this function to make sure that we add a new vendor and not an 
      # already existing one
      for (venditore_attuale in vendors) {
        if (venditore_attuale$v_name == name && venditore_attuale$v_surname == surname) {
          return(TRUE)
        } 
      } 
      return(FALSE)
    },
    resolveID = function(ID) {
      # resolveID is a function that takes the vendor ID as a parameter, for the selected vendor verifies that 
      # the ID corresponds and returns the vendor's name and surname with an array. We will use this function to obtain the 
      # vendor's name and surname and add them into the pieces table
      for (venditore_attuale in vendors) {
        if (venditore_attuale$h_ID == ID) {
          return(c(venditore_attuale$v_name, venditore_attuale$v_surname))
        }
      }
      return(c("unknown", "unknown")) 
    }
  )
)


