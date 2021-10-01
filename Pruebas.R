
library(tidyverse)
library(lubridate)

properati <- read.csv("data/ar_properties20211001.csv")

properati_CABA <- properati %>% 
                  select(-description, -id, -l6, -l5, -l4, -title, -start_date, -end_date) %>% 
                  filter(l2 == "Capital Federal" & !is.na(lon) & !is.na(price) & property_type %in% c("Departamento","Casa","PH") & operation_type %in% c("Venta","Alquiler"))%>%
                  mutate(created_on = ymd(created_on))

properati_CABA <- properati_CABA %>%
                  mutate(year=year(created_on))%>%
                  filter(year=="2021")

as_tibble(properati_CABA)

properati_CABA_alq <- properati_CABA %>% 
                      filter(operation_type=="Alquiler")

properati_CABA_venta <- properati_CABA %>% 
                        filter(operation_type=="Venta")

write.csv(properati_CABA,"data/properati_CABA")
write.csv(properati_CABA_alq,"data/properati_CABA_alq")
write.csv(properati_CABA_venta,"data/properati_CABA_venta")

