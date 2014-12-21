library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("Mississippi Banks Data & Statistics"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view. The helpText function is also used to 
  # include clarifying text. Most notably, the inclusion of a 
  # submitButton defers the rendering of output until the user 
  # explicitly clicks the button (rather than doing it immediately
  # when inputs change). This is useful if the computations required
  # to render output are inordinately time-consuming.
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose area of Specialization:", 
                  choices = c("Agricultural", "Commercial Lending", "Mortgage", "Other Lending < 1 Billion", "All Other < 1 Billion", "All Banks")),
    
      numericInput("obs", "Number of data to view:", 10),
    
      helpText("Note: while the data view will show only the",
               "specified number of observations, the summary",
               "will still be based on the full dataset."),
    
      submitButton("Update View"),
      br(),
    
      dateInput("date", "Date:"),
      br(),
      
      h5("Application Description"),
      helpText("This application displays the summary statistics",
               "of Mississippi banks' financial data obtained from",
               "the quarterly report published by the FDIC.",
               "The user can choose from several areas of specialization,",
               "namely: Agricultural, Commercial Lending, Mortgage,",
               "Other Lending < 1 Billion, All Other < 1 Bilion, and All",
               "Banks. It also displays the individual bank's ",
               "observations. Financial data are limited to the",
               "bank's total assets (ASSETS), total deposits",
               "(DEPOSITS), capital equity (EQUITY), return on",
               "assets (ROA) and return on equity (ROE)."),
      h6("Data Source: Federal Deposit Insurance Corporation",
         "https://www.fdic.gov/bank/statistical/")
      
    ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations. Note the use of the h4 function to provide
  # an additional header above each output section.
    mainPanel(
      h4("Summary Statistics (ASSETS, DEPOSITs and EQUITY in thousands $) "),
      verbatimTextOutput("summary"),
    
      h4("Observations"),
      tableOutput("view")
    )
  )
))
