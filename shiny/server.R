require(shiny)

shinyServer(function(input, output, session) {
    #Reactive prediction
    prediction <- reactive({
            word_predict(input$words)
        })
    #Word Cloud
    output$cloud <- renderPlot({
        if (nchar(input$words) > 0){
        wordcloud(prediction()$word,prediction()$score, 
                  color = brewer.pal(8, "Dark2"), scale = c(6, 2))
        }
    })
    #Suggestions
    output$table <- renderTable(
        if (nchar(input$words) > 0){
            prediction()
        })
})


