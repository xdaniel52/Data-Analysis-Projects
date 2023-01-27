CREATE OR ALTER PROCEDURE addPurchase
--adds purchase to 	PurchasesHistory and if needed add rows to MembershipCards or MembershipHistory
	@ServiceID int,
	@EmployeeID int,
	@Date date,
	@Price decimal(5,2),
	@CardID int,
	@CustomerID int,
	@From date,
	@To date

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

	BEGIN TRANSACTION addPurchaseTran
	DECLARE @OnlyMorning bit, @PurchaseID int,@CardTypeID int

	INSERT INTO [PurchasesHistory]([ServiceID], [CardID], [EmployeeID], [PurchaseDate], [Price]) 
	VALUES(@ServiceID, @CardID, @EmployeeID, @Date, @Price);

	IF (SELECT  [ServiceTypes].ServiceTypeID
		FROM [Gym].[dbo].[Services]
		JOIN [Gym].[dbo].[ServiceTypes] ON ([Services].ServiceTypeID = [ServiceTypes].ServiceTypeID)
		WHERE [ServiceID] = @ServiceID) = 5

			BEGIN
			SET @CardTypeID = (SELECT [Services].Duration FROM [Gym].[dbo].[Services] WHERE [ServiceID] = @ServiceID)
			INSERT INTO [MembershipCards]([CustomerID],[CardTypeID],[PurchaseDate]) 
			VALUES(@CustomerID, @CardTypeID, @Date)
			END

	ELSE IF (SELECT  [ServiceTypes].DurationInHours
		FROM [Gym].[dbo].[Services]
		JOIN [Gym].[dbo].[ServiceTypes] ON ([Services].ServiceTypeID = [ServiceTypes].ServiceTypeID)
		WHERE [ServiceID] = @ServiceID) = 0

			BEGIN
			SET @OnlyMorning = (SELECT [Services].OnlyMorning FROM [Gym].[dbo].[Services] WHERE [ServiceID] = @ServiceID)
			SET @PurchaseID = (SELECT TOP 1 PurchaseID FROM [PurchasesHistory] ORDER BY PurchaseID DESC)

			INSERT INTO [MembershipHistory]([ServiceID], [PurchaseID], [CardID], [From], [To], [OnlyMorning] ) 
			VALUES(@ServiceID, @PurchaseID, @CardID, @From, @To, @OnlyMorning)
			END

	COMMIT TRANSACTION addPurchaseTran

	END TRY
	BEGIN CATCH

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION addPurchaseTran

		DECLARE @ErrorMessage NVARCHAR(4000);  
		DECLARE @ErrorSeverity INT;  
		DECLARE @ErrorState INT;  

		SELECT   
		   @ErrorMessage = ERROR_MESSAGE(),  
		   @ErrorSeverity = ERROR_SEVERITY(),  
		   @ErrorState = ERROR_STATE();  

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);  
	END CATCH
	
END
GO




