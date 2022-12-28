CREATE PROCEDURE dbo.FilterProduct @ProductName nvarchar(255) = NULL, @BrandId int = NULL, @CategoryId int  = NULL, @ModelYear smallint = NULL, @PageNumber int = 1, @PageSize int = 10
AS
	SELECT 
		*
	FROM
		dbo.Product
	WHERE 
		ProductName LIKE '%' + ISNULL(@ProductName, ProductName) + '%' AND
		BrandId = ISNULL(@BrandId, BrandId) AND
		CategoryId = ISNULL(@CategoryId, CategoryId) AND
		ModelYear = ISNULL(@ModelYear, ModelYear)
	ORDER BY
		ModelYear DESC,
		ListPrice DESC,
		ProductName DESC
	OFFSET @PageSize * (@PageNumber - 1)  ROWS 
	FETCH NEXT @PageSize ROWS ONLY
GO