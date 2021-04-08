# there are predictors, and outcome variables
# in the titanic, use class, sex, age as predict(x) and survived as (y)


# in R, when your grouping items in a barplot,
# each member of a column is a member of a group
# by tranforming the matrix, you're making all rows in the matrix a column, and all columns in the matrix a row
# hence, if column 1 is all men, and column two is all women
# you must tranform the matrix to make the bargraph be grouped by class (where group has men and women)

library(RColorBrewer)
library(GISTools)
library(Cairo)



colors <- brewer.pal(3, "Set2")
colorsT <- add.alpha(colors, .5)
setwd("C:\\Users\\tecim\\OneDrive\\Desktop\\proj\\rr\\week4")
#list files in current folder
list.files()

#load titanic.csv as dataframe
data <- read.csv("titanic.csv")

data.Adults <- data[data$Age >= 18,]
data.Children <- data[data$Age < 18,]

classes <- sort(unique(data$Pclass))

survivedDataAdult <- matrix(seq(6), nrow=3, ncol=2)
survivedDataChild <- matrix(seq(6), nrow=3, ncol=2)



for (i in 1:length(classes)) {
    temp <- data.Adults[data.Adults$Pclass == classes[i],]
    survivedDataAdult[i, 1] <- sum(temp[temp$Sex == "male", "Survived"]) / length(temp[temp$Sex == "male", "Survived"])
    survivedDataAdult[i, 2] <- sum(temp[temp$Sex == "female", "Survived"]) / length(temp[temp$Sex == "female", "Survived"])
}

for (i in 1:length(classes)) {
    temp <- data.Children[data.Children$Pclass == classes[i],]
    survivedDataChild[i, 1] <- sum(temp[temp$Sex == "male", "Survived"]) / length(temp[temp$Sex == "male", "Survived"])
    survivedDataChild[i, 2] <- sum(temp[temp$Sex == "female", "Survived"]) / length(temp[temp$Sex == "female", "Survived"])
}

#s <- (1-survivedData)

# b <- barplot(t(survivedData), beside=TRUE, ylab="proportion survived", col=colorsT[3], ylim=c(-1,1), yaxt="n", border=NA)
# abline(h=0, col = "Black")
# barplot(-t(s), beside=TRUE, col=colorsT[2], add=TRUE, border=NA, yaxt="n")

# axis(2, at=c(-1,0,1), labels=c(1,0,1))

par(mfcol=c(1,2), pty="s", mar=c(5,3,5,3))

barplot(t(survivedDataAdult), width=50, beside=TRUE, space=c(.3,.6), col=c(colors[1], colors[2]), ylim=c(0,1), names.arg=classes, yaxt="n")
axis(2, at=seq(0,1,.25), tcl=.2, lwd=2, labels=c("", "25%", "50%", "75%", "100%"), las=2, mgp=c(3,.25,0))
mtext("Adult Survival Rates", 3, line=2)


barplot(t(survivedDataChild), beside=TRUE, space=c(.3,.6), 
        col=c(colors[1], colors[2]), ylim=c(0,1), 
        names.arg=classes, yaxt="n")


axis(2, at=seq(0,1,.25), tcl=.2, lwd=2, labels=c("", "25%", "50%", "75%", "100%"), las=2, mgp=c(3,.25,0))
mtext("Child Survival Rates", 3, line=2)

legend(6, .95, legend=c("Male", "Female"),
       fill=c(colors[1], colors[2]))
