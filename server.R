library(ggplot2)
library(rpart.plot)
load("data.RData")

function(input, output, session) {
  output$plot1 <- renderPlot({
    rpart.plot(fit$finalModel, type = 5, cex = 1, box.palette = "BuRd", 
               main = paste("Accuracy:", round(sum(test$Churn == predict(fit, test)) / nrow(test), 3)))
  })
  
  output$plot2 <- renderPlot({
    if (input$feature == "PaymentMethod") {
      plot2 <- ggplot(data, aes(x = PaymentMethod, y = ..prop.., group = Churn, fill = Churn)) + 
        geom_bar(position = "dodge") + scale_fill_manual(values = c("blue4", "firebrick1"))
    }
    
    if (input$feature == "tenure") {
      plot2 <- ggplot(data, aes(x = Churn, y = tenure)) + geom_boxplot(color = "blue4")
    }
    
    if (input$feature == "InternetService") {
      plot2 <- ggplot(data, aes(x = InternetService, y = ..prop.., group = Churn, fill = Churn)) + 
        geom_bar(position = "dodge") + scale_fill_manual(values = c("blue4", "firebrick1"))
    }
    
    plot2
    
  })
  
  output$predict <- renderPrint({
    predict <- data[1, , drop = F]
    predict$PaymentMethod <- input$PaymentMethod
    predict$tenure <- input$tenure
    predict$InternetService <- input$InternetService
    paste("Churn:", predict(fit, predict))
  })
}