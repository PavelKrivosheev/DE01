/* 1. Напишите запрос, который выберет всех клиентов из таблицы Sales.Customer, у которых идентификатор территории больше 5, 
и отсортирует результаты по этому идентификатору в порядке убывания.

SELECT * 
FROM [Sales].[Customer]
WHERE TerritoryID > 5
ORDER BY TerritoryID DESC 
*/

/* 2. Выведите список из 10 самых дорогих продуктов из таблицы Production.Product, отсортировав их по ListPrice в порядке убывания. 
Отобразите ProductID, Name и ListPrice.

SELECT TOP 10 ProductID
		    , [Name]
	        , ListPrice
FROM [Production].[Product]
ORDER BY ListPrice DESC
*/

/* 3. Найдите всех сотрудников, фамилия которых начинается с буквы "M", из таблицы Person.Person. Отобразите BusinessEntityID, FirstName, LastName.

SELECT BusinessEntityID
     , FirstName
	 , LastName
FROM [Person].[Person]
WHERE LastName LIKE 'M%'
*/

/* 4. Создайте таблицу TopCustomers, которая будет содержать следующие поля: CustomerID, FirstName, LastName. 
После создания таблицы вставьте в неё данные о клиентах. Выведите данные из таблицы TopCustomers, отсортировав их по фамилии в алфавитном порядке

--Вариант с константой.

CREATE TABLE TopCustomers ( CustomerID INT
                          , FirstName VARCHAR(30)
						  , LastName VARCHAR(30))

INSERT INTO [dbo].[TopCustomers] (CustomerID, FirstName, LastName)
VALUES (1, 'Pavel', 'Krivosheev'),
	   (2, 'Ivan', 'Ivanov'),
	   (3, 'Petr', 'Petrov')
SELECT *
FROM [dbo].[TopCustomers]
ORDER BY LastName

--Вариант с забораом данных из другой таблицы.

CREATE TABLE TopCustomersNEW ( CustomerID INT
                             , FirstName VARCHAR(30)
						     , LastName VARCHAR(30))

--DROP TABLE [dbo].[TopCustomersNEW]
INSERT INTO [dbo].[TopCustomersNEW] (CustomerID, FirstName, LastName)
SELECT BusinessEntityID, FirstName, LastName
FROM [Person].[Person]
SELECT * 
FROM [dbo].[TopCustomersNEW]
ORDER BY LastName
*/

/* 5*. Напишите запрос, который отобразит среднюю сумму заказа (TotalDue) по каждому TerritoryID из таблицы Sales.SalesOrderHeader для всех заказов, 
где ShipDate больше OrderDate. Выведите TerritoryID и AverageOrderAmount.*/

-- ВАРИАНТ 1
/*
SELECT AVG(TotalDue) AS AveregeOrderAmount
	 , TerritoryID
FROM [Sales].[SalesOrderHeader]
WHERE ShipDate > OrderDate /* ТУТ ВПРИНЦИПЕ ВСЕ ЗАКАЗЫ ПОДХОДЯТ, ПОЭТОМУ ЭТА СТРОКА НАВЕРНО И НЕ НУЖНА*/
GROUP BY TerritoryID
ORDER BY TerritoryID
*/

-- ВАРИАНТ 2
/*
SELECT (SUM(TotalDue)) / (COUNT(TerritoryID)) AS AveregeOrderAmount
	 , TerritoryID
FROM [Sales].[SalesOrderHeader]
WHERE ShipDate > OrderDate 
GROUP BY TerritoryID
ORDER BY TerritoryID
*/

