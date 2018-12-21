[1] "2018-12-17 15:16:18 KST"
[1] "See README.md for instructions about how to reproduce this output file."
# Dehejia & Wabba (DW) SAMPLE - (Includes RE74)
## Experimental Benchmark (Data: DW Sample)
**Experimental Benchmark**: 1794.342 
## Method: GenMatch - Default Loss Function (Data: CPS-1)
...

(**Matching Estimate reported by Diamond & Sekhon (2013)**: 1734 )

*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1470.9 
AI SE......  1055.3 
T-stat.....  1.3938 
p.val......  0.16339 

Original number of observations..............  16177 
Original number of treated obs...............  185 
Matched number of observations...............  185 
Matched number of observations  (unweighted).  224 

```
After Matching Min P Value 0.2889342 

(Variable Name) I(nsw_obs_data$black * nsw_obs_data$re74) 
## Method: GenMatch -  *my.loss.function.9*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1957 
AI SE......  985 
T-stat.....  1.9868 
p.val......  0.046947 

Original number of observations..............  16177 
Original number of treated obs...............  185 
Matched number of observations...............  185 
Matched number of observations  (unweighted).  221 

```
After Matching Min P Value 0.1483235 

(Variable Name) I(nsw_obs_data$age * nsw_obs_data$hispanic) 
## Method: GenMatch -  *my.loss.function.9.02*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1862 
AI SE......  1018.8 
T-stat.....  1.8276 
p.val......  0.067613 

Original number of observations..............  16177 
Original number of treated obs...............  185 
Matched number of observations...............  185 
Matched number of observations  (unweighted).  224 

```
After Matching Min P Value 0.1228986 

(Variable Name) I(nsw_obs_data$age^2) 
## Method: GenMatch -  *my.subtraction.loss.func.3*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1857 
AI SE......  978.85 
T-stat.....  1.8972 
p.val......  0.057805 

Original number of observations..............  16177 
Original number of treated obs...............  185 
Matched number of observations...............  185 
Matched number of observations  (unweighted).  221 

```
After Matching Min P Value 0.2160444 

(Variable Name) I(nsw_obs_data$age * nsw_obs_data$hispanic) 
## Method: GenMatch -  *my.subtraction.loss.func.3.2*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1638 
AI SE......  1008 
T-stat.....  1.625 
p.val......  0.10416 

Original number of observations..............  16177 
Original number of treated obs...............  185 
Matched number of observations...............  185 
Matched number of observations  (unweighted).  224 

```
After Matching Min P Value 0.101319 

(Variable Name) I(nsw_obs_data$age^2) 
# EARLY RANDOM ASSIGNMENT (RA) SAMPLE - (Includes RE74)
## Experimental Benchmark (Data: Early RA Sample)
**Experimental Benchmark**: 2748.483 
## Method: GenMatch - Default Loss Function (Data: CPS-1)
...

(**Matching Estimate reported by Diamond & Sekhon (2013)**: 1631 )

*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1330.8 
AI SE......  1314.7 
T-stat.....  1.0122 
p.val......  0.31144 

Original number of observations..............  16100 
Original number of treated obs...............  108 
Matched number of observations...............  108 
Matched number of observations  (unweighted).  113 

```
After Matching Min P Value 0.3173262 

(Variable Name) I(nsw_obs_data$education * nsw_obs_data$married) 
## Method: GenMatch - **my.subtraction.loss.func.3.2** (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1666.8 
AI SE......  1317.6 
T-stat.....  1.265 
p.val......  0.20587 

Original number of observations..............  16100 
Original number of treated obs...............  108 
Matched number of observations...............  108 
Matched number of observations  (unweighted).  115 

```
After Matching Min P Value 0.01299406 

(Variable Name) I(nsw_obs_data$hispanic * nsw_obs_data$re75) 
## Method: GenMatch -  *my.loss.function.9*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1237.6 
AI SE......  1313.8 
T-stat.....  0.94202 
p.val......  0.34618 

Original number of observations..............  16100 
Original number of treated obs...............  108 
Matched number of observations...............  108 
Matched number of observations  (unweighted).  113 

```
After Matching Min P Value 0.008954728 

(Variable Name) I(nsw_obs_data$hispanic * nsw_obs_data$re75) 
## Method: GenMatch -  *my.loss.function.9.02*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1594 
AI SE......  1311.1 
T-stat.....  1.2157 
p.val......  0.22409 

