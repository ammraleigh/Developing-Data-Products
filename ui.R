library(shiny)
library(DT)
library(datasets)

shinyUI(
                navbarPage("US Hospital Comparison Application", windowTitle = "Compare Hospitals",
                    tabPanel("Application Description",
                             sidebarPanel(
                                     h4('Application Overview  ', tags$img(width = "74px", height = "12px", src = "beta.png" )),
                                     p('This application is a tool to help individuals find and compare US hospitals. The tool allows users to search US hospitals based on 
                                       three input criteria: State, Outcome and Ranking. The States are the 50 US states plus DC, Guam (GU) and the US Virgin Islands (VI). The available 
                                       Outcomes types are: heart attack, heart failure, and pneumonia. And finally, the hospital Rankings are 1st, 2nd, 3rd, etc., along with \'best\' and \'worst\'
                                       descriptions.'),
                                     p('The results rank over 4,000 Medicare-certified US hospitals based on their handling of heart conditions or pneumonia. 
                                        The application uses information obtained from the Hospital Compare web site (', a(href="http://hospitalcompare.hhs.gov", 'http://hospitalcompare.hhs.gov'), ') 
                                       run by the U.S. Department of Health and Human Services to derive the results. '),
                                     h4('Instructions'),
                                     tags$ol(
                                             tags$li("Select the \'Comparison Tool\' option on the menu bar."), 
                                             tags$li("On the Comparison Tool page enter the desired State, Outcome and Ranking input criteria."), 
                                             tags$li("Click on the Submit button to update the hospital results."),
                                             tags$li("The results are then shown in 3 formats within the Results panel on the lower-left side of the screen: Best Hospital in State, State Hospital by Outcome And Ranking, and Hospitals by Outcome And Ranking (All States). "),
                                             tags$li("Select the tab within the Results panel to see the desired results.")
                                     ),
                                     width = 4
                             ),
                             mainPanel(
                                     #tags$img(src = "findingAHospital2.jpg", width = "4228px", height = "2848px")
                                     tags$img(width = "396px", height = "267px", src = "findingAHospital2.jpg" ),
                                     br(),
                                     br(),
                                     tags$img(src = "whichHospitalText.png")
                             )
                             ),
                    tabPanel("Comparison Tool", 
                             headerPanel ("US Hospital Comparison Tool"),
                             sidebarPanel(
                                     h4('Step 1) Select input data below.'),
                                     
                                     selectInput("State", "Choose a state:", choices = levels(unique(outcomeData[,"State"]))),
                                     
                                     selectInput("Outcome", "Choose an outcome:", 
                                                 choices = gsub("\\.", " " , substring(names(outcomeData[grep(strOutcome, colnames(outcomeData))]),charCnt))),
                                     
                                     textInput("Rank","Choose a ranking (numeric rank or 'best' or 'worst' or '')", 1),
                                     
                                     h4('Step 2) Click Submit for hospital comparison results.'),
                                     
                                     submitButton('Submit')
                             ),
                             mainPanel(
                                     h4('Input Data : State, Outcome, Ranking'),
                                     verbatimTextOutput("enteredState"),
                                     verbatimTextOutput("enteredOutcome"),
                                     verbatimTextOutput("enteredRank"),            
                                     #verbatimTextOutput("convertedRank"),  
                                     
                                     h4('Results :'),
                                     
                                     tabsetPanel(
                                             tabPanel("Best Hospital in State", verbatimTextOutput("bestHospital")),
                                             tabPanel("State Hospital by Outcome And Ranking", verbatimTextOutput ("rankHospital")),
                                             tabPanel("Hospitals by Outcome And Ranking (All States)", dataTableOutput ("rankAll"))
                                     )
                                     )
                    ), 
                   tabPanel("About",
                            mainPanel(
                                    p('This application was done as part of the Coursera Data Science Data Products Course by Johns Hopkins University.'),
                                    p('Many thanks to the professors teaching the Data Science specialization program @ JHU. The courses are excellant!'),
                                    p('Regards,'),
                                    p('Ann Mueller'),
                                    p(''),
                                    p('', tags$a(href="http://rpubs.com/ammraleigh/126432", "Product Presentation"))
                            )
                   )
#                    navbarMenu("More",
#                               tabPanel("Sub-Component A"),
#                               tabPanel("Sub-Component B"))
))
