Login_management <- setRefClass(
  "Login_management",
  methods = list(
    login = function(username, password) {
      if ((username == "admin") && (password == "admin")) {
        return(TRUE)
      }
      return(FALSE)
    }
  )
)