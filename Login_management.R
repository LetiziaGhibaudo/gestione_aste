# The class Login_management is responsible for loading and saving the users list;
# Furthermore, we can add a new user (their username and password) and they will 
# be saved in the csv file as a new row
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
      # load is a function that takes the file name as a parameter, for each row creates a 
      # user and calls it (unserialize function), prints and processes all rows one by one, 
      # loading the csv file
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
      # verifyUserPassword is a function that takes the username and password as parameters and verifies if 
      # the username and password taped already exist. If this is the case the function returns TRUE. 
      # We will use this function to make sure that we add a new user and not an already existing one
      for (login_attuale in users) {
        if (login_attuale$username == username && login_attuale$password == password) {
          return(TRUE)
        } 
      } 
      return(FALSE)
    }
  )
)