cars <- data.frame(CarBrand=c("BMW", "Mercedes", "Toyota", "Mazda", "Tesla"), 
                   Model=c("I8", "S-Class", "Rav 4", "CX-5", "Model S"),
                   topSpeed=c(200, 170, 100, 128, 160))

#could be any function which returns a value for each element in a data frame's column vector
determineClass <- function(val) {
    if (val > 180) {
        return("class a")
    } else if (val > 159) {
        return("class b")
    } else if (val > 125) {
        return("class c")
    } else if (val > 99) {
        return("class d")
    } else {
        return("horse")
    }
}

#this function requires 4 arguments:
#dt is the dataframe which we want to change.
#newColName is the name of the new column we want to add (must be a string).
#conditionalCol is the column we will use to derive the new column (must also be a string).
#and conditionFunc is a function that returns a derived value for each item in the conditionalCol vector.
AddDerivedColumn <- function(dt, newColName, conditionCol, conditionFunc) {
    #initiate empty vector
    values <- NULL

    #loop through each item in the data frame's conditionalCol column
    for (i in 1:length(dt[,conditionCol])) {
        #grab specific value in column
        value <- dt[,conditionCol][i]

        #put specific value into the provided function
        derivedVal <- conditionFunc(value)

        #append new value to the array created above
        values[i] <- derivedVal
    }

    #add new array to the data frame as a column and return
    dt[,newColName] <- values
    return(dt)
}

classyCars <- AddDerivedColumn(cars, "class", "topSpeed", determineClass)

#and some other examples
speedyCars <- AddDerivedColumn(cars, "SpeedTimesTen", "topSpeed", 
                            function(val) { return(val*10) })

lengthOfNameCars <- AddDerivedColumn(cars, "lengthOfName", "CarBrand",
                            function(val) { return(nchar(val)) })

WackyNameCars <- AddDerivedColumn(cars, "coolName", "Model", 
                            function(val) { return(paste(val, "-SuperMobile", sep="")) })