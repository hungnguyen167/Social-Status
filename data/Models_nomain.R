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
ivs <- c("noconf_govZ", "cpiZ", "libZ", "noconf_govZ_i", "cpiZ_i", "libZ_i")
ixs <- c("incdiff_large_C", "incdiff_large_w")
cvs <- "(1|iso3c_wave)"
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 1, data = df_na)

#### Bayesian - test phase

list_mod <- c(paste0("M_4.", 1:12))
df_gof <- create_df_gof(list_mod =  list_mod)
pref_mod <- row.names(df_gof[df_gof$aic == min(df_gof$aic),])

f <- M_4.1@call[["formula"]]
M_bayes.1 <- brm(formula = f, data = df_na, warmup = 1000, iter = 2000, cores = 2, seed = 123)




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

### bare models
cvs <- c("(1|iso3c_wave)","(1|iso3c)")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 13, data = df_na)


### socx_C control

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = 13, data = df_na)


### gini
cvs <- c("(1|iso3c_wave)","(1|iso3c)","gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = 13, data = df_na)


### gdp

cvs <- c("(1|iso3c_wave)","(1|iso3c)","gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = 13, data = df_na)


### immigration
cvs <- c("(1|iso3c_wave)","(1|iso3c)","pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = 13, data = df_na)



## WITH GDP INTERACTIONS

### Country-Year Only

dv <- "gov_redist_C"
ivs <- c("noconf_govZ", "cpiZ", "libZ", "noconf_govZ_i", "cpiZ_i", "libZ_i")
ixs <- c("incdiff_large_C", "incdiff_large_w")
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C")

create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 25, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)



### socx_C control
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = 25, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


### gini
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = 25, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)



### immigration
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = 25, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################


# BASE MODEL + AGE, SEX, AND EDUCATION

## With Country-Year only
### bare models

cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 37, data = df_na)

### socx_C control
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = 37, data = df_na)

### gini

cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = 37, data = df_na)

### gdp
 
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = 37, data = df_na)

### immigration
cvs <- c("(1|iso3c_wave)", "ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = 37, data = df_na)


## With Country-Year and Country
### bare models

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 49, data = df_na)

### socx_C control

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = 49, data = df_na)

### gini

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = 49, data = df_na)

### gdp

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "gdp_pc_10k_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_7.", start = 49, data = df_na)

### immigration

cvs <- c("(1|iso3c_wave)", "(1|iso3c)","ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = 49, data = df_na)

## With GDP interactions
### Country-Year Only


cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs")

create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_4.", start = 61, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)



### socx_C control
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "socx_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_5.", start = 61, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)


### gini
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "gini_disp_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_6.", start = 61, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)



### immigration
cvs <- c("(1|iso3c_wave)", "gdp_pc_10k_C", "ageC","female", "educyrs", "pct_fb_i_C")
create_mod(dv=dv, ivs=ivs, ixs=ixs, cvs = cvs, prefix = "M_8.", start = 61, gdpx=TRUE, gdp = "gdp_pc_10k_C", 
           suffix = "_gdp", data = df_na)





length(ls(pattern="M_")) ## 336 models in total








########################################################################################################################
########################################################################################################################
########################################################################################################################




### Linear regression

L_4.01l <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C, data = df_na)

L_4.02l <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C, data = df_na)

L_4.03l <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_C, data = df_na)

L_4.04il <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C, data = df_na)

L_4.05il <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C, data = df_na)

L_4.06il <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C, data = df_na)

L_4.07wbl <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w , data = df_na)

L_4.08wbl <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w , data = df_na)

L_4.09wbl <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_w , data = df_na)

L_4.10iwbl <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w , data = df_na)

L_4.11iwbl <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w , data = df_na)

L_4.12iwbl <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w , data = df_na)

### socx_C control

L_5.01l <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ socx_C , data = df_na)

L_5.02l <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ socx_C , data = df_na)

L_5.03l <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_C+ socx_C , data = df_na)

L_5.04il <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ socx_C , data = df_na)

L_5.05il <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ socx_C , data = df_na)

L_5.06il <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ socx_C , data = df_na)

L_5.07wbl <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + socx_C , data = df_na)

L_5.08wbl <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + socx_C , data = df_na)

L_5.09wbl <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_w + socx_C , data = df_na)

L_5.10iwbl <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx_C , data = df_na)

L_5.11iwbl <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + socx_C , data = df_na)

L_5.12iwbl <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + socx_C , data = df_na)

## gini

L_6.01l <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gini_disp_C , data = df_na)

L_6.02l <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gini_disp_C , data = df_na)

L_6.03l <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gini_disp_C , data = df_na)

L_6.04il <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gini_disp_C , data = df_na)

L_6.05il <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gini_disp_C , data = df_na)

L_6.06il <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gini_disp_C , data = df_na)

L_6.07wbl <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp_C , data = df_na)

L_6.08wbl <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gini_disp_C , data = df_na)

L_6.09wbl <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_w + gini_disp_C , data = df_na)

L_6.10iwbl <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp_C , data = df_na)

L_6.11iwbl <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp_C , data = df_na)

L_6.12iwbl <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gini_disp_C , data = df_na)

# gdp

L_7.01l <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gdp_pc_10k_C , data = df_na)

L_7.02l <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gdp_pc_10k_C , data = df_na)

L_7.03l <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gdp_pc_10k_C , data = df_na)

L_7.04il <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gdp_pc_10k_C , data = df_na)

L_7.05il <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gdp_pc_10k_C , data = df_na)

L_7.06il <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gdp_pc_10k_C , data = df_na)

L_7.07wbl <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k_C , data = df_na)

L_7.08wbl <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k_C , data = df_na)

L_7.09wbl <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_w + gdp_pc_10k_C , data = df_na)

L_7.10iwbl <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k_C , data = df_na)

L_7.11iwbl <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k_C , data = df_na)

L_7.12iwbl <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k_C , data = df_na)

# immigration

L_8.01l <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ pct_fb_i_C  , data = df_na)

L_8.02l <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ pct_fb_i_C  , data = df_na)

L_8.03l <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_C+ pct_fb_i_C  , data = df_na)

L_8.04il <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ pct_fb_i_C  , data = df_na)

L_8.05il <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ pct_fb_i_C  , data = df_na)

L_8.06il <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ pct_fb_i_C  , data = df_na)

L_8.07wbl <- lm(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + pct_fb_i_C  , data = df_na)

L_8.08wbl <- lm(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + pct_fb_i_C  , data = df_na)

L_8.09wbl <- lm(gov_redist_C ~ libZ + libZ*incdiff_large_w + pct_fb_i_C  , data = df_na)

L_8.10iwbl <- lm(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + pct_fb_i_C  , data = df_na)

L_8.11iwbl <- lm(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + pct_fb_i_C  , data = df_na)

L_8.12iwbl <- lm(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + pct_fb_i_C  , data = df_na)
