# Create population standardization datasets to apply regression results
# Use a single wave of ISSP to demonstrate
df_rep_usa <- df_rep %>%
  subset(iso3c == "USA" & wave == 2009)

df_rep_fin <- df_rep %>%
  subset(iso3c == "FIN" & wave == 2009)


# create marginal effects by simulating the different income deciles in the entire sample, and then introduce an income stagnation version (absgr5_wa - 5 absolute income growth)

df_rep_usa_hinc_1 <- df_rep_usa %>%
  mutate(hinc_decile = 1,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 1], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 1], na.rm = T))

df_rep_usa_hinc_1lo <- df_rep_usa %>%
  mutate(hinc_decile = 1,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 1], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 1], na.rm = T))

df_rep_usa_hinc_2 <- df_rep_usa %>%
  mutate(hinc_decile = 2,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 2], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 2], na.rm = T))

df_rep_usa_hinc_2lo <- df_rep_usa %>%
  mutate(hinc_decile = 2,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 2], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 2], na.rm = T))

df_rep_usa_hinc_3 <- df_rep_usa %>%
  mutate(hinc_decile = 3,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 3], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 3], na.rm = T))

df_rep_usa_hinc_3lo <- df_rep_usa %>%
  mutate(hinc_decile = 3,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 3], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 3], na.rm = T))


df_rep_usa_hinc_4 <- df_rep_usa %>%
  mutate(hinc_decile = 4,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 4], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 4], na.rm = T))

df_rep_usa_hinc_4lo <- df_rep_usa %>%
  mutate(hinc_decile = 4,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 4], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 4], na.rm = T))


df_rep_usa_hinc_5 <- df_rep_usa %>%
    mutate(hinc_decile = 5,
           absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 5], na.rm = T))

df_rep_usa_hinc_5lo <- df_rep_usa %>%
  mutate(hinc_decile = 5,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 5], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 5], na.rm = T))

df_rep_usa_hinc_6 <- df_rep_usa %>%
  mutate(hinc_decile = 6,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 6], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 6], na.rm = T))

df_rep_usa_hinc_6lo <- df_rep_usa %>%
    mutate(hinc_decile = 6,
           absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 6], na.rm = T)-5,
           relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 6], na.rm = T))

df_rep_usa_hinc_7 <- df_rep_usa %>%
  mutate(hinc_decile = 7,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 7], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 7], na.rm = T))


df_rep_usa_hinc_7lo <- df_rep_usa %>%
  mutate(hinc_decile = 7,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 7], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 7], na.rm = T))

df_rep_usa_hinc_8 <- df_rep_usa %>%
  mutate(hinc_decile = 8,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 8], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 8], na.rm = T))

df_rep_usa_hinc_8lo <- df_rep_usa %>%
    mutate(hinc_decile = 8,
           absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 8], na.rm = T)-5,
           relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 8], na.rm = T))

df_rep_usa_hinc_9 <- df_rep_usa %>%
  mutate(hinc_decile = 9,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 9], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 9], na.rm = T))

df_rep_usa_hinc_9lo <- df_rep_usa %>%
  mutate(hinc_decile = 9,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 9], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 9], na.rm = T))

df_rep_usa_hinc_10 <- df_rep_usa %>%
  mutate(hinc_decile = 10,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 10], na.rm = T),
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 10], na.rm = T))

df_rep_usa_hinc_10lo <- df_rep_usa %>%
  mutate(hinc_decile = 10,
         absgr5_wa = mean(df_rep_usa$absgr5_wa[df_rep_usa$hinc_decile == 10], na.rm = T)-5,
         relgr5_wa = mean(df_rep_usa$relgr5_wa[df_rep_usa$hinc_decile == 10], na.rm = T))

# FIN
df_rep_fin_hinc_1 <- df_rep_fin %>%
  mutate(hinc_decile = 1,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 1], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 1], na.rm = T))


