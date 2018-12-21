# The Raiders of the Loss Function


## Overview

This repository contains the replication files used to come up with the results  from this little research paper.

It is recommended to first take a look at [results_summary 2018-12-17 .md](results_summary 2018-12-17 .md) to better understand the details behind Table 1-3 in the paper.

Here's a list with a brief description of each of the replication files.

1. [DataRetrieva.R](): 

This script produces:

3 experimental datasets:
* lalonde.nsw_data (lalonde experimental dataset)
* DW.nsw_data (Dehejia & Wahba experimental dataset) - simulated I think tho to be precise
* RA.nsw_data (Smith & Todd experimental early RA data)

3 'HYBRIDS' with treated units from each RCT and control units from the CPS survey
- lalonde.nsw_treated_data_with_CPS1 (Lalonde faked observational dataset)
- DW.nsw_treated_data_with_CPS1 (Dehejia & Wahba faked observational dataset)
- RA.nsw_treated_



2. [loss.function.R](): 

This script contains each of the definitions of each of the different
loss functions we tried out during our research. Including:

my.loss.function.9 (quadratically weighted sum of balance statistics)
my.subtraction.loss.func.3 (quadratically weighted sum of differences)


3. [NSW.GenMatch.NoRe74.R]():

This script defines

NSW.GenMatch.NoRE74() = function(nsw_obs_data, population = 100, max.gen = 100, wait.gen = 4, my.loss.f = 1), function that produces mout from GenMatch weights based on a NSW "faked" obs data set when re74 is not included.
(aka, for the original LALONDE SAMPLE)

and defines

NSW.MeasureBalance.NoRE74 = function(nsw_obs_data, match.output) which returns the output MatchBalance, based on the output of NSW.GenMatch.NoRE74(). Similarly, it works for a NSW "faked" obs data set when re74 is not included.

4. [NSW.GenMatch.R]():

This script defines NSW.GenMatch() = function(nsw_obs_data, population = 100, max.gen = 100, wait.gen = 4, my.loss.f = 1) function that produces mout from GenMatch weights based on a NSW "faked" obs data set when re74 is ACTUALLY included.
(aka, for the DW sample and early RA sample)

and defines

NSW.MeasureBalance = function(nsw_obs_data, match.output) which returns the output MatchBalance, based on the output of NSW.GenMatch() similarly, it works for a NSW "faked" obs data set when re74 is ACTUALLY included.

5. [SummarizeResults.R]():

This script produces an output file that summarizes the matching results
of different calls to either NSW.GenMatch.NoRe74() or NSW.GenMatch.R() and emphapasizing how the "loss" parameter varies.

****
the output file is an .md file for
easy examination on any mardown visualizer (e.g., GitHub). Check it out ([results_summary 2018-12-17 .md](results_summary 2018-12-17 .md))!
****

to run it, RUN FIRST!!!!!!

* DataRetrieval.R (Loads Data...)

* NSW.GenMatch.R (DW Sample and RA sample)

* NSW.GenMatch.NoRe74.R (Original Lalonde Sample)

* loss.function.R (contains the definitions for the loss functions...)
