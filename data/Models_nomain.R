# SETUP

## Load libraries. Install if packages do not exist!

library(lme4)
library(modelsummary)
library(brms)

## Functions

### A function to generate models

create_mod <- function(dv, ivs, ixs, cvs, prefix, data, start, gdpx=FALSE, gdp) {
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
      assign(paste0(prefix, count), mod, envir = .GlobalEnv)
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


# Decided against Bayesian estimation. Gains here are unclear.

# create_bayes <- function(list_mod){
#   for(i in c(4:8)){
#     start_val <-2
#     while(start_val <= 88){
#       val <- start_val
#       while(val <= start_val+6){
#         mod_name <- paste0("M_",as.character(i), ".", val)
#         if(mod_name %in% list_mod){
#           mod <- get(mod_name)
#           f <- mod@call[["formula"]]
#           print(sprintf("Running a Bayesian simulation for %s", mod_name))
#           bayes_mod <- brm(formula = f, data = df_na, warmup = 500, iter = 2000, cores = 48, chains = 2, seed = 123)
#           assign(paste0(mod_name, "_bayes"), bayes_mod, envir = .GlobalEnv)
#         }
#         val = val+2
#       }
#       start_val = start_val + 16
#     }
#     
#     
#   }
#   
# }

########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################

# BASE MODELS

## With Country-Year only
### bare models
dv <- "gov_redist_C"
ivs <- c("noconf_govZ", "cpiZ", "noconf_govZ_i", 
         "cpiZ_i", "corrupt_top_w", "gdp_pc_10k_C")
ixs <- c("incdiff_large_C", "incdiff_large_w")
cvs <- "(1|iso3c_wave)"
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 1, data = df_na)



### socx_C control

cvs <- c("(1|iso3c_wave)","socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = 1, data = df_na)



### gini
cvs <- c("(1|iso3c_wave)","gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = 1, data = df_na)



### gdp

cvs <- c("(1|iso3c_wave)","gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = 1, data = df_na)


### immigration
cvs <- c("(1|iso3c_wave)","pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = 1, data = df_na)



## With Country-Year and Country
startvalue <- length(ls(pattern="M_4."))+1

### bare models
cvs <- c("(1|iso3c_wave)","(1|iso3c)")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, data = df_na)




### socx_C control

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, data = df_na)


### gini
cvs <- c("(1|iso3c_wave)","(1|iso3c)","gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, data = df_na)


### gdp

cvs <- c("(1|iso3c_wave)","(1|iso3c)","gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = startvalue, data = df_na)


### immigration
cvs <- c("(1|iso3c_wave)","(1|iso3c)","pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, data = df_na)



## WITH GDP INTERACTIONS
startvalue <- length(ls(pattern="M_4."))+1
### Country-Year Only

cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C")

create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)



### socx_C control
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)


### gini
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)



### immigration
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)



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


### socx_C control
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, data = df_na)


### gini

cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, data = df_na)


### gdp

cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = startvalue, data = df_na)


### immigration
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, data = df_na)


## With Country-Year and Country
### bare models
startvalue <- length(ls(pattern="M_4."))+1

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, data = df_na)


### socx_C control

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, data = df_na)


### gini

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, data = df_na)


### gdp

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = startvalue, data = df_na)


### immigration

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, data = df_na)

## With GDP interactions
### Country-Year Only
startvalue <- length(ls(pattern="M_4."))+1

cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs")

create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)



### socx_C control
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)


### gini
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)



### immigration
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = startvalue, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           data = df_na)





# Create a Bayesian simulation for each heuristic for each configuration (4*28 = 112 models in total). Consider running on the cloud as this might take days

# list_mod <- ls(pattern="^M\\_[0-9]\\.[0-9]{1,3}$")
# create_bayes(list_mod)
# 
# 
# 
# length(list_mod) ## 448 models 08-Mar-22 
# length(ls(pattern="[0-9]_bayes$"))      ## 112 bayesian models (11-Mar-22)
# 
# save(list=ls(pattern="^M\\_[0-9]\\.[0-9]{1,3}$"), file = here::here("data", "all_mods.RData"))
# save(list = ls(pattern="[0-9]_bayes$"), file = here::here("data","bayesian_mods.RData"))
