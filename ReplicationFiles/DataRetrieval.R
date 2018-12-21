# This script produces:

# 3 experimental datasets:
# - lalonde.nsw_data (lalonde experimental dataset)
# - DW.nsw_data (Dehejia & Wahba experimental dataset) - simulated I think tho to be precise
# - RA.nsw_data (Smith & Todd experimental early RA data)


# 3 'HYBRIDS' with treated units from each RCT and control units from the CPS survey
# - lalonde.nsw_treated_data_with_CPS1 (Lalonde faked observational dataset)
# - DW.nsw_treated_data_with_CPS1 (Dehejia & Wahba faked observational dataset)
# - RA.nsw_treated_data_with_CPS1 (Smith $ Todd faked observational data set)


library(foreign)

# ******************* PREPARE DATA ***************

### EXPERIMENTAL RCT data sets...

# From http://users.nber.org/~rdehejia/data/nswdata2.html



# FOR THE ORIGINAL LALONDE DATA

lalonde.nsw_controls = read.table("http://www.nber.org/~rdehejia/data/nsw_control.txt")
lalonde.nsw_treated = read.table("http://www.nber.org/~rdehejia/data/nsw_treated.txt")
# Bind treated and controls into one data frame
lalonde.nsw_data = rbind(lalonde.nsw_controls, lalonde.nsw_treated)
# Label it for conveniency
additional_column_to_label_data_set = rep(c("Original Lalonde Sample"), length(lalonde.nsw_data[,1]))
lalonde.nsw_data = cbind(additional_column_to_label_data_set, lalonde.nsw_data)
# Put names to this shit that comes with no names...
names(lalonde.nsw_data) = c("data_id", "treat", "age", "education", "black", "hispanic",
                            "married", "nodegree", "re75", "re78") # remember that unfortunately this sample didn't have re74
# take alook
head(lalonde.nsw_data)
# I think that I could have read this from stata format...



## FOR DEHEJIA'S & WAHBA VERSION OF THE LALONDE DATA
DW.nsw_data = read.dta("http://www.nber.org/~rdehejia/data/nsw_dw.dta")

# take a look
head(DW.nsw_data)



### "FAKE" OBSERVATIONAL DATA SETS - they are not entirely fake tho
# with CPS-1 survey data

# FIRST with the original Lalonde RCT sample
cps1_controls = read.dta("http://www.nber.org/~rdehejia/data/cps_controls.dta")

# cps1 has re74, but lalonde nsw lacks it.
# gotta make them consistent.

# get rid of column
cps1_controls_without_re74 = cps1_controls[,-9]
# make names consistent
names(cps1_controls_without_re74) = names(lalonde.nsw_data)


# Erase the RCT experiment's control group from lalonde experimental data
lalonde.nsw_data_nocontrols = lalonde.nsw_data[-which(lalonde.nsw_data$treat == 0),]

# rbind the nsw_data_nocontrols and the cps1_controols together
lalonde.nsw_treated_data_with_CPS1 = rbind(lalonde.nsw_data_nocontrols, cps1_controls_without_re74)


# SECOND with the Dehejia's experimental sample, (WHICH INCLUDES RE74)

cps1_controls_new_names = cps1_controls
# essentially we're updating the names...
names(cps1_controls_new_names) = names(DW.nsw_data)
# although it was essentially the same shit already I think...
# had worked it out before


# anyways
# erase the RCT experiment's control group data from DW
DW.nws_data_nocontrols = DW.nsw_data[-which(DW.nsw_data$treat ==0),]

# rbind the DW.nws_data_nocontrols and the cps1_controls together
DW.nsw_treated_data_with_CPS1 = rbind(DW.nws_data_nocontrols, cps1_controls_new_names)
# (I really think new names was the same shit as no new names)




# NOW LET'S DO IT FOR THE EARLY RA DATA SET FORM SMITH AND TODD 2005
ST.nsw_data.plus.fakecontrols = read.dta("data/nswbySTwithearlyRAindicator.dta") # this original file a.so includes CPS!!!
# get rid of the CPS in here
ST.nsw_data = ST.nsw_data.plus.fakecontrols[which(!is.na(ST.nsw_data.plus.fakecontrols$treated)),]
# extract early RA from ST.nsw_data
RA.nsw_data = ST.nsw_data[ST.nsw_data$early_ra == 1,]

# add data_id column
additional_column_to_label_data_set = rep(c("Early RA sample"), length(RA.nsw_data[,1]))
RA.nsw_data = cbind(additional_column_to_label_data_set, RA.nsw_data)

# get rid of dwincl, earlyRA indicator, and sample column because it is no longer (or never were) necessary
RA.nsw_data = RA.nsw_data[,-c(8,13,14)]
# Reorganize columns...
# order id, treat, age, educ, black, hisp, married, nodegr, re75, re78
# current order: id, treat, age, educ, black, married, nodegree, re75, re78, hisp
save_some_columns =  RA.nsw_data[,c(6:10)]
# erase them for a second
RA.nsw_data = RA.nsw_data[,-c(6:10)]
# cbind them at the end (so that hisp gets in the middle)
RA.nsw_data = cbind(RA.nsw_data, save_some_columns)
# adjust the name to consistent variable names
names(RA.nsw_data) = names(cps1_controls)#names(DW.nsw_data)

# verifying it is consistent...
length(RA.nsw_data$treat[RA.nsw_data$treat == 1]) # should be 108
length(RA.nsw_data$treat[RA.nsw_data$treat == 0]) # should be 142
mean(RA.nsw_data$re78[RA.nsw_data$treat == 1]) - mean(RA.nsw_data$re78[RA.nsw_data$treat == 0]) # should be 2748


# erase the RCT experiment's control group data from RA
RA.nws_data_nocontrols = RA.nsw_data[-which(RA.nsw_data$treat ==0),]
length(RA.nws_data_nocontrols$treat)
head(RA.nws_data_nocontrols)
head(cps1_controls_new_names)

# rbind the RA.nws_data_nocontrols and the cps1_controls together
RA.nsw_treated_data_with_CPS1 = rbind(RA.nws_data_nocontrols, cps1_controls)

names(RA.nws_data_nocontrols)
names(cps1_controls)

head(RA.nsw_treated_data_with_CPS1)
#View(RA.nsw_treated_data_with_CPS1)


######### CONCLUSION

# This script produced:

# 3 experimental datasets:
# - lalonde.nsw_data (lalonde experimental dataset)
# - DW.nsw_data (Dehejia & Wahha experimental dataset) - simulated I think tho to be precise
# - RA.nsw_data (Smithg & Todd experimental early RA data)


# 3 'HYBRIDS' with treated units from each RCT and control units from the CPS survey
# - lalonde.nsw_treated_data_with_CPS1 (Lalonde faked observational dataset)
# - DW.nsw_treated_data_with_CPS1 (Dehejia & Wahha faked observational dataset)
# - RA.nsw_treated_data_with_CPS1 (Smith $ Todd faked observational data set)


# VIEW STUFF


# Original RCT datasets
View(lalonde.nsw_data)
View(DW.nsw_data) # simulated...
View(RA.nsw_data) # same as lalonde but includes re74

# Fake Observational Data Sets
View(lalonde.nsw_treated_data_with_CPS1)
View(DW.nsw_treated_data_with_CPS1)
View(RA.nsw_treated_data_with_CPS1)

