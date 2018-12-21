# This script contains each of the definitions of each of the different 
# loss functions we tried out during our research. Including:

# my.loss.function.9 (quadratically weighted sum of balance statistics)
# my.subtraction.loss.func.3 (quadratically weighted sum of differences)



# According to the documentation, it could be that:
# loss.func = sort // default choice... (performs lexical optimization)
# loss.func = min // used to be the default choice... (maximize the scalar)
# and it somehow internally takes care of keeping track of the weights that correspond to it...
# and even more... for example
# loss.func = mean
# 



# It picks the weights that maximize the output of the loss.function

# There will be a given set of weights for which the output of the loss function will
# be the most desirable...


# A GIVEN SET OF WEIGHTS W_1,
# induces a vector of p-values that correspond to the final balance measure to consider.
# You pick the set of weights for which vector of induced values after matching, produces
# the best (highest minimum p value) value of the loss function.
# E.g., if the loss.func = min, you pick the best worst-player.
# If the loss.func = sort, it is more nuanced but same idea (aka "lexical optimization")
# If it is loss.func = mean, well you know what it does.
# Or it could be loss.func = median




# In essence, you give a function that calculates the loss for a set of weights W_i, given
# an induced vector of balance statistics.

# it's really that simple




# Receives a vector of balance statistics (E.G., p-values)
# takes the avg and divides it by its standard deviation
my.loss.function = function(bal.statics.vec) {
  
  # Let's take the avg
  avg = mean(bal.statics.vec)
  
  # But we are not interested in just the highest avg
  # but rather in the highest avg with the least std dev
  stdev = sd(bal.statics.vec) 
  #sd(c(1,2,3,4.5))
  
  loss.value = avg / stdev
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}


# Receives a vector of balance statistics (E.G., p-values)
# takes the avg of the lowest half and divides it by its standard deviation
my.loss.function.2 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  # Let's take the avg
  avg = mean(subvec)
  
  # But we are not interested in just the highest avg
  # but rather in the highest avg with the least std dev
  stdev = sd(subvec) 
  #sd(c(1,2,3,4.5))
  
  loss.value = avg / stdev
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}

# Receives a vector of balance statistics (E.G., p-values)
# takes the avg of the lowest half and divides it by its standard deviation * 2
my.loss.function.3 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  # Let's take the avg
  avg = mean(subvec)
  
  # But we are not interested in just the highest avg
  # but rather in the highest avg with the least std dev
  stdev = sd(subvec) 
  #sd(c(1,2,3,4.5))
  
  loss.value = avg / (stdev * 2) # let's care even less about the mean...
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}


# Receives a vector of balance statistics (E.G., p-values)
# takes the avg of the lowest half and divides it by its standard deviation * 3
my.loss.function.4 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  # Let's take the avg
  avg = mean(subvec)
  
  # But we are not interested in just the highest avg
  # but rather in the highest avg with the least std dev
  stdev = sd(subvec) 
  #sd(c(1,2,3,4.5))
  
  loss.value = avg / (stdev * 3) # let's care even even less about the mean...
  # or more about the "team"
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}


# Receives a vector of balance statistics (E.G., p-values)
# takes the avg of the lowest half and divides it by its standard deviation * 2
# and sums again the min p value to "care even more about it" again.
my.loss.function.5 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  # Let's take the avg
  avg = mean(subvec)
  
  # But we are not interested in just the highest avg
  # but rather in the highest avg with the least std dev
  stdev = sd(subvec) 
  #sd(c(1,2,3,4.5))
  
  loss.value.1 = avg / (stdev * 3) # let's care even even less about the mean...
  # or more about the "team"
  
  # Let's also care a little about the min p value
  min.p.val = min(sorted.vec)
  
  loss.value = loss.value.1 + min.p.val # let's also care about this...
  
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}


# TRYING THE SUM OF P-VALUES (weighted sum of balance statistics)
# Should work better than the previous ones
# If anything, we could weight the smallest p value a little bit more... 

