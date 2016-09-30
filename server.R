# used libraries
library(Metrics)
library(caret)
library(randomForest)
library(dplyr)

# load the train dataset preprocessed in file TitanikDataPreprocessing.R 
training <- readRDS("trainPreprocess.Rda")

# convert dataset into data frame tbl to use dplyr functions 
training <- tbl_df(training)
# select features for exploratory analysis
training2 <- training %>% select(Survived,Pclass,Sex,Age,SibSp,Parch,Ticket,Fare,Embarked,Title,FamilySize,CabinPr)

# function that converts checkbox input into a new data frame with the selected features
InputTransformer <- function(value){
  textInput <- unlist(strsplit(value," "))
  # create data frame with selected features
  df <- training2 %>% select(Survived)
  if ("1" %in% textInput){df$Pclass <- training2$Pclass}
  if ("2" %in% textInput){df$Sex <- training2$Sex}
  if ("3" %in% textInput){df$Age <- round(training2$Age, 0)}
  if ("4" %in% textInput){df$SibSp <- training2$SibSp}
  if ("5" %in% textInput){df$Parch <- training2$Parch}
  if ("6" %in% textInput){df$Fare <- round(training2$Fare, 1)}
  if ("7" %in% textInput){df$Embarked <- training2$Embarked}
  if ("8" %in% textInput){df$Title <- training2$Title}
  if ("9" %in% textInput){df$FamilySize <- training2$FamilySize}
  if ("10" %in% textInput){df$CabinPr <- training2$CabinPr}
  return(df)
}

# apply Random Forest algorithm to the df with the selected features 
source("fitting.R")

shinyServer(function(input, output) {
  output$value <- renderPrint({ input$checkGroup })
  output$table <- renderDataTable(InputTransformer(input$checkGroup), options = list(pageLength = 10))
  output$accuracy <- renderText({ 
    # accuracy of Random Forest classification with the selected algorithm parameters
    acc <- accuracyRF(InputTransformer(input$checkGroup),input$ntree,input$mtry)
    # print out the accuracy
    paste("Classification accuracy:  ", round(acc,3), "%")  
  })
  # print out the variable importance plot
  output$importancePlot <- renderPlot({plotImp(InputTransformer(input$checkGroup),input$ntree,input$mtry)})
})