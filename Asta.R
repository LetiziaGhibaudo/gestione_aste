Asta <- setRefClass(
  "Asta",
  fields = list(
    h_ID = "character",
    dataInizio = "character",
    dataFine = "character",
    lotti = "character"
  ),
  methods = list(
    initialize = function(dataI = "undefined",
                          dataF = "undefined",
                          lotti = "list"
                          ) {
      h_ID <<- paste0("A", sample(1:1000000, 1))
      dataInizio <<- dataI
      dataFine <<- dataF
      lotti <<- lotti
    },
    serialize = function() {
      return(paste(h_ID, dataI, dataF, lotti, sep = ","))
    },
    getCsvContent = function() {
      return(c(h_ID, dataI, dataF, lotti))
    },
    unserialize = function(line) {
      list = strsplit(line, ",")
      print(length(unlist(list)))
      h_ID <<- unlist(list)[1]
      dataInizio <<- unlist(list)[2]
      dataFine <<- unlist(list)[3]
      if (length(unlist(list)) > 3) {
        lotti <<- unlist(list)[4]
      }
    }
  )
)