df_rep_fin_hinc_1lo <- df_rep_fin %>%
  mutate(hinc_decile = 1,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 1], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 1], na.rm = T))

df_rep_fin_hinc_2 <- df_rep_fin %>%
  mutate(hinc_decile = 2,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 2], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 2], na.rm = T))

df_rep_fin_hinc_2lo <- df_rep_fin %>%
  mutate(hinc_decile = 2,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 2], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 2], na.rm = T))

df_rep_fin_hinc_3 <- df_rep_fin %>%
  mutate(hinc_decile = 3,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 3], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 3], na.rm = T))

df_rep_fin_hinc_3lo <- df_rep_fin %>%
  mutate(hinc_decile = 3,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 3], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 3], na.rm = T))

df_rep_fin_hinc_4 <- df_rep_fin %>%
  mutate(hinc_decile = 4,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 4], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 4], na.rm = T))

df_rep_fin_hinc_4lo <- df_rep_fin %>%
  mutate(hinc_decile = 4,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 4], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 4], na.rm = T))

df_rep_fin_hinc_5 <- df_rep_fin %>%
  mutate(hinc_decile = 5,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 5], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 5], na.rm = T))

df_rep_fin_hinc_5lo <- df_rep_fin %>%
  mutate(hinc_decile = 5,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 5], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 5], na.rm = T))

df_rep_fin_hinc_6 <- df_rep_fin %>%
  mutate(hinc_decile = 6,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 6], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 6], na.rm = T))

df_rep_fin_hinc_6lo <- df_rep_fin %>%
  mutate(hinc_decile = 6,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 6], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 6], na.rm = T))

df_rep_fin_hinc_7 <- df_rep_fin %>%
  mutate(hinc_decile = 7,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 7], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 7], na.rm = T))

df_rep_fin_hinc_7lo <- df_rep_fin %>%
  mutate(hinc_decile = 7,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 7], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 7], na.rm = T))

df_rep_fin_hinc_8 <- df_rep_fin %>%
  mutate(hinc_decile = 8,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 8], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 8], na.rm = T))

df_rep_fin_hinc_8lo <- df_rep_fin %>%
  mutate(hinc_decile = 8,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 8], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 8], na.rm = T))

df_rep_fin_hinc_9 <- df_rep_fin %>%
  mutate(hinc_decile = 9,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 9], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 9], na.rm = T))

df_rep_fin_hinc_9lo <- df_rep_fin %>%
  mutate(hinc_decile = 9,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 9], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 9], na.rm = T))

df_rep_fin_hinc_10 <- df_rep_fin %>%
  mutate(hinc_decile = 10,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 10], na.rm = T),
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 10], na.rm = T))

df_rep_fin_hinc_10lo <- df_rep_fin %>%
  mutate(hinc_decile = 10,
         absgr5_wa = mean(df_rep_fin$absgr5_wa[df_rep_fin$hinc_decile == 10], na.rm = T)-5,
         relgr5_wa = mean(df_rep_fin$relgr5_wa[df_rep_fin$hinc_decile == 10], na.rm = T))

# add predicted average marginal effects for redist_dum and redist_dum_libZ_i

## Set up DF
# adjust data
df_rep_marg <- as.data.frame(matrix(nrow = 10, ncol = 14))

df_rep_margf <- as.data.frame(matrix(nrow = 10, ncol = 14))

colnames(df_rep_marg) <- c("hinc_decile", "redist_o_obs_obs_m",      "redist_o_obs_obs_sd",    
                           "redist_o_obs_lib_m",      "redist_o_obs_lib_sd",     "redist_o_obs_liblow_m",  
                           "redist_o_obs_liblow_sd",  "redist_o_stag_obs_m",     "redist_o_stag_obs_sd",   
                           "redist_o_stag_lib_m",     "redist_o_stag_lib_sd",    "redist_o_stag_liblow_m", 
                           "redist_o_stag_liblow_sd", "country")

