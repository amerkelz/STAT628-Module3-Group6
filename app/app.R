library(shiny)
library(bslib)
library(shinyTime)
library(reticulate)
py_install(c("pandas","numpy","scikit-learn"))

list_of_airports <- list('ATL','DFW','DEN','LAX','ORD','JFK','MCO','LAS','CLT','MIA','SEA','EWR','SFO','PHX','IAH','BOS','FLL','MSP','LGA','DTW','PHL','SLC','BWI','DCA','SAN','IAD','TPA','BNA','AUS','MDW','HNL','DAL','PDX','STL','RDU','HOU','SMF','MSY','SJC','SJU','SNA','MCI','OAK','SAT','RSW','CLE','IND','PIT','CVG','CMH','PBI','OGG','JAX','ONT','BUR','BDL','CHS','MKE','ANC','ABQ','OMA','MEM','RIC','BOI','ORF','BUF','SDF','RNO','SRQ','OKC','KOA','ELP','GEG','TUS','SAV','GRR','LGB','LIH','PVD','MYR','PSP','TUL','DSM','BHM','SFB','SYR','TYS','ALB','PNS','ROC','GSP','PIE','BZN','FAT','COS','HPN','AVL','VPS','PWM','LIT','MSN')

# Define UI for app that draws a histogram ----
ui <- page_fluid(
  titlePanel("US Holiday Season Flight Delay Estimator - STAT 628 Group 6"),
  fluidRow(
    card(
      card_header("About this Page"),
      helpText(
        "This is a flight delay estimator developed by STAT 628 students at UW-Madison.
        The intent of this tool is to predict whether a domestic US flight in November, December, or January will be delayed or cancelled based on certain inputs.",
        "Please note that this tool was developed using flights to/from the top 100 US airports by passenger volume in 2023, and flights to/from Madison Regional Airport (MSN).
        For a list of supported airports, please see: https://www.travelmag.com/articles/biggest-us-airports/"
      )
    )
  ),
  fluidRow(  
    column(5, 
           wellPanel(
           # titlePanel("Variables"),
           #card(card_header('Variables')),#,helpText('Select the below to estimate your flight\'s delay')),
           dateInput("depDate", "Departure Date", value = "2024-11-01", format='yyyy-mm-dd'),
           timeInput("depTime", "Scheduled Departure Time (CST):", seconds = FALSE, value="12:00:00"),
           # layout_column_wrap(
           #     width = 1/2,
           #     selectInput(
           #      "origin",
           #      "Departing From:",
           #      choices = list_of_airports,
           #      selected = 'ORD'),
           #    selectInput(
           #     "dest",
           #     "Arriving At:",
           #     choices = list_of_airports,
           #     selected = 'LGA')
           #    ),
           timeInput("arrTime", "Scheduled Arrival Time (CST):", seconds = FALSE, value = "14:00:00"),
           layout_column_wrap(
               width=1/2,
               checkboxInput("snow_origin", "Snowfall at Departure Airport?", value = FALSE),
               checkboxInput("snow_dest", "Snowfall at Arrival Airport?", value = FALSE)
             ),
           layout_column_wrap(
             width=1/2,
             selectInput(
               "vis_origin",
               "Visibility at Departure Airport:",
               choices = list("Low Visibility", "Some Visibility", "Clear Skies"),
               selected = "Clear Skies"
             ),
             selectInput(
               "wind_dest",
               "Wind at Arrival Airport:",
               choices = list("Calm", "Some Wind", "Very Windy"),
               selected = "Calme"
             )
           ),
           helpText("",br(),""),
           submitButton("Estimate Flight Arrival"))
    ),
    column(7,
           uiOutput("cancel_box"),
           uiOutput("delay_box"),
           uiOutput("arr_time_box")
           )
  ),
  fluidRow(
    card(
      card_header("About the Models"),
      helpText("Both models were developed using flight and weather data from the 2018 - 2024 Holiday seasons, 
               excluding November 2020 - January 2021, 
               and only using domestic US flights from the top 100 airports by 2023 passenger volume (plus MSN).",
               "Both cancellation and delay predictions use logistic regression models.",
               br(),
               br(),
               "Cancellation Model Variables: month, departure airport visibility, arrival airport windiness, and snowfall at both airports",
               br(),
               "Delay Model Variables: scheduled departure hour, month, departure airport visibility, arrival airport windiness, and snowfall at both airports"
      )
    )
  ),
  fluidRow(
    card(
      card_header("Data References and Contact Information"),
      helpText(
        "Weather data is from the U.S. Local climatology Data V2 provided by the National Centers for Environmental Information (NCEI).",
        br(),
        "Flight data is from the Bureau of Transportation Statistics.",
        br(),
        br(),
        "The model developers can be contacted via email at: amerkelz@wisc.edu; zhang2873@wisc.edu; cjiang232@wisc.edu"
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  #ingest and process input values
  flightMonth <- reactive({as.numeric(format(input$depDate, "%m"))})
  depHour <- reactive({as.numeric(strftime(input$depTime, "%H"))})
  snowOrigin <- reactive({ifelse(input$snow_origin == FALSE, 0, 1)})
  snowDest <- reactive({ifelse(input$snow_dest == FALSE, 0, 1)})
  visOrigin <- reactive({ifelse(input$vis_origin == "Some Visibility",1,ifelse(input$vis_origin == "Low Visibility", 2, 0))})
  windDest <- reactive({ifelse(input$wind_dest == "Some Wind",1,ifelse(input$wind_dest == "Very Windy", 2, 0))})
  
  #Valid Month notification
  observeEvent(input$depDate, {
    #if month is valid, don't show notification
    if(flightMonth() == 1| flightMonth() == 11 | flightMonth() == 12)
      return()
    showNotification("Flight must be in November, December, January!",type="error")
  }
  )
  
  #Cancellation & Delay Predictions:
  source_python("model_predict.py")
  cancel_prediction <- reactive({round((predict_cancel(flightMonth(),visOrigin(),windDest(),snowOrigin(),snowDest())[2])*100, 1)})
  delay_prediction <- reactive({predict_delay(flightMonth(), depHour(), visOrigin(),windDest(),snowOrigin(),snowDest())})
  #cancel_result <- reactive({ifelse(cancel_prediction() == 1, "Cancelled", "Not Cancelled")})
  delay_result <- reactive({ifelse(delay_prediction() == 2, "60+ Minute Delay", ifelse(delay_prediction() == 1, "0 - 60 Minute Delay", "On Time or Early"))})
  estArrTime <- reactive({ifelse(delay_prediction() == 2, paste(strftime((input$arrTime+1*60*60),"%R")," CST or later", sep = ""),
                                 ifelse(delay_prediction() == 1, paste("Between ", strftime(input$arrTime,"%R"), " and ", strftime((input$arrTime+1*60*60),"%R"), " CST", sep = ""),
                                        paste(strftime(input$arrTime,"%R"), " CST", sep="")))
                                 })
  
  #Cancellation Prediction Value Box
  cancel_box_color <- reactive({ifelse(cancel_prediction() < 25, 'green', ifelse(cancel_prediction() < 50, 'yellow','red'))})
  output$cancel_box <- renderUI({
    value_box(
      title = "Probability of Flight Being Cancelled",
      value = paste(format(cancel_prediction(),nsmall=1),"%",sep=""),
      theme = cancel_box_color()
    )
  })
  
  #Delay Prediction Value Box
  delay_box_color <- reactive({ifelse((delay_prediction() == 0), 'green', ifelse(delay_prediction() == 1, 'yellow', 'red'))})
  output$delay_box <- renderUI({
    value_box(
      title = "Estimated Flight Delay (if not cancelled)",
      value = delay_result(),
      theme = delay_box_color()
    )
  })
  output$arr_time_box <- renderUI({
    value_box(
      title = "Estimated Arrival Time (if not cancelled)",
      value = estArrTime()
    )
  })
}

shinyApp(ui = ui, server = server)
