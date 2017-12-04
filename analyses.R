library(dplyr)

data <- read.csv("data.csv", header = TRUE)
nrow(data)
data <- data[data$Gender == 'F',]
nrow(data)