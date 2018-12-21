# This script produces an output file that summarizes the matching results
# of different calls to either NSW.GenMatch.NoRe74() or NSW.GenMatch.R()

# and emphapasizing how the "loss" parameter varies.

#****
# the output file is an .md file for 
# easy examination on any mardown visualizer (e.g., GitHub)
#****


# to run it, RUN FIRST!!!!!!

# DataRetrieval.R (Loads Data...)

# NSW.GenMatch.R (DW Sample and RA sample)
# NSW.GenMatch.NoRe74.R (Original Lalonde Sample)

# loss.function.R (contains the definitions for the loss functions...)



# Helper function...
sink.reset <- function(){
  for(i in seq_len(sink.number())){
    sink(NULL)
  }
}




# (You may run these two lines after you call R studio to define 

# run.summary.1, try.loss.function.RA.SAMPLE, try.loss.function.RA.SAMPLE, try.loss.function.Original.LALONDE.SAMPLE

# to reproduce the summary file that was used for writing the paper)
# - i.g., results_summary 2018-12-17.md 
# (obviously the date will not be the same...)
# (it might take a while if you use the same parameters...)





# output file name.
#output.file = paste("results_summary_long_time", paste(Sys.Date(),".md"))

# run run.summary.1() to reproduce output!!!
#run.summary.1(filename = output.file, population_ = 250, max.gen_ = 75, wait.gen_ = 75)









