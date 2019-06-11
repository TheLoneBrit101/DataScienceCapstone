library(shiny)

# Define UI
shinyUI(navbarPage("Word Predictor",
                    tabPanel("App", icon = icon("code"),
                             fluidPage(
                                 sidebarPanel(
                                     p("See the 'info' tab for instructions of how to use the app"),
                                     textInput("words",
                                               label = "Please type something below.",
                                               value = "")
                                 ),
                                 mainPanel(fluidRow(
                                         column(4,
                                                h2("Results"),
                                                tableOutput('table')
                                         ),
                                         column(6,
                                                h2("WordCloud"),
                                                plotOutput('cloud')
                                         )
                                 ), fluidRow(
                                     column(4,
                                            p("Click a button to update the input field"),
                                            uiOutput('buttons')
                                 )
                                 )
                             )
                    )),
                   tabPanel("Information", icon = icon("info"),
                            h2("Instructions"),
                            p("After one or more words have been entered into the input box, the server will predict the most likely next-word using Stupid Backoff.
The results will be the top most likely posibilities and will be presented in table form from the most likely at the top to the least at the bottom.
There will also be a wordcloud to visualy represent the results.
You may continue the already inputted sequence by adding further words. The results will refresh automatically.
                              Please note, that if your input contains any spelling errors, there is a high chance that the results presented will be from the most common words taken from the unigram model i.e. stopwords.")
                   ),
                   tabPanel("Breakdown", icon = icon("tachometer-alt"),
                            includeHTML("BenchmarkResult.html")
                   )
))


