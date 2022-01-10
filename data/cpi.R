pacman::p_load("readxl", 
               "countrycode",
               "reshape2",
               "zoo")

# 2015 to 2020 (from https://www.transparency.org/en/cpi/2020/, 10.01.2022)


cpi <- readxl::read_excel(here::here("data","CPI2020_GlobalTablesTS_210125.xlsx"), 
                          skip = 2, sheet = "CPI Timeseries 2012 - 2020")

cpi <- cpi %>%
  mutate(iso3c = ISO3) %>%
  rowwise() %>%
  mutate(cpi = mean(c(`CPI score 2020`,`CPI score 2019`,`CPI score 2018`,`CPI score 2017`,`CPI score 2016`)),
         wave = 2019,
         iso3c_wave = paste(iso3c, wave, sep = "_")) %>%
  dplyr::select(iso3c_wave, cpi) %>%
  ungroup()

# Pre 2016
cpi2 <- read_csv(url("https://datahub.io/core/corruption-perceptions-index/r/data.csv"))

cpi2 <- cpi2 %>%
  mutate(iso3c = countrycode::countrycode(Jurisdiction, "country.name", "iso3c"))

# make numeric
cpi2[cpi2 == "-"] <- NA
cpi2[,2:19] <- sapply(cpi2[,2:19], as.numeric)

cpi2.1 <- cpi2 %>%
  dplyr::select(-Jurisdiction) %>%
  group_by(iso3c) %>%
  summarise_all(mean, na.rm = T)

cpi2.1[cpi2.1 == "NaN"] <- NA
cpi2.1 <- cpi2.1 %>%
  subset(!is.na(iso3c))

# reshape
cpi_long <- reshape2::melt(cpi2.1, id.vars = "iso3c", variable.name = "year", value.name = "cpi")

# add years going back to 1987
# remove factor structure
cpi_long$year <- as.numeric(as.character(cpi_long$year))

cpi_long <- cpi_long %>%
  group_by(iso3c) %>%
  complete(year = seq(1987, 2015, 1))

# linear interpolate cpi
# fix change in scale from 10s to 100s after 2012
cpi_long <- cpi_long %>%
  mutate(cpi2 = ifelse(year < 2012, cpi*10, cpi),
         cpi = ifelse(year < 2012, cpi*10, cpi))

m1 <- lm(cpi2 ~ year*factor(iso3c), cpi_long)
cpi_long$cpi_i <- predict.lm(m1, newdata = cpi_long)

# remove negative values, keep real values
cpi_long <- cpi_long %>%
  mutate(cpi_i = ifelse(cpi_i < 1, 1, cpi_i),
         cpi_ii = ifelse(!is.na(cpi), cpi, cpi_i))

cpi_long_87 <- cpi_long %>%
  subset(year < 1991) %>%
  group_by(iso3c) %>%
  summarise_all(mean, na.rm = T) %>%
  mutate(wave = 1987) %>%
  dplyr::select(iso3c, wave, cpi, cpi_ii)

cpi_long_92 <- cpi_long %>%
  subset(year > 1988 & year < 1998) %>%
  group_by(iso3c) %>%
  summarise_all(mean, na.rm = T) %>%
  mutate(wave = 1992) %>%
  dplyr::select(iso3c, wave, cpi, cpi_ii)

cpi_long_99 <- cpi_long %>%
  subset(year > 1996 & year < 2003) %>%
  group_by(iso3c) %>%
  summarise_all(mean, na.rm = T) %>%
  mutate(wave = 1999) %>%
  dplyr::select(iso3c, wave, cpi, cpi_ii)

cpi_long_09 <- cpi_long %>%
  subset(year > 2007) %>%
  group_by(iso3c) %>%
  summarise_all(mean, na.rm = T) %>%
  mutate(wave = 2009) %>%
  dplyr::select(iso3c, wave, cpi, cpi_ii)

cpi2 <- rbind(cpi_long_87, cpi_long_92, cpi_long_99, cpi_long_09)

cpi2 <- cpi2 %>%
  mutate(iso3c_wave = paste(iso3c, wave, sep = "_")) %>%
  dplyr::select(iso3c_wave, cpi, cpi_ii)

cpi$cpi_ii <- cpi$cpi



# add together with 2019
cpi_merge <- rbind(cpi, cpi2)

write_rds(cpi_merge, file = here::here("data","cpi.RDS"))
