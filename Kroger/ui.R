library(shiny)

#load in the data
load('KrogerHouseholdsCarbs.RData')
load('KrogerShiny.RData')

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Kroger Image
    fluidRow(
        column(3,
               tags$img(src="kroger.png")
        ),
        column(6),
        column(3, h3("By Alex Cooper"))
        
        
    ),
    hr(),

    #Make first row
    fluidRow(
        column(2,
               radioButtons(inputId="state", label = h3("State"),
                            choices = list("Alabama"="AL", "Georgia"="GA", "Illinois"="IL", "Indiana"="IN", "Kentucky"="KY", "South Carolina"= "SC", "Tennessee"="TN"), 
                            selected = "AL")
               ),
        column(10,plotOutput("scatter"))
    ),
    hr(),
    #Make second row
    fluidRow(
        column(12,h2("Average Number of Visits for Each Income Level"),dataTableOutput("table"))
    ),
    hr(),
    #Make third row
    fluidRow(
        column(2,
               selectInput(inputId="city", label = h3("City"),
                           choices = levels(HOUSE$City), 
                           selected = "Acworth")
                ),
        column(10,plotOutput("bar"))
    ),hr(),
    #Make fourth row
    fluidRow(
        column(2,
               checkboxGroupInput(inputId="stat", label=h3("What do you want to know?"),
                                  choices = list("Number of Coupons"="NumCoupons", "Number of Visits"="NumVisits", "Number of Stores"="NumberOfStores"),
                                  selected = "NumCoupons")
               ),
        column(2,
               radioButtons(inputId="state2", label = h3("State"),
                            choices = list("Alabama"="AL", "Georgia"="GA", "Illinois"="IL", "Indiana"="IN", "Kentucky"="KY", "South Carolina"= "SC", "Tennessee"="TN"), 
                            selected = "AL")
               ),
        column(8, verbatimTextOutput("stats"))
    ),hr()
))
