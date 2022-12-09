SELECT
	s.StoreName,
	YEAR(o.OrderDate) AS OrderYear,
	COUNT(o.OrderId) AS OrderCount
FROM
	dbo.[Order] o
	INNER JOIN dbo.Store s ON s.StoreId = o.StoreId
GROUP BY
	s.StoreName,
	YEAR(o.OrderDate)
ORDER BY
	s.StoreName,
	YEAR(o.OrderDate) DESC