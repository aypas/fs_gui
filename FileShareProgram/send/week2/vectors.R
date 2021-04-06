#must all be the same type
c <- c(1,3,4)
f <- c("f", "b", "c")

#the output bellow, all the elements will be made intro strings...
b <- c(1,2,3, "hi")

#generating vectors

#generating vec, exactly like range in python
a <- seq(1,20, 2)
print(a)

#random
runif(n=10, min=0,max=1) #returns 10 nums, between 0 and 1

# sort(someVector) returns a new vector which has been sorted

length(a) # == 10


min(a) # returns smallest
max(a) # returns largest
range(a) # returns min and max as vector of length 2

#logical operators
booled <- a < .5 #each element tested on this boolean operations 
evens <- a %% 2 == 0 #true for each even element in a ie c(true, false, true)

#now
a[evens] # this iterators over all even elements which are even

#alternate would be
a[a %% 2 == 0] #is the exact same thing

# take both spec and offer as being job and 
spec <- c("cardio", "neuro", "uro", "gp", "gyn")
offer <- c(110, 220, 330, 400, 500)
spec[offer == sort(offer)[length(offer)-2]]

# order function is like sort, but gives you the ordered indexes

