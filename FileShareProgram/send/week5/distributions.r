# binomial and normal distribution and thier density


par(mfcol=c(2,2))


nums <- seq(-3,3, length.out=1000)

plot(dlogis(nums), ylab="", xlab="")
lines(x=c(500,500), y=c(0,.25))
title(xlab="At index X")
mtext("Binomial Distribution", side=3, line=1)

plot(plogis(nums), ylab="", xlab="")
title(ylab="Percentile", line=3)
title(xlab="At Index X")
mtext("Binomial Percentiles", side=3, line=1)



plot(dnorm(nums), ylab="", xlab="")
lines(x=c(500,500), y=c(-1,.4))
title(xlab="At index X")
mtext("Gaussian Destribution" ,side=3, line=1)

plot(pnorm(nums), ylab="", xlab="")
title(ylab="Percentile", line=3)
title(xlab="At Index X")
mtext("Gaussian Percentiles", side=3, line=1)