colnames(df_rep_margf) <- c("hinc_decile", "redist_o_obs_obs_m",      "redist_o_obs_obs_sd",    
                            "redist_o_obs_lib_m",      "redist_o_obs_lib_sd",     "redist_o_obs_liblow_m",  
                            "redist_o_obs_liblow_sd",  "redist_o_stag_obs_m",     "redist_o_stag_obs_sd",   
                            "redist_o_stag_lib_m",     "redist_o_stag_lib_sd",    "redist_o_stag_liblow_m", 
                            "redist_o_stag_liblow_sd", "country")


df_rep_margf$hinc_decile <- c(1,2,3,4,5,6,7,8,9,10)
df_rep_marg$hinc_decile <- c(1,2,3,4,5,6,7,8,9,10)

### USA Original
df_rep_usa$redist_dum_1 <- predict(m03, newdata = df_rep_usa_hinc_1)
df_rep_usa$redist_dum_2 <- predict(m03, newdata = df_rep_usa_hinc_2)
df_rep_usa$redist_dum_3 <- predict(m03, newdata = df_rep_usa_hinc_3)
df_rep_usa$redist_dum_4 <- predict(m03, newdata = df_rep_usa_hinc_4)
df_rep_usa$redist_dum_5 <- predict(m03, newdata = df_rep_usa_hinc_5)
df_rep_usa$redist_dum_6 <- predict(m03, newdata = df_rep_usa_hinc_6)
df_rep_usa$redist_dum_7 <- predict(m03, newdata = df_rep_usa_hinc_7)
df_rep_usa$redist_dum_8 <- predict(m03, newdata = df_rep_usa_hinc_8)
df_rep_usa$redist_dum_9 <- predict(m03, newdata = df_rep_usa_hinc_9)
df_rep_usa$redist_dum_10 <- predict(m03, newdata = df_rep_usa_hinc_10)

df_rep_marg$redist_o_obs_obs_m <- df_rep_usa %>%
  select(redist_dum_1:redist_dum_10) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_marg$redist_o_obs_obs_sd <- df_rep_usa %>%
  select(redist_dum_1:redist_dum_10) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### FIN Original
df_rep_fin$redist_dum_1 <- predict(m03, newdata = df_rep_fin_hinc_1)
df_rep_fin$redist_dum_2 <- predict(m03, newdata = df_rep_fin_hinc_2)
df_rep_fin$redist_dum_3 <- predict(m03, newdata = df_rep_fin_hinc_3)
df_rep_fin$redist_dum_4 <- predict(m03, newdata = df_rep_fin_hinc_4)
df_rep_fin$redist_dum_5 <- predict(m03, newdata = df_rep_fin_hinc_5)
df_rep_fin$redist_dum_6 <- predict(m03, newdata = df_rep_fin_hinc_6)
df_rep_fin$redist_dum_7 <- predict(m03, newdata = df_rep_fin_hinc_7)
df_rep_fin$redist_dum_8 <- predict(m03, newdata = df_rep_fin_hinc_8)
df_rep_fin$redist_dum_9 <- predict(m03, newdata = df_rep_fin_hinc_9)
df_rep_fin$redist_dum_10 <- predict(m03, newdata = df_rep_fin_hinc_10)

df_rep_margf$redist_o_obs_obs_m <- df_rep_fin %>%
  select(redist_dum_1:redist_dum_10) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_margf$redist_o_obs_obs_sd <- df_rep_fin %>%
  select(redist_dum_1:redist_dum_10) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### USA Simulated, Lib Observed

