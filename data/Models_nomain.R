# SETUP

## Load libraries and dataset. Install if packages do not exist!

library(lme4)
library(modelsummary)
library(brms)

## Functions

### A function to generate models

create_mod <- function(dv, ivs, ixs, cvs, prefix, data, suffix=NULL, start, gdpx=FALSE, gdp) {
    count <- start
    for(iv in ivs){
      for (ix in ixs) {
        if(gdpx){
            f <<- as.formula(paste(dv, 
                                 paste(iv, ix, paste(iv, ix, gdp, sep = " : "), paste(cvs, collapse = " + "), sep = " + "),
                                 sep = "~"))
        }
        else{
            f <<- as.formula(paste(dv, 
                                 paste(iv, ix, paste(iv, ix,sep = " : "), paste(cvs, collapse = " + "), sep = " + "),
                                 sep = "~"))
        }
        print(f)
        mod <- lmer(f, data = data)
        assign(paste0(prefix, count, suffix), mod, envir = .GlobalEnv)
        count = count +1
      }
    } 
    count <- start
}

### A function to retrieve goodness-of-fit statistics from models and append to a dataframe

create_df_gof <- function(list_mod) {
    df_gof <- data.frame(aic=numeric(), bic=numeric(), r2.conditional=numeric(), r2.marginal=numeric(),
                       icc=numeric(), rmse=numeric(),sigma=numeric(),nobs=numeric())
    for (mod_name in list_mod){
      mod <- get(mod_name)
      gof <- get_gof(mod, metrics = "all")
      row.names(gof) <- mod_name
      df_gof <- rbind(df_gof, gof)
    }
    return(df_gof)
}



########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################

# BASE MODELS

## With Country-Year only
### bare models
dv <- "gov_redist_C"
ivs <- c("noconf_govZ", "cpiZ", "libZ", "lib_redistZ", "noconf_govZ_i", 
         "cpiZ_i", "libZ_i", "lib_redistZ_i")
ixs <- c("incdiff_large_C", "incdiff_large_w")
cvs <- "(1|iso3c_wave)"
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 1, data = df_na)

#### Bayesian 
endval <- length(ls(pattern = "M_4."))
  
  
list_mod <- c(paste0("M_4.", 1:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.1 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)




### socx_C control

cvs <- c("(1|iso3c_wave)","socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = 1, data = df_na)

#### Bayesian

list_mod <- c(paste0("M_5.", 1:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.2 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)


### gini
cvs <- c("(1|iso3c_wave)","gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = 1, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_6.", 1:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.3 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)


### gdp

cvs <- c("(1|iso3c_wave)","gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = 1, data = df_na)

#### Bayesian

list_mod <- c(paste0("M_7.", 1:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.4 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)

### immigration
cvs <- c("(1|iso3c_wave)","pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = 1, data = df_na)

#### Bayesian

list_mod <- c(paste0("M_8.", 1:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.5 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)



## With Country-Year and Country
startvalue <- length(ls(pattern="M_4."))+1

### bare models
cvs <- c("(1|iso3c_wave)","(1|iso3c)")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, data = df_na)

#### Bayesian 
endval <- length(ls(pattern = "M_4."))


list_mod <- c(paste0("M_4.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.6 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)

### socx_C control

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_5.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.7 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)

### gini
cvs <- c("(1|iso3c_wave)","(1|iso3c)","gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_6.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.8 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### gdp

cvs <- c("(1|iso3c_wave)","(1|iso3c)","gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_7.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.9 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### immigration
cvs <- c("(1|iso3c_wave)","(1|iso3c)","pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_8.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.10 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)


## WITH GDP INTERACTIONS
startvalue <- length(ls(pattern="M_4."))+1
### Country-Year Only

dv <- "gov_redist_C"
ivs <- c("noconf_govZ", "cpiZ", "libZ", "lib_redistZ", "noconf_govZ_i", "cpiZ_i", "libZ_i", "lib_redistZ_i")
ixs <- c("incdiff_large_C", "incdiff_large_w")
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C")

create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


#### Bayesian 
endval <- length(ls(pattern = "M_4."))


list_mod <- c(paste0("M_4.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.11 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)


### socx_C control
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_5.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.12 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### gini
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


#### Bayesian 

list_mod <- c(paste0("M_6.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.13 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### immigration
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_8.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.14 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)


########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################


# BASE MODEL + AGE, SEX, AND EDUCATION
startvalue <- length(ls(pattern="M_4."))+1
## With Country-Year only
### bare models

cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, data = df_na)

#### Bayesian 
endval <- length(ls(pattern = "M_4."))


list_mod <- c(paste0("M_4.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.15 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### socx_C control
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_5.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.16 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### gini

cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_6.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.17 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### gdp
 
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_7.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.18 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### immigration
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, data = df_na)


#### Bayesian 

list_mod <- c(paste0("M_8.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.19 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)

## With Country-Year and Country
### bare models
startvalue <- length(ls(pattern="M_4."))+1

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, data = df_na)

#### Bayesian 
endval <- length(ls(pattern = "M_4."))


list_mod <- c(paste0("M_4.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.20 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### socx_C control

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_5.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.21 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### gini

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_6.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.22 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### gdp

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_7.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.23 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### immigration

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_8.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.24 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)

## With GDP interactions
### Country-Year Only
startvalue <- length(ls(pattern="M_4."))+1

cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs")

create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


#### Bayesian 
endval <- length(ls(pattern = "M_4."))


list_mod <- c(paste0("M_4.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.25 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### socx_C control
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)

#### Bayesian 

list_mod <- c(paste0("M_5.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.26 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### gini
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


#### Bayesian 

list_mod <- c(paste0("M_6.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.27 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)
### immigration
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


#### Bayesian 

list_mod <- c(paste0("M_8.", startvalue:endval))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- get(pref_mod)@call[["formula"]]


M_bayes.28 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)



length(ls(pattern="M_")) ## 448 models 01-Feb-22 + 28 bayesian models (07-Feb-22)