Original number of observations..............  16100 
Original number of treated obs...............  108 
Matched number of observations...............  108 
Matched number of observations  (unweighted).  114 

```
After Matching Min P Value 0.01299406 

(Variable Name) I(nsw_obs_data$hispanic * nsw_obs_data$re75) 
## Method: GenMatch -  *my.subtraction.loss.func.3*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1710.6 
AI SE......  1280.1 
T-stat.....  1.3363 
p.val......  0.18144 

Original number of observations..............  16100 
Original number of treated obs...............  108 
Matched number of observations...............  108 
Matched number of observations  (unweighted).  113 

```
After Matching Min P Value 0.3034336 

(Variable Name) I(nsw_obs_data$age * nsw_obs_data$hispanic) 
## Method: GenMatch -  *my.subtraction.loss.func.3.2*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  1666.8 
AI SE......  1317.6 
T-stat.....  1.265 
p.val......  0.20587 

Original number of observations..............  16100 
Original number of treated obs...............  108 
Matched number of observations...............  108 
Matched number of observations  (unweighted).  115 

```
After Matching Min P Value 0.01299406 

(Variable Name) I(nsw_obs_data$hispanic * nsw_obs_data$re75) 
# ORIGINAL LALONDE SAMPLE (Does not include RE74)
## Experimental Benchmark (Data: Lalonde Sample)
Experimental Benchmark: 886.303730703743 
## Method: GenMatch - Default Loss Function (Data: CPS-1)
...

(**Matching Estimate reported by Diamond & Sekhon (2013)**: 281 )

*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  87.407 
AI SE......  691.93 
T-stat.....  0.12632 
p.val......  0.89948 

Original number of observations..............  16289 
Original number of treated obs...............  297 
Matched number of observations...............  297 
Matched number of observations  (unweighted).  389 

```
After Matching Min P Value: 0.229849 

(Variable Name) nsw_obs_data$age I(nsw_obs_data$age^2) 
## Method: GenMatch - **my.loss.function.9.02** (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  133.54 
AI SE......  699.84 
T-stat.....  0.19082 
p.val......  0.84867 

Original number of observations..............  16289 
Original number of treated obs...............  297 
Matched number of observations...............  297 
Matched number of observations  (unweighted).  373 

```
After Matching Min P Value 0.0311604 

(Variable Name) I(nsw_obs_data$hispanic * nsw_obs_data$re75) 
## Method: GenMatch -  *my.loss.function.9*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  182.77 
AI SE......  699.97 
T-stat.....  0.26111 
p.val......  0.79401 

Original number of observations..............  16289 
Original number of treated obs...............  297 
Matched number of observations...............  297 
Matched number of observations  (unweighted).  373 

```
After Matching Min P Value 0.12245 

(Variable Name) I(nsw_obs_data$hispanic * nsw_obs_data$re75) 
## Method: GenMatch -  *my.loss.function.9.02*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  29.02 
AI SE......  694.84 
T-stat.....  0.041765 
p.val......  0.96669 

Original number of observations..............  16289 
Original number of treated obs...............  297 
Matched number of observations...............  297 
Matched number of observations  (unweighted).  372 

```
After Matching Min P Value 0.1166452 

(Variable Name) I(nsw_obs_data$education * nsw_obs_data$nodegree) 
## Method: GenMatch -  *my.subtraction.loss.func.3*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  260.66 
AI SE......  699.82 
T-stat.....  0.37247 
p.val......  0.70954 

Original number of observations..............  16289 
Original number of treated obs...............  297 
Matched number of observations...............  297 
Matched number of observations  (unweighted).  375 

```
After Matching Min P Value 0.3039973 

(Variable Name) I(nsw_obs_data$re75^2) 
## Method: GenMatch -  *my.subtraction.loss.func.3.2*  (Data: CPS-1)
*Parameters:*  population = 250 max.gen = 75 wait.gen = 75 
```

Estimate...  5.3387 
AI SE......  673.1 
T-stat.....  0.0079315 
p.val......  0.99367 

Original number of observations..............  16289 
Original number of treated obs...............  297 
Matched number of observations...............  297 
Matched number of observations  (unweighted).  373 

```
After Matching Min P Value 0.03841147 

(Variable Name) I(nsw_obs_data$education * nsw_obs_data$hispanic) 