df_rep_usa$redist_dum_1_lib <- predict(m03lib, newdata = df_rep_usa_hinc_1)
df_rep_usa$redist_dum_2_lib <- predict(m03lib, newdata = df_rep_usa_hinc_2)
df_rep_usa$redist_dum_3_lib <- predict(m03lib, newdata = df_rep_usa_hinc_3)
df_rep_usa$redist_dum_4_lib <- predict(m03lib, newdata = df_rep_usa_hinc_4)
df_rep_usa$redist_dum_5_lib <- predict(m03lib, newdata = df_rep_usa_hinc_5)
df_rep_usa$redist_dum_6_lib <- predict(m03lib, newdata = df_rep_usa_hinc_6)
df_rep_usa$redist_dum_7_lib <- predict(m03lib, newdata = df_rep_usa_hinc_7)
df_rep_usa$redist_dum_8_lib <- predict(m03lib, newdata = df_rep_usa_hinc_8)
df_rep_usa$redist_dum_9_lib <- predict(m03lib, newdata = df_rep_usa_hinc_9)
df_rep_usa$redist_dum_10_lib <- predict(m03lib, newdata = df_rep_usa_hinc_10)

df_rep_marg$redist_o_obs_lib_m <- df_rep_usa %>%
  select(redist_dum_1_lib:redist_dum_10_lib) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_marg$redist_o_obs_lib_sd <- df_rep_usa %>%
  select(redist_dum_1_lib:redist_dum_10_lib) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### FIN Simulated, Lib Observed

df_rep_fin$redist_dum_1_lib <- predict(m03lib, newdata = df_rep_fin_hinc_1)
df_rep_fin$redist_dum_2_lib <- predict(m03lib, newdata = df_rep_fin_hinc_2)
df_rep_fin$redist_dum_3_lib <- predict(m03lib, newdata = df_rep_fin_hinc_3)
df_rep_fin$redist_dum_4_lib <- predict(m03lib, newdata = df_rep_fin_hinc_4)
df_rep_fin$redist_dum_5_lib <- predict(m03lib, newdata = df_rep_fin_hinc_5)
df_rep_fin$redist_dum_6_lib <- predict(m03lib, newdata = df_rep_fin_hinc_6)
df_rep_fin$redist_dum_7_lib <- predict(m03lib, newdata = df_rep_fin_hinc_7)
df_rep_fin$redist_dum_8_lib <- predict(m03lib, newdata = df_rep_fin_hinc_8)
df_rep_fin$redist_dum_9_lib <- predict(m03lib, newdata = df_rep_fin_hinc_9)
df_rep_fin$redist_dum_10_lib <- predict(m03lib, newdata = df_rep_fin_hinc_10)

df_rep_margf$redist_o_obs_lib_m <- df_rep_fin %>%
  select(redist_dum_1_lib:redist_dum_10_lib) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_margf$redist_o_obs_lib_sd <- df_rep_fin %>%
  select(redist_dum_1_lib:redist_dum_10_lib) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### USA Simulated, Lib Low

df_rep_usa$redist_dum_1_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_1)
df_rep_usa$redist_dum_2_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_2)
df_rep_usa$redist_dum_3_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_3)
df_rep_usa$redist_dum_4_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_4)
df_rep_usa$redist_dum_5_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_5)
df_rep_usa$redist_dum_6_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_6)
df_rep_usa$redist_dum_7_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_7)
df_rep_usa$redist_dum_8_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_8)
df_rep_usa$redist_dum_9_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_9)
df_rep_usa$redist_dum_10_lib_low <- predict(m03liblo, newdata = df_rep_usa_hinc_10)

df_rep_marg$redist_o_obs_liblow_m <- df_rep_usa %>%
  select(redist_dum_1_lib_low:redist_dum_10_lib_low) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_marg$redist_o_obs_liblow_sd <- df_rep_usa %>%
  select(redist_dum_1_lib_low:redist_dum_10_lib_low) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### FIN Simulated, Lib Low
  
  
df_rep_fin$redist_dum_1_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_1)
df_rep_fin$redist_dum_2_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_2)
df_rep_fin$redist_dum_3_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_3)
df_rep_fin$redist_dum_4_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_4)
df_rep_fin$redist_dum_5_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_5)
df_rep_fin$redist_dum_6_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_6)
df_rep_fin$redist_dum_7_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_7)
df_rep_fin$redist_dum_8_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_8)
df_rep_fin$redist_dum_9_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_9)
df_rep_fin$redist_dum_10_lib_low <- predict(m03liblo, newdata = df_rep_fin_hinc_10)

