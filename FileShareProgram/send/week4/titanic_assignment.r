library(RColorBrewer)
library(GISTools)
colors <- brewer.pal(3, "Set1") # 2 is blue, 3 is green
colors <- add.alpha(colors, .7)


data <- read.csv("titanic.csv")
data.Adults <- data[data$Age >= 18,]
data.Children <- data[data$Age < 18,]


classes <- sort(unique(data$Pclass))
resultsAdults <- matrix(1:6, nrow=3, ncol=2)
resultsChildren <- matrix(1:6, nrow=3, ncol=2)



for (i in 1:length(classes)) {
    temp <- data.Adults[data.Adults$Pclass == classes[i],]
    resultsAdults[i, 1] <- sum(temp[temp$Sex == "male", "Survived"]) / length(temp[temp$Sex == "male", "Survived"])
    resultsAdults[i, 2] <- sum(temp[temp$Sex == "female", "Survived"]) / length(temp[temp$Sex == "female", "Survived"])
}

for (i in 1:length(classes)) {
    temp <- data.Children[data.Children$Pclass == classes[i],]
    resultsChildren[i, 1] <- sum(temp[temp$Sex == "male", "Survived"]) / length(temp[temp$Sex == "male", "Survived"])
    resultsChildren[i, 2] <- sum(temp[temp$Sex == "female", "Survived"]) / length(temp[temp$Sex == "female", "Survived"])
}

deathsAdults <- (1 - resultsAdults) * -1
deathsChildren <- (1 - resultsChildren) * -1

par(mfcol=c(2,1), mar=c(4,3,2,1), omi=c(0,0,0,0))


barplot(resultsAdults, beside=TRUE, col=colors[3], yaxt="n", ylim=c(-1,1), names.arg=c("Male", "Female"), space=c(.1,.6), border=NA)
barplot(deathsAdults, beside=TRUE, col=colors[2], yaxt="n", ylim=c(-1,1), border=NA, add=TRUE, space=c(.1,.6))
axis(2, at=seq(-1,1,.5), tcl=.25, labels=c("100%", "50%", "0%", "50%", "100%"), las=2, mgp=c(3,.2,0), cex.axis=.8)
lines(x=c(0.6,7.59), y=c(0,0), lwd=2, col="cornsilk4")
mtext("Portion Survived", 2, cex=.7, adj=.8, line=1.8)
mtext("Portion Perished", 2, cex=.7, adj=.2, line=1.8)
mtext("Adults", 3, adj=0, line=.5)



barplot(resultsChildren, beside=TRUE, col=colors[3], yaxt="n", ylim=c(-1,1), space=c(.1,.6), border=NA)
barplot(deathsChildren, beside=TRUE, col=colors[2], yaxt="n", ylim=c(-1,1), border=NA, names.arg=c(classes,classes), add=TRUE, space=c(.1,.6), cex.names=.9)
axis(2, at=seq(-1,1,.5), tcl=.25, labels=c("100%", "50%", "0%", "50%", "100%"), las=2, mgp=c(3,.2,0), cex.axis=.8)
mtext("Portion Survived", 2, cex=.7, adj=.8, line=1.8)
mtext("Portion Perished", 2, cex=.7, adj=.2, line=1.8)
mtext("Children", 3, adj=0, line=.5)
title(xlab="Travel Class")
lines(x=c(0.6,7.59), y=c(0,0), lwd=2, col="cornsilk4")