# Takes the sum of balance statistics with linear decrements on the weights.
my.loss.function.6 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  #subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  for (i in 1:length(sorted.vec)) {
    
    p.value = sorted.vec[i]
    
    weighted.value = p.value * (length(sorted.vec) + 1 - i)
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}



# Let's try with half of the vector.
# Takes the sum of balance statistics (half of vector) 
# with linear decrements on the weights.
my.loss.function.7 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    weighted.value = p.value * (length(subvec) + 1 - i)
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}

# Takes the sum of balance statistics (half of vector) 
# with linear decrements on the weights.
# and adds up the minimum pvalue * 10 "to care even more about it"
my.loss.function.8 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    weighted.value = p.value * (length(subvec) + 1 - i)
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  # to care even more about the first value, we'll add it up again
  weighted.sum.p.values = weighted.sum.p.values + sorted.vec[1] * 10
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}



# Let's come up with a function that decreases weights non-linearly!!!








# ****** QUADRATICALLY WEIGHTED SUM OF BALANCE STATISTICS ******
# Takes the sum of balance statistics (half of vector) 
# with quadratic decrements on the weights.
my.loss.function.9 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  
  # using half of the vector...
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  
  
  weighted.sum.p.values = 0 
  
  
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    
    weighted.value = p.value * (length(subvec) + 1 - i)^2
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  # I love expliciteness...
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}



# Let's come up with a function that decreases weights non-linearly!!!
# Takes the sum of balance statistics (half of vector) 
# with quadratic decrements on the weights.
# slight modification into the parenthesis when adding up the weights...
my.loss.function.9.02 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    weighted.value = (p.value * length(subvec) + 1 - i)^2
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}

# Takes the sum of balance statistics (half of vector) 
# with cubic on the weights.
my.loss.function.10 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    weighted.value = p.value * (length(subvec) + 1 - i)^3
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}

# Takes the sum of balance statistics (half of vector) 
# with ^4 on the weights.
my.loss.function.10.2 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    weighted.value = p.value * (length(subvec) + 1 - i)^4
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}


# Takes the sum of balance statistics (half of vector) 
# with ^2.5 on the weights.
my.loss.function.11 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    weighted.value = p.value * (length(subvec) + 1 - i)^2.5
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}


# An adjustment of how the weights decrease
# also remember to try weighting the values of all the vector...
# Let's come up with a function that decreases weights non-linearly!!!

# Takes the sum of balance statistics (half of vector) 
# with linear decrements on the weights, but gradually, 
# conditionally on the subsequent statistic changing its value 

my.loss.function.12 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  current.weight = length(subvec) + 1
  previous.p.value = sorted.vec[1]
  
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    if (p.value < previous.p.value) {
      current.weight = current.weight - 1 # could be  - i though
      previous.p.value = p.value
    }
    
    weighted.value = p.value * (current.weight)^2
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}

# Takes the sum of balance statistics (half of vector) 
# with quadratic decrements on the weights, but gradually, 
# conditionally on the subsequent statistic changing its value 

my.loss.function.13 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  current.weight = length(subvec) + 1
  previous.p.value = sorted.vec[1]
  
  for (i in 1:length(subvec)) {
    
    p.value = sorted.vec[i]
    
    if (p.value < previous.p.value) {
      current.weight = current.weight - i # could be  - i though
      previous.p.value = p.value
    }
    
    weighted.value = p.value * (current.weight)^2
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}


# Takes the sum of balance statistics (entirety of vector) 
# with quadratic decrements on the weights, but gradually, 
# conditionally on the subsequent statistic changing its value 
my.loss.function.14 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  #subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  current.weight = length(sorted.vec) + 1
  previous.p.value = sorted.vec[1]
  
  for (i in 1:length(sorted.vec)) {
    
    p.value = sorted.vec[i]
    
    if (p.value < previous.p.value) {
      current.weight = current.weight - i # could be  - i though
      previous.p.value = p.value
    }
    
    weighted.value = p.value * (current.weight)^2
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}