df_rep_margf$redist_o_obs_liblow_m <- df_rep_fin %>%
  select(redist_dum_1_lib_low:redist_dum_10_lib_low) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_margf$redist_o_obs_liblow_sd <- df_rep_fin %>%
  select(redist_dum_1_lib_low:redist_dum_10_lib_low) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

#################################################

### USA Stagnation
df_rep_usa$redist_dum_1lo <- predict(m03, newdata = df_rep_usa_hinc_1lo)
df_rep_usa$redist_dum_2lo <- predict(m03, newdata = df_rep_usa_hinc_2lo)
df_rep_usa$redist_dum_3lo <- predict(m03, newdata = df_rep_usa_hinc_3lo)
df_rep_usa$redist_dum_4lo <- predict(m03, newdata = df_rep_usa_hinc_4lo)
df_rep_usa$redist_dum_5lo <- predict(m03, newdata = df_rep_usa_hinc_5lo)
df_rep_usa$redist_dum_6lo <- predict(m03, newdata = df_rep_usa_hinc_6lo)
df_rep_usa$redist_dum_7lo <- predict(m03, newdata = df_rep_usa_hinc_7lo)
df_rep_usa$redist_dum_8lo <- predict(m03, newdata = df_rep_usa_hinc_8lo)
df_rep_usa$redist_dum_9lo <- predict(m03, newdata = df_rep_usa_hinc_9lo)
df_rep_usa$redist_dum_10lo <- predict(m03, newdata = df_rep_usa_hinc_10lo)

df_rep_marg$redist_o_stag_obs_m <- df_rep_usa %>%
  select(redist_dum_1lo:redist_dum_10lo) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_marg$redist_o_stag_obs_sd <- df_rep_usa %>%
  select(redist_dum_1lo:redist_dum_10lo) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### FIN Stagnation
df_rep_fin$redist_dum_1lo <- predict(m03, newdata = df_rep_fin_hinc_1lo)
df_rep_fin$redist_dum_2lo <- predict(m03, newdata = df_rep_fin_hinc_2lo)
df_rep_fin$redist_dum_3lo <- predict(m03, newdata = df_rep_fin_hinc_3lo)
df_rep_fin$redist_dum_4lo <- predict(m03, newdata = df_rep_fin_hinc_4lo)
df_rep_fin$redist_dum_5lo <- predict(m03, newdata = df_rep_fin_hinc_5lo)
df_rep_fin$redist_dum_6lo <- predict(m03, newdata = df_rep_fin_hinc_6lo)
df_rep_fin$redist_dum_7lo <- predict(m03, newdata = df_rep_fin_hinc_7lo)
df_rep_fin$redist_dum_8lo <- predict(m03, newdata = df_rep_fin_hinc_8lo)
df_rep_fin$redist_dum_9lo <- predict(m03, newdata = df_rep_fin_hinc_9lo)
df_rep_fin$redist_dum_10lo <- predict(m03, newdata = df_rep_fin_hinc_10lo)

df_rep_margf$redist_o_stag_obs_m <- df_rep_fin %>%
  select(redist_dum_1lo:redist_dum_10lo) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_margf$redist_o_stag_obs_sd <- df_rep_fin %>%
  select(redist_dum_1lo:redist_dum_10lo) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### USA Stagnation, Lib Original
df_rep_usa$redist_dum_1_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_1lo)
df_rep_usa$redist_dum_2_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_2lo)
df_rep_usa$redist_dum_3_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_3lo)
df_rep_usa$redist_dum_4_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_4lo)
df_rep_usa$redist_dum_5_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_5lo)
df_rep_usa$redist_dum_6_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_6lo)
df_rep_usa$redist_dum_7_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_7lo)
df_rep_usa$redist_dum_8_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_8lo)
df_rep_usa$redist_dum_9_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_9lo)
df_rep_usa$redist_dum_10_liblo <- predict(m03lib, newdata = df_rep_usa_hinc_10lo)

