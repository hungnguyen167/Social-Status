pacman::p_load("tidyverse")


# OECD https://stats.oecd.org/Index.aspx?datasetcode=SOCX_AGG#
socx <- read_csv(here::here("data/prep country level data","SOCX_AGG_07032022163148772.csv"))


socx <- socx %>%
  subset(Measure == "In percentage of Gross Domestic Product" & 
           Source == "Public" & 
           `Type of Expenditure` == "Total") %>%
  dplyr::select(COUNTRY, Year, Value)

colnames(socx) <- c("iso3c","year","socx")

write.csv(socx, here::here("data","socx_oecd.csv"), row.names = F)
