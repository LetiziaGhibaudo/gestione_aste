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
magazzino <- Magazzino$new()

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
            )),
            br(),
            br(),
            br(),
            h2("New vendor"),
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
    ,
    
     tabPanel(
        "Pezzi",
        verbatimTextOutput("Pezzi"),
        fluidRow(column(
            12,
            br(),
            br(),
            DT::dataTableOutput("tabellaPezzi")
        )),
        br(),
        br(),
        br(),
        h2("New piece"),
        verbatimTextOutput("Add Piece"),
        fluidRow(
            column(4,
                   br(),
                   br(),
                   textInput("venditore_ID", h3("Vendor ID"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("name", h3("Name"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("description", h3("Description"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("height_cm", h3("Height (cm)"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("length_cm", h3("Length (cm)"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("width_cm", h3("Width (cm)"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("lowEstimate", h3("Low estimate"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("highEstimate", h3("High estimate"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("added", h3("Added"),
                             value = "")),
            
            column(
                12,
                h3("New piece"),
                actionButton("addPiece", "Add piece"),
                helpText("Click to insert the data")
            )
        )
        
    )
    )
    )
        
    
    )


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
    magazzino$load("pezzi.csv")
    data_p <- magazzino$getCsvContent()
    output$tabellaPezzi <- DT::renderDataTable(data_p)
    observeEvent(input$addPiece, {
        nuovoPezzo = Pezzo$new(v_ID = as.integer(input$venditore_ID),
                               n = input$name,
                               d = input$description,
                               h_cm = as.integer(input$height_cm),
                               l_cm = as.integer(input$length_cm),
                               w_cm = as.integer(input$width_cm),
                               low_e = as.integer(input$lowEstimate),
                               high_e = as.integer(input$highEstimate),
                               a = input$added)
        
        magazzino$addPezzo(nuovoPezzo)
        magazzino$save("pezzi.csv")
        data_p <- magazzino$getCsvContent()
        output$tabellaPezzi <- DT::renderDataTable(data_p)
        updateTextInput(session, "venditore_ID", value = "")
        updateTextInput(session, "name", value = "")
        updateTextInput(session, "description", value = "")
        updateTextInput(session, "height_cm", value = "")
        updateTextInput(session, "length_cm", value = "")
        updateTextInput(session, "width_cm", value = "")
        updateTextInput(session, "lowEstimate", value = "")
        updateTextInput(session, "highEstimate", value = "")
        updateTextInput(session, "added", value = "")
    }) 
    
}

# Run the application
shinyApp(ui = ui, server = server)

