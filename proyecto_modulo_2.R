# Proyecto. Módulo 2.
# Autor: Carlos Alberto Álvarez Velasco.

library("dplyr")
library("lubridate")

getwd()
setwd("C:/Users/Carlos Alvarez/Desktop/DemoDay")
game_data <- read.csv(file.choose()) # Usaremos la tabla game_data_exp.

str(game_data) # Tipo de las variables.

game_data_modified <- game_data %>% mutate(mdy(game_data$r.date))
str(game_data_modified) # Se creo el objeto para las fechas.

game_data_modified <- game_data_modified[,-c(3)] # Eliminamos la columna extra de las fechas.
game_data_modified <- game_data_modified %>% rename(Name = name, Console = platform, Critics_score = score, Users_score = user_score, Developer = developer, Genre = genre, Number_of_players = players, Number_of_critics = critics, Number_of_users = users, Release_Date = "mdy(game_data$r.date)")
# Se cambian los nombres de las columnas.

str(game_data_modified) # Se necesita cambiar el tipo de objeto de la puntuación el usuario.

game_data_modified <- game_data_modified %>% mutate(as.numeric(Users_score))
game_data_modified <- game_data_modified[,-c(4)] # Se elimina la columna original.
game_data_modified <- game_data_modified %>% rename(Users_score = "as.numeric(Users_score)")
