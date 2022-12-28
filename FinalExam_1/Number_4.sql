IF NOT EXISTS (
	SELECT * FROM sys.tables WHERE [name] = 'Ranking'
)
BEGIN
	CREATE TABLE
		dbo.Ranking (
		[Id] [int] IDENTITY (1,1) NOT NULL PRIMARY KEY,
		[Description] [varchar](255) NOT NULL
	)

	INSERT INTO dbo.Ranking ([Description]) VALUES ('Inactive'), ('Bronze'), ('Silver'), ('Gold'), ('Platinum')

	ALTER TABLE dbo.Customer ADD RankingId int, FOREIGN KEY(RankingId) REFERENCES Ranking(Id)
END
GO

DROP PROCEDURE IF EXISTS dbo.uspRankCustomers
GO

CREATE PROCEDURE dbo.uspRankCustomers
AS
	WITH CustomerRankingCTE AS (
		SELECT
			CustomerId,
			RankingId =
			(CASE
				WHEN (t.TotalAmount = 0) THEN 1
				WHEN (t.TotalAmount < 1000) THEN 2
				WHEN (t.TotalAmount < 2000) THEN 3
				WHEN (t.TotalAmount < 3000) THEN 4
				WHEN (t.TotalAmount >= 3000) THEN 5
			END)
		FROM
		(SELECT 
			o.CustomerId,
			SUM(oi.Quantity * oi.ListPrice / (1 + oi.Discount)) TotalAmount
		FROM 
			dbo.[Order] o 
			INNER JOIN dbo.Customer c ON o.CustomerId = c.CustomerId 
			INNER JOIN dbo.OrderItem oi ON o.OrderId = oi.OrderId
		GROUP BY
			o.CustomerId) t) 

	MERGE dbo.Customer AS c
	USING CustomerRankingCTE AS crcte ON
		(c.CustomerId = crcte.CustomerId)
	WHEN MATCHED
		THEN UPDATE
			SET c.RankingId = crcte.RankingId;
GO
	
EXEC dbo.uspRankCustomers
GO

DROP VIEW IF EXISTS dbo.vwCustomerOrders
GO 

CREATE VIEW dbo.vwCustomerOrders AS
SELECT
	c.CustomerId,
	c.FirstName,
	c.LastName,
	SUM(oi.Quantity * oi.ListPrice / (1 + oi.Discount)) as TotalAmount,
	r.[Description] as CustomerRanking
FROM
	dbo.Customer c
	INNER JOIN dbo.[Order] o ON c.CustomerId = o.CustomerId
	INNER JOIN dbo.OrderItem oi ON o.OrderId = oi.OrderId
	INNER JOIN dbo.Ranking r ON r.Id = c.RankingId
GROUP BY
	c.CustomerId,
	c.FirstName,
	c.LastName,
	r.[Description]
GO

SELECT * FROM dbo.vwCustomerOrders