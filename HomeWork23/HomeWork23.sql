/*
Напишите SQL-запрос, который для каждой категории товаров показывает:
Название категории.
Общую сумму продаж (количество × цена).
Количество проданных товаров.
Среднюю цену проданных товаров.
Отсортируйте результат по убыванию общей суммы продаж.
Задание:
Напишите исходный запрос для решения задачи.
Проверьте его производительность, используя данные объемом не менее 100 000 записей в таблицах order_items и products.
Оптимизируйте запрос:
Используйте индексы.
Проверьте план выполнения (EXPLAIN).
Перепишите запрос так, чтобы он выполнялся быстрее.*/

CREATE INDEX idx_products_id ON order_items(product_id)

CREATE INDEX idx_quantity ON order_items(quantity)

CREATE INDEX idx_cat_name ON categories(name)

CREATE INDEX idx_price ON products(price);


WITH SumQuantityCTE AS (
  SELECT 
	product_id, SUM(quantity) AS SumQuantity
	FROM [dbo].[order_items]
	GROUP BY product_id)

SELECT dc.name AS NameCategory
		, SUM(price*SumQuantity) AS TotaAmountlSales
		, SUM(SumQuantity) AS ProductItems
		, AVG(price) AS AveragePrice
FROM [dbo].[products] dp
JOIN SumQuantityCTE sq ON sq.product_id = dp.id
JOIN [dbo].[categories] dc ON dc.id = dp.category_id
GROUP BY dc.name
ORDER BY AVG(price) DESC






