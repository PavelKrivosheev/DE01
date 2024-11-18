/* 1. �������� ������, ������� ������� ���� �������� �� ������� Sales.Customer, � ������� ������������� ���������� ������ 5, 
� ����������� ���������� �� ����� �������������� � ������� ��������.

SELECT * 
FROM [Sales].[Customer]
WHERE TerritoryID > 5
ORDER BY TerritoryID DESC 
*/

/* 2. �������� ������ �� 10 ����� ������� ��������� �� ������� Production.Product, ������������ �� �� ListPrice � ������� ��������. 
���������� ProductID, Name � ListPrice.

SELECT TOP 10 ProductID
		    , [Name]
	        , ListPrice
FROM [Production].[Product]
ORDER BY ListPrice DESC
*/

/* 3. ������� ���� �����������, ������� ������� ���������� � ����� "M", �� ������� Person.Person. ���������� BusinessEntityID, FirstName, LastName.

SELECT BusinessEntityID
     , FirstName
	 , LastName
FROM [Person].[Person]
WHERE LastName LIKE 'M%'
*/

/* 4. �������� ������� TopCustomers, ������� ����� ��������� ��������� ����: CustomerID, FirstName, LastName. 
����� �������� ������� �������� � �� ������ � ��������. �������� ������ �� ������� TopCustomers, ������������ �� �� ������� � ���������� �������

--������� � ����������.

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

--������� � �������� ������ �� ������ �������.

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

/* 5*. �������� ������, ������� ��������� ������� ����� ������ (TotalDue) �� ������� TerritoryID �� ������� Sales.SalesOrderHeader ��� ���� �������, 
��� ShipDate ������ OrderDate. �������� TerritoryID � AverageOrderAmount.*/

-- ������� 1
/*
SELECT AVG(TotalDue) AS AveregeOrderAmount
	 , TerritoryID
FROM [Sales].[SalesOrderHeader]
WHERE ShipDate > OrderDate /* ��� ��������� ��� ������ ��������, ������� ��� ������ ������� � �� �����*/
GROUP BY TerritoryID
ORDER BY TerritoryID
*/

-- ������� 2
/*
SELECT (SUM(TotalDue)) / (COUNT(TerritoryID)) AS AveregeOrderAmount
	 , TerritoryID
FROM [Sales].[SalesOrderHeader]
WHERE ShipDate > OrderDate 
GROUP BY TerritoryID
ORDER BY TerritoryID
*/

