SELECT 
	SalesYear,
	COALESCE(Jan,0) Jan,
	COALESCE(Feb,0) Feb,
	COALESCE(Mar,0) Mar,
	COALESCE(Apr,0) Apr,
	COALESCE(May,0) May,
	COALESCE(Jun,0) Jun,
	COALESCE(Jul,0) Jul,
	COALESCE(Aug,0) Aug,
	COALESCE(Sep,0) Sep,
	COALESCE(Oct,0) Oct,
	COALESCE(Nov,0) Nov,
	COALESCE(Dec,0) Dec
FROM 
(
	SELECT
		YEAR(o.OrderDate) as SalesYear,
		FORMAT (o.OrderDate, 'MMM') as OrderDate,
		ListPrice
	FROM
		dbo.[Order] o
		INNER JOIN dbo.[OrderItem] oi ON oi.OrderId = o.OrderId 
) AS Sales
PIVOT
(
  SUM(ListPrice)
  FOR [OrderDate]
  IN (
	[Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dec]
  )
) AS PivotTable