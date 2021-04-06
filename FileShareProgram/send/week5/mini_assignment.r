setwd("C:\\Users\\tecim\\OneDrive\\Desktop\\proj\\rr\\week5")
load("titanicDataFrame.RData")

titanicDataFrame$SurvivedC <- factor(titanicDataFrame$Survived, levels=c("0-24 years", "25-34 years", "35-44 years", "45-54 years", "55-64 years", "65-74 years", "75-84 years", "85 years and over"), labels=c("dead", "alive"))

model1 <- glm(Survived ~ Sex + Age + PclassN,
              data=titanicDataFrame,
              family="binomial")

model2 <- glm(Survived ~ Sex + Age,
              data=titanicDataFrame,
              family="binomial")



results1 <- predict(model1, titanicDataFrame, type="response")

results2 <- predict(model2, titanicDataFrame, type="response")


titanicTest1 <- titanicDataFrame
titanicTest2 <- titanicDataFrame

titanicTest1$prediction <- results1 > .5
titanicTest2$prediction <- results2 > .5




# False Positive = when model predicted survival but data point died
results1.FP <- sum(titanicTest1$prediction == TRUE & titanicTest1$Survived == 0) / sum(titanicTest1$Survived == 0)
results1.FN <- sum(titanicTest1$prediction == FALSE & titanicTest1$Survived == 1) / sum(titanicTest1$Survived == 1)
results1.PPV <- sum(titanicTest1$prediction == TRUE & titanicTest1$Survived == 1) / sum(titanicTest1$prediction == 1)


results2.FP <- sum(titanicTest2$prediction == TRUE & titanicTest2$Survived == 0) / sum(titanicTest2$Survived == 0)
results2.FN <- sum(titanicTest2$prediction == FALSE & titanicTest2$Survived == 1) / sum(titanicTest2$Survived == 1)
results2.PPV <- sum(titanicTest2$prediction == TRUE & titanicTest2$Survived == 1) / sum(titanicTest2$prediction == 1)

cat("Model 1 (Survived ~ Sex + Age + Class)", "\n", "False Positive:", results1.FP, "\n", "False Negative:", results1.FN, "\n", "PPV:", results1.PPV, "\n\n")
cat("Model 2 (Survived ~ Sex + Age)", "\n", "False Positive:", results2.FP, "\n", "False Negative:", results2.FN, "\n", "PPV:", results2.PPV, "\n\n")


# Model 1 has a slightly higher false positive rate (.2%), while model 2 has a about a 2.6% higher False Negative rate.
# Model 1's PPV is higher by about .5%.
# Overall, taking class into account when making predictions increases the model's accuracy, but not by a whole lot.

# Model 1 is slightly more accurate.