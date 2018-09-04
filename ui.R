library(ggplot2)
library(rpart.plot)
load("data.RData")

navbarPage("Churn",
           tabPanel("Model",
                    plotOutput("plot1")
           ),
           tabPanel("Visualizations",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("feature", "Feature",
                                     c("PaymentMethod" = "PaymentMethod", "tenure" = "tenure", 
                                       "InternetService" = "InternetService")
                        )
                      ),
                      mainPanel(
                        plotOutput("plot2")
                      )
                    )
           ),
           tabPanel("Predict",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput('PaymentMethod', 'PaymentMethod', levels(data$PaymentMethod)),
                        sliderInput("tenure", "tenure",  min = ceiling(min(data$tenure)), 
                                    max = floor(max(data$tenure)), value = round(mean(data$tenure))),
                        selectInput('InternetService', 'InternetService', levels(data$InternetService))
                      ),
                      mainPanel(
                        verbatimTextOutput("predict")
                      )
                    )
           )
)