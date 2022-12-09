SELECT 
	StoreId, StoreName
FROM 
	dbo.Store
WHERE
	(StoreId) NOT IN (
		SELECT 
			StoreId
		FROM
			dbo.[Order])
