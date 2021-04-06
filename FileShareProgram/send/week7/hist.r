library("Sleuth3")
library("RColorBrewer")
library("GISTools")
library("Cairo")

colors <- brewer.pal(3, "Set1")
colorsT <- add.alpha(colors, .4)
data <- case0201
data76 <- data[data$Year == "1976",]
data78 <- data[data$Year == "1978",]

# setwd("...")
# cairo_pdf("finch_beaks.pdf",height=10, width=10)
par(mfcol=c(2,1),mai=c(0,.75,0.25,.75))

hist(data76$Depth, col=colorsT[2], ylim=c(0,25), yaxt="n", xaxt="n", main="", ylab="", xlab="")
hist(data78$Depth, add=TRUE, col=colorsT[3])
axis(2, at=seq(0,25, 5), labels=seq(0,25,5), las=2, tcl=.3, mgp=c(3,1.3,1))
axis(1, at=seq(6,12), labels=seq(6,12), mgp=c(3,.5,0), tcl=.3)
title(xlab="Depth", line=2)
title(ylab="Frequency", line=2.4)
title(main="Beak Depth of Finches in 1976 & 1978", line=.1, tck=.1)
legend("topleft", inset=.1, border=NA, bty="n", legend=c("1976", "1978"), fill=c(colorsT[2], colorsT[3]))


par(mai=c(.75,.75, .5,.75))
boxplot(Depth ~ Year, data=data, horizontal=TRUE, ylim=c(6,12), boxwex=.5, yaxt="n", xaxt="n", xlab="", ylab="", col=colorsT[2:3], mgp=c(3,1.3,0))
axis(1, at=seq(6,12), labels=seq(6,12), mgp=c(3,.5,0), tcl=.3)
title(xlab="Depth", line=1.7)

# dev.off()