library(pwdapi)
library(tidyverse)
library(lubridate)

#To see parameter list, run pwdapi::lims_parameters
parameters <- pwdapi::lims_parameters 

#If you only specify site IDs you get all results from last 3 months
pwdapi::read_lims(site = c(4903, 5903, 6903))  

#But you can specify parameter and date range
data <- pwdapi::read_lims(site = "WS076", parameter = "pH", start_date = "2020-01-01", end_date = "2024-12-01")

pfna <- pwdapi::read_lims(parameter = "Perfluorononanoic acid (PFNA)")

sodium <- pwdapi::read_lims(site = "SEINFN", parameter = "Solids Dissolved Total", start_date = "2000-01-01", end_date = "2025-04-01")
sodium$date_time <- ymd_hms(sodium$date_time)
sodium <- mutate(sodium, Month = month(date_time), Year = year(date_time))
sodium <- group_by(sodium, Month, Year)
stats <- summarise(sodium, average = mean(result))

