import pandas as pd
import requests

#1 Напишите функцию, которая загружает данные из API и фильтрует их по заданному
#пользователем условию.

def dataApi():
    # Получение данных из публичного API
    url = 'http://universities.hipolabs.com/search?country=Belarus'  #Публичный API с данными об университетах Беларуси
    response = requests.get(url)
    # Проверка на успешный ответ и извлечение данных
    if response.status_code == 200:
        data = response.json()

        # Создаем DataFrame
        df = pd.DataFrame(data)

        # Поиск строк, где колонка 'name' содержит слово 'Gomel'
        filtered_df = df[df['name'].str.contains('Gomel', na=False)]

        #Сортировка отфильтрованного DataFrame по столбцу 'name'
        sorted_df = filtered_df.sort_values(by='name')

        #Замена значений None на Gomel
        sorted_df.fillna({'state-province': 'Gomel'}, inplace=True)

        #Записываем данные в Excel
        sorted_df.to_excel('univer_of_BY.xlsx', index=False)
        return print(f'Данные успешно сохранены в файл univer_of_BY.xlsx\n{sorted_df}')
    else:
        print(f"Ошибка при получении данных: {response.status_code}")

# Вызываем функцию
dataApi()

#2 Напишите программу, которая загружает данные из нескольких CSV-файлов, объединяет их,
#сортирует по нескольким столбцам и сохраняет результат в новый файл.

# Загружаем данные из файлов
df1 = pd.read_csv('Files/example.csv')
df2 = pd.read_csv('Files/example1.csv')

# Объединяем данные, перезаписываем индексы
df3 = pd.concat([df1,df2], axis=0).reset_index().drop('index', axis=1)

#Замена значений None на WA
df3.fillna({'State': 'WA'}, inplace=True)

# Сортируем по нескольким столбцам
sorted_df = df3.sort_values(by=['City','Job Title'])

# Записываем данные
sorted_df.to_csv('example3.csv', index=False)

print(f'Данные сохранены успешно в файл example3.csv!\n{sorted_df}')


