WITH CTE AS (
	SELECT 
		b.BrandName, 
		p.ProductId, 
		p.ProductName,
		p.ListPrice
	FROM 
		dbo.[Product] p
		INNER JOIN dbo.Brand b ON b.BrandId = p.BrandId
), CTE2 AS (
	SELECT 
		ROW_NUMBER() OVER (PARTITION BY BrandName ORDER BY ListPrice DESC) AS RowNumber,
		*
	FROM
		CTE
)

SELECT 
	BrandName,
	ProductId,
	ProductName,
	ListPrice
FROM 
	CTE2
WHERE
	RowNumber BETWEEN 1 AND 5