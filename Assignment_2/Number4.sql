WITH CTE AS (SELECT
	YEAR(o.OrderDate) as OrderYear,
	MONTH(o.OrderDate) as OrderMonth,
	p.ProductName,
	SUM(oi.Quantity) as TotalQuantity
FROM
	dbo.[Order] o
	INNER JOIN dbo.Store s ON s.StoreId = o.StoreId
	INNER JOIN dbo.OrderItem oi ON oi.OrderId = o.OrderId
	INNER JOIN dbo.Product p ON p.ProductId = oi.ProductId
GROUP BY
	YEAR(o.OrderDate),
	MONTH(o.OrderDate),
	p.ProductName
), CTE2 AS (
	SELECT TOP 1 WITH TIES
		*,
		DENSE_RANK() OVER (PARTITION BY OrderYear, OrderMonth ORDER BY TotalQuantity DESC) AS RowNumber
	FROM 
		CTE
	ORDER BY
		DENSE_RANK() OVER (PARTITION BY OrderYear, OrderMonth ORDER BY TotalQuantity DESC)
)

SELECT
	OrderYear,
	OrderMonth,
	ProductName,
	TotalQuantity
FROM 
	CTE2
GROUP BY
	OrderYear,
	OrderMonth,
	ProductName,
	TotalQuantity
ORDER BY
	OrderYear,
	OrderMonth