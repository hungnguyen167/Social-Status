


# interaction models for plotting

### With Country-Year only

M_4.01 <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C + (1 | iso3c_wave), data = df_na))

M_4.02 <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C + (1 | iso3c_wave), data = df_na))

M_4.03 <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C + (1 | iso3c_wave), data = df_na))

M_4.04i <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C + (1 | iso3c_wave), data = df_na))

M_4.05i <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C + (1 | iso3c_wave), data = df_na))

M_4.06i <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C + (1 | iso3c_wave), data = df_na))

M_4.07wb <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na))

M_4.08wb <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na))

M_4.09wb <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w  + (1 | iso3c_wave), data = df_na))

M_4.10iwb <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na))

M_4.11iwb <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na))

M_4.12iwb <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w  + (1 | iso3c_wave), data = df_na))

### socx_C control

M_5.01 <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.02 <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.03 <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.04i <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.05i <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.06i <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.07wb <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.08wb <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.09wb <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.10iwb <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.11iwb <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.12iwb <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave), data = df_na))

## gini

M_6.01 <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.02 <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.03 <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.04i <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.05i <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.06i <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.07wb <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.08wb <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.09wb <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.10iwb <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.11iwb <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.12iwb <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave), data = df_na))

# gdp

M_7.01 <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.02 <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.03 <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.04i <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.05i <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.06i <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.07wb <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.08wb <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.09wb <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.10iwb <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.11iwb <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_7.12iwb <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

# immigration

M_8.01 <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.02 <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.03 <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.04i <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.05i <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.06i <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.07wb <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.08wb <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.09wb <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.10iwb <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.11iwb <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.12iwb <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))


### With Country-Year and Country

M_4.13c <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.14c <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.15c <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.16ic <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.17ic <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.18ic <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.19wbc <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.20wbc <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.21wbc <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.22iwbc <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.23iwbc <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_4.24iwbc <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

### socx_C control

M_5.13c <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.14c <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.15c <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.16ic <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.17ic <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.18ic <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.19wbc <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.20wbc <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.21wbc <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.22iwbc <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.23iwbc <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_5.24iwbc <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

## gini

M_6.13c <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.14c <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.15c <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.16ic <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.17ic <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.18ic <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.19wbc <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.20wbc <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.21wbc <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.22iwbc <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.23iwbc <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_6.24iwbc <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

# gdp

M_7.13c <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.14c <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.15c <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.16ic <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.17ic <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.18ic <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.19wbc <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.20wbc <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.21wbc <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.22iwbc <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.23iwbc <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_7.24iwbc <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

# immigration

M_8.13c <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.14c <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.15c <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.16ic <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.17ic <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.18ic <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.19wbc <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.20wbc <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.21wbc <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.22iwbc <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.23iwbc <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))

M_8.24iwbc <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c), data = df_na))


# WITH GDP INTERACTIONS

### With Country-Year only

M_4.01_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave), data = df_na))

M_4.02_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave), data = df_na))

M_4.03_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave), data = df_na))

M_4.04i_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave), data = df_na))

M_4.05i_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C +cpiZ_i:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave), data = df_na))

M_4.06i_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave), data = df_na))

M_4.07wb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C +noconf_govZ:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_4.08wb_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C +cpiZ:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_4.09wb_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_4.10iwb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_w  + (1 | iso3c_wave), data = df_na))

M_4.11iwb_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C +cpiZ_i:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

M_4.12iwb_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C +libZ_i:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave), data = df_na))

### socx_C control

M_5.01_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.02_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.03_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.04i_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.05i_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C +cpiZ_i:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.06i_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave), data = df_na))

M_5.07wb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C +noconf_govZ:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.08wb_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C +cpiZ:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.09wb_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.10iwb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.11iwb_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C +cpiZ_i:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave), data = df_na))

M_5.12iwb_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C +libZ_i:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave), data = df_na))

## gini

M_6.01_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.02_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.03_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.04i_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.05i_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C +cpiZ_i:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.06i_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.07wb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C +noconf_govZ:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.08wb_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C +cpiZ:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.09wb_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.10iwb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.11iwb_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C +cpiZ_i:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave), data = df_na))

M_6.12iwb_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C +libZ_i:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave), data = df_na))

# gdp

#### redundant

# immigration

M_8.01_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.02_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.03_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.04i_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.05i_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C + cpiZ_i:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.06i_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.07wb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C + noconf_govZ:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.08wb_gdp <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C + cpiZ:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.09wb_gdp <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.10iwb_gdp <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C + noconf_govZ_i:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.11iwb_gdp <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C + cpiZ_i:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

M_8.12iwb_gdp <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C + libZ_i:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave), data = df_na))

########################################################################################################################
########################################################################################################################
########################################################################################################################

# MODELS WITH AGE, SEX, AND EDUCATION

### With Country-Year only

M_4.01_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C + (1 | iso3c_wave) + ageC + female + educyrs + ageC + female + educyrs, data = df_na))

M_4.02_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C + (1 | iso3c_wave) + ageC + female + educyrs + ageC + female + educyrs, data = df_na))

M_4.03_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C + (1 | iso3c_wave) + ageC + female + educyrs + ageC + female + educyrs, data = df_na))

