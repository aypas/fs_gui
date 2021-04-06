data.frame()
#always ROW, COLUMN
head(dt) #returns first six
tail(dt) #returns last six

summary() #returns some detail...


#you can filter data.frames the same way you can filter vectors/matrices
a <- data.frame(a=seq(1,20), b=seq(1,20))

#all rows with an even a

a[a$a %% 2 == 0,]
