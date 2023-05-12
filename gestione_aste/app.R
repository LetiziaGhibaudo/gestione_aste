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
library(shinyvalidate)
library(shinyalert)
library(shinythemes)

anagrafica <- Anagrafica$new()
magazzino <- Magazzino$new()
aste <- Aste$new()
asta <- Asta$new()
select_venditore_ID <- anagrafica$getSelectBoxContent()
select_pezzo_ID <- magazzino$getSelectBoxContentPezzo()
select_asta_ID <- aste$getSelectBoxContentAste()

# UI: The user interface object controls the layout and appearance of the app
ui <- fluidPage(theme = shinytheme("flatly"),
                # Application title
                titlePanel(strong("ARTEχNE - auction house solution")),
                
                mainPanel(width = 12, tabsetPanel(
                    # This tab controls the layout of the vendors part
                    tabPanel(
                        "Vendors",
                        verbatimTextOutput("Venditori"),
                        fluidRow(column(
                            12,
                            br(),
                            br(),
                            DT::dataTableOutput("tabellaVenditori", width = "100%")
                        )),
                        br(),
                        br(),
                        br(),
                        h2(strong("New vendor")),
                        verbatimTextOutput("Add Venditore"),
                        fluidRow(
                            column(4,
                                   br(),
                                   br(),
                                   textInput("v_name", h3("Name*"),
                                             value = "")),
                            column(4,
                                   br(),
                                   br(),
                                   textInput("v_surname", h3("Surname*"),
                                             value = "")),
                            column(4,
                                   br(),
                                   br(),
                                   textInput("v_address", h3("Address"),
                                             value = ""))),
                        fluidRow(
                            column(4,
                                   br(),
                                   br(),
                                   textInput("v_phone", h3("Phone number"),
                                             value = "")),
                            column(4,
                                   br(),
                                   br(),
                                   textInput("v_mail", h3("E-mail address*"),
                                             value = "")),
                            column(4,
                                   br(),
                                   br(),
                                   numericInput("v_commission", h3("Commission (%)"),
                                                value = 0, 
                                                min = 0,
                                                max = 100))),
                        fluidRow(
                            column(
                                12,
                                h3(strong("New vendor")),
                                useShinyalert(), 
                                actionButton("addVendor", "Add vendor"),
                                helpText("Click to insert the data")
                            )
                        )
                    ),
                    # This tab controls the layout of the pieces part
                    tabPanel(
                        "Pieces",
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
                        h2(strong("New piece")),
                        verbatimTextOutput("Add Piece"),
                        fluidRow(
                            column(4,
                                   br(),
                                   br(),
                                   selectInput("venditore_ID", label = h3("Select vendor*"),
                                               select_venditore_ID)),
                            column(4,
                                   br(),
                                   br(),
                                   textInput("p_name", h3("Name*"),
                                             value = "")),
                            column(4,
                                   br(),
                                   br(),
                                   textInput("description", h3("Description*"),
                                             value = ""))),
                        fluidRow(
                            column(4,
                                   br(),
                                   br(),
                                   numericInput("height_cm", h3("Height (cm)*"),
                                                value = 0)),
                            column(4,
                                   br(),
                                   br(),
                                   numericInput("length_cm", h3("Length (cm)*"),
                                                value = 0)),
                            column(4,
                                   br(),
                                   br(),
                                   numericInput("width_cm", h3("Width (cm)*"),
                                                value = 0))),
                        fluidRow(
                            column(4,
                                   br(),
                                   br(),
                                   numericInput(
                                       "p_lowEstimate", h3("Low estimate*"),
                                       value = 0
                                   )),
                            column(4,
                                   br(),
                                   br(),
                                   numericInput(
                                       "p_highEstimate", h3("High estimate*"),
                                       value = 0
                                   )),
                            column(4,
                                   br(),
                                   br(),
                                   dateInput("p_added", h3("Added*"),
                                             value = ""))),
                        fluidRow(
                            column(
                                12,
                                h3(strong("New piece")),
                                actionButton("addPiece", "Add piece"),
                                helpText("Click to insert the data")
                            )
                        )
                    ),
                    # This tab controls the layout of the auctions (and lots) part
                    tabPanel(
                        "Auctions",
                        verbatimTextOutput("Aste"),
                            
                        fluidRow(
                            column(
                                6,
                                h2(strong("Auctions")),
                                checkboxInput("showExpired", "showExpired", FALSE),
                                br(),
                                DT::dataTableOutput("tabellaAste")
                            ),
                            column(
                                6,
                                h2(strong("Lots")),
                                br(),
                                br(),
                                DT::dataTableOutput("tabellaLotti")
                            ),
                            br(),
                            br(),
                            br(),
                        ),
                        
                        fluidRow(
                            column(6,
                                   br(),
                                   br(),
                                   br(),
                                   h2(strong("New auction")),
                                   verbatimTextOutput("Add Auction")),
                            column(6,
                                   br(),
                                   br(),
                                   br(),
                                   h2(strong("New lot")),
                                   verbatimTextOutput("Add Lot"))
                        ),
                        fluidRow(
                            column(3,
                                   br(),
                                   dateInput("dataInizio", h3("Start time*"),
                                             value = "")),
                            column(3,
                                   br(),
                                   dateInput("dataFine", h3("End time*"),
                                             value = "")),
                            column(6,
                                   br(),
                                   selectInput(
                                       "pezzo_ID", label = h3("Piece*"),
                                       select_pezzo_ID
                                   )),
                        ),
                        fluidRow(
                            column(6),
                            column(3,
                                   br(),
                                   numericInput("l_prezzoIniziale", h4("Start price*"),
                                                value = 0)),
                            column(3,
                                   br(),
                                   numericInput("l_prezzoMartello", h4("Hammer price"),
                                                value = 0)),
                        ),
                        fluidRow(
                            column(6,
                                   h3(strong("New auction")),
                                   actionButton("addAuction", "Add auction"),
                                   helpText("Click to insert the data")),
                            column(6,
                                   h3(strong("New lot")),
                                   actionButton("addLot", "Add lot"),
                                   helpText("Click to insert the data"))
                        )
                    )
                )
                )
)


