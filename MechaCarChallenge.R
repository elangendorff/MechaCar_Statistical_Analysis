library(dplyr)

mcmpg <- read.csv("./MechaCar_mpg.csv", check.names = FALSE, stringsAsFactors = FALSE)

mpg_lm <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=mcmpg)

mpg_lm

summary(mpg_lm)

