#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# This template has been adapted for USQ HackyHour to demonstrate R Shiny apps
# Author/Presenter: Dr Paul Melloy


# Required libraries
library(shiny)
library(imager)


# Data import from pappubahry on GitHub
# repository https://github.com/pappubahry/AU_COVID19
dat_cases <- read.csv("https://github.com/pappubahry/AU_COVID19/raw/master/time_series_cases.csv")
head(dat_cases)



# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Covid-19 Cases in Australia"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            # sliderInput("bins",
            #             "Number of bins:",
            #             min = 1,
            #             max = 50,
            #             value = 30),
            radioButtons(inputId = "new_cumul",
                         label = "New cases or Cumulative cases",
                         choices = c("Cumulative cases" = "cumu",
                                     "New cases" = "new")
                         )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           #plotOutput("distPlot"),
           tableOutput("dat_table")
           # br(),
           # br()
           # #img(src = "images/usq.png", height = 72, width = 72)
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    
    output$dat_table <-
        renderTable({
            if(input$new_cumul == "new"){
                dat_out <- 
                    cbind(
                        Date = tail(dat_cases, n = 10L)[,1],
                        tail(dat_cases, n = 10L)[,-1] -
                            tail(dat_cases, n = 11L)[1:10,-1])

            }else{
                dat_out <-
                    tail(dat_cases, n = 10L)
            }
            
            dat_out
            
            })
}
    
    
    
#     output$distPlot <- renderPlot({
#         # generate bins based on input$bins from ui.R
#         x    <- faithful[, 2]
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#         # draw the histogram with the specified number of bins
#         hist(x, breaks = bins, col = 'darkgray', border = 'white')
#         })
#     
#     
 #   output$USQ_image <- load.image("covid_cases/images/usq.png")
# }

# Run the application 
shinyApp(ui = ui, server = server)
