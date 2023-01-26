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

anagrafica <- Anagrafica$new()

# UI: The user interface object controls the layout and appearance of the app 
ui <- fluidPage(# Application title
    titlePanel("ARTEχNE - auction house solution"),
    
    mainPanel(tabsetPanel(
        tabPanel(
            "Venditori",
            verbatimTextOutput("Venditori"),
            fluidRow(column(
                12,
                br(),
                br(),
                DT::dataTableOutput("tabellaVenditori")
            ))
        ),
        tabPanel(
            "Add Venditore",
            verbatimTextOutput("Add Venditore"),
            fluidRow(
                column(4,
                       br(),
                       br(),
                       textInput("name", h3("Name"),
                                 value = "")),
                column(4,
                       br(),
                       br(),
                       textInput("surname", h3("Surname"),
                                 value = "")),
                column(4,
                       br(),
                       br(),
                       textInput("address", h3("Address"),
                                 value = "")),
                column(
                    12,
                    h3("New vendor"),
                    actionButton("addVendor", "Add vendor"),
                    helpText("Click to insert the data")
                )
            )
            
        )
    )))

# Server: The server function contains the instructions to build the app
server <- function(input, output, session) {
    anagrafica$load("prova.csv")
    data <- anagrafica$getCsvContent()
    output$tabellaVenditori <- DT::renderDataTable(data)
    observeEvent(input$addVendor, {
        nuovoVenditore = Venditore$new(n = input$name,
                                       s = input$surname,
                                       a = input$address)
        
        anagrafica$addVenditore(nuovoVenditore)
        anagrafica$save("prova.csv")
        data <- anagrafica$getCsvContent()
        output$tabellaVenditori <- DT::renderDataTable(data)
        updateTextInput(session, "name", value = "")
        updateTextInput(session, "surname", value = "")
        updateTextInput(session, "address", value = "")
    })
    
}

# Run the application
shinyApp(ui = ui, server = server)

