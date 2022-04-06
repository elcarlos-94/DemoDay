import pandas as pd


def reading_db():
    db = 'C:/Users/Carlos Alvarez/Desktop/DemoDay/CSV/games-data-exp.csv'
    return db


def deleting_data():
    replacing = ['2-Jan', '3-Jan', '4-Jan', '5-Jan', '8-Jan', '10-Jan',
                 '12-Jan', '16-Jan', '24-Jan', 'Jan-64', 'Jan-32']
    return replacing


def adding_data():
    replacing = ['2 players', '3 players', '4 players', '5 players',
                 '8 players', '10 players', '12 players', '16 players',
                 '24 players', '64 players', '32 players']
    return replacing


# Set data frame

df = pd.read_csv(reading_db(), sep=',')
df.set_index('name')
pd.set_option('display.max_columns', df.shape[0] + 1)
# print(df)

# First look on NA in table
# print(df.isna().sum(axis=0))

# Clean NA in the players column
df_clean_na = df.copy()
df_clean_na['players'] = df_clean_na['players'].fillna(0)

# Second look on NA in table
# print(df_clean_na.isna().sum(axis=0))

# Extract year from "r-date".
df_clean_na['year'] = pd.DatetimeIndex(df_clean_na['r-date']).year

pd.set_option('display.max_columns', df_clean_na.shape[0] + 1)
# print(df_clean_na.head(5))  # Show at least 5 games.

df_genre = df_clean_na['genre'].str.split(',', expand=True)
df_genre_dropped = df_genre.dropna(axis=1, how='any')
# print(df_genre_dropped.head(5)) # Show only one genre per game

df_2 = pd.concat([df_clean_na, df_genre_dropped], axis=1)
df_2_drop = df_2.drop(columns=['genre'])
df_2_renamed = df_2_drop.rename(columns={
    'r-date': 'release_date',
    0: 'genre'
})
# print(df_2_renamed.head(5))

df_2_renamed['players'] = df_2_renamed['players'].replace(deleting_data(), adding_data())

df_2_renamed.index += 1
print(df_2_renamed)

df_2_renamed.to_csv(r'C:/Users/Carlos Alvarez/Desktop/DemoDay/Modulo3/games_rewritten.csv', index=True, header=True)
