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
source("~/Documents/GitHub/gestione_aste/Anagrafica.R")
source("~/Documents/GitHub/gestione_aste/Magazzino.R")
source("~/Documents/GitHub/gestione_aste/Aste.R")
library(shiny)
library(DT)

anagrafica <- Anagrafica$new()
magazzino <- Magazzino$new()
aste <- Aste$new()
asta <- Asta$new()
select_venditore_ID <- anagrafica$getSelectBoxContent()
#print(select)
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
                       textInput("v_name", h3("Name"),
                                 value = "")),
                column(4,
                       br(),
                       br(),
                       textInput("v_surname", h3("Surname"),
                                 value = "")),
                column(4,
                       br(),
                       br(),
                       textInput("v_address", h3("Address"),
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
                   selectInput("venditore_ID", label = h3("Select vendor"), 
                               select_venditore_ID
                               ),
                   
                    # hr(),
                    # fluidRow(column(3, verbatimTextOutput("selected")))
                    
            ),
            # ("venditore_ID", h3("Vendor ID"),
            #                  value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("p_name", h3("Name"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   textInput("description", h3("Description"),
                             value = "")),
            column(4,
                   br(),
                   br(),
                   numericInput("height_cm", h3("Height (cm)"),
                             value = 0)),
            column(4,
                   br(),
                   br(),
                   numericInput("length_cm", h3("Length (cm)"),
                             value = 0)),
            column(4,
                   br(),
                   br(),
                   numericInput("width_cm", h3("Width (cm)"),
                             value = 0)),
            column(4,
                   br(),
                   br(),
                   numericInput("p_lowEstimate", h3("Low estimate"),
                             value = 0)),
            column(4,
                   br(),
                   br(),
                   numericInput("p_highEstimate", h3("High estimate"),
                             value = 0)),
            column(4,
                   br(),
                   br(),
                   dateInput("p_added", h3("Added"),
                             value = "")),
            
            column(
                12,
                h3("New piece"),
                actionButton("addPiece", "Add piece"),
                helpText("Click to insert the data")
            )
        )
        
    ),
    tabPanel(
        "Aste",
        verbatimTextOutput("Aste"),
        fluidRow(column(
            6,
            br(),
            br(),
            h2("Auctions"),
            br(),
            br(),
            DT::dataTableOutput("tabellaAste")
        ),
        column(
            6,
            br(),
            br(),
            h2("Lots"),
            br(),
            br(),
            DT::dataTableOutput("tabellaLotti")
        )),
        br(),
        br(),
        br(),
        h2("New auction"),
        verbatimTextOutput("Add Auction"),
        fluidRow(
            column(3,
                   br(),
                   dateInput("dataInizio", h3("Start time"),
                             value = "")),
            column(3,
                   br(),
                   dateInput("dataFine", h3("End time"),
                             value = "")),
            br(),
            br(),
            br(),
            column(
                12,
                h3("New auction"),
                actionButton("addAuction", "Add auction"),
                helpText("Click to insert the data")
            ),
            
        )
    )
    )
    ))
    
        
    
    


# Server: The server function contains the instructions to build the app
server <- function(input, output, session) {
    anagrafica$load("prova.csv")
    data <- anagrafica$getCsvContent()
    output$tabellaVenditori <- DT::renderDataTable(data)
    observeEvent(input$addVendor, {
        nuovoVenditore = Venditore$new(v_n = input$v_name,
                                       v_s = input$v_surname,
                                       v_a = input$v_address)
        
        anagrafica$addVenditore(nuovoVenditore)
        anagrafica$save("prova.csv")
        data <- anagrafica$getCsvContent()
        output$tabellaVenditori <- DT::renderDataTable(data)
        select_venditore_ID <- anagrafica$getSelectBoxContent()
        updateSelectInput(session, "venditore_ID", choices = select_venditore_ID)
        updateTextInput(session, "v_name", value = "")
        updateTextInput(session, "v_surname", value = "")
        updateTextInput(session, "v_address", value = "")
    })
    magazzino$load("pezzi.csv")
    data_p <- magazzino$getCsvContent()
    select_venditore_ID <- anagrafica$getSelectBoxContent()
    updateSelectInput(session, "venditore_ID", choices = select_venditore_ID)
    output$tabellaPezzi <- DT::renderDataTable(data_p)
    observeEvent(input$addPiece, {
        print(input$venditore_ID)
        nuovoPezzo = Pezzo$new(
                               v_ID = input$venditore_ID,
                               
                               p_n = input$p_name,
                               d = input$description,
                               h_cm = as.integer(input$height_cm),
                               l_cm = as.integer(input$length_cm),
                               w_cm = as.integer(input$width_cm),
                               p_low_e = as.integer(input$p_lowEstimate),
                               p_high_e = as.integer(input$p_highEstimate),
                               p_a = as.character(input$p_added))
        
        magazzino$addPezzo(nuovoPezzo)
        magazzino$save("pezzi.csv")
        data_p <- magazzino$getCsvContent()
        output$tabellaPezzi <- DT::renderDataTable(data_p)
        updateSelectInput(session, "venditore_ID", selected = NULL)
        updateTextInput(session, "p_name", value = "")
        updateTextInput(session, "description", value = "")
        updateNumericInput(session, "height_cm", value = 0)
        updateNumericInput(session, "length_cm", value = 0)
        updateNumericInput(session, "width_cm", value = 0)
        updateNumericInput(session, "p_lowEstimate", value = 0)
        updateNumericInput(session, "p_highEstimate", value = 0)
        updateDateInput(session, "p_added", value = NULL)
    }) 
    aste$loadAuctions("aste.csv", "lotti.csv")
    data_aste <- aste$getCsvContentAste()
    output$tabellaAste <- DT::renderDataTable(data_aste, selection = "single")
    
    observeEvent(input$addAuction, {
        
        nuovaAsta = Asta$new(dataI = as.character(input$dataInizio),
                             dataF = as.character(input$dataFine))
        
        aste$addAuction(nuovaAsta)
        aste$save("aste.csv", "lotti.csv")
        data_aste <- aste$getCsvContentAste()
        output$tabellaAste <- DT::renderDataTable(data_aste, selection = "single")
        updateDateInput(session, "dataInizio", value = NULL)
        updateDateInput(session, "dataFine", value = NULL)
    }) 
   
     
    #asta$loadLots("lotti.csv")
    data_lotti <- aste$getCsvContentLotti()
    observeEvent(input$tabellaAste_rows_selected, {
        id_asta_selezionata <- data_aste[as.character(input$tabellaAste_rows_selected), 1]
        data_lotti_sub <- data_lotti[data_lotti$"auction ID"  %in% id_asta_selezionata, ]
        output$tabellaLotti <- DT::renderDataTable(data_lotti_sub)
    })
}
    

# Run the application
if(interactive()) {
shinyApp(ui = ui, server = server)
    }