# Server: The server function contains the instructions to build the app
server <- function(input, output, session) {
    # Vendors 
    anagrafica$load("prova.csv")
    data <- anagrafica$getCsvContent()
    # We create the vendors table and we hide the column containing the vendor ID
    output$tabellaVenditori <- DT::renderDataTable(data, options = list(columnDefs = list(list(visible = FALSE, targets = c(1)))))
    # We verify that all the required fields are filled 
    v_iv <- InputValidator$new()
    v_iv$add_rule("v_name", sv_required())
    v_iv$add_rule("v_surname", sv_required())
    v_iv$add_rule("v_mail", sv_required())
    # We verify that the address is a valid e-mail address
    v_iv$add_rule("v_mail", sv_email())
    # To add a new vendor
    observeEvent(input$addVendor, {
        # If all the required fields are verified we can proceed 
        if (v_iv$is_valid()) {
            # If the vendor's name and surname do not exist we can create a new vendor
            if (anagrafica$verifyNameSurname(input$v_name, input$v_surname) == FALSE) {
                nuovoVenditore = Venditore$new(v_n = input$v_name,
                                               v_s = input$v_surname,
                                               v_a = input$v_address,
                                               v_ph = input$v_phone,
                                               v_mail = input$v_mail,
                                               v_comm = as.character(input$v_commission))
                anagrafica$addVenditore(nuovoVenditore)
                anagrafica$save("prova.csv")
                # To update the table and make the new vendor visible
                data <- anagrafica$getCsvContent()
                output$tabellaVenditori <- DT::renderDataTable(data, options = list(columnDefs = list(list(visible = FALSE, targets = c(1)))))
                select_venditore_ID <- anagrafica$getSelectBoxContent()
                v_iv$disable()
                updateSelectInput(session, "venditore_ID", choices = select_venditore_ID)
                updateTextInput(session, "v_name", value = "")
                updateTextInput(session, "v_surname", value = "")
                updateTextInput(session, "v_address", value = "")
                updateTextInput(session, "v_phone", value = "")
                updateTextInput(session, "v_mail", value = "")
                updateNumericInput(session, "v_commission", value = 0)
            } else {
                # If after the verification of the vendor's name and surname it results that they already exist
                # an alert will appear
                shinyalert("Oops!", "The user already exists", type = "error")
            }
        } else {
            # If after the verification of all the required fields it results that some are empty an alert will appear
            shinyalert("Oops!", "Please make sure that all required fields are not empty", type = "error")
            v_iv$enable() 
        }
    })
    
    # Pieces 
    magazzino$load("pezzi.csv")
    data_p <- magazzino$getCsvContent(anagrafica)
    select_venditore_ID <- anagrafica$getSelectBoxContent()
    updateSelectInput(session, "venditore_ID", choices = select_venditore_ID)
    # We create the pieces table and we hide the column containing the piece ID
    output$tabellaPezzi <- DT::renderDataTable(data_p, options = list(columnDefs = list(list(visible = FALSE, targets = c(1)))))
    # We verify that all the required fields are filled and that the numeric fields are greater than zero
    p_iv <- InputValidator$new()
    p_iv$add_rule("venditore_ID", sv_required())
    p_iv$add_rule("p_name", sv_required())
    p_iv$add_rule("description", sv_required())
    p_iv$add_rule("height_cm", sv_gt(0))
    p_iv$add_rule("length_cm", sv_gt(0))
    p_iv$add_rule("width_cm", sv_gt(0))
    p_iv$add_rule("p_lowEstimate", sv_gt(0))
    p_iv$add_rule("p_highEstimate", sv_gt(0))
    p_iv$add_rule("p_added", sv_required())
    # To add a new piece
    observeEvent(input$addPiece, {
        # We verify that the high etimate is greater than the low estimate 
        p_iv$add_rule("p_highEstimate", sv_gt(input$p_lowEstimate))
        # If all the required fields are verified we can proceed
        if (p_iv$is_valid()) {
            # If the piece's name does not exist we can create a new piece
            if (magazzino$verifyName(input$p_name) == FALSE) {
                nuovoPezzo = Pezzo$new(v_ID = input$venditore_ID,
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
                # To update the table and make the new piece visible
                data_p <- magazzino$getCsvContent(anagrafica)
                output$tabellaPezzi <- DT::renderDataTable(data_p, options = list(columnDefs = list(list(visible = FALSE, targets = c(1)))))
                select_pezzo_ID <- magazzino$getSelectBoxContentPezzo()
                p_iv$disable()
                updateSelectInput(session, "pezzo_ID", choices = select_pezzo_ID)
                updateSelectInput(session, "venditore_ID", selected = NULL)
                updateTextInput(session, "p_name", value = "")
                updateTextInput(session, "description", value = "")
                updateNumericInput(session, "height_cm", value = 0)
                updateNumericInput(session, "length_cm", value = 0)
                updateNumericInput(session, "width_cm", value = 0)
                updateNumericInput(session, "p_lowEstimate", value = 0)
                updateNumericInput(session, "p_highEstimate", value = 0)
                updateDateInput(session, "p_added", value = NULL)
            } else {
                # If after the verification of the piece's name it results that it already exists an alert will appear
                shinyalert("Oops!", "The piece already exists", type = "error")
            }
        } else {
            # If after the verification of all the required fields it results that some are empty an alert will appear
            shinyalert("Oops!", "Please make sure that all required fields are not empty", type = "error")
            p_iv$enable() 
        }
    }) 
    
    # Auctions     
    aste$loadAuctions("aste.csv", "lotti.csv")
    data_aste <- aste$getCsvContentAste(FALSE)
    # We create the auctions table and we hide the column containing the auction ID
    # Thanks to selection = "single", we can select the auction we are interested in (and the lots associated will appear)
    output$tabellaAste <- DT::renderDataTable(data_aste, selection = "single", options = list(columnDefs = list(list(visible = FALSE, targets = c(1)))))
    observeEvent(input$showExpired, {
        data_aste <- aste$getCsvContentAste(input$showExpired)
        output$tabellaAste <- DT::renderDataTable(data_aste, selection = "single", options = list(columnDefs = list(list(visible = FALSE, targets = c(1)))))
    })
    # We verify that all the required fields are filled
    a_iv <- InputValidator$new()
    a_iv$add_rule("dataInizio", sv_required())
    a_iv$add_rule("dataFine", sv_required())
    # To add a new auction
    observeEvent(input$addAuction, {
        # If all the required fields are verified we can proceed
        if (a_iv$is_valid()) {
            nuovaAsta = Asta$new(dataI = as.character(input$dataInizio),
                                 dataF = as.character(input$dataFine))
            aste$addAuction(nuovaAsta)
            aste$save("aste.csv", "lotti.csv")
            # To update the table and make the new auction visible
            data_aste <- aste$getCsvContentAste(input$showExpired)
            output$tabellaAste <- DT::renderDataTable(data_aste, selection = "single", options = list(columnDefs = list(list(visible = FALSE, targets = c(1)))))
            a_iv$disable()
            updateSelectInput(session, "asta_ID", choices = select_asta_ID)
            updateDateInput(session, "dataInizio", value = NULL)
            updateDateInput(session, "dataFine", value = NULL)
        } else {
            # If after the verification of all the required fields it results that some are empty an alert will appear
            shinyalert("Oops!", "Please make sure that all required fields are not empty", type = "error")
            a_iv$enable() 
        }
    }) 
    
    # Lots    
    data_lotti <- aste$getCsvContentLotti(magazzino)
    select_pezzo_ID <- magazzino$getSelectBoxContentPezzo()
    updateSelectInput(session, "pezzo_ID", choices = select_pezzo_ID)
    # We create the table of the lots associated to the auction we have selected
    observeEvent(input$tabellaAste_rows_selected, {
        data_aste <- aste$getCsvContentAste(input$showExpired)
        data_lotti <- aste$getCsvContentLotti(magazzino)
        id_asta_selezionata <- data_aste[as.character(input$tabellaAste_rows_selected), 1]
        data_lotti_sub <- data_lotti[data_lotti$"Auction ID"  %in% id_asta_selezionata, ]
        # We hide the columns containing the auction ID and the piece ID
        output$tabellaLotti <- DT::renderDataTable(data_lotti_sub, options = list(columnDefs = list(list(visible = FALSE, targets = c(1, 4)))))
    })
    # We verify that all the required fields are filled and that the numeric fields are greater than zero 
    l_iv <- InputValidator$new()
    l_iv$add_rule("pezzo_ID", sv_required())
    l_iv$add_rule("l_prezzoIniziale", sv_gt(0))
    l_iv$add_rule("l_prezzoMartello", sv_gt(0))
    # To add a new lot
    observeEvent(input$addLot, {
        if (length(input$tabellaAste_rows_selected) > 0) {
        # We verify that the hammer price is greater than (or at least equal to) the starting price 
        l_iv$add_rule("l_prezzoMartello", sv_gte(input$l_prezzoIniziale))
        # If all the required fields are verified we can proceed
        if (l_iv$is_valid()) {
            nuovoLotto = Lotto$new(
                p_ID = input$pezzo_ID,
                a_ID = data_aste[input$tabellaAste_rows_selected, 1],
                l_pI = as.integer(input$l_prezzoIniziale),
                l_pM = as.integer(input$l_prezzoMartello))
            aste$addLot(nuovoLotto)
            aste$save("aste.csv", "lotti.csv") 
            # To update the table and make the new lot visible
            data_lotti <- aste$getCsvContentLotti(magazzino)
            id_asta_selezionata <- data_aste[as.character(input$tabellaAste_rows_selected), 1]
            data_lotti_sub <- data_lotti[data_lotti$"Auction ID"  %in% id_asta_selezionata, ]
            output$tabellaLotti <- DT::renderDataTable(data_lotti_sub, options = list(columnDefs = list(list(visible = FALSE, targets = c(1, 4)))))
            l_iv$disable()
            updateSelectInput(session, "pezzo_ID", selected = NULL)
            updateNumericInput(session, "l_prezzoIniziale", value = 0)
            updateNumericInput(session, "l_prezzoMartello", value = 0) 
        }  else {
            # If after the verification of all the required fields it results that some are empty an alert will appear
            shinyalert("Oops!", "Please make sure that all required fields are not empty", type = "error")
            l_iv$enable() 
        }
    }}) 
}


# Run the application
if(interactive()) {
    shinyApp(ui = ui, server = server)
}

