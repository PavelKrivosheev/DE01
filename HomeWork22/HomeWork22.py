import pandas as pd
import pyodbc

#1 Создать в БД 2 таблицы, заполнить их тестовыми данными

# Создание соединения с локальной MS SQL базой данных с использованием аутентификации Windows
server = 'PISH\\SQLEXPRESS'  # Имя сервера
database = 'AdventureWorks2017'         # Имя базы данных

# Создаем строку подключения для Windows аутентификации

connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'

connection = pyodbc.connect(connection_string)
connection.autocommit = True
cursor = connection.cursor()

query1 = '''CREATE DATABASE Library'''

cursor.execute(query1)

cursor.execute('''USE  Library''')

# Создаем таблицы

table1 = ('''CREATE TABLE Books (
			BookID INT PRIMARY KEY,
			Title VARCHAR(255) NOT NULL,
			Author VARCHAR(255) NOT NULL,
			PublishedYear INT CHECK (PublishedYear > 1800))'''
          )
cursor.execute(table1)

table2 = ('''CREATE TABLE Borrowers (
			BorrowerID INT PRIMARY KEY,
			Name VARCHAR(255) NOT NULL,
			Email VARCHAR(255) UNIQUE)'''
          )
cursor.execute(table2)

table3 = (''' CREATE TABLE Loans (
			LoanID INT PRIMARY KEY,
			BookID INT NOT NULL,
			BorrowerID INT NOT NULL,
			LoanDate DATE NOT NULL,
			CONSTRAINT FK_Book FOREIGN KEY (BookID) REFERENCES Books(BookID)
				ON DELETE CASCADE,
			CONSTRAINT FK_Borrower FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
				ON DELETE CASCADE )'''
          )
cursor.execute(table3)


#Вставляем тестовые данные в таблицы

insert_table1 = ('''INSERT INTO Books 
			        VALUES  (1, 'Lolita', 'V.Nabokov', 1958),
				            (2, 'Anna_Karenina', 'L.Tolstoy', 1873),
				            (3, 'Moby_Dick', 'H.Melville', 1851)
				            ''')


cursor.execute(insert_table1)

insert_table2 = ('''INSERT INTO Borrowers (BorrowerID, Name, Email)
			VALUES
				(1, 'Ivan', 'Ivan@gmail.com'),
				(2, 'Olga', 'Olga@gmail.com'),
				(3, 'Petr', 'Petr@gmail.com')
				'''
            )


cursor.execute(insert_table2)

insert_table3 = ('''INSERT INTO Loans (LoanID, BookID, BorrowerID, LoanDate)
			VALUES
				(1, 2, 1, '20241101' ),
				(2, 1, 3, '20241103'),
				(3, 3, 2, '20241102')
				'''
                 )

cursor.execute(insert_table3)


# Закрываем подключение
connection.close()



