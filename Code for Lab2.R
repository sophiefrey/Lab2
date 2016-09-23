library(dplyr)
library(readr)
library(tidyr)

a <- read_csv('./9.22.CSV')
head(a)
tail(a)
#determing which RACED values are in the dataset
table(a$RACED)
#excluding Hawaii and Alaska
aa <- a %>% filter(!(YEAR<1960 & STATEFIP %in% c(2,15)))
#crosswalk with only the values defined by table
race <- read_csv('./RACED.csv',col_types = cols(RACED='i'))
b <- left_join(aa,race, by= 'RACED')
#grouping
c <- b %>% group_by(YEAR,Race) %>% summarise(NUMBER = sum(PERWT))
#creating spread
d <- c %>% spread(YEAR,NUMBER)
#export to .csv
write_csv(d,'./Race_YEAR.csv')
