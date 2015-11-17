library(shiny)
library(DT)

source("best.R")
source("rankhospital.R")
source("rankall.R")

diabetesRisk <- function(glucose) glucose/200
strRate <- "Must be numeric || best || worst || ''"

shinyServer(
        function(input,output) {
                
                #browser()
                
                inputRank <- reactive({
                        inputRank <- input$Rank
                })
                
                typeRank <- reactive({
                        validate(
                                need((is.numeric(as.numeric({input$Rank})) && !is.na(as.numeric({input$Rank}))) || toupper({input$Rank}) == toupper("Best") || toupper({input$Rank}) == toupper("Worst") || {input$Rank} == "", strRate)
                        )
                        if (is.numeric(as.numeric({input$Rank})) && !is.na(as.numeric({input$Rank}))) {
                                as.numeric({input$Rank})
                        }
                        else if (toupper({input$Rank}) == toupper("Best")) {
                                "best"
                        }
                        else if (toupper({input$Rank}) == toupper("Worst")) {
                                "worst"
                        }
                        else if ({input$Rank == ""}) {
                                return("")
                        }
                        else {
                                return("typeRank_failed")
                        }
                })

                b <- reactive({as.character(best(input$State, input$Outcome))})
                output$bestHospital <- renderPrint({b()})
                
                r <- reactive({as.character(rankhospital(input$State, input$Outcome, typeRank()))})
                output$rankHospital <- renderPrint({r()})
                
                #sink("debug.txt")
                #showReactLog
                #isolate(typeRank())
                #isolate(b())
                #isolate(r())
                
                output$enteredState <- renderPrint({input$State})
                output$enteredOutcome <- renderPrint({input$Outcome})
                output$enteredRank <- renderPrint({input$Rank})
                output$convertedRank <- renderPrint({typeRank()})
                output$rankAll <- renderDataTable(rankall(input$Outcome, {typeRank()}), options = list(paging = FALSE))
                
        }
)