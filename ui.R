

library(shiny)

# Define UI for application that draws Canadian Active Rigs chart
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Drilling Rig Dashboard"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
      sidebarPanel(
            h4("Directions: "),
            p("To filter dashboard results, use date slider or region selection buttons below."),
            dateRangeInput("dates", 
                      "Date Range:",
                      start = "2003-01-01", 
                      end = "2017-04-01"
            ),
          
            checkboxGroupInput(inputId='vars',
                             label="Select Regions to Include:",
                             choices=c(Alberta='AB', 'Saskatchewan'='SK', 'Man'='MB',
                                       'British Columbia' = 'BC',
                                       'Territories'="Kavik", 'New Brunswick'="NB",
                                       'Newfoundland - Land'="NL.Land", 
                                       'Newfoundland - Offshore'= "NL.OS",
                                       'Nova Scotia - Land' = "NS.Land",
                                       'Nova Scotia - Offshore' = "NS.OS",
                                       'Ontario - Land' = "ON.Land",
                                       'Ontario - Offshore' = "ON.OS",
                                       'Quebec' = "QC"),
                             selected=c('AB', 'SK', 'BC', 'MB')
                             )
       ),
    
    # Main Panel - show plot
    mainPanel(
          h2("Canada - Active Drilling Rigs"),
          plotOutput("plot"),
          textOutput("DateRange"),
          textOutput("test"),
          h5("Data obtained from Baker Hughes Rotary Rig Count data.")
    )
  )
))
