IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Product_20221128')
BEGIN
	SELECT 
		* 
	INTO 
		Product_20221128 
	FROM 
		dbo.Product  
	WHERE 
		ModelYear != 2016
END
GO

SELECT 
	p.ProductId,
	p.ProductName,
	p.BrandId,
	p.CategoryId,
	p.ModelYear,
	CAST(((p.ListPrice * .20) + p.ListPrice) as decimal(10,2)) as ListPrice
FROM 
	dbo.Product_20221128 p
	INNER JOIN dbo.Brand b ON p.BrandId = b.BrandId
WHERE 
	b.BrandName IN ('Heller','Sun Bicycles')

	

SELECT 
	p.ProductId,
	p.ProductName,
	p.BrandId,
	p.CategoryId,
	p.ModelYear,
	CAST(((p.ListPrice * .10) + p.ListPrice) as decimal(10,2)) as ListPrice
FROM 
	dbo.Product_20221128 p
	INNER JOIN dbo.Brand b ON p.BrandId = b.BrandId
WHERE 
	b.BrandName NOT IN ('Heller','Sun Bicycles')

