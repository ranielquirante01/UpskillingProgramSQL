SELECT * INTO dbo.Product_28122022 FROM dbo.Product

DECLARE @CategoryName VARCHAR(255)

UPDATE dbo.Product_28122022
SET [ListPrice] = 
	CASE 
		WHEN @CategoryName IN ('Children Bicycles', 'Cyclocross Bicycles', 'Road Bikes') THEN [ListPrice] + ([ListPrice] * 1.2) 
		WHEN @CategoryName IN ('Comfort Bicycles', 'Cruisers Bicycles', 'Electric Bikes') THEN [ListPrice] + ([ListPrice] * 1.7) 
		WHEN @CategoryName IN ('Mountain Bikes') THEN [ListPrice] + ([ListPrice] * 1.4) 
		ELSE [ListPrice]
	END
FROM dbo.Product_28122022