run.summary.1 = function(filename, population_, max.gen_, wait.gen_) {
  
  
  
  
  #filename = paste(filename, paste(Sys.Date(),".md"))
  
  sink.reset()
  sink(filename) # open the connection to the summary file!!!
  
  
  ########################################################################################
  # DW SAMPLE (Includes RE74)
  sink(filename, append = TRUE)
  
  #cat("```\n ", Sys.time(), "\n", "```\n")
  print(Sys.time())
  print("See README.md for instructions about how to reproduce this output file.")
  cat("# Dehejia & Wabba (DW) SAMPLE - (Includes RE74)\n")
  
  
  
  # Experimental Benchmark
  cat("## Experimental Benchmark (Data: DW Sample)\n")
  cat("**Experimental Benchmark**: ")
  estimate = mean(DW.nsw_data$re78[DW.nsw_data$treat == 1]) - mean(DW.nsw_data$re78[DW.nsw_data$treat == 0])
  cat(estimate, "\n")
  
  
  ### Default Loss Function
  cat("## Method: GenMatch - Default Loss Function (Data: CPS-1)\n")
  
  cat("...\n\n")
  cat("(**Matching Estimate reported by Diamond & Sekhon (2013)**: 1734 )\n\n")
  
  sink.reset()
  
  DW.mout = NSW.GenMatch(DW.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = 1)
  DW.balout = NSW.MeasureBalance(DW.nsw_treated_data_with_CPS1, DW.mout)
  
  sink(filename, append = TRUE)
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(DW.mout))
  cat("```\n")
  
  
  cat("After Matching Min P Value", DW.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",  DW.balout$AMsmallestVarName, "\n")
  
  
  # Original loss function: my.loss.function
  # cat("## Method: GenMatch - **my.loss.function** (Data: CPS-1)\n")
  # 
  # sink.reset()
  # 
  # DW.mout = NSW.GenMatch(DW.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = my.loss.function)
  # DW.balout = NSW.MeasureBalance(DW.nsw_treated_data_with_CPS1, DW.mout)
  # 
  # sink(filename, append = TRUE)
  # 
  # cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  # cat("```\n")
  # cat(summary(DW.mout))
  # cat("```\n")
  # 
  # 
  # cat("After Matching Min P Value", DW.balout$AMsmallest.p.value, "\n\n")
  # cat("(Variable Name)",  DW.balout$AMsmallestVarName, "\n")
  # 
  
  
  
  # Try other loss functions...
  #try.loss.function.DW.SAMPLE = function(output.file.name = NULL, population_, max.gen_, wait.gen_, my.loss.f_, my.loss.f.name_ = "NO loss.F NAME GIVEN"){
  try.loss.function.DW.SAMPLE(my.loss.f_ = my.loss.function.9, my.loss.f.name_ = "*my.loss.function.9*",
                                output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_) 
  
  
  try.loss.function.DW.SAMPLE(my.loss.f_ = my.loss.function.9.02, my.loss.f.name_ = "*my.loss.function.9.02*",
                              output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_) 
  
  
  try.loss.function.DW.SAMPLE(my.loss.f_ = my.subtraction.loss.func.3, my.loss.f.name_ = "*my.subtraction.loss.func.3*",
                              output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_) 
  
  try.loss.function.DW.SAMPLE(my.loss.f_ = my.subtraction.loss.func.3.2, my.loss.f.name_ = "*my.subtraction.loss.func.3.2*",
                              output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_) 
  
  
  
  #DW.mout = NSW.GenMatch(DW.nsw_treated_data_with_CPS1, population = 200, my.loss.f = my.loss.function)#, max.gen = 5, wait.gen = 5)
  #DW.balout = NSW.MeasureBalance(DW.nsw_treated_data_with_CPS1, DW.mout)
  
  
  # Original loss function # another number
  
  
  
  
  
  
  ######################################################################################
  # RA SAMPLE (Includes RE74)
  sink(filename, append = TRUE)
  cat("# EARLY RANDOM ASSIGNMENT (RA) SAMPLE - (Includes RE74)\n")
  
  
  # Experimental Benchmark
  cat("## Experimental Benchmark (Data: Early RA Sample)\n")
  cat("**Experimental Benchmark**: ")
  estimate = mean(RA.nsw_data$re78[RA.nsw_data$treat == 1]) - mean(RA.nsw_data$re78[RA.nsw_data$treat == 0])
  cat(estimate, "\n")
  
  
  
  ### Default Loss Function
  cat("## Method: GenMatch - Default Loss Function (Data: CPS-1)\n")
  
  cat("...\n\n")
  cat("(**Matching Estimate reported by Diamond & Sekhon (2013)**: 1631 )\n\n")
  
  
  sink.reset()
  
  RA.mout = NSW.GenMatch(RA.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = 1)
  RA.balout = NSW.MeasureBalance(RA.nsw_treated_data_with_CPS1, RA.mout)
  
  sink(filename, append= TRUE)
  
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(RA.mout))
  cat("```\n")
  
  
  cat("After Matching Min P Value", RA.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",  RA.balout$AMsmallestVarName, "\n")
  
  #sink.reset()
  
  
  
  # Original loss function # a number
  cat("## Method: GenMatch - **my.subtraction.loss.func.3.2** (Data: CPS-1)\n")
  
  sink.reset()
  
  RA.mout = NSW.GenMatch(RA.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = my.subtraction.loss.func.3.2)
  RA.balout = NSW.MeasureBalance(RA.nsw_treated_data_with_CPS1, RA.mout)
  
  sink(filename, append= TRUE)
  
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(RA.mout))
  cat("```\n")
  
  
  cat("After Matching Min P Value", RA.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",  RA.balout$AMsmallestVarName, "\n")
  
  sink.reset()
  
  
  # Original loss function # another number
  
  
  # Try other loss functions...
  
  try.loss.function.RA.SAMPLE(my.loss.f_ = my.loss.function.9, my.loss.f.name_ = "*my.loss.function.9*",
                              output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)

  try.loss.function.RA.SAMPLE(my.loss.f_ = my.loss.function.9.02, my.loss.f.name_ = "*my.loss.function.9.02*",
                              output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)
  
  try.loss.function.RA.SAMPLE(my.loss.f_ = my.subtraction.loss.func.3, my.loss.f.name_ = "*my.subtraction.loss.func.3*",
                              output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)
  
  try.loss.function.RA.SAMPLE(my.loss.f_ = my.subtraction.loss.func.3.2, my.loss.f.name_ = "*my.subtraction.loss.func.3.2*",
                              output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)
  
  
  
  
  #####################################################################################
  # ORIGINAL LALONDE SAMPLE (Does not include RE74)
  sink(filename, append = TRUE)
  cat("# ORIGINAL LALONDE SAMPLE (Does not include RE74)\n")
  
  
  # Experimental Benchmark
  cat("## Experimental Benchmark (Data: Lalonde Sample)\n")
  cat("Experimental Benchmark: ")
  
  estimate = mean(lalonde.nsw_data$re78[lalonde.nsw_data$treat == 1]) - mean(lalonde.nsw_data$re78[lalonde.nsw_data$treat == 0])
  
  cat(paste(estimate,"\n"))
  
  
  
  ### Default Loss Function
  cat("## Method: GenMatch - Default Loss Function (Data: CPS-1)\n")
  
  cat("...\n\n")
  cat("(**Matching Estimate reported by Diamond & Sekhon (2013)**: 281 )\n\n")
  
  
  sink.reset()
  
  Lalonde.mout = NSW.GenMatch.NoRE74(lalonde.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = 1)
  Lalonde.balout = NSW.MeasureBalance.NoRE74(lalonde.nsw_treated_data_with_CPS1, Lalonde.mout)
  
  sink(filename, append= TRUE)
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(Lalonde.mout))
  cat("```\n")
  
  cat("After Matching Min P Value:", Lalonde.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",Lalonde.balout$AMsmallestVarName,"\n")
  
  sink.reset()
  
  
  
  
  
  
  
  ### Original loss function: my.loss.function.9.02
  sink(filename, append= TRUE)
  cat("## Method: GenMatch - **my.loss.function.9.02** (Data: CPS-1)\n")
  
  sink.reset()
  Lalonde.mout = NSW.GenMatch.NoRE74(lalonde.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = my.loss.function.9.02)
  Lalonde.balout = NSW.MeasureBalance.NoRE74(lalonde.nsw_treated_data_with_CPS1, Lalonde.mout)
  
  sink(filename, append= TRUE)
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(Lalonde.mout))
  cat("```\n")
  
  cat("After Matching Min P Value", Lalonde.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",  Lalonde.balout$AMsmallestVarName, "\n")
  
  sink.reset()
  
  
  
  # Original loss function # another number
  
  
  # Try other loss functions
  try.loss.function.Original.LALONDE.SAMPLE(my.loss.f_ = my.loss.function.9, my.loss.f.name_ = "*my.loss.function.9*",
                                            output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)
  
  try.loss.function.Original.LALONDE.SAMPLE(my.loss.f_ = my.loss.function.9.02, my.loss.f.name_ = "*my.loss.function.9.02*",
                                            output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)
  
  
  try.loss.function.Original.LALONDE.SAMPLE(my.loss.f_ = my.subtraction.loss.func.3, my.loss.f.name_ = "*my.subtraction.loss.func.3*",
                                            output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)
  

  try.loss.function.Original.LALONDE.SAMPLE(my.loss.f_ = my.subtraction.loss.func.3.2, my.loss.f.name_ = "*my.subtraction.loss.func.3.2*",
                                            output.file.name = filename, population_ = population_, max.gen_ = max.gen_, wait.gen_ = wait.gen_)
  
  
  
}



