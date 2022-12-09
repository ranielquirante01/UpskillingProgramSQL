DECLARE 
	@FirstCounter int,
	@SecondCounter int 
SET @FirstCounter = 1
SET @SecondCounter = 1
WHILE (@FirstCounter <= 10)
BEGIN
	WHILE(@SecondCounter <= 10)
	BEGIN
		PRINT CAST(@FirstCounter as varchar(10)) + ' * ' + CAST(@SecondCounter as varchar(10)) +  ' = ' + CAST(@FirstCounter * @SecondCounter as varchar(10))
		SET @SecondCounter = @SecondCounter + 1
	END
	SET @FirstCounter  = @FirstCounter  + 1
	SET @SecondCounter = 1
END