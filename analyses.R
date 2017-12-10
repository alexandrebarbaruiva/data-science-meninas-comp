library(dplyr)
library(caret)
library(corrplot)

df <- read.csv("data.csv", header = TRUE, na.strings=c(""), stringsAsFactors=FALSE)
df <- df[, -(1:4), drop=FALSE ]
df <- df[, -(2:3), drop=FALSE ]
df <- df[complete.cases(df),]

decide <- function(x) {
  switch(x,
    "Yes"= {
      return(2)
    },
    "Maybe"={
      return(1)
    },
    "No"={
      return(0)
    },
    {
      return(0)
    }
  )
}

for(j in 1:32) {
  for(i in 1:3178) {
    df[i, j] <- decide(df[i, j])
  }
  df[,j] <- as.numeric(df[,j])
}

df$Would.Enroll.In.CS <- factor(df$Would.Enroll.In.CS, levels=c(0,1,2), labels=c("No", "Maybe", "Yes"))

trainingIndexes <- createDataPartition(df$Would.Enroll.In.CS, p=0.85, list=FALSE)
trainingData <- df[trainingIndexes,]
testData <- df[-trainingIndexes,]
trainingParameters <- trainControl(method="repeatedcv", number=10, repeats=2)

SVModel <- train(Would.Enroll.In.CS ~ ., data = trainingData,
                 method = "svmPoly",
                 trControl= trainingParameters,
                 tuneGrid = data.frame(degree = 1,
                                       scale = 1,
                                       C = 1),
                 preProcess = c("pca","scale","center"),
                 na.action = na.omit
)

importance <- varImp(SVModel, scale=FALSE)

corMatrix <- cor(df[,2:32])
highlyCorrelated <- findCorrelation(corMatrix, cutoff=0.50)
# corrplot(corMatrix, method = "circle", cl.pos = "n", tl.pos = "n")