


setwd("C:\\Users\\tecim\\OneDrive\\Desktop\\proj\\rr\\week4")
data <- read.csv("titanic.csv")


hist(data$Age)
lines(y=0, x=29, lwd=2, col="Black")