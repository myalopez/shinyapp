library(shiny)

data = read.csv("data/MSBanksDec14.csv")
banks = data[, c(1, 2, 3, 8, 9, 11, 13, 14)]
banks1 = banks[, c(2:8)]

# Subset the data by banks' specialization
sub1 = banks[banks$SPECGRP == 2, ]
sub1 = sub1[, c(2:8)]
sub2 = banks[banks$SPECGRP == 4, ]
sub2 = sub2[, c(2:8)]
sub3 = banks[banks$SPECGRP == 5, ]
sub3 = sub3[, c(2:8)]
sub4 = banks[banks$SPECGRP == 7, ]
sub4 = sub4[, c(2:8)]
sub5 = banks[banks$SPECGRP == 8, ]
sub5 = sub5[, c(2:8)]

data1 = read.csv("data/MSBanksNov14.csv")
bank = data1[, c(1, 2, 3, 8, 9, 11, 13, 14)]
bank1 = bank[, c(2:8)]

# Subset the data by banks' specialization
sub1a = bank[bank$SPECGRP == 2, ]
sub1a = sub1a[, c(2:8)]
sub2a = bank[bank$SPECGRP == 4, ]
sub2a = sub2a[, c(2:8)]
sub3a = bank[bank$SPECGRP == 5, ]
sub3a = sub3a[, c(2:8)]
sub4a = bank[bank$SPECGRP == 7, ]
sub4a = sub4a[, c(2:8)]
sub5a = bank[bank$SPECGRP == 8, ]
sub5a = sub5a[, c(2:8)]

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "Agricultural" = sub1, 
           "Commercial Lending" = sub2, 
           "Mortgage" = sub3, 
           "Other Lending < 1 Billion" = sub4, 
           "All Other < 1 Billion" = sub5,
           "All Banks" = banks1)   
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    dataset = dataset[, 3:7]
    summary(dataset)
  })
  
  datasetInput1 <- reactive({
    switch(input$dataset,
           "Agricultural" = sub1a, 
           "Commercial Lending" = sub2a, 
           "Mortgage" = sub3a, 
           "Other Lending < 1 Billion" = sub4a, 
           "All Other < 1 Billion" = sub5a,
           "All Banks" = bank1)   
  })
  
 # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput1(), n = input$obs)
  })
})
