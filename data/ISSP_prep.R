# Put Together ISSP Files

pacman::p_load("tidyverse",
               "haven")

# Source data need to be specified here

wd <- "C:/data/"
  
## Read data

# Inequality Module
socin <- read_dta(paste(wd, "ZA5890_v1-0-0.dta",sep=""))
socin2 <- read_dta(paste(wd, "ZA5891_v1-1-0.dta", sep = ""))

# Inequality 2019 not in the cumulative file
socin3 <- read_dta(paste0(wd, "ZA7600_v1-0-0.dta"))

# Environment Modulel
# (if we are only going to use the incd variable, we should merge this)
env93 <- read_dta(paste(wd, "ZA2450.dta",sep=""))
env00 <- read_dta(paste(wd, "ZA3440.dta",sep=""))
env10 <- read_dta(paste(wd, "ZA5500_v3-0-0.dta",sep=""))


# Integrate missing countries

ie87 <- read_dta(paste(wd, "ZA1306_v1-0-0.dta", sep=""))
nl87 <- read_dta(paste(wd, "ZA1680.dta", sep=""))  
nl87 <- subset(nl87, nl87$v3 == 7)
dk99 <- read_dta(paste(wd, "ZA3562_v1-0-0.dta", sep=""))
ie99 <- read_dta(paste(wd, "ZA3613_v1-0-0.dta", sep=""))
nl09 <- read_dta(paste(wd, "ZA5995_v1-0-0.dta", sep=""))
ca09 <- read_dta(paste(wd, "ZA5389_v1-0-0.dta", sep=""))

rm(wd)

save.image(here::here("data","issp.Rdata"))

