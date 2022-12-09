DECLARE @StoreName varchar(255), @OrderYear varchar(4), @OrderCount int

DECLARE StoreOrderYearCursor CURSOR FOR

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

OPEN StoreOrderYearCursor

FETCH NEXT FROM StoreOrderYearCursor
INTO @StoreName, @OrderYear, @OrderCount

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @StoreName + ' ' + @OrderYear + ' ' + CAST(@OrderCount AS varchar(10))

FETCH NEXT FROM StoreOrderYearCursor
INTO @StoreName, @OrderYear, @OrderCount

END

CLOSE StoreOrderYearCursor;
DEALLOCATE StoreOrderYearCursor;