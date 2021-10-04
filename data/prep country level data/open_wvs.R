# "WVS" WVS_TimeSeries_1981_2020_ascii_v2_0.csv downloaded from https://www.worldvaluessurvey.org/WVSDocumentationWVL.jsp


## R Open, aggregate and save WVS data



pacman::p_load("data.table","tidyverse")

wvs <- fread(here::here("data","prep country level data", "WVS_TimeSeries_1981_2020_ascii_v2_0.csv"), select = c("S002VS", "COUNTRY_ALPHA", "S020", "E037", "E069_11", "E119", "E236", "E131", "E112", "E130"))

wvs <- rename(wvs, wave = S002VS, year = S020, liberal = E037, confidence_gov = E069_11, system_rating = E112, freedom_gov = E119, democratic = E236, reason_neediness = E131, poverty_compare = E130)
write.csv(wvs, "data/wvs.csv", row.names = FALSE)



agg <- read_csv(here::here("data","wvs.csv"))
agg <- agg %>%
  group_by(COUNTRY_ALPHA, year, wave) %>%
  summarise_at(.vars = names(.)[-3:-1], .funs = c(mean))
agg[agg < 0] <- NA 
write.csv(agg, "data/wvs_aggregated.csv", row.names = FALSE)

