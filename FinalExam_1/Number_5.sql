WITH rCTE AS (
	
	SELECT s.StaffId
		, s.FirstName + ' ' + s.LastName AS FullName
		, CAST(s.FirstName + ' ' + s.LastName + ', ' 
			AS VARCHAR(500)) AS EmployeeHierarchy
	FROM dbo.Staff s
	WHERE ManagerId IS NULL

	UNION ALL

	SELECT s.StaffId
		, s.FirstName + ' ' + s.LastName AS FullName
		, CAST(r.EmployeeHierarchy 
				+ s.FirstName 
				+ ' ' + s.LastName 
				+ ', ' AS VARCHAR(500))
	FROM dbo.Staff s
	INNER JOIN rCTE AS r
		ON (s.ManagerId = r.StaffId)
)

SELECT r.StaffId
	, r.FullName
	, LEFT(r.EmployeeHierarchy, LEN(r.EmployeeHierarchy ) - 1)
FROM rCTE r
ORDER BY r.StaffId