
library(shiny); library(dplyr); library(reshape); library(ggplot2)


shinyServer(function(input, output) {
  PigData <- read.csv("./RigData.csv", header=TRUE, as.is=TRUE)
  PigData$DATE <- as.Date(PigData$DATE)
  # convert to long tidy form
  PD <- melt(PigData, id.vars="DATE", variable_name="Region")

  mmax <- reactive({
        t1 <- subset(PD, (DATE >= input$dates[1] & DATE <= input$dates[2] & Region %in% input$vars) )
        t1 <- aggregate(value~DATE, t1, FUN=sum)
        t1[t1$value==max(t1$value),]
  })

  #Verification statement for date range controls
  output$DateRange <- renderText({
        paste("Date range shown is:", as.character(input$dates[1]),
              " to ",
              as.character(input$dates[2]) )
  })

  #Verification statement for reactive evaluation of maximum rigs
  output$test <- renderText({
        v <- paste(input$vars, collapse=", ")
        paste("Peak number of total active drilling rigs is: ", mmax()$value, 
              " on ", mmax()$DATE, ". \n", "(Regions included: ", v, ".)", sep="" )
  })
  
  #Prepare plot
  output$plot <- renderPlot({
    
        ggplot(subset(PD, Region %in% input$vars) ) +
              geom_line(aes(x=DATE, y=value, color=Region)) +
              scale_x_date( limits=c(input$dates[1], input$dates[2]) ) +
              ylab("Number of Active Rigs")    
  })
  
})
