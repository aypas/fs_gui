# for any file that is in R format (matrices, dataframes)
# use load function to load

# otherwise there are functions for specific formats
# like read csv

setwd("C:\\Users\\tecim\\OneDrive\\Desktop\\proj\\rr\\week5")
load("titanicDataFrame.RData")


predictor <- glm(Survived ~ Sex + Age,
                 data=titanicDataFrame,
                 family="binomial")

plogis(1.11 + -2.5 + -.002 * 23) # male age 23
plogis(1.11 + -.002*23) #female age 23

pred <- glm(Survived ~ Sex + Age + Pclass,
            data=titanicDataFrame,
            family="binomial")


titanicDataFrame$SurvivedC <- factor(titanicDataFrame$Survived, levels=c(0,1), labels=c("dead", "alive"))


Y <- predict(pred, titanicDataFrame, type="response") # does predictions of y values



