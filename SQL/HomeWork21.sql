/*����: �������� �������� ���������, ������� ����������� ���������� ������� �� ������ � ������� ��� ������� ������ ����� ����������.
��������� ������:
���������� ����� ���������� ������� ������ �� ������.
��������� ��������� � ������� ProductInventorySummary, ��� ����� ��������� ProductID � TotalQuantity (����� ���������� ������� ������ �� ������).
��� ��������� ������ ������������ ���� WHILE.
������������ �������:
Production.ProductInventory: �������� ������ � ������� ������� �� ������, ������� ProductID � Quantity.
������:
��� ������� ������ ����� ��������� ����� ���������� � ������ ���� ������� � ������� ProductInventory.
������� ������� ��� �������� �����������.
�����, ��������� ����, ��������� ������� � ������ ������� ��� ������� ������.*/

-- �������1. ������� ������ �� ���� ���������
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



-- �������2. ������� ������ �� ��������� �������� ����� ��� ID.

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