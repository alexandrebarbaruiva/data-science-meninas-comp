library(dplyr)
library(caret)

data <- read.csv("data.csv", header = TRUE, na.strings=c(""))

# drop <- c("Gender", "Year", "Educational.Stage", "Field.Of.Interest")

data2 <- data[, -(1:7), drop=FALSE ]

data2 <- data2[complete.cases(data2),]

cor(data2)

# data3 <- lapply(data2, decide)