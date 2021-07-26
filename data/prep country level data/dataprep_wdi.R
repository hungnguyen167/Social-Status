pacman::p_load("tidyverse")
pacman::p_load("WDI")

wdi <- WDI(indicator = c(
  gdp_cap = "NY.GDP.PCAP.KD",
  unemp_nat = "SL.UEM.TOTL.NE.ZS",
  unemp_ilo = "SL.UEM.TOTL.ZS",
  fertility = "SP.DYN.TFRT.IN",
  fem_labour = "SL.TLF.TOTL.FE.ZS",
  pop = "SP.POP.TOTL",
  pop65 = "SP.POP.65UP.TO.ZS",
  pop_dens = "EN.POP.DNST"
)) %>%
  mutate(iso3c = countrycode::countrycode(iso2c, "iso2c", "iso3c")) %>%
  drop_na(iso3c) %>%
  relocate(iso3c) %>%
  select(-country, -iso2c)

wdi <- wdi %>%
  subset(year > 1985) %>%
  group_by(iso3c,year) %>%
  summarise_all(mean, na.rm = T)

wdi[ wdi == "NaN" ] <- NA

write.csv(wdi, here::here("data","wdi.csv"), row.names = F)
