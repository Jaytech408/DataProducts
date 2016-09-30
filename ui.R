# used libraries
library(shinythemes)
library(stylo)

shinyUI(navbarPage("Titanic Survival Explorer", 
                   theme = shinytheme("cosmo"),
                   ##### Tab 1 - Interactive Analysis
                   tabPanel("Interactive Analysis",
                            fluidPage(
                              sidebarLayout(
                                sidebarPanel( 
                                  checkboxGroupInput("checkGroup", 
                                                     label = h4("Variable selection"), 
                                                     choices = list("Pclass" = 1, "Sex" = 2, "Age" = 3,"SibSp" = 4,"Parch" = 5, "Fare" = 6,"Embarked"= 7,"Title" = 8,"FamilySize" = 9, "CabinPr" = 10), selected = c("Sex", "Age", "Pclass")),
                                  h4("Random Forest Parameters"),
                                  sliderInput("ntree", label = h5("ntree"),
                                              min = 5, max = 2000, value = 500, step=50, ticks=TRUE),
                                  
                                  sliderInput("mtry", label = h5("mtry"),
                                              min = 1, max = 4, value = 2, step=1, ticks=TRUE)
                                ),
                                mainPanel(
                                  tabsetPanel(    
                                    tabPanel("Importance Plot",
                                             plotOutput("importancePlot"), br(), h3(class="accuracy",textOutput("accuracy"), align="center"))
                                    ,
                                    tabPanel("Data", dataTableOutput('table'))
                                    ,
                                    tabPanel("Description", h4("VARIABLE DESCRIPTION"),includeMarkdown("variable.Rmd"), br(),h4("PARAMETER DESCRIPTION"), includeMarkdown("parameter.Rmd"))
                                  )
                                )
                              )
                            ) 
                   ), 
                   ##### Tab 2 - Info
                   tabPanel("Info",
                            fluidPage( h4("INSTRUCTION"),
                                       includeMarkdown("instructions.Rmd")                            )
                   )
) 
) 