M_4.04i_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C + (1 | iso3c_wave) + ageC + female + educyrs + ageC + female + educyrs, data = df_na))

M_4.05i_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.06i_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.07wb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.08wb_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.09wb_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.10iwb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.11iwb_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.12iwb_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

### socx_C control

M_5.01_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.02_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.03_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.04i_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.05i_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.06i_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.07wb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.08wb_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.09wb_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.10iwb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.11iwb_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.12iwb_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

## gini

M_6.01_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.02_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.03_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.04i_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.05i_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.06i_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.07wb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.08wb_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.09wb_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.10iwb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.11iwb_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.12iwb_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

# gdp

M_7.01_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.02_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.03_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.04i_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.05i_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.06i_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.07wb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.08wb_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.09wb_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.10iwb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.11iwb_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_7.12iwb <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

# immigration

M_8.01_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.02_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.03_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.04i_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.05i_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.06i_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.07wb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.08wb_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.09wb_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.10iwb_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.11iwb_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.12iwb_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))


### With Country-Year and Country

M_4.13c_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.14c_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.15c_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.16ic_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.17ic_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.18ic_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.19wbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.20wbc_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.21wbc_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.22iwbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.23iwbc_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_4.24iwbc_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

### socx_C control

M_5.13c_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.14c_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.15c_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.16ic_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.17ic_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.18ic_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.19wbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.20wbc_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.21wbc_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.22iwbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.23iwbc_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_5.24iwbc_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + socx_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

## gini

M_6.13c_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.14c_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.15c_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.16ic_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.17ic_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.18ic_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.19wbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.20wbc_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.21wbc_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.22iwbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.23iwbc_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_6.24iwbc_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gini_disp_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

# gdp

M_7.13c_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.14c_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.15c_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.16ic_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.17ic_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.18ic_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.19wbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.20wbc_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.21wbc_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.22iwbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.23iwbc_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_7.24iwbc_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + gdp_pc_10k_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

# immigration

M_8.13c_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.14c_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.15c_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.16ic_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.17ic_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.18ic_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_C+ pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.19wbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + noconf_govZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.20wbc_ind <- summary(lmer(gov_redist_C ~ cpiZ + cpiZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.21wbc_ind <- summary(lmer(gov_redist_C ~ libZ + libZ*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.22iwbc_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + noconf_govZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.23iwbc_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + cpiZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

M_8.24iwbc_ind <- summary(lmer(gov_redist_C ~ libZ_i + libZ_i*incdiff_large_w + pct_fb_i_C  + (1 | iso3c_wave) + (1 | iso3c) + ageC + female + educyrs, data = df_na))

# WITH GDP INTERACTIONS

### With Country-Year only

M_4.01_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.02_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.03_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.04i_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.05i_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C +cpiZ_i:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.06i_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.07wb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C +noconf_govZ:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.08wb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C +cpiZ:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.09wb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.10iwb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_w  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.11iwb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C +cpiZ_i:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_4.12iwb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C +libZ_i:incdiff_large_w:gdp_pc_10k_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

### socx_C control

M_5.01_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.02_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.03_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.04i_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.05i_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C +cpiZ_i:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.06i_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C+ socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.07wb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C +noconf_govZ:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.08wb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C +cpiZ:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.09wb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.10iwb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.11iwb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C +cpiZ_i:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_5.12iwb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C +libZ_i:incdiff_large_w:gdp_pc_10k_C + socx_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

## gini

M_6.01_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.02_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.03_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.04i_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.05i_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C +cpiZ_i:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.06i_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C+ gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.07wb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C +noconf_govZ:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.08wb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C +cpiZ:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.09wb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.10iwb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.11iwb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C +cpiZ_i:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_6.12iwb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C +libZ_i:incdiff_large_w:gdp_pc_10k_C + gini_disp_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

# gdp

#### redundant

# immigration

M_8.01_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_C + gdp_pc_10k_C +noconf_govZ:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.02_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_C + gdp_pc_10k_C +cpiZ:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.03_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_C + gdp_pc_10k_C +libZ:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.04i_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_C + gdp_pc_10k_C +noconf_govZ_i:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.05i_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_C + gdp_pc_10k_C + cpiZ_i:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.06i_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_C + gdp_pc_10k_C +libZ_i:incdiff_large_C:gdp_pc_10k_C+ pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.07wb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ + incdiff_large_w + gdp_pc_10k_C + noconf_govZ:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.08wb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ + incdiff_large_w + gdp_pc_10k_C + cpiZ:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.09wb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ + incdiff_large_w + gdp_pc_10k_C +libZ:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.10iwb_gdp_ind <- summary(lmer(gov_redist_C ~ noconf_govZ_i + incdiff_large_w + gdp_pc_10k_C + noconf_govZ_i:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.11iwb_gdp_ind <- summary(lmer(gov_redist_C ~ cpiZ_i + incdiff_large_w + gdp_pc_10k_C + cpiZ_i:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))

M_8.12iwb_gdp_ind <- summary(lmer(gov_redist_C ~ libZ_i + incdiff_large_w + gdp_pc_10k_C + libZ_i:incdiff_large_w:gdp_pc_10k_C + pct_fb_i_C  + (1 | iso3c_wave) + ageC + female + educyrs, data = df_na))




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
