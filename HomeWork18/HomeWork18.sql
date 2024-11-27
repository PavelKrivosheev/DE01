/*1. ����������� ����� ���������� ������� � ������� ����� ������ �� ������� ����. 
�������� ������ �� ����, ��� ������� ����� ������ ��������� 2000. 
�������� ���������: "High Demand" ��� ��� � ����� ��� 500 ��������, "Medium Demand" ��� ��� � 300-500 �������� � "Low Demand" ��� ���������. 
������� ����, ���������� �������, ������� ����� ������ � ���������.
����������� ������� Sales.SalesOrderHeader*/

SELECT COUNT(1) AS TotalOrders
 	,  AVG(TotalDue) AS AvgTotal
	,  YEAR(OrderDate) AS DateYear 
	, CASE
	  WHEN COUNT(SalesOrderID) > 12000
	  THEN 'High Demand'
	  WHEN COUNT(SalesOrderID) > 3000
	  THEN 'Medium Demand'
	  ELSE 'Low Demand'
	  END AS 'Demand'
FROM [Sales].[SalesOrderHeader]
GROUP BY YEAR(OrderDate)
HAVING AVG(TotalDue) > 2000
ORDER BY YEAR(OrderDate)

/*2. ������� ����� ����� ������ � ������� ������� ������ �� ������ ��������� ��������. 
�������� ������ ���������, ��� ����� ����� ������ ��������� 50,000. 
�������� ���������: "Top Category" ��� ��������� � ������ ������ ����� 200,000, "Mid Category" ��� ��������� � ������ �� 100,000 �� 200,000 �
"Low Category" ��� ���� ���������. 
������� ���������, ����� ����� ������, ������� ������� ������ � ��������� ������ ������.
����������� ������� Sales.SalesOrderDetail, Production.Product, Production.ProductSubcategory, � Production.ProductCategory.*/

SELECT  ppc.[Name] AS NameCategoru
	  , SUM(sso.LineTotal) AS TotalPrice
	  , AVG(sso.UnitPriceDiscount) AS AvgDisc
	  , CASE 
	    WHEN SUM(sso.LineTotal) > 50000000
	    THEN 'Top Category'
	    WHEN SUM(sso.LineTotal) > 10000000
	    THEN 'Mid Category'
	    ELSE 'Low Category'
	    END AS 'SaleLevelCategory'
FROM [Production].[ProductCategory] ppc
JOIN [Production].[ProductSubcategory] pps ON pps.ProductCategoryID = ppc.ProductCategoryID
JOIN [Production].[Product] pp ON pp.ProductSubcategoryID = pps.ProductSubcategoryID 
JOIN [Sales].[SalesOrderDetail] sso ON sso.ProductID = pp.ProductID
GROUP BY ppc.ProductCategoryID, ppc.[Name]
HAVING SUM(sso.LineTotal) > 50000
ORDER BY SUM(sso.LineTotal) DESC

/*3. ����������� ������� ��������� ������ � ����� ���������� ������� �� ������� ������� (StateProvince). 
�������� ������ �������, ��� ������� ��������� ������ ��������� 1500. �������� ���������:
"Expensive" ��� �������� �� ������� ���������� ������ ���� 3000, "Moderate" ��� ��������� �� 2000 �� 3000 � "Affordable" ��� ���������. 
������� ������, ������� ��������� ������, ���������� ������� � ���������.
����������� ������� Sales.SalesOrderHeader, Person.Address, � Person.StateProvince.*/

SELECT AVG(soh.TotalDue) AS AvgTotal
	 , COUNT(1) AS TotalOrder
	 , psp.Name
	 , CASE 
	    WHEN AVG(soh.TotalDue) > 3000
	    THEN 'Expensive'
	    WHEN AVG(soh.TotalDue) > 2000
	    THEN 'Moderate'
	    ELSE 'Affordable'
	    END AS 'Category'
FROM Sales.SalesOrderHeader soh
JOIN [Person].[Address] pa ON pa.AddressID = soh.BillToAddressID
JOIN [Person].[StateProvince] psp ON psp.StateProvinceID = pa.StateProvinceID
GROUP BY psp.[Name]
HAVING AVG(soh.TotalDue) > 1500
ORDER BY AVG(soh.TotalDue) DESC

/*4. ������� ������� ������� ������ � ���������� ������� ��� ������� ��� ������. 
�������� ������ �� ���, ��� ���������� ������� ��������� 100. �������� ���������:
"Peak Day" ��� ���� � ����� ��� 300 ��������, "High Traffic" ��� 200-300 ������� � "Regular" ��� ���������. ������� ���� ������, 
������� ������� ������, ���������� ������� � ���������.
����������� ������� Sales.SalesOrderHeader � Sales.SalesOrderDetail.*/

SELECT *
FROM [Sales].[SalesOrderHeader]
SELECT * 
FROM [Sales].[SalesOrderDetail]


SELECT datename(WEEKDAY, soh.OrderDate) AS DateOfWeek
	,  AVG(sod.UnitPriceDiscount) AS AvgDiscount
	,  COUNT(soh.SalesOrderID) AS TotalOrders
	, CASE
	  WHEN COUNT(soh.SalesOrderID) > 20000
	  THEN 'Peak Day'
	  WHEN COUNT(soh.SalesOrderID) > 15000
	  THEN 'High Traffic'
	  ELSE 'Regular'
	  END AS 'TrafficCategori'
FROM [Sales].[SalesOrderHeader] soh
JOIN [Sales].[SalesOrderDetail] sod ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY datename(WEEKDAY, OrderDate)
HAVING COUNT(soh.SalesOrderID) > 100
ORDER BY COUNT(soh.SalesOrderID) DESC
