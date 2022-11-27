SELECT 
	CustomerId, 
	COUNT(CustomerId) as OrderCount
FROM 
	dbo.[Order] 
WHERE 
		ShippedDate IS NULL 
	AND
		OrderDate BETWEEN '2017-01-01' AND '2018-12-31'
	AND
		(CustomerId) IN (
		SELECT 
			CustomerId
		FROM
			dbo.[Order]
		WHERE 
				ShippedDate IS NULL
			AND
				OrderDate BETWEEN '2017-01-01' AND '2018-12-31'
		GROUP BY
			CustomerId
		HAVING
			COUNT(CustomerId) > 1) 
GROUP BY
	CustomerId