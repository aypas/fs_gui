convert <- function(value, from) {
    #from argument is the unit of the value; if "f", value will be converted to c, and vice versa
    if (from == "c") {
        valueConvertedToC <- (value * (9/5)) + 32
        return(valueConvertedToC)
    } else if (from == "f") {
        valueConvertedToF <- (value - 32) * (5/9)
        return(valueConvertedToF)
    } else {
        return("error")
    }
}

#cbind(args) gets makes matrix out of all vectors as columns
#rbind(args) makes matrix out of all vectors as rows
#BOTH CBIND AND RBIND CAN TAKE MATRICES AS ARGS

#if you want to take two 10x4 matrices and combine them 
#use cbind to make it 10x4
#use rbind to make it 20x4

#matrix(1starg, nrow=int, ) makes a matrix out of one vector 
fTemps <- c(1,2,3,4,5,6)
cTemps <- convert(fTemps, "f")
cMatrix <- cbind(fTemps, cTemps)
cMatrix
print(cMatrix)

#apply function is like for each
#1 returns each named set as a row, 2 returns each named set as row