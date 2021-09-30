pacman::p_load("tidyverse",
               "readxl")

crpt <- read_xlsx(here::here("data", "prep country level data", "CPI2020_GlobalTablesTS_210125.xlsx"), 
                          sheet = "CPI Timeseries 2012 - 2020", skip = 1) %>%
  mutate(iso3c = ISO3) %>%
  select(iso3c, `CPI score 2020`, `CPI score 2019`, `CPI score 2018`, 
         `CPI score 2017`, `CPI score 2016`, `CPI score 2015`) %>%
  group_by(iso3c) %>%
  mutate(cpi15_20 = mean(c(`CPI score 2020`, `CPI score 2019`, `CPI score 2018`, 
                            `CPI score 2017`, `CPI score 2016`, `CPI score 2015`), na.rm = T)) %>%
  ungroup() %>%
  select(iso3c, cpi15_20) %>%
  mutate(cpi15_20 = (100-cpi15_20)/100)

write_csv(crpt, file = here::here("data","crpt.csv"))
