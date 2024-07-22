library(rvest)
library(stringr)
library(lubridate)

url <- "https://en.wikipedia.org/wiki/Men%27s_high_jump_world_record_progression"
page <- read_html(url)
tables <- html_table(html_elements(page,"table"))
raw <- as.data.frame(tables[3])
head(raw,5)

Record <- str_sub(raw$Mark,1,4)
head(Record)
class(Record)
Record <- as.numeric(Record)

Country <- str_sub(raw$Athlete,-4,-2)
Country

Athlete <- str_to_upper(str_trim(str_sub(raw$Athlete,1,-6)))
Athlete

raw$Date

Dates <- str_replace(raw$Date,"\\[[1-9]\\]","")
class(Dates)
Dates <- dmy(Dates)
Dates

Year <- year(Dates)
head(Year)
Month <- month(Dates)
Day <- day(Dates)

Record_time_elapsed <- year(today()) - year(Dates)

clean_data <- data.frame("record"=Record,"athlete"=Athlete,"country"=Country,"date"=Dates,"year"=Year,"month"=Month,"day"=Day, "years_elapsed"=Record_time_elapsed)
head(clean_data)

library(dplyr)

?mutate

info <- clean_data %>% mutate("multiple_records"= ifelse(duplicated(athlete),TRUE, FALSE)) %>% select(record,athlete,year,"multiple_records",country)
head(info,n=5)

head(clean_data, n=5)

info <- clean_data %>% select(record,athlete,year,country) %>%
                       filter(record>=2.30) %>%
                       group_by(country) %>%
                       summarise("max_record"=max(record),"#_of_records"=n()) %>% #la función n nos muestra cuantos casos hay dentro de un agrupado.
                       arrange(desc(max_record))
info


