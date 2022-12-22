#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
rm(list = ls())
setwd("~/Documents/GitHub/gestione_aste")
source("~/Documents/GitHub/gestione_aste/Venditore.R")
source("~/Documents/GitHub/gestione_aste/Anagrafica.R")
library(shiny)
library(DT)

# UI 
ui <- fluidPage(

    # Application title
    titlePanel("gestione_aste"),

   
        
        mainPanel(
            tabsetPanel(
                tabPanel("Venditori", verbatimTextOutput("Venditori"),
                fluidRow(
                    column(12,
                           br(),
                           br(),
                           DT::dataTableOutput("tabellaVenditori"))
                )         
                ),
                
                tabPanel("Add Venditore", verbatimTextOutput("Add Venditore"),
                fluidRow(
                    column(12,
                           h3("New vendor"),
                           actionButton("addVendor", "Add vendor"),
                           br(),
                           br(),
                           br(),
                           submitButton("Save"))
                )
                )
               
            )
        )
)



data <- read.csv2("prova.csv", header = T, sep=",")
# Server 
server <- function(input, output) {
   
    output$tabellaVenditori <- DT::renderDataTable(
        
        data
    )
}
    


# Run the application 
shinyApp(ui = ui, server = server)


# # Example test                               
# path <- getwd()
# 
# 
# write.table(x = "987654, Mario, Rossi, Via Roma 1\n123456, Irene, Bianchi, Via Garibaldi 2\n234567, Elisa, Verdi, Via Marconi 3",
#             file = paste(path, "/prova.txt", sep = ""),
#             row.names = FALSE, col.names = FALSE, quote = FALSE)
# 
# # readLines function
# #prova_txt <- readLines(paste(path, "/prova.txt", sep = ""))
# #prova_txt
# 
# anagrafica = Anagrafica$new()
# anagrafica$load("prova.txt")
# anagrafica$show()
# 
# 
# nuovoVenditore = Venditore$new(n = "Filippo", s = "Verdi", a = "Casa di Filippo 55")
# anagrafica$addVenditore(nuovoVenditore)
# anagrafica$show()
# 
# 
