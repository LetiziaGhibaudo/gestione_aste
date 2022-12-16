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

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
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
