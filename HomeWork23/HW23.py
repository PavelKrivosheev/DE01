import pandas as pd
import pyodbc
from sqlalchemy import create_engine

# Подключаемся к сереверу
server = 'PISH\\SQLEXPRESS'  # Имя сервера
database = 'AdventureWorks2017'         # Имя базы данных

# Создаем строку подключения для Windows аутентификации
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'

connection = pyodbc.connect(connection_string)

connection.autocommit = True

cursor = connection.cursor()

query1 = '''CREATE DATABASE OnlineStore'''

cursor.execute(query1)

cursor.execute('''USE  OnlineStore''')

table_categories = ( ''' CREATE TABLE categories(
                        id INT PRIMARY KEY,
                        name VARCHAR(50) NOT NULL)
                        ''')
cursor.execute(table_categories)

table_products = (''' CREATE TABLE products (
                    id INT PRIMARY KEY,
                    name VARCHAR(50) ,
                    category_id INT NOT NULL,
                    price DECIMAL(5,2) ,
                    CONSTRAINT FK_category_id FOREIGN KEY (category_id) REFERENCES categories(id)
				        ON DELETE CASCADE)
				    ''')
cursor.execute(table_products)

table_orders = (''' CREATE TABLE orders (
                    id INT PRIMARY KEY,
                    customer_id INT NOT NULL,
                    order_date DATE NOT NULL) 
                ''')
cursor.execute(table_orders)

table_order_items = (''' CREATE TABLE order_items(
                        order_id INT NOT NULL,
                        product_id INT NOT NULL,
                        quantity INT NOT NULL,
                        CONSTRAINT FK_order_id FOREIGN KEY (order_id) REFERENCES orders(id)
				            ON DELETE CASCADE,
				        CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES products(id)
				            ON DELETE CASCADE)
                    ''')
cursor.execute(table_order_items)


# Параметры подключения
server = 'PISH\\SQLEXPRESS'  # Например, 'localhost' или '127.0.0.1'
database = 'OnlineStore'  # Название вашей базы данных

# Строка подключения
connection_string = f'mssql+pyodbc://{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server'

# Подключение к базе данных
engine = create_engine(connection_string)

df1 = pd.read_csv('Q:/DE01/MyPy/categories.csv')
df2 = pd.read_csv('Q:/DE01/MyPy/products.csv')
df3 = pd.read_csv('Q:/DE01/MyPy/orders.csv')
df4 = pd.read_csv('Q:/DE01/MyPy/order_items.csv')



df1.to_sql('categories',con=engine, if_exists='append', index=False)
df2.to_sql('products', con=engine, if_exists='append', index=False)
df3.to_sql('orders', con=engine, if_exists='append', index=False)
df4.to_sql('order_items',con=engine,if_exists='append', index=False)
