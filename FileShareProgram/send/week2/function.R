isEven <- function(x) {
    return(x %% 2 == 0)
}

cat(isEven(1), isEven(99), "\n")


is <- function(type) {
    if (type == "odd") {
        return(function(num) {return(num %% 2 == 1)})
    } else if (type == "even") {
        return(function(num) {return(num %% 2 == 0)})
    } else {
        return(function(num) {return(NULL)})
    }
}

cat(is("odd")(111), is("even")(40), "\n")