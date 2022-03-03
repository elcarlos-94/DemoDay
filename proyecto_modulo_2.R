# Proyecto. Módulo 2.
# Autor: Carlos Alberto Álvarez Velasco.

library("dplyr")
library("lubridate")

getwd()
setwd("C:/Users/Carlos Alvarez/Desktop/DemoDay")
game_data <- read.csv(file.choose()) # Usaremos la tabla game_data_exp.

str(game_data) # Tipo de las variables.

game_data_modified <- game_data %>% mutate(Release_Date = mdy(game_data$r.date))
str(game_data_modified) # Se creo el objeto para las fechas.

game_data_modified <- game_data_modified[,-c(4)] # Eliminamos la columna extra de las fechas.
game_data_modified <- game_data_modified %>% rename(Name = name, Console = platform, Company = company, Critics_score = score, Users_score = user_score, Developer = developer, Genre = genre, Number_of_players = players, Number_of_critics = critics, Number_of_users = users)
# Se cambian los nombres de las columnas.

str(game_data_modified) # Se necesita cambiar el tipo de objeto de la puntuación el usuario.

game_data_modified <- game_data_modified %>% mutate(Users_Score = as.numeric(Users_score))
game_data_modified <- game_data_modified[,-c(5)] # Se elimina la columna original.

str(game_data_modified)
developer_mean <- game_data_modified %>% group_by(Developer) %>% summarise(Mean = mean(Critics_score), n = n())
company_mean <- game_data_modified %>% group_by(Company) %>% summarise(Mean = mean(Critics_score), n = n())

# Histogramas que muestran el promedio de calificación de la critica y los usuarios.

ggplot(game_data_modified, aes(Critics_score)) +
  geom_histogram(col = "black", fill= "red") +
  ggtitle("Critics score by console") +
  xlab("Score") +
  ylab("Times") +
  geom_vline(xintercept = mean(game_data_modified$Critics_score))

ggplot(game_data_modified, aes(Users_Score)) +
  geom_histogram(col = "black", fill= "red") +
  ggtitle("Users score by console") +
  xlab("Score") +
  ylab("Times") +
  geom_vline(xintercept = mean(na.omit(game_data_modified$Users_Score)))

ggplot(game_data_modified, aes(Number_of_critics,Critics_score)) +
  geom_point() +
  facet_wrap("Company") +
  ggtitle("Users Score by company") +
  xlab("Number of critics") +
  ylab("Score")
  
ggplot(game_data_modified, aes(Number_of_users,Users_Score)) +
  geom_point() +
  facet_wrap("Company") +
  ggtitle("Users Score by company") +
  xlab("Number of users") +
  ylab("Score")
