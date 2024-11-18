/*1. �������� ������, ������� � ������� ����� � ���������� ������� ������� ��������� ��� ��������� �����.*/

--CREATE TABLE MultiTable (Result INT) -- ������� �������, ���� ����� �������� ������

DECLARE @MyVar1 INT, @MyVar2 INT -- ������ ����������
SELECT @MyVar1 = 6, @MyVar2 = 1 -- ������ �������� ����������

WHILE @MyVar2 < 11 -- ������� ���� ��� ������� ��������� �� 10 ������������ 
BEGIN

INSERT INTO MultiTable (Result) --������� ������ � �������
SELECT @MyVar1 * @MyVar2

SELECT @MyVar2 += 1 -- �������������� ����������

END

SELECT * 
FROM [dbo].[MultiTable]

DELETE [dbo].[MultiTable]

/*2. �������: HumanResources.Employee
�������� ������: � ������� ���������� ������� ���� �����������, 
������� �������� � �������� ������ ��������� ���������� ���.*/

DECLARE @Year INT
SELECT @Year = 15

SELECT BusinessEntityID
	 , JobTitle
	 , HireDate
     , (YEAR(GETDATE()) - YEAR(he.HireDate)) AS YearWork
FROM [HumanResources].[Employee] he
WHERE(YEAR(GETDATE()) - YEAR(he.HireDate)) > @Year
ORDER BY YearWork DESC

/*3. �������: Sales.Customer, Sales.SalesOrderHeader
�������� ������: �������� ������ � ���������� � �����������, ����� ����� ���� ��������, 
������� ��������� � ����� ������ �������� ����� �� ��� ���� ������.*/

DECLARE @AmountSum INT
SET @AmountSum = 2000

SELECT sc.CustomerID, SUM(soh.TotalDue) AS TotalDue
FROM [Sales].[Customer] sc 
JOIN [Sales].[SalesOrderHeader] soh ON soh.CustomerID = sc.CustomerID
GROUP BY sc.CustomerID
HAVING 
SUM(soh.TotalDue) > @AmountSum
/*(SELECT SUM(soh1.TotalDue) AS AmountSum 
					FROM [Sales].[Customer] sc1 
					JOIN [Sales].[SalesOrderHeader] soh1 ON soh1.CustomerID = sc1.CustomerID 
					WHERE sc1.CustomerID = sc.CustomerID
					GROUP BY sc1.CustomerID) > @AmountSum*/
ORDER BY SUM(soh.TotalDue) 
			
/*4. �������:
Sales.SalesOrderDetail
Sales.SalesOrderHeader
Production.Product
�������� ������: �������� ������, ������� � �������������� ���������� 
� ���������� ���������� ����� ����������� ����� (�� ���������� ��������� ������) ��� ������� ����.*/

DECLARE @FavProd INT 
SET @FavProd = 1000

SELECT   pp.Name AS ProductName,
         res.YearDate,
         res.SumQty 
FROM [Production].[Product] pp
JOIN (  SELECT SUM(sod.OrderQty) AS SumQty, YEAR(soh.OrderDate) AS YearDate, sod.ProductID
		FROM [Sales].[SalesOrderDetail] sod
		JOIN [Sales].[SalesOrderHeader] soh ON soh.SalesOrderID = sod.SalesOrderID
		GROUP BY YEAR(soh.OrderDate), sod.ProductID) AS res ON res.ProductID = pp.ProductID 
WHERE res.SumQty = (
        SELECT 
            MAX(SumQty1)
        FROM 
            (SELECT 
                SUM(sod.OrderQty) AS SumQty1
             FROM 
                Sales.SalesOrderDetail sod
             JOIN 
                Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
             WHERE 
                YEAR(soh.OrderDate) = res.YearDate
             GROUP BY 
                sod.ProductID
            ) AS res2 
    )
ORDER BY 
    res.YearDate