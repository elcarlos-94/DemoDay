import pandas as pd
# import numpy as np

# Import original file
df = pd.read_csv('C:/Users/Carlos Alvarez/Desktop/DemoDay/CSV/games-data-exp.csv', sep=',')
df.set_index('name')

# First look on NA in table
print(df.isna().sum(axis=0))

# Clean NA in the players column
df_clean_na = df.copy()
df_clean_na['players'] = df_clean_na['players'].fillna(0)

# Second look on NA in table
print(df_clean_na.isna().sum(axis=0))

# Extract year from "r-date".
df_clean_na['year'] = pd.DatetimeIndex(df_clean_na['r-date']).year

pd.set_option('display.max_columns', df_clean_na.shape[0] + 1)
# print(df_clean_na.head(5))  # Show at least 5 games.

df_genre = df_clean_na['genre'].str.split(',', expand=True)
df_genre_dropped = df_genre.dropna(axis=1, how='any')
# print(df_genre_dropped.head(5)) # Show only one genre per game

df_2 = pd.concat([df_clean_na, df_genre_dropped], axis=1)
df_2_drop = df_2.drop(columns=['genre'])
column_renamed = {
    'r-date': 'release_date',
    0: 'genre'
}
df_2_renamed = df_2_drop.rename(columns=column_renamed)
print(df_2_renamed.head(5))
