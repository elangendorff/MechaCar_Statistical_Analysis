library(dplyr)

###
# Deliverable 1
###

mcmpg <- read.csv("./MechaCar_mpg.csv", check.names = FALSE, stringsAsFactors = FALSE)

mpg_lm <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mcmpg)

mpg_lm

summary(mpg_lm)

###
# Deliverable 2
###

mcsc <- read.csv("./Suspension_Coil.csv", check.names = FALSE, stringsAsFactors = FALSE)

total_summary <-
    summarize(
        mcsc,
        Mean=mean(PSI),
        Median=median(PSI),
        Variance=var(PSI),
        SD=sd(PSI)
    )

total_summary

lot_summary <-
    summarize(
        mcsc %>% group_by(Manufacturing_Lot),
        Mean=mean(PSI),
        Median=median(PSI),
        Variance=var(PSI),
        SD=sd(PSI)
    )

lot_summary

###
# Deliverable 3
###

# Use a t-test to determine if the PSI across all manufacturing lots is
# statistically different from the population mean of 1,500 pounds per square
# inch.
t.test(mcsc$PSI, mu=1500)

# Use a t-tests to determine if the PSI across *each* manufacturing lot is
# statistically different from the population mean of 1,500 pounds per square
# inch.
t.test(subset(mcsc, Manufacturing_Lot == "Lot1")$PSI, mu=1500)
t.test(subset(mcsc, Manufacturing_Lot == "Lot2")$PSI, mu=1500)
t.test(subset(mcsc, Manufacturing_Lot == "Lot3")$PSI, mu=1500)

