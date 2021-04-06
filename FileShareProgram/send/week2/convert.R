#you can give this func a vector, and itll iterate over it
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
if (convert(-40, "f") == convert(-40, "c")) {
    print("first is gut")
} else {
    print("fail")
    stop()
}
tests <- c(1,2,3,4,5,6,7)
for (index in 1:length(tests)) {
    cat(tests[index], )
}
cat(convert(700, "c"), convert(100, "f"), "\n")