df_rep_marg$redist_o_stag_lib_m <- df_rep_usa %>%
  select(redist_dum_1_liblo:redist_dum_10_liblo) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_marg$redist_o_stag_lib_sd <- df_rep_usa %>%
  select(redist_dum_1_liblo:redist_dum_10_liblo) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### FIN Stagnation, Lib Original
df_rep_fin$redist_dum_1_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_1lo)
df_rep_fin$redist_dum_2_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_2lo)
df_rep_fin$redist_dum_3_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_3lo)
df_rep_fin$redist_dum_4_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_4lo)
df_rep_fin$redist_dum_5_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_5lo)
df_rep_fin$redist_dum_6_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_6lo)
df_rep_fin$redist_dum_7_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_7lo)
df_rep_fin$redist_dum_8_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_8lo)
df_rep_fin$redist_dum_9_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_9lo)
df_rep_fin$redist_dum_10_liblo <- predict(m03lib, newdata = df_rep_fin_hinc_10lo)

df_rep_margf$redist_o_stag_lib_m <- df_rep_fin %>%
  select(redist_dum_1_liblo:redist_dum_10_liblo) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_margf$redist_o_stag_lib_sd <- df_rep_fin %>%
  select(redist_dum_1_liblo:redist_dum_10_liblo) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### USA Stagnation, Lib Low
df_rep_usa$redist_dum_1_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_1lo)
df_rep_usa$redist_dum_2_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_2lo)
df_rep_usa$redist_dum_3_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_3lo)
df_rep_usa$redist_dum_4_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_4lo)
df_rep_usa$redist_dum_5_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_5lo)
df_rep_usa$redist_dum_6_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_6lo)
df_rep_usa$redist_dum_7_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_7lo)
df_rep_usa$redist_dum_8_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_8lo)
df_rep_usa$redist_dum_9_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_9lo)
df_rep_usa$redist_dum_10_liblo_low <- predict(m03liblo, newdata = df_rep_usa_hinc_10lo)

df_rep_marg$redist_o_stag_liblow_m <- df_rep_usa %>%
  select(redist_dum_1_liblo_low:redist_dum_10_liblo_low) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_marg$redist_o_stag_liblow_sd <- df_rep_usa %>%
  select(redist_dum_1_liblo_low:redist_dum_10_liblo_low) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

### FIN Stagnation, Lib Low
df_rep_fin$redist_dum_1_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_1lo)
df_rep_fin$redist_dum_2_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_2lo)
df_rep_fin$redist_dum_3_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_3lo)
df_rep_fin$redist_dum_4_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_4lo)
df_rep_fin$redist_dum_5_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_5lo)
df_rep_fin$redist_dum_6_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_6lo)
df_rep_fin$redist_dum_7_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_7lo)
df_rep_fin$redist_dum_8_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_8lo)
df_rep_fin$redist_dum_9_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_9lo)
df_rep_fin$redist_dum_10_liblo_low <- predict(m03liblo, newdata = df_rep_fin_hinc_10lo)

df_rep_margf$redist_o_stag_liblow_m <- df_rep_fin %>%
  select(redist_dum_1_liblo_low:redist_dum_10_liblo_low) %>%
  summarise_all(c(mean), na.rm = T) %>%
  t() 

df_rep_margf$redist_o_stag_liblow_sd <- df_rep_fin %>%
  select(redist_dum_1_liblo_low:redist_dum_10_liblo_low) %>%
  summarise_all(c(sd), na.rm = T) %>%
  t() 

df_rep_marg$country <-  "USA"
df_rep_margf$country <- "Finland"

df_rep_marg <- rbind(df_rep_marg, df_rep_margf)










