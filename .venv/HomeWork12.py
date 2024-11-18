import pandas as pd
import json
import requests
#1 Напишите функцию, которая принимает JSON-строку и выводит данные в виде словаря Python.

def myFunc(name):
   name = dict(name)
   return name

with open('sample1.json', 'r') as myFile:
    n = json.load(myFile)

print(myFunc(n))
print(type(n))

#2 Напишите код, который загружает данные из Excel-файла, подсчитывает количество строк и
#выводит результат.

df = pd.read_excel('Files/myExcel.xlsx')
n = df.shape
print(n[0])

#3 Напишите функцию, которая загружает данные из API и обрабатывает их, выводя только
#нужные поля. (по аналогии с примером, который мы смотрели на уроке)

def apiFunc(): # ???Не очень понятно какие здесь должны передаваться аргументы???

    #URL для запроса к API для получения списка всех университетов Беларуси
    url = c

    # Отправляем запрос к API
    response = requests.get(url)

    #Проверка на успешный ответ
    if response.status_code == 200:
        #Извлечение данных
        data = response.json()
        # Т.к. в строке выше мы получаем список словарей, то на следующей строке выбираем конкретный словарь
        myDict = data[18] #Выбираем конкретный университет(словарь)

        # Создаем DataFrame
        univer_df = pd.DataFrame([{
            'Domens': myDict['domains'],
            'Name': myDict['name'],
            'Web pages': myDict['web_pages'],
            'Country': myDict['country'],
        }])
            #print(univer_df)

        # Записываем данные в Excel
        univer_df.to_excel('univer_of_BY.xlsx', index=False)

        print("Данные успешно сохранены в файл univer_of_BY.xlsx")
    else:
        print(f"Ошибка при получении данных: {response.status_code}")

apiFunc()

# def dataApi():
#     # Шаг 1: Получение данных из публичного API
#     url = 'http://universities.hipolabs.com/search?country=Belarus'  #Публичный API с данными об университетах Беларуси
#     response = requests.get(url)
#     data = response.json()
#     return data
# # Создаем DataFrame
# df = pd.DataFrame([{
#     'NAME': i['name'],
#     'WEBPAGE': i['web_pages'],
#     'COUNTRY': i['country'],
#     }
#     for i in dataApi()
#     ])
# #    df = pd.DataFrame(data)
# #    print(data)
#
#
#
# print(df)


#4 Напишите программу, которая загружает данные из нескольких Excel файлов,
#объединяет их и сохраняет в новый файл.

df1 = pd.read_excel('Files/myExcel.xlsx')
df2 = pd.read_excel('Files/newExcel.xlsx')

df3 = pd.concat([df1,df2], axis=0)
df3.to_excel('Files/NewFile.xlsx', index=False)

print(df3)

#5 Напишите код, который загружает данные из API, выполняет предварительную обработку
#(например, фильтрацию) и сохраняет результат в Excel-файл.

#URL для запроса к API для получения списка всех университетов Беларуси
url = 'http://universities.hipolabs.com/search?country=Belarus'

# Отправляем запрос к API
response = requests.get(url)

#Проверка на успешный ответ
if response.status_code == 200:
    #Извлечение данных
    data = response.json()

    #print(data)
    # Т.к. запрос возвращается в формате списка,
    # преобразовываем список в словарь и добавляем под каждый ключ список значений.
    myDict1 = {}
    myDict1['domains'] = []
    myDict1['name'] = []
    myDict1['web_pages'] = []
    myDict1['country'] = []
    for i in data:
        for k in i:
            myDict1['domains'].append(i['domains'])
            myDict1['name'].append(i['name'])
            myDict1['web_pages'].append(i['web_pages'])
            myDict1['country'].append(i['country'])
            break

    # Создаем DataFrame
    df = pd.DataFrame({
             'Domens': myDict1['domains'],
             'Name': myDict1['name'],
             'Web pages': myDict1['web_pages'],
             'Country': myDict1['country']
         })

    # Сортировка по определенной колонке (по убыванию)
    univer_df = df.sort_values(by='Name', ascending=False)

    # Записываем данные в Excel
    univer_df.to_excel('univer1_of_BY.xlsx', index=False)

    print("Данные успешно сохранены в файл univer1_of_BY.xlsx")
else:
    print(f"Ошибка при получении данных: {response.status_code}")


