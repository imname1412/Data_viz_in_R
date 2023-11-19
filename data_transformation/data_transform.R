library(tidyverse)
library(glue)
library(lubridate)
library(nycflights13)
 
# glue msg
name <- 'Alice'
age <- 26
 
glue('Hello, {name} my age is {age}')


## data transform -> dplyr: Manipulate data
# select, filter, arrange, mutate, summarise
 
mtcars <- rownames_to_column(mtcars, 'model_car')
View(mtcars) 

# pipe operator
mtcars %>%
  select(model_car, mpg, hp, wt, am) %>% # select
  filter(hp > 200 & mpg >= 10) %>% # filter
  arrange(desc(mpg)) %>% # sort default (ascending)
  filter(grepl("^C", model_car)) # regEx start with C


mt_1 <- mtcars %>%
  select(model_car, mpg, hp, wt, am) %>%
  filter(between(hp, 100, 200)) %>%
  arrange(am, desc(hp)) # multiple sort column am > desc hp

## write csv
write_csv(mt_1, 'result.csv')

# mutate: create new columns
mtcars %>%
  select(model_car, mpg, hp, wt, am) %>%
  filter(mpg >= 20) %>%
  mutate(model_upper= toupper(model_car),
         mpg_double= mpg*2,
         constant_val= 42,
         am= if_else(am==0, "Auto", "Manual")
         )

# summarise | summarize like aggregate function
mt_2 <- mtcars %>%
  mutate(am= if_else(am==0, "Auto", "Manual")) %>%
  group_by(am) %>%
  summarize(avg_mpg = mean(mpg),
            sum_hp = sum(hp),
            max_hp = max(hp),
            min_hp = min(hp),
            n = n()
            )
write_csv(mt_2, 'result2.csv')


## Join data in R
# left, inner, full
mt_3 <- band_members %>%
  select(member_name = name,
         band_name = band) %>%
  left_join(band_instruments, by=c('member_name' = 'name'))
  
View(mt_3)


## random sampling
mtcars %>%
  sample_n(5) %>%
  pull(model_car) # pull only vector (exclude col_name)

mtcars %>%
  sample_frac(0.25) %>% # sampling data 25 % from 100 %
  summarize(avg_hp = mean(hp))

## 100% => Analytics
## 20% => Statistics

mtcars <- mtcars %>%
  mutate(am = if_else(am == 0, 'Auto', 'Manual'))

mtcars %>%
  count(am) %>%
  mutate(per = n/sum(n))

###
View(flights)
View(airlines)

flights %>%
  filter(year == 2013 & month ==9) %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  left_join(airlines, by='carrier') %>%
  head(5)

## sql
# install.packages('sqldf')

library(sqldf)
sqldf('select * from mtcars
      where hp > 200;')

sqldf(
  "select avg(hp) as avg, max(hp) as max_hp
  from mtcars;"
)

### R connect Database :D
library(RSQLite) # sqlite
library(RPostgreSQL) # progres server

# connect to sqlite.db file
con_sqlite <- dbConnect(SQLite(), "chinook.db")

# list talbe
dbListTables(con_sqlite)

# list columns
dbListFields(con_sqlite, 'customers')

# get data from table
df_sql1 <- dbGetQuery(con_sqlite, 
           "select firstname, email, country from customers
           where country = 'USA' ")

View(df_sql1)

# create dataframe+datatype => tribble
products <- tribble(
  ~id, ~product_name,
  1, "apple",
  2, "Steak",
  3, "Fired rice"
)

# write table
dbWriteTable(con_sqlite, "products_table", products)

dbGetQuery(con_sqlite, 'select * from products_table')

# drop table
dbRemoveTable(con_sqlite, 'products_table')

# close connection
dbDisconnect(con_sqlite)


# sql server (postgres)
# multi comment ctrl + shift + C

# con <- dbConnect(
#   PostgreSQL(),
#   host='',
#   dbname='',
#   user='',
#   password='',
#   port=5432
# )
