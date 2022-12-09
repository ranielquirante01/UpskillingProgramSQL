SELECT
	p.ProductId, 
	p.ProductName, 
	b.BrandName, 
	c.CategoryName, 
	s.Quantity
FROM
	dbo.Product p
	INNER JOIN dbo.Stock s ON s.ProductId = p.ProductId
	INNER JOIN dbo.Brand b ON b.BrandId = p.BrandId
	INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId
WHERE
	p.ModelYear IN (2017, 2018) AND
	(s.StoreId) IN (
		SELECT
			StoreId
		FROM
			dbo.Store
		WHERE
			StoreName = 'Baldwin Bikes')
ORDER BY
	s.Quantity DESC, 
	p.ProductName, 
	b.BrandName, 
	c.CategoryName