try.loss.function.DW.SAMPLE = function(output.file.name = NULL, population_, max.gen_, wait.gen_, my.loss.f_, my.loss.f.name_ = "NO loss.F NAME GIVEN"){
  
  # Original loss function: my.loss.function
  cat("## Method: GenMatch - ", my.loss.f.name_, " (Data: CPS-1)\n")
  
  sink.reset()
  
  DW.mout = NSW.GenMatch(DW.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = my.loss.f_)
  DW.balout = NSW.MeasureBalance(DW.nsw_treated_data_with_CPS1, DW.mout)
  
  sink(output.file.name, append = TRUE)
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(DW.mout))
  cat("```\n")
  
  
  cat("After Matching Min P Value", DW.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",  DW.balout$AMsmallestVarName, "\n")
  
  
}


try.loss.function.RA.SAMPLE = function(output.file.name = NULL, population_, max.gen_, wait.gen_, my.loss.f_, my.loss.f.name_ = "NO loss.F NAME GIVEN") {
  # Original loss function # a number
  sink(output.file.name, append= TRUE)
  
  cat("## Method: GenMatch - ", my.loss.f.name_ ," (Data: CPS-1)\n")
  
  sink.reset()
  
  RA.mout = NSW.GenMatch(RA.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = my.loss.f_)
  RA.balout = NSW.MeasureBalance(RA.nsw_treated_data_with_CPS1, RA.mout)
  
  sink(output.file.name, append= TRUE)
  
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(RA.mout))
  cat("```\n")
  
  
  cat("After Matching Min P Value", RA.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",  RA.balout$AMsmallestVarName, "\n")
  
  sink.reset()
  
}


try.loss.function.Original.LALONDE.SAMPLE = function (output.file.name = NULL, population_, max.gen_, wait.gen_, my.loss.f_, my.loss.f.name_ = "NO loss.F NAME GIVEN") {
  
  sink(output.file.name, append= TRUE)
  cat("## Method: GenMatch - ", my.loss.f.name_," (Data: CPS-1)\n")
  
  sink.reset()
  Lalonde.mout = NSW.GenMatch.NoRE74(lalonde.nsw_treated_data_with_CPS1, population = population_, max.gen = max.gen_, wait.gen = wait.gen_, my.loss.f = my.loss.f_)
  Lalonde.balout = NSW.MeasureBalance.NoRE74(lalonde.nsw_treated_data_with_CPS1, Lalonde.mout)
  
  sink(output.file.name, append= TRUE)
  
  cat("*Parameters:* ", "population =", population_, "max.gen =", max.gen_, "wait.gen =", wait.gen_, "\n")
  cat("```\n")
  cat(summary(Lalonde.mout))
  cat("```\n")
  
  cat("After Matching Min P Value", Lalonde.balout$AMsmallest.p.value, "\n\n")
  cat("(Variable Name)",  Lalonde.balout$AMsmallestVarName, "\n")
  
  sink.reset()
  
  
}













# output file name.
output.file = paste("results_summary_long_time", paste(Sys.Date(),".md"))

# run run.summary.1() to reproduce output!!!
run.summary.1(filename = output.file, population_ = 250, max.gen_ = 75, wait.gen_ = 75)




