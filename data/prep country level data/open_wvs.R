# Used originally: "WVS" WVS_TimeSeries_1981_2020_ascii_v2_0.csv downloaded from https://www.worldvaluessurvey.org/WVSDocumentationWVL.jsp
# Used currently: EVS https://search.gesis.org/research_data/ZA7503
# Used currently: WVS https://www.worldvaluessurvey.org/WVSEVStrend.jsp

## R Open, aggregate and save WVS and EVS data and combine into IVS
pacman::p_load("haven",
               "labelled",
               "dplyr")

wvs <-  read_dta(here::here("data","prep country level data","WVS_Trend_v2_0.dta"),encoding="UTF-8",col_select=c("S002VS", "COW_NUM", "S009","S020", "E037", "E036", "E069_11", "E119", "E236", "E112"))
evs <- read_dta(here::here("data","prep country level data","ZA7503_v2-0-0.dta"),encoding="UTF-8",col_select=c("S002vs", "COW_NUM", "S009","S020", "E037", "E036", "E069_11", "E119", "E236", "E112"))
evs <- rename(evs, S002VS = S002vs)
# needed due to bug in haven-library when using rbind
wvs <- remove_labels(wvs)
ivs <- rbind(evs,wvs)

ivs <- rename(ivs, wave = S002VS, COUNTRY_ALPHA=S009, year = S020, liberal = E036, liberal_redist = E037,
              confidence_gov = E069_11, system_rating = E112, freedom_gov = E119, 
              democratic = E236)

ivs <- ivs %>%
  mutate(
         confidence_gov = -1*(confidence_gov - 5),
         liberal = -1*(liberal - 11), # Nate discovered an error in the WVS data, they are reverse coded; higher = private v. gov 
         liberal_redist = -1*(liberal_redist - 11), # lower values indicate individual v. gov so reverse
         liberal = ifelse(liberal < 1 | liberal > 10, NA, liberal),
         confidence_gov = ifelse(confidence_gov < 1 | confidence_gov > 4, NA, confidence_gov),
         liberal_redist = ifelse(liberal_redist < 1 | liberal_redist > 10, NA, liberal_redist))

saveRDS(ivs, here::here("data","ivs.rds"))

agg <- ivs
agg[agg < 0] <- NA 
agg <- agg %>%
  group_by(COUNTRY_ALPHA, year) %>%
  summarise_all(mean, na.rm = T) %>%
  ungroup() %>%
  as.data.frame()
agg[agg == NaN] <- NA

# obtain all possible country-year rows even if listwise missing, for later interpolation and merging functions
library(tidyr)
agg <- complete(agg, COUNTRY_ALPHA, year = 1981:2020)

saveRDS(ivs, here::here("data","ivs_aggregated.rds"))