# same approach as the last ones, but covers entire array...
# Takes the sum of balance statistics (half of vector) 
# with cubic decrements on the weights, but gradually, 
# conditionally on the subsequent statistic changing its value 

my.loss.function.14.2 = function(bal.statics.vec) {
  
  sorted.vec = sort(bal.statics.vec)
  
  #subvec = sorted.vec[1:length(sorted.vec)/2]
  
  weighted.sum.p.values = 0 
  current.weight = length(sorted.vec) + 1
  previous.p.value = sorted.vec[1]
  
  for (i in 1:length(sorted.vec)) {
    
    p.value = sorted.vec[i]
    
    if (p.value < previous.p.value) {
      current.weight = current.weight - i # could be  - i though
      previous.p.value = p.value
    }
    
    weighted.value = p.value * (current.weight)^3
    
    weighted.sum.p.values = weighted.sum.p.values + weighted.value
    
  }
  
  
  
  loss.value = weighted.sum.p.values 
  
  
  return (loss.value)
  
  
  # You could also focus this calculations on the lower half of the data.
  # e.g., until the 50th percentile of the observations...
  # Because, in general, those are the fucked up guys...
  
  
  
}



# Had a new idea at a very cold cafe in Seoul...


# TRYING THE SUM OF DIFFERENCES (weighted sum of differences)


# plain sum of differences
my.subtraction.loss.func.1 = function(bal.statics.vec){
 
  sorted.vec = sort(bal.statics.vec)
  
  
  total.loss = 0
  for (i in 1:length(sorted.vec)) {
    p.val.i = sorted.vec[i] #val between 0 and 1
    
    loss.i = p.val.i - 1 # i is the ideal 
    
    total.loss = total.loss + loss.i # might consider to multiply by a weight
  }
  
  loss.value = total.loss #I like explicitness...
  
  
  return (loss.value) 
}

# let's try some linear weights...
# linearly weighted sum of differences (entire vector)
my.subtraction.loss.func.2 = function(bal.statics.vec){
  
  sorted.vec = sort(bal.statics.vec)
  
  
  total.loss = 0
  for (i in 1:length(sorted.vec)) {
    p.val.i = sorted.vec[i] #val between 0 and 1
    
    loss.i = p.val.i - 1 # i is the ideal 
    
    total.loss = total.loss + (loss.i) * (length(sorted.vec) + 1 - i) # might consider to multiply by a weight
  }
  
  loss.value = total.loss #I like explicitness...
  
  
  return (loss.value) 
}



# *** QUADRATICALLY WEIGHTED SUM OF DIFFERENCES ***
# quadratically weighted sum of differences (entire vector)
my.subtraction.loss.func.3 = function(bal.statics.vec){
  
  sorted.vec = sort(bal.statics.vec)
  
  
  total.loss = 0
  for (i in 1:length(sorted.vec)) {
    p.val.i = sorted.vec[i] #val between 0 and 1
    
    loss.i = p.val.i - 1 # i is the ideal 
    
    total.loss = (total.loss + loss.i) * (length(sorted.vec) + 1 - i)^2 # might consider to multiply by a weight
  }
  
  loss.value = total.loss #I like explicitness...
  
  
  return (loss.value) 
}

# let's try some quadratic weights...
# quadratically weighted sum of differences (entire vector)
# slight modification on the weighting line 
my.subtraction.loss.func.3.2 = function(bal.statics.vec){
  
  sorted.vec = sort(bal.statics.vec)
  
  
  total.loss = 0
  for (i in 1:length(sorted.vec)) {
    p.val.i = sorted.vec[i] #val between 0 and 1
    
    loss.i = p.val.i - 1 # i is the ideal 
    
    total.loss = total.loss + (loss.i) * (length(sorted.vec) + 1 - i)^2 # might consider to multiply by a weight
  }
  
  loss.value = total.loss #I like explicitness...
  
  
  return (loss.value) 
}


