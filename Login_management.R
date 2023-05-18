source("~/Documents/GitHub/gestione_aste/Login.R")
Login_management <- setRefClass(
  "Login_management",
  fields = list(
    users = "list"
  ),
  methods = list(
    login = function(username, password) {
      for (login_attuale in users) {
        if ((login_attuale$username == username ) && (login_attuale$password == password)) {
          return(TRUE)
        }
      }
      return(FALSE)
    },
    load = function(file_name) {
      path <- getwd()
      myfile = file(paste(path, "/", file_name, sep = ""))
      lines = readLines(myfile)
      entries = length(lines)
      users <<- list()
      for (i in 1:entries) {
        login = Login$new()
        login$unserialize(lines[i])
        users <<- c(users, login)
      }
      close(myfile)
    },
    getElementsContent = function() {
      data <- c()
      for (login_attuale in users) {
        data <- c(login_attuale$serialize(), data)
      }
      return(data)
    },
    addUser = function(login) {
      # the function creates a new user 
      users <<- c(users, login)
    },
    save = function(file_name) {
      path <- getwd()
      myfile = file(paste(path, "/", file_name, sep = ""), open = "w+")
      # the mode "w+" opens the file for reading and writing, truncating file initially
      writeLines(getElementsContent(), myfile)
      close(myfile)
    },
    verifyUserPassword = function(username, password) {
      for (login_attuale in users) {
        if (login_attuale$username == username && login_attuale$password == password) {
          return(TRUE)
        } 
      } 
      return(FALSE)
    }

  )
)