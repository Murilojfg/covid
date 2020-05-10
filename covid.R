setwd("C:/Users/Thaiza Bermejo/Desktop/covid")

library(dplyr)
library(forecast)
library(zoo)

covid <- read.csv("covid19.csv")

covidPA <- filter(covid, covid$state == "PA")

covidPA <- cbind(covidPA$date, 
                 covidPA$last_available_confirmed_per_100k_inhabitants,
                 covidPA$last_available_death_rate)

covidPA <- as.data.frame(covidPA)

colnames(covidPA) <- c("time", "cases_100", "letalidade")

covidPA <- arrange(covidPA, time)

ts.plot(covidPA$cases_100)
ts.plot(covidPA$letalidade)

auto.arima(covidPA$cases_100)

pd_cases <- forecast(auto.arima(covidPA$cases_100), h = 5)

plot(pd_cases)
