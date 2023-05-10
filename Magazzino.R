source("~/Documents/GitHub/gestione_aste/Pezzo.R")
Magazzino <- setRefClass(
  "Magazzino",
  fields = list(pieces = "list"),
  methods = list(
    load = function(file_name) {
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
      pieces <<- c(pieces, pezzo)
    },
    save = function(file_name) {
      path <- getwd()
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      writeLines(getElementsContent(), myfile)
      close(myfile)
    },
    verifyName = function(name) {
      for (pezzo_attuale in pieces) {
        if (pezzo_attuale$p_name == name) {
          return(TRUE)
        } 
      } 
      return(FALSE)
    },
    resolveID = function(ID) {
      for (pezzo_attuale in pieces) {
        if (pezzo_attuale$h_ID == ID) {
          return(c(pezzo_attuale$p_name))
        }
      }
      return(c("unknown")) 
      
    }
  )
)

