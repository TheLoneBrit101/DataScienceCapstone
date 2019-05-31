library(shiny)

# Define UI
shinyUI(navbarPage("Word Predictor",
                    tabPanel("App",
                             fluidPage(
                                 sidebarPanel(
                                     p(" Please ignore the errors currently present on the screen. This app is under construction and is only up to show that the model works."),
                                     textInput("words",
                                               label = "Please type something below.",
                                               value = "")
                                 ),
                                 mainPanel(
                                         column(4,
                                                h2("Results"),
                                                tableOutput('table')
                                         ),
                                         column(6,
                                                h2("WordCloud"),
                                                plotOutput('cloud')
                                         )
                                 )
                             )
                    ),
                   tabPanel("Information",
                            includeMarkdown("")
                   ),
                   tabPanel("Breakdown",
                            includeMarkdown("")
                   )
))


