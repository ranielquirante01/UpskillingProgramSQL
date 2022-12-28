CREATE PROCEDURE dbo.CreateNewBrandAndMoveProducts @NewBrandName nvarchar(255) = NULL, @OldBrandId int = NULL
AS
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS(SELECT * FROM dbo.Brand WHERE BrandId = @OldBrandId)
			INSERT INTO
				dbo.Brand (BrandName)
			VALUES
				(@NewBrandName)

			UPDATE 
				dbo.Product
			SET
				BrandId = (SELECT BrandId FROM dbo.Brand WHERE BrandName = @NewBrandName AND BrandId != @OldBrandId)
			WHERE
				BrandId = @OldBrandId

			DELETE FROM dbo.Brand WHERE BrandId = @OldBrandId

		COMMIT TRAN
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRAN
	END CATCH
GO