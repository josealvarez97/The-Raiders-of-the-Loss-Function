# This script defines 

# NSW.GenMatch() = function(nsw_obs_data, population = 100, max.gen = 100, wait.gen = 4, my.loss.f = 1)
# function that produces mout from GenMatch weights 
# based on a NSW "faked" obs data set when re74 is ACTUALLY included.
# (aka, for the DW sample and early RA sample)

# and defines

# NSW.MeasureBalance = function(nsw_obs_data, match.output)
# which returns the output MatchBalance, based on the output of NSW.GenMatch()
# similarly, it works for a NSW "faked" obs data set when re74 is ACTUALLY included.





# Produces mout from GenMatch weights based on a NSW "faked" obs data set.
NSW.GenMatch = function(nsw_obs_data, population = 100, max.gen = 100, wait.gen = 4, my.loss.f = 1) {
  
  
  #cat("*Parameters:* ", "population = ", population,", max.gen = ", max.gen, ", wait.gen = ", wait.gen, ", my.loss.f = ", my.loss.f, "\n")
  
  
  # "GenMatch was asked to maximize balance in all of 
  # the observed covariates, their first-order 
  # interactions, and quadratic terms"
  
  
  # The Covariates We Want to Match On
  X = as.matrix(cbind(
    nsw_obs_data$age, nsw_obs_data$education, nsw_obs_data$black, nsw_obs_data$hispanic,
    nsw_obs_data$married, nsw_obs_data$nodegree, nsw_obs_data$re74, nsw_obs_data$re75
  ))
  
  
  # What we want to achieve balance on
  # ("the observed covariates, their first-order interactions, and quadratic terms)
  BalanceMat = as.matrix(cbind(
    # The covariates
    nsw_obs_data$age, nsw_obs_data$education, nsw_obs_data$black, nsw_obs_data$hispanic,
    nsw_obs_data$married, nsw_obs_data$nodegree, nsw_obs_data$re74, nsw_obs_data$re75,
    
    # Their first order interactions
    # age
    I(nsw_obs_data$age * nsw_obs_data$education),
    I(nsw_obs_data$age * nsw_obs_data$black),
    I(nsw_obs_data$age * nsw_obs_data$hispanic),
    I(nsw_obs_data$age * nsw_obs_data$married),
    I(nsw_obs_data$age * nsw_obs_data$nodegree),
    I(nsw_obs_data$age * nsw_obs_data$re74),
    I(nsw_obs_data$age * nsw_obs_data$re75),
    
    # educ
    I(nsw_obs_data$education * nsw_obs_data$black),
    I(nsw_obs_data$education * nsw_obs_data$hispanic),
    I(nsw_obs_data$education * nsw_obs_data$married),
    I(nsw_obs_data$education * nsw_obs_data$nodegree),
    I(nsw_obs_data$education * nsw_obs_data$re74),
    I(nsw_obs_data$education * nsw_obs_data$re75),
    
    # black
    I(nsw_obs_data$black * nsw_obs_data$hispanic),
    I(nsw_obs_data$black * nsw_obs_data$married),
    I(nsw_obs_data$black * nsw_obs_data$nodegree),
    I(nsw_obs_data$black * nsw_obs_data$re74),
    I(nsw_obs_data$black * nsw_obs_data$re75),
    
    # hispanic
    I(nsw_obs_data$hispanic * nsw_obs_data$married),
    I(nsw_obs_data$hispanic * nsw_obs_data$nodegree),
    I(nsw_obs_data$hispanic * nsw_obs_data$re74), # I(nsw_obs_data$hispanic * nsw_obs_data$re74)  Number(s): 29
    I(nsw_obs_data$hispanic * nsw_obs_data$re75),
    
    # married
    I(nsw_obs_data$married * nsw_obs_data$nodegree),
    I(nsw_obs_data$married * nsw_obs_data$re74),
    I(nsw_obs_data$married * nsw_obs_data$re75),
    
    # nodegree
    I(nsw_obs_data$nodegree * nsw_obs_data$re74),
    I(nsw_obs_data$nodegree * nsw_obs_data$re75),
    
    # re74 (and re75...)
    I(nsw_obs_data$re74 * nsw_obs_data$re75),
    
    # And their quadratic terms
    I(nsw_obs_data$age ^ 2),
    I(nsw_obs_data$education ^ 2),
    I(nsw_obs_data$black ^ 2),
    I(nsw_obs_data$hispanic ^ 2),
    I(nsw_obs_data$married ^ 2),
    I(nsw_obs_data$nodegree ^ 2),
    I(nsw_obs_data$re74 ^ 2),
    I(nsw_obs_data$re75 ^ 2)
    
  ))
  
  
  # Model template for the prp score
  functional.form.prp.scr = nsw_obs_data$treat ~ 
                              I(nsw_obs_data$age) + 
                              I(nsw_obs_data$age ^ 2) + 
                              I(nsw_obs_data$age ^ 3) + 
                              I(nsw_obs_data$education) + 
                              I(nsw_obs_data$education ^ 2) +  
                              I(nsw_obs_data$married) +
                              I(nsw_obs_data$nodegree) +
                              I(nsw_obs_data$black) +
                              I(nsw_obs_data$hispanic) +
                              I(nsw_obs_data$re74) +
                              I(nsw_obs_data$re75) +
                              I(nsw_obs_data$re74 == 0) +
                              I(nsw_obs_data$re75 == 0) +
                              I( I(nsw_obs_data$re74) * I(nsw_obs_data$re75))
  
  # Produce prp score model
  p.scr.model = glm(functional.form.prp.scr, family = binomial)
  
  
  
  # Here you may want to do the normalization and orthogonalization suff
  # or before the previous line perhaps
  
  
  # "Orthogonalize to propensity score"
  X2 = X
  for (i in 1:ncol(X2)) {
    # Just a regression like any other here.
    # Regressing each covariate i onto (all) the prp scores... 
    lm1 = lm(X2[,i] ~ p.scr.model$linear.predictors)
    # For getting a model of the type
    # covariate_i = B0 + B1 * prp_score
    
    X2[,i] = lm1$residuals # this is definitely counterintuitive.
    # what is that for...
  }
  
  
  # "Variables we match on begin with propensity score
  orthoX2.plus.pscore = cbind(p.scr.model$linear.predictors, X2)
  
  # [,1] is the col of pscores
  # weird move here...
  orthoX2.plus.pscore[,1] = orthoX2.plus.pscore[,1] - mean(orthoX2.plus.pscore[,1]) 
  
  
  
  # "Normalize all covars by standard deviation"
  for (i in 1:(dim(orthoX2.plus.pscore)[2])){
    orthoX2.plus.pscore[,i] = #for each column i in this
      orthoX2.plus.pscore[,i] / sqrt(var(orthoX2.plus.pscore[,i]))
  }
  
  
  
  
  # Attach prp scores to X...
  #X.plus.p.scrs = cbind(p.scr.model$linear.predictors, X)
  

  
  
  
  
  
  # Time to find the weights
  # "In all of the analyses in this paper, we estimate the 
  # average treatment effect on the treated (ATT) by one-to-one
  # matching with replacement"  
  
  
  # "GenMatch was run with its default parameters" (not for this section tho I think)
  # GenMatch(Tr, X, BalanceMatrix=X, estimand="ATT", M=1, weights=NULL,
  #          pop.size = 100, max.generations=100,
  #          wait.generations=4, hard.generation.limit=FALSE,
  #          starting.values=rep(1,ncol(X)),
  #          fit.func="pvals",
  #          MemoryMatrix=TRUE,
  #          exact=NULL, caliper=NULL, replace=TRUE, ties=TRUE,
  #          CommonSupport=FALSE, nboots=0, ks=TRUE, verbose=FALSE,
  #          distance.tolerance=1e-05,
  #          tolerance=sqrt(.Machine$double.eps),
  #          min.weight=0, max.weight=1000,
  #          Domains=NULL, print.level=2,
  #          project.path=NULL,
  #          paired=TRUE, loss=1,
  #          data.type.integer=FALSE,
  #          restrict=NULL,
  #          cluster=FALSE, balance=TRUE, ...)
  # IMPORTANT: pop.size = 100, max.generations = 100, wait.generations = 4,
  # hard.generations.limit - FALSE, replace = TRUE
  
  
  genout = GenMatch(Tr= nsw_obs_data$treat,
                       X = orthoX2.plus.pscore,
                       BalanceMatrix = BalanceMat,
                    
                      pop.size = population,
                      max.generations = max.gen,
                      wait.generations = wait.gen,
                    hard.generation.limit = TRUE,
                    loss = my.loss.f)
  
  Y = nsw_obs_data$re78
  
  mout = Match(Y=Y, Tr= nsw_obs_data$treat, X = orthoX2.plus.pscore,
                  Weight.matrix = genout)
  
  
  summary(mout)
  
  print("Hello World")
  return (mout)
  
  
}

