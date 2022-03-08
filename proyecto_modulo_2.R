# Proyecto. Módulo 2.
# Autor: Carlos Alberto Álvarez Velasco.

# install.packages("tidyverse")

library("dplyr")
library("lubridate")
library("ggplot2")
library("tidyverse")

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
#developer_mean <- game_data_modified %>% group_by(Developer) %>% summarise(Mean = mean(Critics_score), n = n())
#company_mean <- game_data_modified %>% group_by(Company) %>% summarise(Mean = mean(Critics_score), n = n())

# Histogramas que muestran el promedio de calificación de la critica y los usuarios.

# Gráfica sin normalizar de puntaje de la crítica.

ggplot(game_data_modified, aes(Critics_score)) +
  geom_histogram(col = "black", fill= "red") +
  ggtitle("Critics score by console") +
  xlab("Score") +
  ylab("Times") +
  geom_vline(xintercept = mean(game_data_modified$Critics_score))

# Normalizamos la serie de datos, sacando el cuadrado de cada calificación hecha por la crítica.

ggplot(game_data_modified, aes((Critics_score)^2)) +
  geom_histogram(col = "black", fill= "red") +
  ggtitle("Critics score by console") +
  xlab("Score^2") +
  ylab("Times") +
  geom_vline(xintercept = (mean(game_data_modified$Critics_score))^2)

sd_critics <- sd((game_data_modified$Critics_score)^2)
mean_critics <- (mean(game_data_modified$Critics_score))^2
prob_critics <- pnorm(q = (60)^2, mean = mean_critics, sd = sd_critics)
prob_critics <- pnorm(q = (80)^2, mean = mean_critics, sd = sd_critics)

group_critics_score <- game_data_modified %>% select(Critics_score)
group_critics_score <- group_critics_score %>% mutate(Game_factor = ifelse(Critics_score >= 60, 1, 0)) # 1 es bueno, 0 es malo.

#m_log_critics <- glm(group_critics_score$Game_factor ~ group_critics_score$Critics_score, data = group_critics_score, family = "binomial")

ggplot(data = group_critics_score, aes(x = Critics_score, y = Game_factor)) +
  geom_point(aes(color = as.factor(sqrt(Game_factor)), shape = 1) +
  geom_smooth(method = "glm",
              method.args = list(family = "binomial"),
              color = "gray20",
              se = FALSE))

str(m_log_critics)
str(group_critics_score)

# Gráfica sin normalizar de puntaje de los usuarios.

ggplot(game_data_modified, aes(Users_Score)) +
  geom_histogram(col = "black", fill= "red") +
  ggtitle("Users score by console") +
  xlab("Score") +
  ylab("Times") +
  geom_vline(xintercept = mean(na.omit(game_data_modified$Users_Score)))


#Normalizamos la serie de datos, sacando el cuadrado de cada calificación hecha por los usuarios.

ggplot(game_data_modified, aes((Users_Score)^2)) +
  geom_histogram(col = "black", fill= "red") +
  ggtitle("Users score by console") +
  xlab("Score^2") +
  ylab("Times") +
  geom_vline(xintercept = (mean(na.omit(game_data_modified$Users_Score))^2))

sd_users <- sd(na.omit(game_data_modified$Users_Score)^2)
mean_users <- (mean(na.omit(game_data_modified$Users_Score))^2)
prob_users <- pnorm(q = (6.0)^2, mean = mean_users, sd = sd_users)
prob_users <- pnorm(q = (8.0)^2, mean = mean_users, sd = sd_users)

# Análisis cualitativo de relación entre el número de usuarios y el puntaje por la compañía.

game_data_filtered <- filter(game_data_modified, Name != "The Last of Us Part II") # Se filtró este dato ya que es un número grande.
ggplot(game_data_filtered, aes(Number_of_critics,Users_Score)) +
  geom_point() +
  facet_wrap("Company") +
  ggtitle("Users Score by company") +
  xlab("Number of users") +
  ylab("Score")

# Extraemos el año de lanzamiento de cada juego.
game_data_modified$Year <- format(game_data_modified$Release_Date, format = "%Y")

# Graficamos la calidad de los juegos año tras año según la crítica.
year_mean <- game_data_modified %>% group_by(Year) %>% summarise(Mean = mean(Critics_score), n = n())
year_mean_filtered <- filter(year_mean, n > 52)
plot(year_mean_filtered$Year, year_mean_filtered$Mean, xlab = "Year", ylab = "Critics Score")

# Graficamos la calidad de los juegos año tras año según los jugadores.
game_data_users_filtered <- filter(game_data_modified, Number_of_users > 100)
year_mean_users <- game_data_users_filtered %>% group_by(Year) %>% summarise(Mean = mean(Users_Score), n = n())
plot(year_mean_users$Year, year_mean_users$Mean, 
     xlab = "Year", ylab = "User Score")

# Graficamos la popularidad de los videojuegos a través de los años.
plot(year_mean_users$Year, year_mean_users$n,
     xlab = "Year", ylab = "Number of players")
