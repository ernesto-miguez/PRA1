library(rvest)
library(tidyverse)
library(stringi)
library(jsonlite)
library(janitor)
library(writexl)
library(polite)
library(httr)

# SCRIPT PARA EXTRAER RESULTADOS DE LAS TEMPORADAS ANTERIORES

scrape_function <- function(temporada = 1992){
  
  #Scrape
  link <- paste0("https://fbref.com/en/comps/9/",temporada,"-",temporada+1,
                 "/schedule/",temporada,"-",temporada+1,"-Premier-League-Scores-and-Fixtures")
  
  bow(link)
  epl_page <- read_html(GET(link, timeout(10)))
  
  
  resultados <- link %>% 
    read_html() %>% 
    html_table() %>%
    .[[1]] %>% 
    clean_names()
  
  resultados_clean <- resultados %>%
    filter(wk != "NA")
  
  write_csv(resultados_clean, "~/Documents/Douglas/Projects/futbol/R_data/scrap_directory/data_ligas/epl_data/epl_resultados.csv")
}

scrape_function(temporada = 2022)




#DEMOSTRACION BOW

link <- "https://fbref.com/en/comps/9/schedule/Premier-League-Scores-and-Fixtures"
