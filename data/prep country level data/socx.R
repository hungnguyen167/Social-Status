pacman::p_load("tidyverse")


# OECD https://stats.oecd.org/Index.aspx?datasetcode=SOCX_AGG#
socx <- read_csv(here::here("data/prep country level data","SOCX_AGG_26072021091623933.csv"))

socx1 <- socx %>%
  subset(Measure == "Per head, at current prices and current PPPs, in US dollars" & Source == "Public") %>%
  dplyr::select(COUNTRY, Year, Value)

socx2 <- socx %>%
  subset(Measure == "In percentage of Gross Domestic Product" & Source == "Public") %>%
  dplyr::select(COUNTRY, Year, Value)

colnames(socx1) <- c("iso3c","year","socx_perhead")
colnames(socx2) <- c("iso3c","year","socx")

socx <- full_join(socx1, socx2, by = c("iso3c","year"))

write.csv(socx, here::here("data","socx_oecd.csv"), row.names = F)
