# "WVS" WVS_TimeSeries_1981_2020_ascii_v2_0.csv downloaded from https://www.worldvaluessurvey.org/WVSDocumentationWVL.jsp


## R Open, aggregate and save WVS data



pacman::p_load("data.table","tidyverse")

wvs <- fread(here::here("data","prep country level data", "WVS_TimeSeries_1981_2020_ascii_v2_0.csv"), select = c("S002VS", "COUNTRY_ALPHA", "S020", "E037", "E036", "E069_11", "E119", "E236", "E131", "E112", "E130"))

wvs <- rename(wvs, wave = S002VS, year = S020, liberal = E036, liberal_redist = E037,
              confidence_gov = E069_11, system_rating = E112, freedom_gov = E119, 
              democratic = E236, reason_neediness = E131, poverty_compare = E130)

wvs <- wvs %>%
  mutate(
         confidence_gov = -1*(confidence_gov - 5),
         liberal = -1*(liberal - 11), # Nate discovered an error in the WVS data, they are reverse coded  
         liberal_redist = -1*(liberal_redist - 11), # lower values indicate higher confidence so reverse
         liberal = ifelse(liberal < 1 | liberal > 10, NA, liberal),
         confidence_gov = ifelse(confidence_gov < 1 | confidence_gov > 4, NA, confidence_gov),
         liberal_redist = ifelse(liberal_redist < 1 | liberal_redist > 10, NA, liberal_redist))

write.csv(wvs, "data/wvs.csv", row.names = FALSE)



agg <- read_csv(here::here("data","wvs.csv"))
agg[agg < 0] <- NA 
agg <- agg %>%
  group_by(COUNTRY_ALPHA, year) %>%
  summarise_all(mean, na.rm = T) %>%
  ungroup() %>%
  as.data.frame()
agg[agg == "NaN"] <- NA

# obtain all possible country-year rows even if listwise missing, for later interpolation and merging functions
agg <- complete(agg, COUNTRY_ALPHA, year = 1981:2020)

write.csv(agg, "data/wvs_aggregated.csv", row.names = FALSE)

