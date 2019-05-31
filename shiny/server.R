require(shiny)


shinyServer(function(input, output, session) {
    #Reactive prediction
    prediction <- reactive({
        word_predict(input$words)
    })
    #Word Cloud
    output$cloud <- renderPlot({
        wordcloud(prediction()$word,prediction()$score, 
                  color = brewer.pal(8, "Dark2"), scale = c(6, 2))
    })
    #Suggestions
    output$table <- renderTable(prediction())
})
