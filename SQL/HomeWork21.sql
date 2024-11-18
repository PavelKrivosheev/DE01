/*Цель: Написать хранимую процедуру, которая анализирует количество товаров на складе и выводит для каждого товара общее количество.
Процедура должна:
Подсчитать общее количество каждого товара на складе.
Результат сохранить в таблице ProductInventorySummary, где будут храниться ProductID и TotalQuantity (общее количество данного товара на складе).
Для обработки данных использовать цикл WHILE.
Используемые таблицы:
Production.ProductInventory: Содержит данные о наличии товаров на складе, включая ProductID и Quantity.
Логика:
Для каждого товара нужно вычислить общее количество с учетом всех записей в таблице ProductInventory.
Создаем таблицу для хранения результатов.
Затем, используя цикл, обновляем таблицу с общими данными для каждого товара.*/

-- Вариант1. Выводим данные по всем продуктам
CREATE TABLE ProductInventorySummary  (ProductID INT, TotalQuantity INT)

CREATE PROCEDURE dbo.MyProcedure 
AS
BEGIN

DECLARE @MyVar INT
SET @MyVar = 0
WHILE @MyVar < 1000
BEGIN
INSERT INTO ProductInventorySummary (ProductID, TotalQuantity)
SELECT ProductID, SUM(Quantity)
FROM [Production].[ProductInventory] 
WHERE ProductID = @MyVar
GROUP BY ProductID
SELECT @MyVar +=1
END

SELECT*
FROM ProductInventorySummary

DELETE ProductInventorySummary

END

EXEC dbo.MyProcedure



-- Вариант2. Выводим данные по заданному продукту через его ID.

CREATE TABLE ProductInventorySummary  (ProductID INT, TotalQuantity INT)

CREATE PROCEDURE dbo.MyProcedure @PrID INT
AS
BEGIN

DECLARE @MyVar INT
SET @MyVar = 0
WHILE @MyVar < 1000 AND @PrID < 1000
BEGIN
INSERT INTO ProductInventorySummary (ProductID, TotalQuantity)
SELECT ProductID, SUM(Quantity)
FROM [Production].[ProductInventory] 
WHERE ProductID = @MyVar AND ProductID = @PrID
GROUP BY ProductID
SELECT @MyVar +=1
END

SELECT*
FROM ProductInventorySummary

DELETE ProductInventorySummary

END

EXEC dbo.MyProcedure @PrID = 1