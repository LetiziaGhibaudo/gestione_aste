Login <- setRefClass(
  "Login",
  fields = list(
    username = "character",
    password = "character"
  ),
  methods = list(
    initialize = function(username = "undefined",
                          password = "undefined") {
      username <<- username
      password <<- password
    },
    serialize = function() {
      # The serialize function is a method to convert all content to a csv row
      return(paste(username, password, sep = ","))
    },
    unserialize = function(line) {
      # The unserialize function divides the various elements of the csv row and returns a list 
      list = strsplit(line, ",")
      if (length(unlist(list)) > 1) {
        username <<- unlist(list)[1]
        password <<- unlist(list)[2]
      }
    }
    
  )
)

# write.table(x = "admin,admin\nprova,prova\nusername,password",
#                         file = "~/Documents/GitHub/gestione_aste/login.csv",
#                         row.names = FALSE, col.names = FALSE, quote = FALSE)
#             