# Measures balance of mout out of a NSW "faked" obs data set.
NSW.MeasureBalance = function(nsw_obs_data, match.output){
  balance_object = MatchBalance(
    
    nsw_obs_data$treat ~ 
      # All the covariates
      nsw_obs_data$age + nsw_obs_data$education +
      nsw_obs_data$black + nsw_obs_data$hispanic +
      nsw_obs_data$married + nsw_obs_data$nodegree +
      nsw_obs_data$re74 + nsw_obs_data$re75 +
      # Their first order interactions
      # age
      I(nsw_obs_data$age * nsw_obs_data$education) +
      I(nsw_obs_data$age * nsw_obs_data$black) +
      I(nsw_obs_data$age * nsw_obs_data$hispanic) +
      I(nsw_obs_data$age * nsw_obs_data$married) +
      I(nsw_obs_data$age * nsw_obs_data$nodegree) +
      I(nsw_obs_data$age * nsw_obs_data$re74) +
      I(nsw_obs_data$age * nsw_obs_data$re75) +
      
      # educ
      I(nsw_obs_data$education * nsw_obs_data$black) +
      I(nsw_obs_data$education * nsw_obs_data$hispanic) +
      I(nsw_obs_data$education * nsw_obs_data$married) +
      I(nsw_obs_data$education * nsw_obs_data$nodegree) +
      I(nsw_obs_data$education * nsw_obs_data$re74) +
      I(nsw_obs_data$education * nsw_obs_data$re75) +
      
      # black
      I(nsw_obs_data$black * nsw_obs_data$hispanic) +
      I(nsw_obs_data$black * nsw_obs_data$married) +
      I(nsw_obs_data$black * nsw_obs_data$nodegree) +
      I(nsw_obs_data$black * nsw_obs_data$re74) +
      I(nsw_obs_data$black * nsw_obs_data$re75) +
      
      # hispanic
      I(nsw_obs_data$hispanic * nsw_obs_data$married) +
      I(nsw_obs_data$hispanic * nsw_obs_data$nodegree) +
      I(nsw_obs_data$hispanic * nsw_obs_data$re74) +
      I(nsw_obs_data$hispanic * nsw_obs_data$re75) +
      
      # married
      I(nsw_obs_data$married * nsw_obs_data$nodegree) +
      I(nsw_obs_data$married * nsw_obs_data$re74) +
      I(nsw_obs_data$married * nsw_obs_data$re75) +
      
      # nodegree
      I(nsw_obs_data$nodegree * nsw_obs_data$re74) +
      I(nsw_obs_data$nodegree * nsw_obs_data$re75) +
      
      # re74 (and re75...)
      I(nsw_obs_data$re74 * nsw_obs_data$re75) +
      
      
      # And their quadratic terms
      I(nsw_obs_data$age ^ 2) +
      I(nsw_obs_data$education ^ 2) +
      I(nsw_obs_data$black ^ 2) +
      I(nsw_obs_data$hispanic ^ 2) +
      I(nsw_obs_data$married ^ 2) +
      I(nsw_obs_data$nodegree ^ 2) +
      I(nsw_obs_data$re74 ^ 2) +
      I(nsw_obs_data$re75 ^ 2),
    
    data = nsw_obs_data,
    
    match.out = match.output,
    nboots = 0
    
  )
  
  return (balance_object)
  
}






# EXAMPLE OF USAGE
# # Dehejia & Wabba (Includes RE74)
# #DW.mout = NSW.GenMatch(DW.nsw_treated_data_with_CPS1, population = 200, my.loss.f = my.loss.function)#, max.gen = 5, wait.gen = 5)
# #DW.balout = NSW.MeasureBalance(DW.nsw_treated_data_with_CPS1, DW.mout)

#summary(DW.mout)

# # Early RA Dataset (Includes RE74)
# #RA.mout = NSW.GenMatch(RA.nsw_treated_data_with_CPS1, population = 200, max.gen = 50, wait.gen = 30, my.loss.f = my.subtraction.loss.func.3.2)
# #RA.balout = NSW.MeasureBalance(RA.nsw_treated_data_with_CPS1, RA.mout)
# 

# summary(RA.mout)


