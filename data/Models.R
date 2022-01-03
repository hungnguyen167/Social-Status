


# interaction models for plotting

### With Country-Year and intercepts

M_4.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

### socx control

M_5.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

## gini

M_6.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

# gdp

M_7.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)



### With Country-Year and intercepts

M_4.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large  + (1 | iso3c_wave), data = df_na)

M_4.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

M_4.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na)

### socx control

M_5.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + socx  + (1 | iso3c_wave), data = df_na)

M_5.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

M_5.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + socx  + (1 | iso3c_wave), data = df_na)

## gini

M_6.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

M_6.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + gini_disp  + (1 | iso3c_wave), data = df_na)

# gdp

M_7.01 <- lmer(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.02 <- lmer(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.03 <- lmer(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.04i <- lmer(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.05i <- lmer(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.06i <- lmer(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.07wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.08wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.09wb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.10iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.11iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)

M_7.12iwb <- lmer(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k  + (1 | iso3c_wave), data = df_na)



### Linear regression

L_4.01l <- lm(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large , data = df_na)

L_4.02l <- lm(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large , data = df_na)

L_4.03l <- lm(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large , data = df_na)

L_4.04il <- lm(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large , data = df_na)

L_4.05il <- lm(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large , data = df_na)

L_4.06il <- lm(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large , data = df_na)

L_4.07wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w , data = df_na)

L_4.08wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w , data = df_na)

L_4.09wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w , data = df_na)

L_4.10iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w , data = df_na)

L_4.11iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w , data = df_na)

L_4.12iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w , data = df_na)

### socx control

L_5.01l <- lm(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + socx , data = df_na)

L_5.02l <- lm(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + socx , data = df_na)

L_5.03l <- lm(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + socx , data = df_na)

L_5.04il <- lm(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + socx , data = df_na)

L_5.05il <- lm(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + socx , data = df_na)

L_5.06il <- lm(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + socx , data = df_na)

L_5.07wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + socx , data = df_na)

L_5.08wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + socx , data = df_na)

L_5.09wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + socx , data = df_na)

L_5.10iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx , data = df_na)

L_5.11iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + socx , data = df_na)

L_5.12iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + socx , data = df_na)

## gini

L_6.01l <- lm(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + gini_disp , data = df_na)

L_6.02l <- lm(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + gini_disp , data = df_na)

L_6.03l <- lm(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + gini_disp , data = df_na)

L_6.04il <- lm(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + gini_disp , data = df_na)

L_6.05il <- lm(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + gini_disp , data = df_na)

L_6.06il <- lm(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + gini_disp , data = df_na)

L_6.07wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp , data = df_na)

L_6.08wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + gini_disp , data = df_na)

L_6.09wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + gini_disp , data = df_na)

L_6.10iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp , data = df_na)

L_6.11iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp , data = df_na)

L_6.12iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + gini_disp , data = df_na)

# gdp

L_7.01l <- lm(gov_redist ~ incdiff_large + noconf_govZ + noconf_govZ*incdiff_large + gdp_pc_10k , data = df_na)

L_7.02l <- lm(gov_redist ~ incdiff_large + cpiZ + cpiZ*incdiff_large + gdp_pc_10k , data = df_na)

L_7.03l <- lm(gov_redist ~ incdiff_large + libZ + libZ*incdiff_large + gdp_pc_10k , data = df_na)

L_7.04il <- lm(gov_redist ~ incdiff_large + noconf_govZ_i + noconf_govZ_i*incdiff_large + gdp_pc_10k , data = df_na)

L_7.05il <- lm(gov_redist ~ incdiff_large + cpiZ_i + cpiZ_i*incdiff_large + gdp_pc_10k , data = df_na)

L_7.06il <- lm(gov_redist ~ incdiff_large + libZ_i + libZ_i*incdiff_large + gdp_pc_10k , data = df_na)

L_7.07wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k , data = df_na)

L_7.08wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k , data = df_na)

L_7.09wbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ + libZ*incdiff_large_w + gdp_pc_10k , data = df_na)

L_7.10iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k , data = df_na)

L_7.11iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k , data = df_na)

L_7.12iwbl <- lm(gov_redist ~ incdiff_large_b + incdiff_large_w + libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k , data = df_na)
