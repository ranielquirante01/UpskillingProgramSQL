WITH CTE as
(
SELECT
	p.ProductName,
	SUM(oi.Quantity) as TotalQuantity
FROM
	dbo.[Order] o
	INNER JOIN dbo.Store s ON s.StoreId = o.StoreId
	INNER JOIN dbo.OrderItem oi ON oi.OrderId = o.OrderId
	INNER JOIN dbo.Product p ON p.ProductId = oi.ProductId
WHERE
	s.[State] = 'TX'
GROUP BY
	p.ProductName
HAVING
	SUM(oi.Quantity) > 10

UNION ALL

SELECT
	REPLACE(c.CategoryName, 'Bikes', 'Bicycles') as CategoryName,
	SUM(oi.Quantity) as TotalQuantity
FROM
	dbo.[Order] o
	INNER JOIN dbo.Store s ON s.StoreId = o.StoreId
	INNER JOIN dbo.OrderItem oi ON oi.OrderId = o.OrderId
	INNER JOIN dbo.Product p ON p.ProductId = oi.ProductId
	INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId
GROUP BY
	c.CategoryName)

SELECT 
	* 
FROM 
	CTE
ORDER BY
	TotalQuantity DESC