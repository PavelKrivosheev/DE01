#1 Создать в БД 2 таблицы, заполнить их тестовыми данными
#2 Записать данные из этих двух таблиц в эксель файл с помощью создания python скрипта.
#3 Создать датасет, который мы запишем в файл двумя способами: с помощью JOIN в запросе,
#с помощью создания двух отдельных датафреймов с последующим их объединением с помощью команды merge

import pandas as pd
from sqlalchemy import create_engine
import urllib
import pyodbc

#1 Создать в БД 2 таблицы, заполнить их тестовыми данными

# Создание соединения с локальной MS SQL базой данных с использованием аутентификации Windows
server = 'PISH\SQLEXPRESS'  # Имя сервера
database = 'AdventureWorks2017'         # Имя базы данных

# Создаем строку подключения для Windows аутентификации
params = urllib.parse.quote_plus(f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes')

engine = create_engine(f'mssql+pyodbc:///?odbc_connect={params}')

# Создаем DataFrame
StudentTable = {
    'student_Id' : [1, 2, 3, 4],
    'name' : ['Alice', 'Bob', 'Charlie', 'Dave'],
    'course_Id' : [101, 102, 101, 103]
}
CourseTable = {
    'course_Id' : [101, 102, 103],
    'course_name' : ['Math', 'Physics', 'Chemistry'],
    'teacher' : ['Mr.Brown', 'Dr.Green', 'Mr.White']
}
df1 = pd.DataFrame(StudentTable)
df2 = pd.DataFrame(CourseTable)

# Вставка данных в таблицы
df1.to_sql('StudentTable', con=engine, if_exists='append', index=False)
df2.to_sql('CourseTable', con=engine, if_exists='append', index=False)

print("Данные успешно вставлены в таблицы.")


#2 Записать данные из этих двух таблиц в эксель файл с помощью создания python скрипта.

# Параметры подключения к локальной базе данных MS SQL Server
server = 'PISH\SQLEXPRESS'  # Имя сервера
database = 'AdventureWorks2017'         # Имя базы данных

# Строка подключения с использованием Windows Authentication
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'

#  Подключение к базе данных
connection = pyodbc.connect(connection_string)
query1 = 'SELECT * FROM [dbo].[StudentTable]'
query2 = 'SELECT * FROM [dbo].[CourseTable]'

# Загрузка данных в DataFrame
df1 = pd.read_sql(query1, connection)
df2 = pd.read_sql(query2, connection)

# Закрытие подключения
connection.close()
# Записываем данные в файл.
df3 = pd.concat([df1,df2], axis=0)
df3.to_excel('NewFile.xlsx', index=False)

print('Данные успешно записаны в файл NewFile.xlsx')

#3 Создать датасет, который мы запишем в файл двумя способами: с помощью JOIN в запросе,
#с помощью создания двух отдельных датафреймов с последующим их объединением с помощью команды merge

#СПОСОБ 1 с помощью JOIN в запросе

# Параметры подключения к локальной базе данных MS SQL Server
server = 'PISH\SQLEXPRESS'  # Имя сервера
database = 'AdventureWorks2017'         # Имя базы данных

# Строка подключения с использованием Windows Authentication
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'

# Подключение к базе данных
connection = pyodbc.connect(connection_string)

# Создаем новый датасет
query1 = """
    SELECT *
    FROM [dbo].[StudentTable] st
    JOIN [dbo].[CourseTable] ct ON ct.Course_ID = st.Course_Id
    ORDER BY st.Course_Id
"""

# Загрузка данных в DataFrame
df1 = pd.read_sql(query1, connection)

# Закрытие подключения
connection.close()

# Записываем данные в файл.
df1.to_excel('NewFile1.xlsx', index=False)

print('Данные успешно записаны в файл NewFile1.xlsx')

# СПОСОБ 2 с помощью команды merge

# Параметры подключения к локальной базе данных MS SQL Server
server = 'PISH\SQLEXPRESS'  # Имя сервера
database = 'AdventureWorks2017'         # Имя базы данных

# Строка подключения с использованием Windows Authentication
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'

# Подключение к базе данных
connection = pyodbc.connect(connection_string)
query1 = 'SELECT * FROM [dbo].[StudentTable]'
query2 = 'SELECT * FROM [dbo].[CourseTable]'

# Загрузка данных в DataFrame
df1 = pd.read_sql(query1, connection)
df2 = pd.read_sql(query2, connection)

# Закрытие подключения
connection.close()

# Создаем новый датасет.
df3 = pd.merge(df1, df2, how='inner', on='Course_Id')

# Сортировка по колонке Course_Id
df3 = df3.sort_values(by='Course_Id')

# Записываем данные в файл.
df3.to_excel('NewFile2.xlsx', index=False)

print('Данные успешно записаны в файл NewFile2.xlsx')


