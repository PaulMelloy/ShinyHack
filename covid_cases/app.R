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



# Data import from pappubahry on GitHub
# repository https://github.com/pappubahry/AU_COVID19
dat_cases <- read.csv("https://github.com/pappubahry/AU_COVID19/raw/master/time_series_cases.csv")




# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Covid-19 Cases in Australia"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            # sliderInput(inputId = "bins",
            #             label = "Number of bins:",
            #             min = 1,
            #             max = 50,
            #             value = 30),
            radioButtons(inputId = "new_cumul",
                         label = "New cases or Cumulative cases",
                         choices = c("Cumulative cases" = "cumu",
                                     "New cases" = "new")
                         ),
            br(),
            br(),
            img(src = "usq.jpg")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           h1("Table of recent COVID-19 cases"),
           h2("in Australia", align = "center"),
           h3("Nationally", align = "center"),
           h4("and by State", align = "center"),
           
           tableOutput("dat_table")
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
                            tail(dat_cases, n = 11L)[1:10,-1]
                        )
                
            }
            if(input$new_cumul == "cumu"){
                dat_out <-
                    tail(dat_cases, n = 10L)
            }
            
            dat_out
            
            })
}
    
    

# Run the application 
shinyApp(ui = ui, server = server)
