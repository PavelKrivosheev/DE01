/*1. Подсчитайте общее количество заказов и среднюю сумму заказа по каждому году. 
Включите только те годы, где средняя сумма заказа превышает 2000. 
Добавьте категорию: "High Demand" для лет с более чем 500 заказами, "Medium Demand" для лет с 300-500 заказами и "Low Demand" для остальных. 
Укажите дату, количество заказов, среднюю сумму заказа и категорию.
Используйте таблицу Sales.SalesOrderHeader*/

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

/*2. Найдите общую сумму продаж и средний процент скидки по каждой категории продукта. 
Выберите только категории, где общая сумма продаж превышает 50,000. 
Добавьте категорию: "Top Category" для категорий с суммой продаж более 200,000, "Mid Category" для категорий с суммой от 100,000 до 200,000 и
"Low Category" для всех остальных. 
Укажите категорию, общую сумму продаж, средний процент скидки и категорию уровня продаж.
Используйте таблицы Sales.SalesOrderDetail, Production.Product, Production.ProductSubcategory, и Production.ProductCategory.*/

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

/*3. Подсчитайте среднюю стоимость заказа и общее количество заказов по каждому региону (StateProvince). 
Включите только регионы, где средняя стоимость заказа превышает 1500. Добавьте категорию:
"Expensive" для регионов со средней стоимостью заказа выше 3000, "Moderate" для стоимости от 2000 до 3000 и "Affordable" для остальных. 
Укажите регион, среднюю стоимость заказа, количество заказов и категорию.
Используйте таблицы Sales.SalesOrderHeader, Person.Address, и Person.StateProvince.*/

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

/*4. Найдите средний процент скидки и количество заказов для каждого дня недели. 
Включите только те дни, где количество заказов превышает 100. Добавьте категорию:
"Peak Day" для дней с более чем 300 заказами, "High Traffic" для 200-300 заказов и "Regular" для остальных. Укажите день недели, 
средний процент скидки, количество заказов и категорию.
Используйте таблицы Sales.SalesOrderHeader и Sales.SalesOrderDetail.*/

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
