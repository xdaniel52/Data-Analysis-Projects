
---------- database structure ----------

SET XACT_ABORT ON

CREATE DATABASE Gym;

Go

use Gym;

BEGIN TRANSACTION GymTransaction

--Tables
CREATE TABLE [Customers] (
    [CustomerID] INT IDENTITY(1,1) NOT NULL ,
    [FirstName] VARCHAR(50)  NOT NULL ,
    [LastName] VARCHAR(50)  NOT NULL ,
    [Email] VARCHAR(50)  NOT NULL ,
    [PhoneNumber] VARCHAR(11)  NOT NULL ,
    [DateOfBirth] DATE  NOT NULL ,
    [Sex] CHAR(1)  NOT NULL ,
    [City] VARCHAR(50)  NOT NULL ,
    [StreetName] VARCHAR(30)  NOT NULL ,
    [BuildingNumber] INT  NOT NULL ,
    [ApartmentNumber] INT  NULL ,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED (
        [CustomerID] ASC
    )
)

CREATE TABLE [MembershipCards] (
    [CardID] INT IDENTITY(1,1) NOT NULL ,
    [CustomerID] INT  NOT NULL ,
    [CardTypeID] INT  NOT NULL ,
    [PurchaseDate] DATE  NOT NULL ,
    CONSTRAINT [PK_MembershipCards] PRIMARY KEY CLUSTERED (
        [CardID] ASC
    )
)

CREATE TABLE [CardTypes] (
    [CardTypeID] INT IDENTITY(1,1) NOT NULL ,
    [Name] VARCHAR(30)  NOT NULL ,
    CONSTRAINT [PK_CardTypes] PRIMARY KEY CLUSTERED (
        [CardTypeID] ASC
    )
)

CREATE TABLE [PurchasesHistory] (
    [PurchaseID] INT IDENTITY(1,1) NOT NULL ,
    [ServiceID] INT  NOT NULL ,
    [CardID] INT  NULL ,
    [EmployeeID] INT  NOT NULL ,
    [PurchaseDate] DATE  NOT NULL ,
    [Price] DECIMAL(5,2)  NOT NULL ,
    CONSTRAINT [PK_PurchasesHistory] PRIMARY KEY CLUSTERED (
        [PurchaseID] ASC
    )
)

CREATE TABLE [MembershipHistory] (
    [MembershipID] INT IDENTITY(1,1) NOT NULL ,
    [ServiceID] INT  NOT NULL ,
    [PurchaseID] INT  NOT NULL ,
    [CardID] INT  NOT NULL ,
    [From] DATE  NOT NULL ,
    [To] DATE  NOT NULL ,
    [OnlyMorning] BIT  NOT NULL ,
    CONSTRAINT [PK_MembershipHistory] PRIMARY KEY CLUSTERED (
        [MembershipID] ASC
    )
)

CREATE TABLE [Services] (
    [ServiceID] INT IDENTITY(1,1) NOT NULL ,
    [Name] VARCHAR(50)  NOT NULL ,
    [ServiceTypeID] INT  NOT NULL ,
    [Duration] INT  NULL ,
    [OnlyMorning] BIT  NULL ,
    [Price] DECIMAL(5,2)  NOT NULL ,
    CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED (
        [ServiceID] ASC
    )
)

CREATE TABLE [ServiceTypes] (
    [ServiceTypeID] INT IDENTITY(1,1) NOT NULL ,
    [Name] VARCHAR(50)  NOT NULL ,
    [DurationInHours] BIT  NOT NULL ,
    CONSTRAINT [PK_ServiceTypes] PRIMARY KEY CLUSTERED (
        [ServiceTypeID] ASC
    )
)

CREATE TABLE [Employees] (
    [EmployeeID] INT IDENTITY(1,1) NOT NULL ,
    [JobID] INT  NOT NULL ,
    [FirstName] VARCHAR(50)  NOT NULL ,
    [LastName] VARCHAR(50)  NOT NULL ,
    [Email] VARCHAR(50)  NOT NULL ,
    [PhoneNumber] VARCHAR(11)  NOT NULL ,
    [DateOfBirth] DATE  NOT NULL ,
    [Sex] CHAR(1)  NOT NULL ,
    [City] VARCHAR(50)  NOT NULL ,
    [StreetName] VARCHAR(30)  NOT NULL ,
    [BuildingNumber] INT  NOT NULL ,
    [ApartmentNumber] INT  NULL ,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED (
        [EmployeeID] ASC
    )
)

CREATE TABLE [Contracts] (
    [ContractID] INT IDENTITY(1,1) NOT NULL ,
    [EmployeeID] INT  NOT NULL ,
    [DateSigned] DATE  NOT NULL ,
    [From] DATE  NOT NULL ,
    [To] DATE  NOT NULL ,
    [Salary] DECIMAL(7,2)  NOT NULL ,
    [WorkingTime] DECIMAL(3,2)  NOT NULL ,
    CONSTRAINT [PK_Contracts] PRIMARY KEY CLUSTERED (
        [ContractID] ASC
    )
)

CREATE TABLE [Discounts] (
    [DiscountID] INT IDENTITY(1,1) NOT NULL ,
    [Name] VARCHAR(255)  NOT NULL ,
    [CardTypeID] INT  NOT NULL ,
    [ServiceTypeID] INT  NOT NULL ,
    [Fraction] DECIMAL(3,2)  NOT NULL ,
    CONSTRAINT [PK_Discounts] PRIMARY KEY CLUSTERED (
        [DiscountID] ASC
    )
)

CREATE TABLE [Jobs] (
    [JobID] INT IDENTITY(1,1) NOT NULL ,
    [Name] VARCHAR(255)  NOT NULL ,
    CONSTRAINT [PK_Jobs] PRIMARY KEY CLUSTERED (
        [JobID] ASC
    )
)

--Constraints
ALTER TABLE [MembershipCards] WITH CHECK ADD CONSTRAINT [FK_MembershipCards_CustomerID] FOREIGN KEY([CustomerID])
REFERENCES [Customers] ([CustomerID])

ALTER TABLE [MembershipCards] CHECK CONSTRAINT [FK_MembershipCards_CustomerID]

ALTER TABLE [MembershipCards] WITH CHECK ADD CONSTRAINT [FK_MembershipCards_CardTypeID] FOREIGN KEY([CardTypeID])
REFERENCES [CardTypes] ([CardTypeID])

ALTER TABLE [MembershipCards] CHECK CONSTRAINT [FK_MembershipCards_CardTypeID]

ALTER TABLE [PurchasesHistory] WITH CHECK ADD CONSTRAINT [FK_PurchasesHistory_ServiceID] FOREIGN KEY([ServiceID])
REFERENCES [Services] ([ServiceID])

ALTER TABLE [PurchasesHistory] CHECK CONSTRAINT [FK_PurchasesHistory_ServiceID]

ALTER TABLE [PurchasesHistory] WITH CHECK ADD CONSTRAINT [FK_PurchasesHistory_CardID] FOREIGN KEY([CardID])
REFERENCES [MembershipCards] ([CardID])

ALTER TABLE [PurchasesHistory] CHECK CONSTRAINT [FK_PurchasesHistory_CardID]

ALTER TABLE [PurchasesHistory] WITH CHECK ADD CONSTRAINT [FK_PurchasesHistory_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [Employees] ([EmployeeID])

ALTER TABLE [PurchasesHistory] CHECK CONSTRAINT [FK_PurchasesHistory_EmployeeID]

ALTER TABLE [MembershipHistory] WITH CHECK ADD CONSTRAINT [FK_MembershipHistory_ServiceID] FOREIGN KEY([ServiceID])
REFERENCES [Services] ([ServiceID])

ALTER TABLE [MembershipHistory] CHECK CONSTRAINT [FK_MembershipHistory_ServiceID]

ALTER TABLE [MembershipHistory] WITH CHECK ADD CONSTRAINT [FK_MembershipHistory_PurchaseID] FOREIGN KEY([PurchaseID])
REFERENCES [PurchasesHistory] ([PurchaseID])

ALTER TABLE [MembershipHistory] CHECK CONSTRAINT [FK_MembershipHistory_PurchaseID]

ALTER TABLE [MembershipHistory] WITH CHECK ADD CONSTRAINT [FK_MembershipHistory_CardID] FOREIGN KEY([CardID])
REFERENCES [MembershipCards] ([CardID])

ALTER TABLE [MembershipHistory] CHECK CONSTRAINT [FK_MembershipHistory_CardID]

ALTER TABLE [Services] WITH CHECK ADD CONSTRAINT [FK_Services_ServiceTypeID] FOREIGN KEY([ServiceTypeID])
REFERENCES [ServiceTypes] ([ServiceTypeID])

ALTER TABLE [Services] CHECK CONSTRAINT [FK_Services_ServiceTypeID]

ALTER TABLE [Employees] WITH CHECK ADD CONSTRAINT [FK_Employees_JobID] FOREIGN KEY([JobID])
REFERENCES [Jobs] ([JobID])

ALTER TABLE [Employees] CHECK CONSTRAINT [FK_Employees_JobID]

ALTER TABLE [Employees] WITH CHECK ADD CONSTRAINT [CHK_Employees_Sex] CHECK([Sex] IN ('F','M'));

ALTER TABLE [Employees] CHECK CONSTRAINT [CHK_Employees_Sex]

ALTER TABLE [Contracts] WITH CHECK ADD CONSTRAINT [FK_Contracts_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [Employees] ([EmployeeID])

ALTER TABLE [Contracts] CHECK CONSTRAINT [FK_Contracts_EmployeeID]

ALTER TABLE [Discounts] WITH CHECK ADD CONSTRAINT [FK_Discounts_CardTypeID] FOREIGN KEY([CardTypeID])
REFERENCES [CardTypes] ([CardTypeID])

ALTER TABLE [Discounts] CHECK CONSTRAINT [FK_Discounts_CardTypeID]

ALTER TABLE [Discounts] WITH CHECK ADD CONSTRAINT [FK_Discounts_ServiceTypeID] FOREIGN KEY([ServiceTypeID])
REFERENCES [ServiceTypes] ([ServiceTypeID])

ALTER TABLE [Discounts] CHECK CONSTRAINT [FK_Discounts_ServiceTypeID]

ALTER TABLE [Customers] WITH CHECK ADD CONSTRAINT [CHK_Customers_Sex] CHECK([Sex] IN ('F','M'));

ALTER TABLE [Customers] CHECK CONSTRAINT [CHK_Customers_Sex]

--Indexes
CREATE INDEX [idx_MembershipCards_CustomerID]
ON [MembershipCards] ([CustomerID])

CREATE INDEX [idx_MembershipCards_CardTypeID]
ON [MembershipCards] ([CardTypeID])

CREATE INDEX [idx_PurchasesHistory_ServiceID]
ON [PurchasesHistory] ([ServiceID])

CREATE INDEX [idx_PurchasesHistory_CardID]
ON [PurchasesHistory] ([CardID])

CREATE INDEX [idx_MembershipHistory_ServiceID]
ON [MembershipHistory] ([ServiceID])

CREATE INDEX [idx_MembershipHistory_CardID]
ON [MembershipHistory] ([CardID])

CREATE INDEX [idx_Services_ServiceTypeID]
ON [Services] ([ServiceTypeID])

COMMIT TRANSACTION GymTransaction

---------- stored procedures ----------

Go

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
		FROM [dbo].[Services]
		JOIN [dbo].[ServiceTypes] ON ([Services].ServiceTypeID = [ServiceTypes].ServiceTypeID)
		WHERE [ServiceID] = @ServiceID) = 5

			BEGIN
			SET @CardTypeID = (SELECT [Services].Duration FROM [dbo].[Services] WHERE [ServiceID] = @ServiceID)
			INSERT INTO [MembershipCards]([CustomerID],[CardTypeID],[PurchaseDate]) 
			VALUES(@CustomerID, @CardTypeID, @Date)
			END

	ELSE IF (SELECT  [ServiceTypes].DurationInHours
		FROM [dbo].[Services]
		JOIN [dbo].[ServiceTypes] ON ([Services].ServiceTypeID = [ServiceTypes].ServiceTypeID)
		WHERE [ServiceID] = @ServiceID) = 0

			BEGIN
			SET @OnlyMorning = (SELECT [Services].OnlyMorning FROM [dbo].[Services] WHERE [ServiceID] = @ServiceID)
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


---------- views ----------

GO

CREATE OR ALTER VIEW vw_ServicesList AS
--clear view of all services without cards
SELECT [ServiceID]
      ,[Services].[Name] AS ServiceName
	  ,[ServiceTypes].[Name] AS ServiceType
      ,[Duration]
	  ,CASE WHEN [ServiceTypes].DurationInHours = 1 THEN 'hours' ELSE 'days' END AS TimeUnit
      ,[OnlyMorning]
      ,[Price]
  FROM [dbo].[Services]
  JOIN [dbo].[ServiceTypes] ON ([Services].[ServiceTypeID] = [ServiceTypes].[ServiceTypeID])
  WHERE [Services].[ServiceTypeID] != 5;

GO

CREATE OR ALTER VIEW vw_CardsWithDiscountsList AS
--clear view of discounts to each card type
SELECT 
	ServicesQuery.Name AS Card_type
	,ServicesQuery.Price AS Price
    ,STR(FLOOR(MAX(case when DiscountsQuery.[ServiceTypeID] = 1 then Fraction else 0 end)*100))+'%' "Gym_membership"
    ,STR(FLOOR(MAX(case when DiscountsQuery.[ServiceTypeID] = 2 then Fraction else 0 end)*100))+'%' "Gym_ticket"
    ,STR(FLOOR(MAX(case when DiscountsQuery.[ServiceTypeID] = 3 then Fraction else 0 end)*100))+'%' "Pool_membership"
    ,STR(FLOOR(MAX(case when DiscountsQuery.[ServiceTypeID] = 4 then Fraction else 0 end)*100))+'%' "Pool_ticket"
  FROM 
  (
	SELECT dis.[CardTypeID] AS CardTypeID
      ,dis.[ServiceTypeID] AS ServiceTypeID
      ,dis.[Fraction] AS Fraction
  FROM [dbo].[Discounts] dis
  ) DiscountsQuery  
  JOIN 
  (
	SELECT ser.[Duration] AS CardTypeID
      ,ser.[Price] AS Price
      ,ser.[Name] AS Name
  FROM [dbo].[Services] ser
  WHERE ser.[ServiceTypeID] = 5
  ) ServicesQuery
  ON (DiscountsQuery.[CardTypeID] = ServicesQuery.[CardTypeID])
  GROUP BY DiscountsQuery.CardTypeID,ServicesQuery.Name,ServicesQuery.Price;

GO


CREATE OR ALTER VIEW vw_CurrentEmployees AS
--list of employees with important information about their contracts and qualifying periods
SELECT [Employees].[EmployeeID]   
      ,[FirstName]
      ,[LastName]
	  ,[Jobs].[Name] AS Job
      ,[DateOfBirth]
	  ,[LatestContracts].[Salary]
	  ,[LatestContracts].[WorkingTime]
	  ,[LatestContracts].[From]
	  ,CASE WHEN [LatestContracts].[To] = '9999-12-31' THEN '' ELSE  CONVERT(varchar ,[LatestContracts].[To]) END AS "To"
	  ,DATEDIFF(year, [OldestContracts].[From], CONVERT(date, GETDATE())) AS Qualifying_Period_In_Years
  FROM [dbo].[Employees]
  JOIN [dbo].[Jobs] ON ([Employees].[JobID] = [Jobs].[JobID])
  JOIN (
	  SELECT [ContractID]
		  ,[EmployeeID]
		  ,[DateSigned]
		  ,[From]
		  ,[To]
		  ,[Salary]
		  ,[WorkingTime]
	  FROM [dbo].[Contracts] LatestContractsInner
	  WHERE [From] = (
			SELECT max([From]) 
			FROM [dbo].[Contracts] WhereContracts
			WHERE LatestContractsInner.EmployeeID = WhereContracts.EmployeeID
			)
	) LatestContracts ON ([Employees].[EmployeeID] = LatestContracts.[EmployeeID])
  JOIN (
		
		SELECT EmployeeID
			,Min([From]) AS [From]
		FROM [dbo].[Contracts] WhereContracts
		GROUP BY EmployeeID
			
	) OldestContracts ON ([Employees].[EmployeeID] = OldestContracts.[EmployeeID]);

GO

CREATE OR ALTER VIEW vw_GymIncomsIn2022byServiceType AS
--incoms in 2022 groped by ServiceType
SELECT TOP 1000 [ServiceTypes].[Name] AS "ServiceType"
      ,FORMAT(SUM([PurchasesHistory].[Price]), 'C') AS "Income"
  FROM [dbo].[PurchasesHistory] 
  JOIN [Services] ON ([PurchasesHistory].[ServiceID] = [Services].[ServiceID])
  JOIN [ServiceTypes] ON ([Services].[ServiceTypeID] = [ServiceTypes].[ServiceTypeID])
  WHERE Year([PurchaseDate]) = 2022
  GROUP BY [ServiceTypes].[Name]
  ORDER BY SUM([PurchasesHistory].[Price]) DESC
  ;

GO

CREATE OR ALTER VIEW vw_GymIncomsIn2022byCardType AS
--incoms in 2022 groped by CardType
SELECT TOP 1000 [CardTypes].[Name] AS "CardType"
      ,FORMAT(SUM([PurchasesHistory].[Price]), 'C') AS "Income in 2022"
  FROM .[dbo].[PurchasesHistory] 
  JOIN [MembershipCards] ON ([PurchasesHistory].[CardID] = [MembershipCards].[CardID])
  JOIN [CardTypes] ON ([MembershipCards].[CardTypeID] = [CardTypes].[CardTypeID])
  WHERE Year([PurchasesHistory].[PurchaseDate]) = 2022
  GROUP BY [CardTypes].[Name]
  ORDER BY SUM([PurchasesHistory].[Price]) DESC;

GO

CREATE OR ALTER VIEW vw_GymIncomsIn2022byEmployee AS
--incoms in 2022 groped by receptionist
SELECT TOP 1000 [Employees].[EmployeeID]
	  ,[Employees].[FirstName] 
	  ,[Employees].[LastName] 
      ,FORMAT(SUM([PurchasesHistory].[Price]), 'C') AS "Income in 2022"
  FROM [dbo].[PurchasesHistory] 
  JOIN [Employees] ON ([PurchasesHistory].[EmployeeID] = [Employees].[EmployeeID])
  WHERE Year([PurchasesHistory].[PurchaseDate]) = 2022
  GROUP BY [Employees].[EmployeeID],[Employees].[FirstName],[Employees].[LastName]
  ORDER BY SUM([PurchasesHistory].[Price]) DESC;

GO

---------- database data ----------

--Jobs data
INSERT INTO [Jobs]([Name]) VALUES('Manager');
INSERT INTO [Jobs]([Name]) VALUES('Personal trainer');
INSERT INTO [Jobs]([Name]) VALUES('Receptionist');
INSERT INTO [Jobs]([Name]) VALUES('Cleaning lady');
INSERT INTO [Jobs]([Name]) VALUES('Caretaker');
INSERT INTO [Jobs]([Name]) VALUES('Lifeguard');
INSERT INTO [Jobs]([Name]) VALUES('Other');

--CardTypes data
INSERT INTO [CardTypes]([Name]) VALUES('Basic');
INSERT INTO [CardTypes]([Name]) VALUES('Premium');
INSERT INTO [CardTypes]([Name]) VALUES('Employee');
INSERT INTO [CardTypes]([Name]) VALUES('University');

--ServiceTypes data
INSERT INTO [ServiceTypes]([Name], [DurationInHours]) VALUES('Gym membership', 0);
INSERT INTO [ServiceTypes]([Name], [DurationInHours]) VALUES('Gym ticket', 1);
INSERT INTO [ServiceTypes]([Name], [DurationInHours]) VALUES('Pool membership', 0);
INSERT INTO [ServiceTypes]([Name], [DurationInHours]) VALUES('Pool ticket', 1);
INSERT INTO [ServiceTypes]([Name], [DurationInHours]) VALUES('Membership cards', 0);

--Services data
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Monthly gym membership OPEN',1,30, 0, 100.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Monthly gym membership MORNING',1,30, 1, 70.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Three-month gym membership OPEN',1,90, 0, 280.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Three-month gym membership MORNING',1,90, 1, 190.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Half-year gym membership OPEN',1,180, 0, 540.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Half-year gym membership MORNING',1,180, 1, 360.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('One-time gym ticket 2h',2,2, 0, 10.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('One-time gym ticket 5h',2,5, 0, 15.00);

INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Monthly pool membership OPEN',3,30, 0, 250.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Monthly pool membership MORNING',3,30, 1, 210.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Three-month pool membership OPEN',3,90, 0, 700.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Three-month pool membership MORNING',3,90, 1, 550.00);

INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Swimming pool ticket 1h',4,1, 0, 15.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Swimming pool ticket 2h',4,2, 0, 25.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Swimming pool ticket 4h',4,4, 0, 35.00);

INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Basic card',5,1, null, 15.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Premium card',5,2, null, 100.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('Employee card',5,3, null, 5.00);
INSERT INTO [Services]([Name], [ServiceTypeID],[Duration],[OnlyMorning],[Price]) VALUES('University card',5,4, null, 15.00);

--Discounts data
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Emploee discount gym membership', 3, 1, 0.7);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Emploee discount gym ticket', 3, 2, 0.7);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Emploee discount pool membership', 3, 3, 0.7);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Emploee discount pool ticket', 3, 4, 0.7);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('University discount gym membership', 4, 1, 0.2);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('University discount pool ticket', 4, 4, 0.2);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Premium cards discount gym membership', 2, 1, 0.30);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Premium cards discount pool membership', 2, 3, 0.20);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Basic cards discount gym membership', 1, 1, 0.10);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Basic cards discount gym ticket', 1, 2, 0.10);
INSERT INTO [Discounts]([Name], [CardTypeID], [ServiceTypeID], [Fraction]) VALUES('Basic cards discount pool membership', 1, 3, 0.05);

--Employees data
--Job - Manager
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(1, 'Daniel', 'Kucharski', 'xdaniel@onet.eu', '123456789', '2001-03-23','M', 'Częstochowa','My Street',5,25);
--Job - Personal 
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(2, 'Przemyk', 'Kysiak', 'przemek_krysiak@gym.com', '234567891', '1997-04-21','M', 'Częstochowa','Brett Way',4,14);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(2, 'Rafał', 'Bajer', 'rafal_bajer@gym.com', '345678912', '1990-09-30','M', 'Częstochowa','Albara Place ',37, null);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(2, 'Mateusz', 'Zaręba', 'matesz_zarebak@gym.com', '456789123', '1994-01-09','M', 'Częstochowa','Kurtz Lane',2,63);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(2, 'Sara', 'Garncarz', 'sara_garncarz@gym.com', '567891234', '1989-05-15','F', 'Częstochowa','Nicole Terrace',46,82);
--Job - Receptionist 
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(3, 'Isabelle', 'Cain', 'isabelle _cain@gym.com', '678912345', '1989-09-01','F', 'Częstochowa','Liberty Way',10,12);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(3, 'Katerina', 'Downs', 'katerina_downs@gym.com', '789123456', '1985-02-12','F', 'Częstochowa','Lake Lane',3,null);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(3, 'Pamela', 'Brady', 'pamela_brady@gym.com', '891234567', '1977-08-23','F', 'Częstochowa','Lilypad Boulevard',245,34);
--Job - Cleaning lady 
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(4, 'Emmy', 'Dale', 'emmy_dale@gym.com', '987654321', '1964-12-29','F', 'Częstochowa','Serenity Way',22,10);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(4, 'Farrah', 'Gray', 'farrah_gray@gym.com', '876543219', '1971-07-19','F', 'Częstochowa','Senna Route',84,94);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(4, 'Samara', 'Beltran', 'samara_beltran@gym.com', '765432198', '1965-06-11','F', 'Częstochowa','Congress Boulevard',134,null);
--Job - Caretaker 
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(5, 'Darius', 'Lamb', 'darius_lamb@gym.com', '654321987', '1960-04-21','M', 'Częstochowa','Aviation Row',1,45);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(5, 'Jaden', 'Campbell', 'jaden_campbell@gym.com', '543219876', '1968-03-07','M', 'Częstochowa','Albara Place',82, 111);
--Job - Lifeguard 
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(6, 'Aled', 'Baldwin', 'aled_baldwin@gym.com', '432198765', '1996-08-18','M', 'Częstochowa','Ashland Street',64,null);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(6, 'Nabil', 'Slater', 'nabil_slater@gym.com', '321987654', '1999-04-07','M', 'Częstochowa','Pebble Lane',168, null);
--Job - Other 
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
				 VALUES(6, 'Jamal', 'Barton', 'jamal_barton@gym.com', '219876543', '1987-11-14','M', 'Częstochowa','Anchor Route',32, 67);

--Contracts data
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(1, '2020-01-02', '2020-01-02', '2021-12-31',4000,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(2, '2020-01-02', '2020-01-02', '2021-12-31',1500,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(3, '2022-01-02', '2022-01-02', '9999-12-31',1650,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(4, '2020-01-02', '2020-01-02', '9999-12-31',750,0.5);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(5, '2020-01-02', '2020-01-02', '2020-03-31',300,0.2);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(5, '2020-04-01', '2020-04-01', '2020-10-01',700,0.5);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(5, '2020-10-02', '2020-10-02', '9999-12-31',1400,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(6, '2022-01-02', '2022-01-02', '2023-12-31',1500,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(7, '2020-01-02', '2020-01-02', '2021-08-31',1600,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(8, '2021-03-02', '2021-03-02', '2021-12-31',1300,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(8, '2022-01-02', '2022-01-01', '9999-12-31',1400,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(9, '2020-01-02', '2020-01-02', '2021-11-30',1000,0.8);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(10, '2021-04-01', '2021-04-01', '9999-12-31',1400,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(11, '2022-01-02', '2020-01-02', '2022-08-31',1300,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(12, '2020-01-02', '2020-01-02', '2022-11-30',700,0.5);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(13, '2023-01-02', '2023-01-02', '9999-12-31',1200,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(14, '2020-06-01', '2020-06-01', '9999-12-31',1250,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(15, '2022-06-01', '2022-06-01', '9999-12-31',1350,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(16, '2022-08-01', '2022-08-01', '9999-12-31',1500,1.0);

--Customers data
-- employee as a customer
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Przemyk', 'Kysiak', 'przemek_krysiak@gym.com', '234567891', '1997-04-21','M', 'Częstochowa','Brett Way',4,14);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Rafał', 'Bajer', 'rafal_bajer@gym.com', '345678912', '1990-09-30','M', 'Częstochowa','Albara Place ',37, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Mateusz', 'Zaręba', 'matesz_zarebak@gym.com', '456789123', '1994-01-09','M', 'Częstochowa','Kurtz Lane',2,63);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Sara', 'Garncarz', 'sara_garncarz@gym.com', '567891234', '1989-05-15','F', 'Częstochowa','Nicole Terrace',46,82);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Jamal', 'Barton', 'jamal_barton@gym.com', '219876543', '1987-11-14','M', 'Częstochowa','Anchor Route',32, 67);
--pure Customers
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Ezra', 'Bridges', 'ezra_bridges@random.com', '660953955', '2002-08-04','M', 'Częstochowa','Woodhouse Lane',150, 78);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Osvaldo', 'Clarke', 'osvaldo_clarke@random.com', '755527030', '1977-02-19','M', 'San Tiesfemi','Watery Lane',379, 55);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Adalberto', 'Bass', 'adalberto_bass@random.com', '501338681', '1988-05-23','M', 'Częstochowa','Kent Close',176, 119);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Forest', 'Rush', 'forest_rush@random.com', '840185321', '1996-11-23','M', 'Częstochowa','Chiltern Close',425, 100);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Thomas', 'Marshall', 'thomas_marshall@random.com', '378584482', '1992-06-01','M', 'Parkesche','Queens Road',408, 54);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Rebecca', 'Washington', 'rebecca_washington@random.com', '790351856', '1980-03-25','F', 'Częstochowa','Moorland Road',31, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Susanna', 'Guerra', 'Susanna_guerra@random.com', '574743464', '1992-10-13','F', 'Rsipday','Bankside',99, 31);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Warner', 'Frederick', 'warner_frederick@random.com', '160989844', '1989-04-13','M', 'Prince Ulmthton','The Lane',41, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Herb', 'Preston', 'herb_preston@random.com', '373686522', '1979-03-16','M', 'San Tiesfemi','Poplar Avenue',170, 81);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Kara', 'Booth', 'kara_booth@random.com', '443946061', '1976-03-21','F', 'Prince Ulmthton','Berkeley Close',68, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Marianne', 'Combs', 'marianne_combs@random.com', '668942041', '1973-09-04','F', 'Częstochowa','Cedar Grove',28, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Florencio', 'Fleming', 'florencio_fleming@random.com', '984491789', '1999-04-16','M', 'Port Blackscotmod','Devonshire Road',229, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('George', 'Guzman', 'george_guzman@random.com', '931299264', '2003-05-06','M', 'Częstochowa','Crown Street',168, 61);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Myles', 'Cervantes', 'myles_cervantes@random.com', '384922528', '1982-05-13','M', 'Prince Ulmthton','Second Avenue',330, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Tim', 'Wolf', 'tim_wolf@random.com', '340754239', '1997-04-07','M', 'Częstochowa','The Ridings',43, 58);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Kara', 'Booth', 'kara_booth@random.com', '443946061', '1972-03-07','F', 'Częstochowa','Aspen Close',91, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Elvia', 'Pennington', 'elivia_pannington@random.com', '338339938', '1984-03-21','F', 'Częstochowa','York Avenue',8, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Patty ', 'Sharp', 'patty_sharp@random.com', '208623272', '1990-05-05','F', 'Prince Ulmthton','Oak Lane',280, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Carlos', 'Donovan', 'carlos_danovan@random.com', '754695878', '1997-04-07','M', 'Częstochowa','Derby Street',171, 15);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Modesto', 'Cross', 'modesto_cross@random.com', '143845640', '1977-03-22','M', 'Częstochowa','Windsor Drive',96, 54);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Pierre', 'Dunlap', 'pierre_dunlap@random.com', '936610434', '1971-12-08','M', 'Częstochowa','York Street',246, 13);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Wally', 'Lopez', 'wally_lopez@random.com', '741273520', '1973-01-18','M', 'San Tiesfemi','Albert Road',160, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Joanne', 'Mckay', 'joanne_mckay@random.com', '483404466', '1974-11-03','F', 'Częstochowa','Poplar Avenue',34, 8);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Marla', 'Vega', 'marla_vega@random.com', '841691621', '1994-12-24','F', 'Częstochowa','Trinity Street',28, 96);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Teddy', 'Neal', 'teddy_neal@random.com', '832113397', '1980-07-07','M', 'Port Blackscotmod','Orchard Lane',58, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Carlton', 'Stokes', 'carlton_stokes@random.com', '608178813', '1980-07-09','M', 'Parkesche','Catherine Street',285, 30);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Jackson', 'Branch', 'jackson_branch@random.com', '286900341', '1987-03-07','M', 'San Tiesfemi','Graham Road',17, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Buddy', 'Pugh', 'buddy_pugh@random.com', '346383570', '1987-02-12','M', 'South Paltzre','Beech Grove',99, 78);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Sterling', 'Cox', 'sterling_cox@random.com', '274460364', '2002-07-02','M', 'Częstochowa','Grove Lane',487, 86);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Tommie', 'Cantu', 'tommie_cantu@random.com', '743279549', '1982-11-30','M', 'San Tiesfemi','Alexandra Street',168, 36);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Loyd', 'House', 'loyd_house@random.com', '262104836', '1997-02-04','M', 'Częstochowa','Common Lane',327, 58);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Gerard', 'Rasmussen', 'gerald_rasmussen@random.com', '507710104', '1970-11-27','M', 'Częstochowa','Spencer Close',113, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Garret', 'Prince', 'garret_prince@random.com', '635471279', '1972-05-18','M', 'Częstochowa','Cherry Close',217, 50);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Cyrus', 'Berger', 'cyrus_berger@random.com', '105566672', '1981-04-10','M', 'Częstochowa','Church Way',115, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Dan', 'Bond', 'dan_bond@random.com', '520697711', '1993-02-20','M', 'Częstochowa','Woodfield Road',158, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Joshua', 'Osborn', 'jashua_osborn@random.com', '559875579', '2003-09-16','M', 'Goldhouse','Riverside Drive',93, 32);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Tyler', 'One', 'tyler_one@random.com', '365429950', '1997-05-26','M', 'Prince Ulmthton','Portland Road',470, 52);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Jamie', 'Barker', 'jamie_barker@random.com', '943404561', '1974-10-23','F', 'Częstochowa','Westbourne Road',30, 44);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Alyce', 'Sweeney', 'alyce_sweeney@random.com', '741926860', '2004-09-06','F', 'Prince Ulmthton','Woodlands Avenue',79, 12);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Claud', 'Blackwell', 'claud_blackwell@random.com', '241608933', '1990-04-26','M', 'Częstochowa','Regent Street',127, 60);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Alfonzo', 'Mejia', 'alfonzo_mejia@random.com', '889937894', '1999-12-19','M', 'Częstochowa','York Street',43, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Helena', 'Whitaker', 'helena_whitaker@random.com', '739534860', '1992-11-10','F', 'Częstochowa','Sydney Road',49, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Juliana', 'Hawkins', 'juliana_hawkins@random.com', '141912652', '1972-05-11','F', 'Częstochowa','Sydney Road',49, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Elwood', 'Santiago', 'elwood_santiago@random.com', '335335887', '1982-08-13','M', 'Port Blackscotmod','Windsor Close',152, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Julia', 'Campbell', 'julia_campbell@random.com', '692633901', '1979-08-07','F', 'Częstochowa','Church Street',73, 8);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Elva', 'Griffith', 'elva_griffith@random.com', '225790348', '1997-09-22','F', 'Prince Ulmthton','St Marys Close',6, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Jake', 'Salinas', 'jake_salinas@random.com', '977582284', '1983-09-26','M', 'Częstochowa','Bridge Close',25, 59);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Buck', 'Nelson', 'buck_nelson@random.com', '436468639', '1977-02-19','M', 'Częstochowa','Grange Road',484, 28);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Giuseppe', 'Caldwell', 'giusepper_caldwell@random.com', '597557239', '2002-08-04','M', 'Częstochowa','Highfield Close',306, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Gale', 'Ortiz', 'gale_ortiz@random.com', '558580094', '2005-04-01','M', 'Parkesche','Back Lane',183, 50);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Ramiro', 'Huff', 'ramiro_huff@random.com', '928583503', '2005-04-01','M', 'Częstochowa','Woodlands',39, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Jere', 'Huber', 'jare_huber@random.com', '644545485', '2001-03-13','M', 'Port Blackscotmod','Vicarage Road',31, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Tonya', 'Strickland', 'tonya_strickland@random.com', '809176101', '1995-12-02','F', 'Częstochowa','Glebe Road',48, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Isabel', 'Oslon', 'isabel_oslon@random.com', '805292229', '1977-06-02','F', 'Częstochowa','Grasmere Close',22, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Mathew', 'Oneill', 'mathew_oneill@random.com', '189117337', '2002-08-25','M', 'Port Blackscotmod','Garden Street',290, 14);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Garret', 'Parsons', 'garrert_parsons@random.com', '793289897', '1996-11-17','M', 'Goldhouse','Cedar Close',223, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Vincent', 'Krause', 'vincent_krause@random.com', '678453028', '1999-08-20','M', 'Goldhouse','Railway Terrace',74, 107);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Barney', 'Cameron', 'barney_cameron@random.com', '276482038', '1985-06-14','M', 'Częstochowa','Ash Street',275, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Marc', 'Peterson', 'marc_peterson@random.com', '719612790', '1999-10-09','M', 'Częstochowa','North View',30, 9);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Frederic', 'Arroyo', 'frederic_arroyo@random.com', '795391337', '1997-03-11','M', 'Częstochowa','Grange Close',13, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Rufus', 'Morse', 'rufus_morse@random.com', '483611029', '2004-12-23','M', 'Parkesche','Sycamore Avenue',41, 58);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Rene', 'James', 'rene_james@random.com', '322264429', '1989-06-27','F', 'Częstochowa','Vicarage Road',217, 9);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Cyrus', 'Wilcox', 'cyrus_wilcox@random.com', '941333924', '1989-06-12','M', 'Częstochowa','Brighton Road',49, 10);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Branden', 'Ochoa', 'branden_ochoa@random.com', '379129372', '1983-02-12','M', 'Prince Ulmthton','Rectory Close',48, null);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Frieda', 'Holt', 'frieda_holt@random.com', '971101120', '1977-03-30','F', 'Goldhouse','West Way',27, 64);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetName],[BuildingNumber],[ApartmentNumber]) 
VALUES('Aisha', 'Nielsen', 'aisha_nielsen@random.com', '853720501', '1973-05-23','F', 'Prince Ulmthton','Alexandra Street',2, null);

---------- database purchases data ----------

EXEC addPurchase @ServiceID=18,@EmployeeID=9,@Date='2020-01-02',@Price=5.0,@CardID=null,@CustomerID=1,@From='2020-01-02',@To='2020-01-02';
EXEC addPurchase @ServiceID=18,@EmployeeID=8,@Date='2020-01-02',@Price=5.0,@CardID=null,@CustomerID=2,@From='2020-01-02',@To='2020-01-02';
EXEC addPurchase @ServiceID=18,@EmployeeID=9,@Date='2020-01-02',@Price=5.0,@CardID=null,@CustomerID=3,@From='2020-01-02',@To='2020-01-02';
EXEC addPurchase @ServiceID=18,@EmployeeID=7,@Date='2020-01-02',@Price=5.0,@CardID=null,@CustomerID=4,@From='2020-01-02',@To='2020-01-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-01-03',@Price=4.5,@CardID=2,@CustomerID=2,@From='2020-01-03',@To='2020-01-03';
EXEC addPurchase @ServiceID=19,@EmployeeID=8,@Date='2020-01-04',@Price=15.0,@CardID=null,@CustomerID=5,@From='2020-01-04',@To='2020-01-04';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-01-04',@Price=30.0,@CardID=4,@CustomerID=4,@From='2020-01-04',@To='2020-02-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-01-04',@Price=3.0,@CardID=1,@CustomerID=1,@From='2020-01-04',@To='2020-01-04';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2020-01-05',@Price=75.0,@CardID=3,@CustomerID=3,@From='2020-01-05',@To='2020-02-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-01-07',@Price=12.0,@CardID=5,@CustomerID=5,@From='2020-01-07',@To='2020-01-07';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2020-01-11',@Price=15.0,@CardID=null,@CustomerID=6,@From='2020-01-11',@To='2020-01-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-01-11',@Price=4.5,@CardID=1,@CustomerID=1,@From='2020-01-11',@To='2020-01-11';
EXEC addPurchase @ServiceID=17,@EmployeeID=8,@Date='2020-01-12',@Price=100.0,@CardID=null,@CustomerID=7,@From='2020-01-12',@To='2020-01-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-01-13',@Price=12.0,@CardID=5,@CustomerID=5,@From='2020-01-13',@To='2020-01-13';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-01-13',@Price=30.0,@CardID=2,@CustomerID=2,@From='2020-01-13',@To='2020-02-12';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-01-13',@Price=30.0,@CardID=1,@CustomerID=1,@From='2020-01-13',@To='2020-02-12';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2020-01-13',@Price=324.0,@CardID=6,@CustomerID=6,@From='2020-01-13',@To='2020-07-11';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2020-01-13',@Price=15.0,@CardID=null,@CustomerID=8,@From='2020-01-13',@To='2020-01-13';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2020-01-16',@Price=15.0,@CardID=null,@CustomerID=9,@From='2020-01-16',@To='2020-01-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-01-16',@Price=9.0,@CardID=8,@CustomerID=8,@From='2020-01-16',@To='2020-01-16';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-01-19',@Price=63.0,@CardID=9,@CustomerID=9,@From='2020-01-19',@To='2020-02-18';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-01-19',@Price=56.0,@CardID=5,@CustomerID=5,@From='2020-01-19',@To='2020-02-18';
EXEC addPurchase @ServiceID=17,@EmployeeID=8,@Date='2020-01-23',@Price=100.0,@CardID=null,@CustomerID=10,@From='2020-01-23',@To='2020-01-23';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-01-23',@Price=35.0,@CardID=8,@CustomerID=8,@From='2020-01-23',@To='2020-01-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-01-24',@Price=10.0,@CardID=10,@CustomerID=10,@From='2020-01-24',@To='2020-01-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-01-26',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-01-26',@To='2020-01-26';
EXEC addPurchase @ServiceID=16,@EmployeeID=9,@Date='2020-01-31',@Price=15.0,@CardID=null,@CustomerID=11,@From='2020-01-31',@To='2020-01-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-02-01',@Price=10.0,@CardID=10,@CustomerID=10,@From='2020-02-01',@To='2020-02-01';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2020-02-02',@Price=171.0,@CardID=11,@CustomerID=11,@From='2020-02-02',@To='2020-05-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-02-03',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-02-03',@To='2020-02-03';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2020-02-06',@Price=57.0,@CardID=3,@CustomerID=3,@From='2020-02-06',@To='2020-05-06';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-02-08',@Price=49.0,@CardID=10,@CustomerID=10,@From='2020-02-08',@To='2020-03-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-02-08',@Price=21.0,@CardID=4,@CustomerID=4,@From='2020-02-08',@To='2020-03-09';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-02-10',@Price=15.0,@CardID=null,@CustomerID=12,@From='2020-02-10',@To='2020-02-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-02-10',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-02-10',@To='2020-02-10';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2020-02-11',@Price=560.0,@CardID=7,@CustomerID=7,@From='2020-02-11',@To='2020-05-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-02-11',@Price=12.0,@CardID=12,@CustomerID=12,@From='2020-02-11',@To='2020-02-11';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-02-14',@Price=30.0,@CardID=1,@CustomerID=1,@From='2020-02-14',@To='2020-03-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-02-14',@Price=4.5,@CardID=2,@CustomerID=2,@From='2020-02-14',@To='2020-02-14';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-02-17',@Price=21.0,@CardID=2,@CustomerID=2,@From='2020-02-17',@To='2020-03-18';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2020-02-19',@Price=15.0,@CardID=null,@CustomerID=13,@From='2020-02-19',@To='2020-02-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-02-20',@Price=15.0,@CardID=9,@CustomerID=9,@From='2020-02-20',@To='2020-02-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-02-20',@Price=90.0,@CardID=13,@CustomerID=13,@From='2020-02-20',@To='2020-03-21';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2020-02-21',@Price=15.0,@CardID=null,@CustomerID=14,@From='2020-02-21',@To='2020-02-21';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-02-21',@Price=10.0,@CardID=5,@CustomerID=5,@From='2020-02-21',@To='2020-02-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-02-23',@Price=35.0,@CardID=14,@CustomerID=14,@From='2020-02-23',@To='2020-02-23';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-02-24',@Price=80.0,@CardID=5,@CustomerID=5,@From='2020-02-24',@To='2020-03-25';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2020-02-28',@Price=15.0,@CardID=null,@CustomerID=15,@From='2020-02-28',@To='2020-02-28';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2020-02-28',@Price=237.5,@CardID=14,@CustomerID=14,@From='2020-02-28',@To='2020-03-29';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-02-29',@Price=63.0,@CardID=9,@CustomerID=9,@From='2020-02-29',@To='2020-03-30';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2020-03-01',@Price=522.5,@CardID=15,@CustomerID=15,@From='2020-03-01',@To='2020-05-30';
EXEC addPurchase @ServiceID=17,@EmployeeID=8,@Date='2020-03-01',@Price=100.0,@CardID=null,@CustomerID=16,@From='2020-03-01',@To='2020-03-01';
EXEC addPurchase @ServiceID=17,@EmployeeID=8,@Date='2020-03-03',@Price=100.0,@CardID=null,@CustomerID=17,@From='2020-03-03',@To='2020-03-03';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2020-03-04',@Price=440.0,@CardID=16,@CustomerID=16,@From='2020-03-04',@To='2020-06-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-03-05',@Price=10.0,@CardID=12,@CustomerID=12,@From='2020-03-05',@To='2020-03-05';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-03-06',@Price=70.0,@CardID=17,@CustomerID=17,@From='2020-03-06',@To='2020-04-05';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-03-08',@Price=15.0,@CardID=null,@CustomerID=18,@From='2020-03-08',@To='2020-03-08';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2020-03-08',@Price=15.0,@CardID=null,@CustomerID=19,@From='2020-03-08',@To='2020-03-08';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-03-08',@Price=15.0,@CardID=null,@CustomerID=20,@From='2020-03-08',@To='2020-03-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-03-09',@Price=15.0,@CardID=19,@CustomerID=19,@From='2020-03-09',@To='2020-03-09';
EXEC addPurchase @ServiceID=19,@EmployeeID=9,@Date='2020-03-10',@Price=15.0,@CardID=null,@CustomerID=21,@From='2020-03-10',@To='2020-03-10';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2020-03-10',@Price=224.0,@CardID=20,@CustomerID=20,@From='2020-03-10',@To='2020-06-08';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2020-03-10',@Price=84.0,@CardID=4,@CustomerID=4,@From='2020-03-10',@To='2020-06-08';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-03-11',@Price=210.0,@CardID=18,@CustomerID=18,@From='2020-03-11',@To='2020-04-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-03-11',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-03-11',@To='2020-03-11';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-03-11',@Price=35.0,@CardID=19,@CustomerID=19,@From='2020-03-11',@To='2020-03-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-03-12',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-03-12',@To='2020-03-12';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-03-13',@Price=15.0,@CardID=null,@CustomerID=22,@From='2020-03-13',@To='2020-03-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-03-13',@Price=10.0,@CardID=10,@CustomerID=10,@From='2020-03-13',@To='2020-03-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-03-14',@Price=56.0,@CardID=22,@CustomerID=22,@From='2020-03-14',@To='2020-04-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-03-15',@Price=12.0,@CardID=12,@CustomerID=12,@From='2020-03-15',@To='2020-03-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-03-16',@Price=21.0,@CardID=1,@CustomerID=1,@From='2020-03-16',@To='2020-04-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-03-17',@Price=49.0,@CardID=10,@CustomerID=10,@From='2020-03-17',@To='2020-04-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-03-18',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-03-18',@To='2020-03-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-03-18',@Price=9.0,@CardID=19,@CustomerID=19,@From='2020-03-18',@To='2020-03-18';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-03-20',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-03-20',@To='2020-03-20';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-03-20',@Price=25.0,@CardID=19,@CustomerID=19,@From='2020-03-20',@To='2020-03-20';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-03-20',@Price=56.0,@CardID=21,@CustomerID=21,@From='2020-03-20',@To='2020-04-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-03-21',@Price=28.0,@CardID=12,@CustomerID=12,@From='2020-03-21',@To='2020-03-21';
EXEC addPurchase @ServiceID=17,@EmployeeID=7,@Date='2020-03-21',@Price=100.0,@CardID=null,@CustomerID=23,@From='2020-03-21',@To='2020-03-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-03-22',@Price=4.5,@CardID=2,@CustomerID=2,@From='2020-03-22',@To='2020-03-22';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2020-03-23',@Price=560.0,@CardID=23,@CustomerID=23,@From='2020-03-23',@To='2020-06-21';
EXEC addPurchase @ServiceID=19,@EmployeeID=8,@Date='2020-03-25',@Price=15.0,@CardID=null,@CustomerID=24,@From='2020-03-25',@To='2020-03-25';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-03-25',@Price=210.0,@CardID=12,@CustomerID=12,@From='2020-03-25',@To='2020-04-24';
EXEC addPurchase @ServiceID=16,@EmployeeID=9,@Date='2020-03-25',@Price=15.0,@CardID=null,@CustomerID=25,@From='2020-03-25',@To='2020-03-25';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-03-26',@Price=199.5,@CardID=13,@CustomerID=13,@From='2020-03-26',@To='2020-04-25';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2020-03-26',@Price=15.0,@CardID=null,@CustomerID=26,@From='2020-03-26',@To='2020-03-26';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2020-03-27',@Price=210.0,@CardID=2,@CustomerID=2,@From='2020-03-27',@To='2020-06-25';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2020-03-28',@Price=324.0,@CardID=26,@CustomerID=26,@From='2020-03-28',@To='2020-09-24';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2020-03-28',@Price=665.0,@CardID=25,@CustomerID=25,@From='2020-03-28',@To='2020-06-26';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-03-28',@Price=20.0,@CardID=24,@CustomerID=24,@From='2020-03-28',@To='2020-03-28';
EXEC addPurchase @ServiceID=17,@EmployeeID=9,@Date='2020-03-28',@Price=100.0,@CardID=null,@CustomerID=27,@From='2020-03-28',@To='2020-03-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-03-30',@Price=10.0,@CardID=27,@CustomerID=27,@From='2020-03-30',@To='2020-03-30';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2020-03-30',@Price=237.5,@CardID=14,@CustomerID=14,@From='2020-03-30',@To='2020-04-29';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-03-30',@Price=80.0,@CardID=5,@CustomerID=5,@From='2020-03-30',@To='2020-04-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-04-02',@Price=9.0,@CardID=9,@CustomerID=9,@From='2020-04-02',@To='2020-04-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-04-03',@Price=28.0,@CardID=24,@CustomerID=24,@From='2020-04-03',@To='2020-04-03';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-04-06',@Price=49.0,@CardID=27,@CustomerID=27,@From='2020-04-06',@To='2020-05-06';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-04-06',@Price=63.0,@CardID=9,@CustomerID=9,@From='2020-04-06',@To='2020-05-06';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-04-06',@Price=15.0,@CardID=null,@CustomerID=28,@From='2020-04-06',@To='2020-04-06';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-04-07',@Price=56.0,@CardID=28,@CustomerID=28,@From='2020-04-07',@To='2020-05-07';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2020-04-09',@Price=378.0,@CardID=17,@CustomerID=17,@From='2020-04-09',@To='2020-10-06';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-04-10',@Price=20.0,@CardID=24,@CustomerID=24,@From='2020-04-10',@To='2020-04-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-04-13',@Price=20.0,@CardID=18,@CustomerID=18,@From='2020-04-13',@To='2020-04-13';
EXEC addPurchase @ServiceID=17,@EmployeeID=8,@Date='2020-04-14',@Price=100.0,@CardID=null,@CustomerID=29,@From='2020-04-14',@To='2020-04-14';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2020-04-14',@Price=250.0,@CardID=22,@CustomerID=22,@From='2020-04-14',@To='2020-05-14';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2020-04-15',@Price=133.0,@CardID=29,@CustomerID=29,@From='2020-04-15',@To='2020-07-14';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2020-04-16',@Price=700.0,@CardID=18,@CustomerID=18,@From='2020-04-16',@To='2020-07-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-04-17',@Price=4.5,@CardID=1,@CustomerID=1,@From='2020-04-17',@To='2020-04-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-04-19',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-04-19',@To='2020-04-19';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2020-04-19',@Price=550.0,@CardID=24,@CustomerID=24,@From='2020-04-19',@To='2020-07-18';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-04-20',@Price=35.0,@CardID=19,@CustomerID=19,@From='2020-04-20',@To='2020-04-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-04-21',@Price=70.0,@CardID=10,@CustomerID=10,@From='2020-04-21',@To='2020-05-21';
EXEC addPurchase @ServiceID=17,@EmployeeID=7,@Date='2020-04-22',@Price=100.0,@CardID=null,@CustomerID=30,@From='2020-04-22',@To='2020-04-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-04-22',@Price=35.0,@CardID=8,@CustomerID=8,@From='2020-04-22',@To='2020-04-22';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-04-23',@Price=25.0,@CardID=19,@CustomerID=19,@From='2020-04-23',@To='2020-04-23';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-04-24',@Price=49.0,@CardID=30,@CustomerID=30,@From='2020-04-24',@To='2020-05-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-04-24',@Price=28.0,@CardID=12,@CustomerID=12,@From='2020-04-24',@To='2020-04-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-04-26',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-04-26',@To='2020-04-26';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-04-27',@Price=63.0,@CardID=13,@CustomerID=13,@From='2020-04-27',@To='2020-05-27';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-04-27',@Price=30.0,@CardID=1,@CustomerID=1,@From='2020-04-27',@To='2020-05-27';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2020-04-27',@Price=15.0,@CardID=null,@CustomerID=31,@From='2020-04-27',@To='2020-04-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-04-28',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-04-28',@To='2020-04-28';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2020-04-30',@Price=522.5,@CardID=14,@CustomerID=14,@From='2020-04-30',@To='2020-07-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-04-30',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-04-30',@To='2020-04-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-05-01',@Price=80.0,@CardID=5,@CustomerID=5,@From='2020-05-01',@To='2020-05-31';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-05-02',@Price=25.0,@CardID=19,@CustomerID=19,@From='2020-05-02',@To='2020-05-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-05-04',@Price=12.0,@CardID=12,@CustomerID=12,@From='2020-05-04',@To='2020-05-04';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-05-05',@Price=15.0,@CardID=null,@CustomerID=32,@From='2020-05-05',@To='2020-05-05';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2020-05-05',@Price=171.0,@CardID=11,@CustomerID=11,@From='2020-05-05',@To='2020-08-03';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-05-06',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-05-06',@To='2020-05-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-05-06',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-05-06',@To='2020-05-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-05-06',@Price=10.0,@CardID=27,@CustomerID=27,@From='2020-05-06',@To='2020-05-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-05-07',@Price=10.0,@CardID=32,@CustomerID=32,@From='2020-05-07',@To='2020-05-07';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2020-05-08',@Price=210.0,@CardID=28,@CustomerID=28,@From='2020-05-08',@To='2020-06-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-05-08',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-05-08',@To='2020-05-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-05-08',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-05-08',@To='2020-05-08';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-05-08',@Price=63.0,@CardID=3,@CustomerID=3,@From='2020-05-08',@To='2020-06-07';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-05-09',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-05-09',@To='2020-05-09';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-05-09',@Price=70.0,@CardID=27,@CustomerID=27,@From='2020-05-09',@To='2020-06-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-05-09',@Price=35.0,@CardID=19,@CustomerID=19,@From='2020-05-09',@To='2020-05-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-05-09',@Price=56.0,@CardID=32,@CustomerID=32,@From='2020-05-09',@To='2020-06-08';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2020-05-11',@Price=15.0,@CardID=null,@CustomerID=33,@From='2020-05-11',@To='2020-05-11';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-05-12',@Price=15.0,@CardID=null,@CustomerID=34,@From='2020-05-12',@To='2020-05-12';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-05-12',@Price=10.0,@CardID=12,@CustomerID=12,@From='2020-05-12',@To='2020-05-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-05-13',@Price=15.0,@CardID=7,@CustomerID=7,@From='2020-05-13',@To='2020-05-13';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2020-05-13',@Price=15.0,@CardID=null,@CustomerID=35,@From='2020-05-13',@To='2020-05-13';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-05-14',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-05-14',@To='2020-05-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-05-14',@Price=90.0,@CardID=33,@CustomerID=33,@From='2020-05-14',@To='2020-06-13';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2020-05-15',@Price=224.0,@CardID=34,@CustomerID=34,@From='2020-05-15',@To='2020-08-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-05-15',@Price=56.0,@CardID=12,@CustomerID=12,@From='2020-05-15',@To='2020-06-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-05-15',@Price=9.0,@CardID=19,@CustomerID=19,@From='2020-05-15',@To='2020-05-15';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2020-05-16',@Price=522.5,@CardID=35,@CustomerID=35,@From='2020-05-16',@To='2020-08-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-05-17',@Price=15.0,@CardID=31,@CustomerID=31,@From='2020-05-17',@To='2020-05-17';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2020-05-18',@Price=196.0,@CardID=7,@CustomerID=7,@From='2020-05-18',@To='2020-08-16';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-05-18',@Price=56.0,@CardID=22,@CustomerID=22,@From='2020-05-18',@To='2020-06-17';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-05-18',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-05-18',@To='2020-05-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-05-19',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-05-19',@To='2020-05-19';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2020-05-21',@Price=15.0,@CardID=null,@CustomerID=36,@From='2020-05-21',@To='2020-05-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-05-22',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-05-22',@To='2020-05-22';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2020-05-22',@Price=15.0,@CardID=null,@CustomerID=37,@From='2020-05-22',@To='2020-05-22';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2020-05-23',@Price=522.5,@CardID=36,@CustomerID=36,@From='2020-05-23',@To='2020-08-21';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-05-23',@Price=80.0,@CardID=37,@CustomerID=37,@From='2020-05-23',@To='2020-06-22';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-05-24',@Price=70.0,@CardID=10,@CustomerID=10,@From='2020-05-24',@To='2020-06-23';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-05-24',@Price=35.0,@CardID=19,@CustomerID=19,@From='2020-05-24',@To='2020-05-24';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2020-05-25',@Price=196.0,@CardID=30,@CustomerID=30,@From='2020-05-25',@To='2020-08-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-05-27',@Price=9.0,@CardID=8,@CustomerID=8,@From='2020-05-27',@To='2020-05-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-05-27',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-05-27',@To='2020-05-27';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-05-30',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-05-30',@To='2020-05-30';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2020-05-30',@Price=171.0,@CardID=13,@CustomerID=13,@From='2020-05-30',@To='2020-08-28';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-05-30',@Price=199.5,@CardID=15,@CustomerID=15,@From='2020-05-30',@To='2020-06-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-05-30',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-05-30',@To='2020-05-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-05-31',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-05-31',@To='2020-05-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-05-31',@Price=3.0,@CardID=1,@CustomerID=1,@From='2020-05-31',@To='2020-05-31';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2020-06-01',@Price=15.0,@CardID=null,@CustomerID=38,@From='2020-06-01',@To='2020-06-01';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-06-01',@Price=90.0,@CardID=19,@CustomerID=19,@From='2020-06-01',@To='2020-07-01';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-06-02',@Price=12.0,@CardID=5,@CustomerID=5,@From='2020-06-02',@To='2020-06-02';
EXEC addPurchase @ServiceID=17,@EmployeeID=9,@Date='2020-06-03',@Price=100.0,@CardID=null,@CustomerID=39,@From='2020-06-03',@To='2020-06-03';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-06-03',@Price=90.0,@CardID=38,@CustomerID=38,@From='2020-06-03',@To='2020-07-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-06-04',@Price=15.0,@CardID=31,@CustomerID=31,@From='2020-06-04',@To='2020-06-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-06-04',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-06-04',@To='2020-06-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-06-04',@Price=10.0,@CardID=5,@CustomerID=5,@From='2020-06-04',@To='2020-06-04';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-06-05',@Price=35.0,@CardID=39,@CustomerID=39,@From='2020-06-05',@To='2020-06-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-06-07',@Price=3.0,@CardID=1,@CustomerID=1,@From='2020-06-07',@To='2020-06-07';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2020-06-07',@Price=200.0,@CardID=16,@CustomerID=16,@From='2020-06-07',@To='2020-07-07';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2020-06-08',@Price=152.0,@CardID=28,@CustomerID=28,@From='2020-06-08',@To='2020-09-06';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-06-08',@Price=90.0,@CardID=9,@CustomerID=9,@From='2020-06-08',@To='2020-07-08';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-06-08',@Price=80.0,@CardID=5,@CustomerID=5,@From='2020-06-08',@To='2020-07-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-06-08',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-06-08',@To='2020-06-08';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2020-06-08',@Price=57.0,@CardID=4,@CustomerID=4,@From='2020-06-08',@To='2020-09-06';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-06-08',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-06-08',@To='2020-06-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-06-10',@Price=15.0,@CardID=27,@CustomerID=27,@From='2020-06-10',@To='2020-06-10';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2020-06-10',@Price=165.0,@CardID=3,@CustomerID=3,@From='2020-06-10',@To='2020-09-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-06-10',@Price=9.0,@CardID=31,@CustomerID=31,@From='2020-06-10',@To='2020-06-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-06-11',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-06-11',@To='2020-06-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-06-11',@Price=10.0,@CardID=32,@CustomerID=32,@From='2020-06-11',@To='2020-06-11';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2020-06-13',@Price=288.0,@CardID=20,@CustomerID=20,@From='2020-06-13',@To='2020-12-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-06-13',@Price=35.0,@CardID=39,@CustomerID=39,@From='2020-06-13',@To='2020-06-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-06-13',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-06-13',@To='2020-06-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-06-13',@Price=15.0,@CardID=31,@CustomerID=31,@From='2020-06-13',@To='2020-06-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-06-13',@Price=21.0,@CardID=1,@CustomerID=1,@From='2020-06-13',@To='2020-07-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-06-15',@Price=9.0,@CardID=8,@CustomerID=8,@From='2020-06-15',@To='2020-06-15';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-06-15',@Price=35.0,@CardID=27,@CustomerID=27,@From='2020-06-15',@To='2020-06-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-06-17',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-06-17',@To='2020-06-17';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2020-06-17',@Price=224.0,@CardID=32,@CustomerID=32,@From='2020-06-17',@To='2020-09-15';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2020-06-18',@Price=252.0,@CardID=33,@CustomerID=33,@From='2020-06-18',@To='2020-09-16';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-06-18',@Price=80.0,@CardID=22,@CustomerID=22,@From='2020-06-18',@To='2020-07-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-06-18',@Price=10.0,@CardID=12,@CustomerID=12,@From='2020-06-18',@To='2020-06-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-06-18',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-06-18',@To='2020-06-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-06-18',@Price=10.0,@CardID=27,@CustomerID=27,@From='2020-06-18',@To='2020-06-18';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-06-20',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-06-20',@To='2020-06-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-06-22',@Price=9.0,@CardID=8,@CustomerID=8,@From='2020-06-22',@To='2020-06-22';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-06-22',@Price=56.0,@CardID=37,@CustomerID=37,@From='2020-06-22',@To='2020-07-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-06-22',@Price=15.0,@CardID=39,@CustomerID=39,@From='2020-06-22',@To='2020-06-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-06-23',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-06-23',@To='2020-06-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-06-24',@Price=10.0,@CardID=27,@CustomerID=27,@From='2020-06-24',@To='2020-06-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-06-25',@Price=20.0,@CardID=12,@CustomerID=12,@From='2020-06-25',@To='2020-06-25';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2020-06-26',@Price=560.0,@CardID=23,@CustomerID=23,@From='2020-06-26',@To='2020-09-24';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2020-06-26',@Price=199.5,@CardID=25,@CustomerID=25,@From='2020-06-26',@To='2020-07-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-06-26',@Price=15.0,@CardID=10,@CustomerID=10,@From='2020-06-26',@To='2020-06-26';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-06-27',@Price=35.0,@CardID=39,@CustomerID=39,@From='2020-06-27',@To='2020-06-27';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-06-27',@Price=30.0,@CardID=2,@CustomerID=2,@From='2020-06-27',@To='2020-07-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-06-28',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-06-28',@To='2020-06-28';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-06-28',@Price=28.0,@CardID=12,@CustomerID=12,@From='2020-06-28',@To='2020-06-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-06-29',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-06-29',@To='2020-06-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-06-29',@Price=10.0,@CardID=39,@CustomerID=39,@From='2020-06-29',@To='2020-06-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-06-30',@Price=10.0,@CardID=12,@CustomerID=12,@From='2020-06-30',@To='2020-06-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-06-30',@Price=15.0,@CardID=10,@CustomerID=10,@From='2020-06-30',@To='2020-06-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-07-02',@Price=10.0,@CardID=27,@CustomerID=27,@From='2020-07-02',@To='2020-07-02';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2020-07-02',@Price=171.0,@CardID=15,@CustomerID=15,@From='2020-07-02',@To='2020-09-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-07-02',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-07-02',@To='2020-07-02';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2020-07-02',@Price=522.5,@CardID=8,@CustomerID=8,@From='2020-07-02',@To='2020-09-30';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2020-07-04',@Price=378.0,@CardID=39,@CustomerID=39,@From='2020-07-04',@To='2020-12-31';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-07-05',@Price=90.0,@CardID=19,@CustomerID=19,@From='2020-07-05',@To='2020-08-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-07-05',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-07-05',@To='2020-07-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-07-07',@Price=10.0,@CardID=27,@CustomerID=27,@From='2020-07-07',@To='2020-07-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-07-08',@Price=15.0,@CardID=9,@CustomerID=9,@From='2020-07-08',@To='2020-07-08';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-07-09',@Price=49.0,@CardID=10,@CustomerID=10,@From='2020-07-09',@To='2020-08-08';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-07-10',@Price=56.0,@CardID=5,@CustomerID=5,@From='2020-07-10',@To='2020-08-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-07-11',@Price=63.0,@CardID=6,@CustomerID=6,@From='2020-07-11',@To='2020-08-10';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2020-07-12',@Price=560.0,@CardID=16,@CustomerID=16,@From='2020-07-12',@To='2020-10-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-07-12',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-07-12',@To='2020-07-12';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-07-13',@Price=9.0,@CardID=9,@CustomerID=9,@From='2020-07-13',@To='2020-07-13';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-07-15',@Price=210.0,@CardID=18,@CustomerID=18,@From='2020-07-15',@To='2020-08-14';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-07-16',@Price=21.0,@CardID=1,@CustomerID=1,@From='2020-07-16',@To='2020-08-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-07-16',@Price=49.0,@CardID=27,@CustomerID=27,@From='2020-07-16',@To='2020-08-15';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2020-07-19',@Price=196.0,@CardID=29,@CustomerID=29,@From='2020-07-19',@To='2020-10-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-07-20',@Price=15.0,@CardID=9,@CustomerID=9,@From='2020-07-20',@To='2020-07-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-07-20',@Price=12.0,@CardID=22,@CustomerID=22,@From='2020-07-20',@To='2020-07-20';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-07-20',@Price=28.0,@CardID=24,@CustomerID=24,@From='2020-07-20',@To='2020-07-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-07-22',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-07-22',@To='2020-07-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-07-23',@Price=28.0,@CardID=24,@CustomerID=24,@From='2020-07-23',@To='2020-07-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-07-25',@Price=12.0,@CardID=12,@CustomerID=12,@From='2020-07-25',@To='2020-07-25';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-07-27',@Price=56.0,@CardID=22,@CustomerID=22,@From='2020-07-27',@To='2020-08-26';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2020-07-27',@Price=432.0,@CardID=37,@CustomerID=37,@From='2020-07-27',@To='2021-01-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-07-28',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-07-28',@To='2020-07-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-07-28',@Price=15.0,@CardID=9,@CustomerID=9,@From='2020-07-28',@To='2020-07-28';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-07-30',@Price=35.0,@CardID=38,@CustomerID=38,@From='2020-07-30',@To='2020-07-30';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-07-31',@Price=199.5,@CardID=25,@CustomerID=25,@From='2020-07-31',@To='2020-08-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-07-31',@Price=10.0,@CardID=24,@CustomerID=24,@From='2020-07-31',@To='2020-07-31';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-07-31',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-07-31',@To='2020-07-31';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2020-08-03',@Price=665.0,@CardID=14,@CustomerID=14,@From='2020-08-03',@To='2020-11-01';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-08-03',@Price=20.0,@CardID=24,@CustomerID=24,@From='2020-08-03',@To='2020-08-03';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2020-08-03',@Price=252.0,@CardID=11,@CustomerID=11,@From='2020-08-03',@To='2020-11-01';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-08-03',@Price=20.0,@CardID=12,@CustomerID=12,@From='2020-08-03',@To='2020-08-03';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-08-06',@Price=90.0,@CardID=9,@CustomerID=9,@From='2020-08-06',@To='2020-09-05';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2020-08-07',@Price=152.0,@CardID=12,@CustomerID=12,@From='2020-08-07',@To='2020-11-05';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-08-08',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-08-08',@To='2020-08-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-08-09',@Price=15.0,@CardID=19,@CustomerID=19,@From='2020-08-09',@To='2020-08-09';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-08-10',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-08-10',@To='2020-08-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-08-13',@Price=15.0,@CardID=10,@CustomerID=10,@From='2020-08-13',@To='2020-08-13';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-08-13',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-08-13',@To='2020-08-13';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2020-08-14',@Price=250.0,@CardID=34,@CustomerID=34,@From='2020-08-14',@To='2020-09-13';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2020-08-14',@Price=252.0,@CardID=6,@CustomerID=6,@From='2020-08-14',@To='2020-11-12';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-08-14',@Price=80.0,@CardID=5,@CustomerID=5,@From='2020-08-14',@To='2020-09-13';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-08-15',@Price=210.0,@CardID=18,@CustomerID=18,@From='2020-08-15',@To='2020-09-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-08-16',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-08-16',@To='2020-08-16';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2020-08-16',@Price=522.5,@CardID=35,@CustomerID=35,@From='2020-08-16',@To='2020-11-14';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-08-16',@Price=49.0,@CardID=27,@CustomerID=27,@From='2020-08-16',@To='2020-09-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-08-17',@Price=10.0,@CardID=10,@CustomerID=10,@From='2020-08-17',@To='2020-08-17';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-08-17',@Price=168.0,@CardID=7,@CustomerID=7,@From='2020-08-17',@To='2020-09-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-08-17',@Price=3.0,@CardID=1,@CustomerID=1,@From='2020-08-17',@To='2020-08-17';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-08-20',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-08-20',@To='2020-08-20';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-08-22',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-08-22',@To='2020-08-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-08-22',@Price=9.0,@CardID=31,@CustomerID=31,@From='2020-08-22',@To='2020-08-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-08-23',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-08-23',@To='2020-08-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-08-25',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-08-25',@To='2020-08-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-08-26',@Price=3.0,@CardID=2,@CustomerID=2,@From='2020-08-26',@To='2020-08-26';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-08-26',@Price=30.0,@CardID=1,@CustomerID=1,@From='2020-08-26',@To='2020-09-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-08-26',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-08-26',@To='2020-08-26';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2020-08-26',@Price=199.5,@CardID=36,@CustomerID=36,@From='2020-08-26',@To='2020-09-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-08-27',@Price=15.0,@CardID=10,@CustomerID=10,@From='2020-08-27',@To='2020-08-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-08-27',@Price=35.0,@CardID=30,@CustomerID=30,@From='2020-08-27',@To='2020-08-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-08-28',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-08-28',@To='2020-08-28';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-08-29',@Price=56.0,@CardID=22,@CustomerID=22,@From='2020-08-29',@To='2020-09-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-08-30',@Price=4.5,@CardID=2,@CustomerID=2,@From='2020-08-30',@To='2020-08-30';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2020-08-30',@Price=665.0,@CardID=25,@CustomerID=25,@From='2020-08-30',@To='2020-11-28';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2020-08-31',@Price=252.0,@CardID=30,@CustomerID=30,@From='2020-08-31',@To='2021-02-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-08-31',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-08-31',@To='2020-08-31';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-08-31',@Price=25.0,@CardID=38,@CustomerID=38,@From='2020-08-31',@To='2020-08-31';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-09-01',@Price=90.0,@CardID=13,@CustomerID=13,@From='2020-09-01',@To='2020-10-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-09-01',@Price=3.0,@CardID=2,@CustomerID=2,@From='2020-09-01',@To='2020-09-01';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-09-03',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-09-03',@To='2020-09-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-09-05',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-09-05',@To='2020-09-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-09-05',@Price=9.0,@CardID=38,@CustomerID=38,@From='2020-09-05',@To='2020-09-05';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2020-09-06',@Price=378.0,@CardID=10,@CustomerID=10,@From='2020-09-06',@To='2021-03-05';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-09-07',@Price=15.0,@CardID=9,@CustomerID=9,@From='2020-09-07',@To='2020-09-07';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-09-07',@Price=30.0,@CardID=4,@CustomerID=4,@From='2020-09-07',@To='2020-10-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-09-09',@Price=3.0,@CardID=2,@CustomerID=2,@From='2020-09-09',@To='2020-09-09';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2020-09-10',@Price=57.0,@CardID=3,@CustomerID=3,@From='2020-09-10',@To='2020-12-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-09-10',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-09-10',@To='2020-09-10';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2020-09-11',@Price=550.0,@CardID=28,@CustomerID=28,@From='2020-09-11',@To='2020-12-10';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2020-09-11',@Price=162.0,@CardID=2,@CustomerID=2,@From='2020-09-11',@To='2021-03-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-09-11',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-09-11',@To='2020-09-11';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-09-13',@Price=210.0,@CardID=34,@CustomerID=34,@From='2020-09-13',@To='2020-10-13';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-09-14',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-09-14',@To='2020-09-14';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-09-16',@Price=56.0,@CardID=5,@CustomerID=5,@From='2020-09-16',@To='2020-10-16';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-09-17',@Price=168.0,@CardID=7,@CustomerID=7,@From='2020-09-17',@To='2020-10-17';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-09-18',@Price=25.0,@CardID=19,@CustomerID=19,@From='2020-09-18',@To='2020-09-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-09-19',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-09-19',@To='2020-09-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-09-19',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-09-19',@To='2020-09-19';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2020-09-19',@Price=210.0,@CardID=18,@CustomerID=18,@From='2020-09-19',@To='2020-10-19';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-09-20',@Price=49.0,@CardID=27,@CustomerID=27,@From='2020-09-20',@To='2020-10-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-09-20',@Price=12.0,@CardID=32,@CustomerID=32,@From='2020-09-20',@To='2020-09-20';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2020-09-21',@Price=252.0,@CardID=33,@CustomerID=33,@From='2020-09-21',@To='2020-12-20';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-09-22',@Price=35.0,@CardID=19,@CustomerID=19,@From='2020-09-22',@To='2020-09-22';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-09-24',@Price=63.0,@CardID=19,@CustomerID=19,@From='2020-09-24',@To='2020-10-24';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2020-09-25',@Price=237.5,@CardID=36,@CustomerID=36,@From='2020-09-25',@To='2020-10-25';
EXEC addPurchase @ServiceID=6,@EmployeeID=8,@Date='2020-09-26',@Price=324.0,@CardID=26,@CustomerID=26,@From='2020-09-26',@To='2021-03-25';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-09-27',@Price=168.0,@CardID=23,@CustomerID=23,@From='2020-09-27',@To='2020-10-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-09-29',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-09-29',@To='2020-09-29';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2020-09-30',@Price=56.0,@CardID=32,@CustomerID=32,@From='2020-09-30',@To='2020-10-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-09-30',@Price=30.0,@CardID=1,@CustomerID=1,@From='2020-09-30',@To='2020-10-30';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-09-30',@Price=199.5,@CardID=15,@CustomerID=15,@From='2020-09-30',@To='2020-10-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-10-02',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-10-02',@To='2020-10-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-10-02',@Price=12.0,@CardID=24,@CustomerID=24,@From='2020-10-02',@To='2020-10-02';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-10-03',@Price=80.0,@CardID=22,@CustomerID=22,@From='2020-10-03',@To='2020-11-02';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-10-04',@Price=199.5,@CardID=13,@CustomerID=13,@From='2020-10-04',@To='2020-11-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-10-04',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-10-04',@To='2020-10-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-10-04',@Price=20.0,@CardID=24,@CustomerID=24,@From='2020-10-04',@To='2020-10-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-10-06',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-10-06',@To='2020-10-06';
EXEC addPurchase @ServiceID=6,@EmployeeID=7,@Date='2020-10-10',@Price=252.0,@CardID=17,@CustomerID=17,@From='2020-10-10',@To='2021-04-08';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2020-10-11',@Price=210.0,@CardID=4,@CustomerID=4,@From='2020-10-11',@To='2021-01-09';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-10-11',@Price=35.0,@CardID=8,@CustomerID=8,@From='2020-10-11',@To='2020-10-11';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2020-10-11',@Price=133.0,@CardID=16,@CustomerID=16,@From='2020-10-11',@To='2021-01-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-10-12',@Price=15.0,@CardID=31,@CustomerID=31,@From='2020-10-12',@To='2020-10-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-10-13',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-10-13',@To='2020-10-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-10-14',@Price=10.0,@CardID=24,@CustomerID=24,@From='2020-10-14',@To='2020-10-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-10-15',@Price=90.0,@CardID=9,@CustomerID=9,@From='2020-10-15',@To='2020-11-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-10-15',@Price=20.0,@CardID=21,@CustomerID=21,@From='2020-10-15',@To='2020-10-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-10-16',@Price=12.0,@CardID=24,@CustomerID=24,@From='2020-10-16',@To='2020-10-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-10-17',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-10-17',@To='2020-10-17';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2020-10-18',@Price=560.0,@CardID=7,@CustomerID=7,@From='2020-10-18',@To='2021-01-16';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2020-10-18',@Price=224.0,@CardID=34,@CustomerID=34,@From='2020-10-18',@To='2021-01-16';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-10-19',@Price=56.0,@CardID=5,@CustomerID=5,@From='2020-10-19',@To='2020-11-18';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-10-20',@Price=49.0,@CardID=27,@CustomerID=27,@From='2020-10-20',@To='2020-11-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2020-10-20',@Price=28.0,@CardID=21,@CustomerID=21,@From='2020-10-20',@To='2020-10-20';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-10-20',@Price=35.0,@CardID=38,@CustomerID=38,@From='2020-10-20',@To='2020-10-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-10-20',@Price=10.0,@CardID=24,@CustomerID=24,@From='2020-10-20',@To='2020-10-20';
EXEC addPurchase @ServiceID=6,@EmployeeID=7,@Date='2020-10-22',@Price=252.0,@CardID=29,@CustomerID=29,@From='2020-10-22',@To='2021-04-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-10-22',@Price=12.0,@CardID=24,@CustomerID=24,@From='2020-10-22',@To='2020-10-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-10-22',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-10-22',@To='2020-10-22';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2020-10-22',@Price=550.0,@CardID=18,@CustomerID=18,@From='2020-10-22',@To='2021-01-20';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-10-27',@Price=28.0,@CardID=24,@CustomerID=24,@From='2020-10-27',@To='2020-10-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2020-10-27',@Price=9.0,@CardID=19,@CustomerID=19,@From='2020-10-27',@To='2020-10-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-10-27',@Price=35.0,@CardID=8,@CustomerID=8,@From='2020-10-27',@To='2020-10-27';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2020-10-30',@Price=199.5,@CardID=36,@CustomerID=36,@From='2020-10-30',@To='2020-11-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-10-30',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-10-30',@To='2020-10-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-10-30',@Price=25.0,@CardID=38,@CustomerID=38,@From='2020-10-30',@To='2020-10-30';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-10-30',@Price=168.0,@CardID=23,@CustomerID=23,@From='2020-10-30',@To='2020-11-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-10-31',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-10-31',@To='2020-10-31';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2020-10-31',@Price=210.0,@CardID=1,@CustomerID=1,@From='2020-10-31',@To='2021-01-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-11-02',@Price=15.0,@CardID=15,@CustomerID=15,@From='2020-11-02',@To='2020-11-02';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-11-02',@Price=25.0,@CardID=19,@CustomerID=19,@From='2020-11-02',@To='2020-11-02';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-11-02',@Price=199.5,@CardID=14,@CustomerID=14,@From='2020-11-02',@To='2020-12-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-11-03',@Price=28.0,@CardID=24,@CustomerID=24,@From='2020-11-03',@To='2020-11-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-11-04',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-11-04',@To='2020-11-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-11-04',@Price=10.0,@CardID=32,@CustomerID=32,@From='2020-11-04',@To='2020-11-04';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-11-04',@Price=56.0,@CardID=22,@CustomerID=22,@From='2020-11-04',@To='2020-12-04';
EXEC addPurchase @ServiceID=8,@EmployeeID=9,@Date='2020-11-05',@Price=15.0,@CardID=24,@CustomerID=24,@From='2020-11-05',@To='2020-11-05';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2020-11-06',@Price=171.0,@CardID=11,@CustomerID=11,@From='2020-11-06',@To='2021-02-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-11-06',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-11-06',@To='2020-11-06';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2020-11-07',@Price=199.5,@CardID=13,@CustomerID=13,@From='2020-11-07',@To='2020-12-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-11-07',@Price=12.0,@CardID=21,@CustomerID=21,@From='2020-11-07',@To='2020-11-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-11-08',@Price=12.0,@CardID=12,@CustomerID=12,@From='2020-11-08',@To='2020-11-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-11-08',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-11-08',@To='2020-11-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-11-10',@Price=35.0,@CardID=19,@CustomerID=19,@From='2020-11-10',@To='2020-11-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-11-10',@Price=35.0,@CardID=38,@CustomerID=38,@From='2020-11-10',@To='2020-11-10';
EXEC addPurchase @ServiceID=6,@EmployeeID=8,@Date='2020-11-12',@Price=324.0,@CardID=19,@CustomerID=19,@From='2020-11-12',@To='2021-05-11';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2020-11-13',@Price=486.0,@CardID=6,@CustomerID=6,@From='2020-11-13',@To='2021-05-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-11-13',@Price=12.0,@CardID=24,@CustomerID=24,@From='2020-11-13',@To='2020-11-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-11-14',@Price=12.0,@CardID=12,@CustomerID=12,@From='2020-11-14',@To='2020-11-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-11-14',@Price=90.0,@CardID=9,@CustomerID=9,@From='2020-11-14',@To='2020-12-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-11-14',@Price=10.0,@CardID=21,@CustomerID=21,@From='2020-11-14',@To='2020-11-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2020-11-14',@Price=80.0,@CardID=32,@CustomerID=32,@From='2020-11-14',@To='2020-12-14';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2020-11-15',@Price=237.5,@CardID=35,@CustomerID=35,@From='2020-11-15',@To='2020-12-15';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2020-11-20',@Price=152.0,@CardID=21,@CustomerID=21,@From='2020-11-20',@To='2021-02-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-11-20',@Price=9.0,@CardID=38,@CustomerID=38,@From='2020-11-20',@To='2020-11-20';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2020-11-21',@Price=432.0,@CardID=24,@CustomerID=24,@From='2020-11-21',@To='2021-05-20';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2020-11-22',@Price=56.0,@CardID=5,@CustomerID=5,@From='2020-11-22',@To='2020-12-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-11-23',@Price=10.0,@CardID=27,@CustomerID=27,@From='2020-11-23',@To='2020-11-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-11-24',@Price=12.0,@CardID=12,@CustomerID=12,@From='2020-11-24',@To='2020-11-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-11-24',@Price=25.0,@CardID=38,@CustomerID=38,@From='2020-11-24',@To='2020-11-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2020-11-26',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-11-26',@To='2020-11-26';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2020-11-29',@Price=199.5,@CardID=36,@CustomerID=36,@From='2020-11-29',@To='2020-12-29';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2020-11-29',@Price=200.0,@CardID=23,@CustomerID=23,@From='2020-11-29',@To='2020-12-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-11-30',@Price=25.0,@CardID=15,@CustomerID=15,@From='2020-11-30',@To='2020-11-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-12-01',@Price=70.0,@CardID=27,@CustomerID=27,@From='2020-12-01',@To='2020-12-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-12-02',@Price=9.0,@CardID=31,@CustomerID=31,@From='2020-12-02',@To='2020-12-02';
EXEC addPurchase @ServiceID=8,@EmployeeID=7,@Date='2020-12-02',@Price=13.5,@CardID=38,@CustomerID=38,@From='2020-12-02',@To='2020-12-02';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2020-12-02',@Price=237.5,@CardID=14,@CustomerID=14,@From='2020-12-02',@To='2021-01-01';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2020-12-03',@Price=199.5,@CardID=25,@CustomerID=25,@From='2020-12-03',@To='2021-01-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-12-06',@Price=10.0,@CardID=22,@CustomerID=22,@From='2020-12-06',@To='2020-12-06';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2020-12-06',@Price=522.5,@CardID=15,@CustomerID=15,@From='2020-12-06',@To='2021-03-06';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-12-07',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-12-07',@To='2020-12-07';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2020-12-09',@Price=63.0,@CardID=13,@CustomerID=13,@From='2020-12-09',@To='2021-01-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-12-09',@Price=25.0,@CardID=8,@CustomerID=8,@From='2020-12-09',@To='2020-12-09';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-12-10',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-12-10',@To='2020-12-10';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2020-12-11',@Price=224.0,@CardID=28,@CustomerID=28,@From='2020-12-11',@To='2021-03-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-12-12',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-12-12',@To='2020-12-12';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2020-12-12',@Price=152.0,@CardID=20,@CustomerID=20,@From='2020-12-12',@To='2021-03-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-12-13',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-12-13',@To='2020-12-13';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2020-12-13',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-12-13',@To='2020-12-13';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-12-14',@Price=80.0,@CardID=32,@CustomerID=32,@From='2020-12-14',@To='2021-01-13';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2020-12-15',@Price=665.0,@CardID=35,@CustomerID=35,@From='2020-12-15',@To='2021-03-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2020-12-15',@Price=12.0,@CardID=22,@CustomerID=22,@From='2020-12-15',@To='2020-12-15';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2020-12-16',@Price=171.0,@CardID=9,@CustomerID=9,@From='2020-12-16',@To='2021-03-16';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-12-17',@Price=35.0,@CardID=38,@CustomerID=38,@From='2020-12-17',@To='2020-12-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2020-12-19',@Price=9.0,@CardID=31,@CustomerID=31,@From='2020-12-19',@To='2020-12-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2020-12-19',@Price=15.0,@CardID=8,@CustomerID=8,@From='2020-12-19',@To='2020-12-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-12-21',@Price=12.0,@CardID=22,@CustomerID=22,@From='2020-12-21',@To='2020-12-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-12-22',@Price=15.0,@CardID=38,@CustomerID=38,@From='2020-12-22',@To='2020-12-22';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2020-12-23',@Price=171.0,@CardID=33,@CustomerID=33,@From='2020-12-23',@To='2021-03-23';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2020-12-23',@Price=80.0,@CardID=22,@CustomerID=22,@From='2020-12-23',@To='2021-01-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2020-12-24',@Price=28.0,@CardID=12,@CustomerID=12,@From='2020-12-24',@To='2020-12-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2020-12-24',@Price=35.0,@CardID=31,@CustomerID=31,@From='2020-12-24',@To='2020-12-24';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2020-12-24',@Price=90.0,@CardID=8,@CustomerID=8,@From='2020-12-24',@To='2021-01-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2020-12-26',@Price=25.0,@CardID=31,@CustomerID=31,@From='2020-12-26',@To='2020-12-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2020-12-26',@Price=12.0,@CardID=5,@CustomerID=5,@From='2020-12-26',@To='2020-12-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2020-12-30',@Price=9.0,@CardID=38,@CustomerID=38,@From='2020-12-30',@To='2020-12-30';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2020-12-31',@Price=560.0,@CardID=23,@CustomerID=23,@From='2020-12-31',@To='2021-03-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-01-01',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-01-01',@To='2021-01-01';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-01-02',@Price=522.5,@CardID=36,@CustomerID=36,@From='2021-01-02',@To='2021-04-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-01-02',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-01-02',@To='2021-01-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-01-02',@Price=28.0,@CardID=12,@CustomerID=12,@From='2021-01-02',@To='2021-01-02';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-01-02',@Price=15.0,@CardID=null,@CustomerID=40,@From='2021-01-02',@To='2021-01-02';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-01-02',@Price=30.0,@CardID=3,@CustomerID=3,@From='2021-01-02',@To='2021-02-01';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-01-03',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-01-03',@To='2021-01-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-01-03',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-01-03',@To='2021-01-03';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-01-04',@Price=665.0,@CardID=14,@CustomerID=14,@From='2021-01-04',@To='2021-04-04';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-01-04',@Price=522.5,@CardID=25,@CustomerID=25,@From='2021-01-04',@To='2021-04-04';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-01-05',@Price=252.0,@CardID=40,@CustomerID=40,@From='2021-01-05',@To='2021-04-05';
EXEC addPurchase @ServiceID=16,@EmployeeID=9,@Date='2021-01-09',@Price=15.0,@CardID=null,@CustomerID=41,@From='2021-01-09',@To='2021-01-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-01-09',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-01-09',@To='2021-01-09';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-01-10',@Price=25.0,@CardID=31,@CustomerID=31,@From='2021-01-10',@To='2021-01-10';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-01-10',@Price=168.0,@CardID=16,@CustomerID=16,@From='2021-01-10',@To='2021-02-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-01-11',@Price=9.0,@CardID=41,@CustomerID=41,@From='2021-01-11',@To='2021-01-11';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2021-01-11',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-01-11',@To='2021-01-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-01-11',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-01-11',@To='2021-01-11';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-01-12',@Price=252.0,@CardID=13,@CustomerID=13,@From='2021-01-12',@To='2021-04-12';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-01-13',@Price=210.0,@CardID=4,@CustomerID=4,@From='2021-01-13',@To='2021-04-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-01-13',@Price=15.0,@CardID=41,@CustomerID=41,@From='2021-01-13',@To='2021-01-13';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-01-13',@Price=25.0,@CardID=31,@CustomerID=31,@From='2021-01-13',@To='2021-01-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-01-15',@Price=12.0,@CardID=12,@CustomerID=12,@From='2021-01-15',@To='2021-01-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-01-16',@Price=56.0,@CardID=32,@CustomerID=32,@From='2021-01-16',@To='2021-02-15';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-01-17',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-01-17',@To='2021-01-17';
EXEC addPurchase @ServiceID=19,@EmployeeID=8,@Date='2021-01-18',@Price=15.0,@CardID=null,@CustomerID=42,@From='2021-01-18',@To='2021-01-18';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2021-01-19',@Price=378.0,@CardID=7,@CustomerID=7,@From='2021-01-19',@To='2021-07-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-01-19',@Price=25.0,@CardID=38,@CustomerID=38,@From='2021-01-19',@To='2021-01-19';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-01-19',@Price=90.0,@CardID=41,@CustomerID=41,@From='2021-01-19',@To='2021-02-18';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2021-01-20',@Price=152.0,@CardID=34,@CustomerID=34,@From='2021-01-20',@To='2021-04-20';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-01-21',@Price=700.0,@CardID=42,@CustomerID=42,@From='2021-01-21',@To='2021-04-21';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-01-21',@Price=80.0,@CardID=5,@CustomerID=5,@From='2021-01-21',@To='2021-02-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-01-21',@Price=70.0,@CardID=39,@CustomerID=39,@From='2021-01-21',@To='2021-02-20';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2021-01-21',@Price=700.0,@CardID=18,@CustomerID=18,@From='2021-01-21',@To='2021-04-21';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-01-22',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-01-22',@To='2021-01-22';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-01-23',@Price=25.0,@CardID=8,@CustomerID=8,@From='2021-01-23',@To='2021-01-23';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-01-25',@Price=35.0,@CardID=8,@CustomerID=8,@From='2021-01-25',@To='2021-01-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-01-25',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-01-25',@To='2021-01-25';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-01-26',@Price=25.0,@CardID=38,@CustomerID=38,@From='2021-01-26',@To='2021-01-26';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2021-01-26',@Price=432.0,@CardID=37,@CustomerID=37,@From='2021-01-26',@To='2021-07-25';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-01-27',@Price=56.0,@CardID=22,@CustomerID=22,@From='2021-01-27',@To='2021-02-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-01-27',@Price=9.0,@CardID=8,@CustomerID=8,@From='2021-01-27',@To='2021-01-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-01-30',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-01-30',@To='2021-01-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-01-31',@Price=25.0,@CardID=8,@CustomerID=8,@From='2021-01-31',@To='2021-01-31';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-02-01',@Price=12.0,@CardID=12,@CustomerID=12,@From='2021-02-01',@To='2021-02-01';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2021-02-01',@Price=15.0,@CardID=null,@CustomerID=43,@From='2021-02-01',@To='2021-02-01';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2021-02-03',@Price=665.0,@CardID=43,@CustomerID=43,@From='2021-02-03',@To='2021-05-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-02-03',@Price=10.0,@CardID=27,@CustomerID=27,@From='2021-02-03',@To='2021-02-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-02-03',@Price=4.5,@CardID=1,@CustomerID=1,@From='2021-02-03',@To='2021-02-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-02-04',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-02-04',@To='2021-02-04';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-02-05',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-02-05',@To='2021-02-05';
EXEC addPurchase @ServiceID=19,@EmployeeID=8,@Date='2021-02-06',@Price=15.0,@CardID=null,@CustomerID=45,@From='2021-02-06',@To='2021-02-06';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-02-06',@Price=15.0,@CardID=null,@CustomerID=44,@From='2021-02-06',@To='2021-02-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-02-07',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-02-07',@To='2021-02-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-02-08',@Price=35.0,@CardID=8,@CustomerID=8,@From='2021-02-08',@To='2021-02-08';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-02-08',@Price=237.5,@CardID=44,@CustomerID=44,@From='2021-02-08',@To='2021-03-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-02-08',@Price=28.0,@CardID=12,@CustomerID=12,@From='2021-02-08',@To='2021-02-08';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2021-02-08',@Price=486.0,@CardID=11,@CustomerID=11,@From='2021-02-08',@To='2021-08-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-02-09',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-02-09',@To='2021-02-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-02-10',@Price=3.0,@CardID=1,@CustomerID=1,@From='2021-02-10',@To='2021-02-10';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2021-02-10',@Price=196.0,@CardID=16,@CustomerID=16,@From='2021-02-10',@To='2021-05-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-02-11',@Price=10.0,@CardID=27,@CustomerID=27,@From='2021-02-11',@To='2021-02-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-02-11',@Price=9.0,@CardID=8,@CustomerID=8,@From='2021-02-11',@To='2021-02-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-02-13',@Price=3.0,@CardID=1,@CustomerID=1,@From='2021-02-13',@To='2021-02-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-02-14',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-02-14',@To='2021-02-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-02-14',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-02-14',@To='2021-02-14';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2021-02-15',@Price=15.0,@CardID=null,@CustomerID=46,@From='2021-02-15',@To='2021-02-15';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-02-15',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-02-15',@To='2021-02-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-02-17',@Price=9.0,@CardID=8,@CustomerID=8,@From='2021-02-17',@To='2021-02-17';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-02-18',@Price=199.5,@CardID=46,@CustomerID=46,@From='2021-02-18',@To='2021-03-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-02-19',@Price=12.0,@CardID=32,@CustomerID=32,@From='2021-02-19',@To='2021-02-19';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-02-19',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-02-19',@To='2021-02-19';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-02-20',@Price=20.0,@CardID=12,@CustomerID=12,@From='2021-02-20',@To='2021-02-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-02-20',@Price=10.0,@CardID=27,@CustomerID=27,@From='2021-02-20',@To='2021-02-20';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-02-20',@Price=21.0,@CardID=1,@CustomerID=1,@From='2021-02-20',@To='2021-03-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-02-20',@Price=28.0,@CardID=5,@CustomerID=5,@From='2021-02-20',@To='2021-02-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-02-20',@Price=9.0,@CardID=41,@CustomerID=41,@From='2021-02-20',@To='2021-02-20';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-02-23',@Price=237.5,@CardID=31,@CustomerID=31,@From='2021-02-23',@To='2021-03-25';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-02-23',@Price=90.0,@CardID=41,@CustomerID=41,@From='2021-02-23',@To='2021-03-25';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-02-23',@Price=28.0,@CardID=45,@CustomerID=45,@From='2021-02-23',@To='2021-02-23';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-02-23',@Price=80.0,@CardID=5,@CustomerID=5,@From='2021-02-23',@To='2021-03-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-02-25',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-02-25',@To='2021-02-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-02-25',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-02-25',@To='2021-02-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-02-26',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-02-26',@To='2021-02-26';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-02-26',@Price=35.0,@CardID=8,@CustomerID=8,@From='2021-02-26',@To='2021-02-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-02-27',@Price=12.0,@CardID=32,@CustomerID=32,@From='2021-02-27',@To='2021-02-27';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2021-02-27',@Price=15.0,@CardID=45,@CustomerID=45,@From='2021-02-27',@To='2021-02-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-02-28',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-02-28',@To='2021-02-28';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-02-28',@Price=70.0,@CardID=27,@CustomerID=27,@From='2021-02-28',@To='2021-03-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-03-01',@Price=20.0,@CardID=12,@CustomerID=12,@From='2021-03-01',@To='2021-03-01';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-03-01',@Price=21.0,@CardID=3,@CustomerID=3,@From='2021-03-01',@To='2021-03-31';
EXEC addPurchase @ServiceID=16,@EmployeeID=9,@Date='2021-03-02',@Price=15.0,@CardID=null,@CustomerID=47,@From='2021-03-02',@To='2021-03-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-03-02',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-03-02',@To='2021-03-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-03-02',@Price=12.0,@CardID=32,@CustomerID=32,@From='2021-03-02',@To='2021-03-02';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2021-03-02',@Price=378.0,@CardID=30,@CustomerID=30,@From='2021-03-02',@To='2021-08-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-03-04',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-03-04',@To='2021-03-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-03-05',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-03-05',@To='2021-03-05';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-03-05',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-03-05',@To='2021-03-05';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-03-06',@Price=63.0,@CardID=15,@CustomerID=15,@From='2021-03-06',@To='2021-04-05';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-03-07',@Price=49.0,@CardID=10,@CustomerID=10,@From='2021-03-07',@To='2021-04-06';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2021-03-07',@Price=15.0,@CardID=null,@CustomerID=48,@From='2021-03-07',@To='2021-03-07';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-03-07',@Price=20.0,@CardID=45,@CustomerID=45,@From='2021-03-07',@To='2021-03-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-03-08',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-03-08',@To='2021-03-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-03-08',@Price=25.0,@CardID=8,@CustomerID=8,@From='2021-03-08',@To='2021-03-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-03-08',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-03-08',@To='2021-03-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-03-08',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-03-08',@To='2021-03-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-03-09',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-03-09',@To='2021-03-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-03-09',@Price=63.0,@CardID=48,@CustomerID=48,@From='2021-03-09',@To='2021-04-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-03-10',@Price=4.5,@CardID=2,@CustomerID=2,@From='2021-03-10',@To='2021-03-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-03-10',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-03-10',@To='2021-03-10';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-03-11',@Price=56.0,@CardID=32,@CustomerID=32,@From='2021-03-11',@To='2021-04-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-03-11',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-03-11',@To='2021-03-11';
EXEC addPurchase @ServiceID=16,@EmployeeID=9,@Date='2021-03-12',@Price=15.0,@CardID=null,@CustomerID=49,@From='2021-03-12',@To='2021-03-12';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-03-13',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-03-13',@To='2021-03-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-03-14',@Price=56.0,@CardID=28,@CustomerID=28,@From='2021-03-14',@To='2021-04-13';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-03-15',@Price=224.0,@CardID=20,@CustomerID=20,@From='2021-03-15',@To='2021-06-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-03-15',@Price=9.0,@CardID=8,@CustomerID=8,@From='2021-03-15',@To='2021-03-15';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-03-15',@Price=199.5,@CardID=35,@CustomerID=35,@From='2021-03-15',@To='2021-04-14';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-03-15',@Price=665.0,@CardID=49,@CustomerID=49,@From='2021-03-15',@To='2021-06-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-03-16',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-03-16',@To='2021-03-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-03-16',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-03-16',@To='2021-03-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-03-17',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-03-17',@To='2021-03-17';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-03-17',@Price=20.0,@CardID=45,@CustomerID=45,@From='2021-03-17',@To='2021-03-17';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-03-19',@Price=30.0,@CardID=2,@CustomerID=2,@From='2021-03-19',@To='2021-04-18';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-03-19',@Price=63.0,@CardID=9,@CustomerID=9,@From='2021-03-19',@To='2021-04-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-03-19',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-03-19',@To='2021-03-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-03-20',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-03-20',@To='2021-03-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-03-20',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-03-20',@To='2021-03-20';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-03-23',@Price=15.0,@CardID=null,@CustomerID=51,@From='2021-03-23',@To='2021-03-23';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2021-03-23',@Price=171.0,@CardID=33,@CustomerID=33,@From='2021-03-23',@To='2021-06-21';
EXEC addPurchase @ServiceID=16,@EmployeeID=9,@Date='2021-03-23',@Price=15.0,@CardID=null,@CustomerID=50,@From='2021-03-23',@To='2021-03-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-03-24',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-03-24',@To='2021-03-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-03-24',@Price=12.0,@CardID=45,@CustomerID=45,@From='2021-03-24',@To='2021-03-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-03-24',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-03-24',@To='2021-03-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-03-24',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-03-24',@To='2021-03-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-03-24',@Price=25.0,@CardID=8,@CustomerID=8,@From='2021-03-24',@To='2021-03-24';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2021-03-25',@Price=252.0,@CardID=26,@CustomerID=26,@From='2021-03-25',@To='2021-06-23';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-03-25',@Price=210.0,@CardID=1,@CustomerID=1,@From='2021-03-25',@To='2021-06-23';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-03-25',@Price=522.5,@CardID=46,@CustomerID=46,@From='2021-03-25',@To='2021-06-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-03-25',@Price=9.0,@CardID=50,@CustomerID=50,@From='2021-03-25',@To='2021-03-25';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-03-26',@Price=56.0,@CardID=5,@CustomerID=5,@From='2021-03-26',@To='2021-04-25';
EXEC addPurchase @ServiceID=8,@EmployeeID=7,@Date='2021-03-26',@Price=15.0,@CardID=45,@CustomerID=45,@From='2021-03-26',@To='2021-03-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-03-26',@Price=9.0,@CardID=51,@CustomerID=51,@From='2021-03-26',@To='2021-03-26';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2021-03-27',@Price=237.5,@CardID=38,@CustomerID=38,@From='2021-03-27',@To='2021-04-26';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-03-30',@Price=35.0,@CardID=8,@CustomerID=8,@From='2021-03-30',@To='2021-03-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-03-30',@Price=90.0,@CardID=41,@CustomerID=41,@From='2021-03-30',@To='2021-04-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-03-30',@Price=20.0,@CardID=45,@CustomerID=45,@From='2021-03-30',@To='2021-03-30';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-03-31',@Price=165.0,@CardID=3,@CustomerID=3,@From='2021-03-31',@To='2021-06-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-03-31',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-03-31',@To='2021-03-31';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-04-01',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-04-01',@To='2021-04-01';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2021-04-01',@Price=15.0,@CardID=null,@CustomerID=52,@From='2021-04-01',@To='2021-04-01';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-04-02',@Price=28.0,@CardID=45,@CustomerID=45,@From='2021-04-02',@To='2021-04-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-04-02',@Price=15.0,@CardID=50,@CustomerID=50,@From='2021-04-02',@To='2021-04-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-04-02',@Price=15.0,@CardID=8,@CustomerID=8,@From='2021-04-02',@To='2021-04-02';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-04-02',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-04-02',@To='2021-04-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-04-03',@Price=35.0,@CardID=51,@CustomerID=51,@From='2021-04-03',@To='2021-04-03';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-04-03',@Price=200.0,@CardID=23,@CustomerID=23,@From='2021-04-03',@To='2021-05-03';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-04-03',@Price=49.0,@CardID=27,@CustomerID=27,@From='2021-04-03',@To='2021-05-03';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2021-04-04',@Price=237.5,@CardID=36,@CustomerID=36,@From='2021-04-04',@To='2021-05-04';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-04-04',@Price=63.0,@CardID=52,@CustomerID=52,@From='2021-04-04',@To='2021-05-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-04-05',@Price=9.0,@CardID=51,@CustomerID=51,@From='2021-04-05',@To='2021-04-05';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-04-05',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-04-05',@To='2021-04-05';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-04-06',@Price=199.5,@CardID=14,@CustomerID=14,@From='2021-04-06',@To='2021-05-06';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2021-04-06',@Price=486.0,@CardID=8,@CustomerID=8,@From='2021-04-06',@To='2021-10-03';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-04-06',@Price=90.0,@CardID=15,@CustomerID=15,@From='2021-04-06',@To='2021-05-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-04-07',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-04-07',@To='2021-04-07';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2021-04-07',@Price=237.5,@CardID=44,@CustomerID=44,@From='2021-04-07',@To='2021-05-07';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-04-07',@Price=70.0,@CardID=10,@CustomerID=10,@From='2021-04-07',@To='2021-05-07';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-04-08',@Price=199.5,@CardID=50,@CustomerID=50,@From='2021-04-08',@To='2021-05-08';
EXEC addPurchase @ServiceID=6,@EmployeeID=7,@Date='2021-04-08',@Price=324.0,@CardID=40,@CustomerID=40,@From='2021-04-08',@To='2021-10-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-04-08',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-04-08',@To='2021-04-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-04-09',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-04-09',@To='2021-04-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-04-10',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-04-10',@To='2021-04-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-04-10',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-04-10',@To='2021-04-10';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-04-10',@Price=63.0,@CardID=48,@CustomerID=48,@From='2021-04-10',@To='2021-05-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-04-10',@Price=15.0,@CardID=51,@CustomerID=51,@From='2021-04-10',@To='2021-04-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-04-11',@Price=12.0,@CardID=32,@CustomerID=32,@From='2021-04-11',@To='2021-04-11';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2021-04-11',@Price=196.0,@CardID=17,@CustomerID=17,@From='2021-04-11',@To='2021-07-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-04-12',@Price=20.0,@CardID=45,@CustomerID=45,@From='2021-04-12',@To='2021-04-12';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-04-12',@Price=15.0,@CardID=null,@CustomerID=53,@From='2021-04-12',@To='2021-04-12';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-04-13',@Price=80.0,@CardID=28,@CustomerID=28,@From='2021-04-13',@To='2021-05-13';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2021-04-13',@Price=486.0,@CardID=13,@CustomerID=13,@From='2021-04-13',@To='2021-10-10';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2021-04-14',@Price=15.0,@CardID=45,@CustomerID=45,@From='2021-04-14',@To='2021-04-14';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-04-14',@Price=165.0,@CardID=4,@CustomerID=4,@From='2021-04-14',@To='2021-07-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-04-15',@Price=63.0,@CardID=53,@CustomerID=53,@From='2021-04-15',@To='2021-05-15';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-04-15',@Price=522.5,@CardID=35,@CustomerID=35,@From='2021-04-15',@To='2021-07-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-04-16',@Price=20.0,@CardID=45,@CustomerID=45,@From='2021-04-16',@To='2021-04-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-04-16',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-04-16',@To='2021-04-16';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-04-18',@Price=28.0,@CardID=21,@CustomerID=21,@From='2021-04-18',@To='2021-04-18';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-04-18',@Price=15.0,@CardID=51,@CustomerID=51,@From='2021-04-18',@To='2021-04-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-04-18',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-04-18',@To='2021-04-18';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2021-04-19',@Price=13.5,@CardID=47,@CustomerID=47,@From='2021-04-19',@To='2021-04-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-04-19',@Price=3.0,@CardID=2,@CustomerID=2,@From='2021-04-19',@To='2021-04-19';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-04-19',@Price=56.0,@CardID=22,@CustomerID=22,@From='2021-04-19',@To='2021-05-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-04-21',@Price=12.0,@CardID=32,@CustomerID=32,@From='2021-04-21',@To='2021-04-21';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2021-04-21',@Price=700.0,@CardID=18,@CustomerID=18,@From='2021-04-21',@To='2021-07-20';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-04-21',@Price=210.0,@CardID=42,@CustomerID=42,@From='2021-04-21',@To='2021-05-21';
EXEC addPurchase @ServiceID=17,@EmployeeID=8,@Date='2021-04-22',@Price=100.0,@CardID=null,@CustomerID=54,@From='2021-04-22',@To='2021-04-22';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-04-22',@Price=550.0,@CardID=34,@CustomerID=34,@From='2021-04-22',@To='2021-07-21';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-04-22',@Price=90.0,@CardID=9,@CustomerID=9,@From='2021-04-22',@To='2021-05-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-04-22',@Price=15.0,@CardID=31,@CustomerID=31,@From='2021-04-22',@To='2021-04-22';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-04-23',@Price=15.0,@CardID=null,@CustomerID=55,@From='2021-04-23',@To='2021-04-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-04-23',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-04-23',@To='2021-04-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-04-24',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-04-24',@To='2021-04-24';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-04-24',@Price=90.0,@CardID=55,@CustomerID=55,@From='2021-04-24',@To='2021-05-24';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-04-24',@Price=49.0,@CardID=54,@CustomerID=54,@From='2021-04-24',@To='2021-05-24';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2021-04-24',@Price=133.0,@CardID=29,@CustomerID=29,@From='2021-04-24',@To='2021-07-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-04-24',@Price=20.0,@CardID=45,@CustomerID=45,@From='2021-04-24',@To='2021-04-24';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-04-24',@Price=30.0,@CardID=2,@CustomerID=2,@From='2021-04-24',@To='2021-05-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-04-24',@Price=28.0,@CardID=12,@CustomerID=12,@From='2021-04-24',@To='2021-04-24';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-04-25',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-04-25',@To='2021-04-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-04-26',@Price=10.0,@CardID=5,@CustomerID=5,@From='2021-04-26',@To='2021-04-26';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-04-26',@Price=25.0,@CardID=38,@CustomerID=38,@From='2021-04-26',@To='2021-04-26';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-04-26',@Price=15.0,@CardID=null,@CustomerID=56,@From='2021-04-26',@To='2021-04-26';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-04-27',@Price=63.0,@CardID=56,@CustomerID=56,@From='2021-04-27',@To='2021-05-27';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-04-27',@Price=199.5,@CardID=47,@CustomerID=47,@From='2021-04-27',@To='2021-05-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-04-28',@Price=9.0,@CardID=51,@CustomerID=51,@From='2021-04-28',@To='2021-04-28';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-04-28',@Price=199.5,@CardID=25,@CustomerID=25,@From='2021-04-28',@To='2021-05-28';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-04-28',@Price=28.0,@CardID=12,@CustomerID=12,@From='2021-04-28',@To='2021-04-28';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-04-29',@Price=56.0,@CardID=5,@CustomerID=5,@From='2021-04-29',@To='2021-05-29';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-05-01',@Price=80.0,@CardID=32,@CustomerID=32,@From='2021-05-01',@To='2021-05-31';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-05-01',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-05-01',@To='2021-05-01';
EXEC addPurchase @ServiceID=19,@EmployeeID=8,@Date='2021-05-01',@Price=15.0,@CardID=null,@CustomerID=57,@From='2021-05-01',@To='2021-05-01';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-05-01',@Price=63.0,@CardID=41,@CustomerID=41,@From='2021-05-01',@To='2021-05-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-05-02',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-05-02',@To='2021-05-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-05-02',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-05-02',@To='2021-05-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-05-03',@Price=12.0,@CardID=12,@CustomerID=12,@From='2021-05-03',@To='2021-05-03';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-05-04',@Price=440.0,@CardID=23,@CustomerID=23,@From='2021-05-04',@To='2021-08-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-05-04',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-05-04',@To='2021-05-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-05-04',@Price=10.0,@CardID=57,@CustomerID=57,@From='2021-05-04',@To='2021-05-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-05-04',@Price=15.0,@CardID=27,@CustomerID=27,@From='2021-05-04',@To='2021-05-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-05',@Price=25.0,@CardID=39,@CustomerID=39,@From='2021-05-05',@To='2021-05-05';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-05-05',@Price=665.0,@CardID=36,@CustomerID=36,@From='2021-05-05',@To='2021-08-03';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-05',@Price=25.0,@CardID=51,@CustomerID=51,@From='2021-05-05',@To='2021-05-05';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-05-05',@Price=199.5,@CardID=43,@CustomerID=43,@From='2021-05-05',@To='2021-06-04';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2021-05-05',@Price=237.5,@CardID=38,@CustomerID=38,@From='2021-05-05',@To='2021-06-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-05-06',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-05-06',@To='2021-05-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-05-06',@Price=15.0,@CardID=52,@CustomerID=52,@From='2021-05-06',@To='2021-05-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-05-06',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-05-06',@To='2021-05-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-05-06',@Price=15.0,@CardID=27,@CustomerID=27,@From='2021-05-06',@To='2021-05-06';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-05-07',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-05-07',@To='2021-05-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-05-08',@Price=35.0,@CardID=51,@CustomerID=51,@From='2021-05-08',@To='2021-05-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-05-08',@Price=9.0,@CardID=52,@CustomerID=52,@From='2021-05-08',@To='2021-05-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-05-08',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-05-08',@To='2021-05-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-09',@Price=25.0,@CardID=39,@CustomerID=39,@From='2021-05-09',@To='2021-05-09';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-05-10',@Price=522.5,@CardID=14,@CustomerID=14,@From='2021-05-10',@To='2021-08-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-05-11',@Price=15.0,@CardID=50,@CustomerID=50,@From='2021-05-11',@To='2021-05-11';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-05-11',@Price=63.0,@CardID=48,@CustomerID=48,@From='2021-05-11',@To='2021-06-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-05-11',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-05-11',@To='2021-05-11';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-05-11',@Price=168.0,@CardID=16,@CustomerID=16,@From='2021-05-11',@To='2021-06-10';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2021-05-11',@Price=237.5,@CardID=44,@CustomerID=44,@From='2021-05-11',@To='2021-06-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-05-11',@Price=15.0,@CardID=52,@CustomerID=52,@From='2021-05-11',@To='2021-05-11';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-12',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-05-12',@To='2021-05-12';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-05-12',@Price=49.0,@CardID=10,@CustomerID=10,@From='2021-05-12',@To='2021-06-11';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2021-05-13',@Price=252.0,@CardID=27,@CustomerID=27,@From='2021-05-13',@To='2021-11-09';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2021-05-13',@Price=171.0,@CardID=6,@CustomerID=6,@From='2021-05-13',@To='2021-08-11';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-05-14',@Price=250.0,@CardID=28,@CustomerID=28,@From='2021-05-14',@To='2021-06-13';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-05-15',@Price=15.0,@CardID=null,@CustomerID=58,@From='2021-05-15',@To='2021-05-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-05-16',@Price=63.0,@CardID=50,@CustomerID=50,@From='2021-05-16',@To='2021-06-15';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-05-16',@Price=665.0,@CardID=58,@CustomerID=58,@From='2021-05-16',@To='2021-08-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-16',@Price=25.0,@CardID=19,@CustomerID=19,@From='2021-05-16',@To='2021-05-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-05-16',@Price=12.0,@CardID=45,@CustomerID=45,@From='2021-05-16',@To='2021-05-16';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-17',@Price=25.0,@CardID=39,@CustomerID=39,@From='2021-05-17',@To='2021-05-17';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2021-05-17',@Price=15.0,@CardID=null,@CustomerID=59,@From='2021-05-17',@To='2021-05-17';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-05-17',@Price=28.0,@CardID=12,@CustomerID=12,@From='2021-05-17',@To='2021-05-17';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-18',@Price=25.0,@CardID=51,@CustomerID=51,@From='2021-05-18',@To='2021-05-18';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-05-19',@Price=63.0,@CardID=53,@CustomerID=53,@From='2021-05-19',@To='2021-06-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-05-19',@Price=25.0,@CardID=59,@CustomerID=59,@From='2021-05-19',@To='2021-05-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-05-20',@Price=15.0,@CardID=52,@CustomerID=52,@From='2021-05-20',@To='2021-05-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-05-21',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-05-21',@To='2021-05-21';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-05-22',@Price=56.0,@CardID=42,@CustomerID=42,@From='2021-05-22',@To='2021-06-21';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-05-23',@Price=25.0,@CardID=19,@CustomerID=19,@From='2021-05-23',@To='2021-05-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-05-23',@Price=20.0,@CardID=24,@CustomerID=24,@From='2021-05-23',@To='2021-05-23';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-05-23',@Price=28.0,@CardID=45,@CustomerID=45,@From='2021-05-23',@To='2021-05-23';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-05-25',@Price=550.0,@CardID=12,@CustomerID=12,@From='2021-05-25',@To='2021-08-23';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-05-25',@Price=90.0,@CardID=59,@CustomerID=59,@From='2021-05-25',@To='2021-06-24';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-05-26',@Price=90.0,@CardID=9,@CustomerID=9,@From='2021-05-26',@To='2021-06-25';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-05-26',@Price=196.0,@CardID=54,@CustomerID=54,@From='2021-05-26',@To='2021-08-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-05-27',@Price=15.0,@CardID=55,@CustomerID=55,@From='2021-05-27',@To='2021-05-27';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-05-28',@Price=199.5,@CardID=25,@CustomerID=25,@From='2021-05-28',@To='2021-06-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-05-28',@Price=28.0,@CardID=24,@CustomerID=24,@From='2021-05-28',@To='2021-05-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-05-28',@Price=15.0,@CardID=51,@CustomerID=51,@From='2021-05-28',@To='2021-05-28';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-05-29',@Price=30.0,@CardID=2,@CustomerID=2,@From='2021-05-29',@To='2021-06-28';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-05-29',@Price=35.0,@CardID=19,@CustomerID=19,@From='2021-05-29',@To='2021-05-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-05-30',@Price=28.0,@CardID=24,@CustomerID=24,@From='2021-05-30',@To='2021-05-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-05-30',@Price=90.0,@CardID=56,@CustomerID=56,@From='2021-05-30',@To='2021-06-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-05-31',@Price=9.0,@CardID=47,@CustomerID=47,@From='2021-05-31',@To='2021-05-31';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-05-31',@Price=56.0,@CardID=57,@CustomerID=57,@From='2021-05-31',@To='2021-06-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-06-02',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-06-02',@To='2021-06-02';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-06-02',@Price=63.0,@CardID=41,@CustomerID=41,@From='2021-06-02',@To='2021-07-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-02',@Price=12.0,@CardID=5,@CustomerID=5,@From='2021-06-02',@To='2021-06-02';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2021-06-03',@Price=237.5,@CardID=15,@CustomerID=15,@From='2021-06-03',@To='2021-07-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-06-03',@Price=28.0,@CardID=24,@CustomerID=24,@From='2021-06-03',@To='2021-06-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-03',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-06-03',@To='2021-06-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-04',@Price=15.0,@CardID=31,@CustomerID=31,@From='2021-06-04',@To='2021-06-04';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-06-05',@Price=80.0,@CardID=32,@CustomerID=32,@From='2021-06-05',@To='2021-07-05';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2021-06-05',@Price=665.0,@CardID=43,@CustomerID=43,@From='2021-06-05',@To='2021-09-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-05',@Price=12.0,@CardID=45,@CustomerID=45,@From='2021-06-05',@To='2021-06-05';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-06-06',@Price=35.0,@CardID=51,@CustomerID=51,@From='2021-06-06',@To='2021-06-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-06-06',@Price=9.0,@CardID=55,@CustomerID=55,@From='2021-06-06',@To='2021-06-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-06-06',@Price=15.0,@CardID=31,@CustomerID=31,@From='2021-06-06',@To='2021-06-06';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-06-06',@Price=28.0,@CardID=24,@CustomerID=24,@From='2021-06-06',@To='2021-06-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-07',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-06-07',@To='2021-06-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-06-08',@Price=9.0,@CardID=19,@CustomerID=19,@From='2021-06-08',@To='2021-06-08';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-06-08',@Price=80.0,@CardID=5,@CustomerID=5,@From='2021-06-08',@To='2021-07-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-06-08',@Price=35.0,@CardID=51,@CustomerID=51,@From='2021-06-08',@To='2021-06-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-06-09',@Price=9.0,@CardID=55,@CustomerID=55,@From='2021-06-09',@To='2021-06-09';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-06-09',@Price=25.0,@CardID=38,@CustomerID=38,@From='2021-06-09',@To='2021-06-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-06-09',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-06-09',@To='2021-06-09';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-06-11',@Price=199.5,@CardID=44,@CustomerID=44,@From='2021-06-11',@To='2021-07-11';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-06-11',@Price=28.0,@CardID=24,@CustomerID=24,@From='2021-06-11',@To='2021-06-11';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-06-11',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-06-11',@To='2021-06-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-12',@Price=15.0,@CardID=55,@CustomerID=55,@From='2021-06-12',@To='2021-06-12';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-06-13',@Price=522.5,@CardID=49,@CustomerID=49,@From='2021-06-13',@To='2021-09-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-06-14',@Price=15.0,@CardID=19,@CustomerID=19,@From='2021-06-14',@To='2021-06-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-06-14',@Price=90.0,@CardID=48,@CustomerID=48,@From='2021-06-14',@To='2021-07-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-14',@Price=12.0,@CardID=45,@CustomerID=45,@From='2021-06-14',@To='2021-06-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-06-14',@Price=10.0,@CardID=24,@CustomerID=24,@From='2021-06-14',@To='2021-06-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-06-15',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-06-15',@To='2021-06-15';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-06-15',@Price=90.0,@CardID=52,@CustomerID=52,@From='2021-06-15',@To='2021-07-15';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2021-06-16',@Price=152.0,@CardID=28,@CustomerID=28,@From='2021-06-16',@To='2021-09-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-16',@Price=15.0,@CardID=31,@CustomerID=31,@From='2021-06-16',@To='2021-06-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-06-16',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-06-16',@To='2021-06-16';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-06-16',@Price=28.0,@CardID=45,@CustomerID=45,@From='2021-06-16',@To='2021-06-16';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-06-16',@Price=70.0,@CardID=10,@CustomerID=10,@From='2021-06-16',@To='2021-07-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-06-17',@Price=9.0,@CardID=55,@CustomerID=55,@From='2021-06-17',@To='2021-06-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-06-17',@Price=9.0,@CardID=50,@CustomerID=50,@From='2021-06-17',@To='2021-06-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-17',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-06-17',@To='2021-06-17';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-06-17',@Price=35.0,@CardID=51,@CustomerID=51,@From='2021-06-17',@To='2021-06-17';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-06-18',@Price=56.0,@CardID=20,@CustomerID=20,@From='2021-06-18',@To='2021-07-18';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-06-19',@Price=90.0,@CardID=50,@CustomerID=50,@From='2021-06-19',@To='2021-07-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-06-19',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-06-19',@To='2021-06-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-06-20',@Price=35.0,@CardID=55,@CustomerID=55,@From='2021-06-20',@To='2021-06-20';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-06-21',@Price=20.0,@CardID=24,@CustomerID=24,@From='2021-06-21',@To='2021-06-21';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-06-21',@Price=210.0,@CardID=42,@CustomerID=42,@From='2021-06-21',@To='2021-07-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-06-22',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-06-22',@To='2021-06-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-22',@Price=15.0,@CardID=51,@CustomerID=51,@From='2021-06-22',@To='2021-06-22';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-06-22',@Price=90.0,@CardID=53,@CustomerID=53,@From='2021-06-22',@To='2021-07-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-23',@Price=15.0,@CardID=19,@CustomerID=19,@From='2021-06-23',@To='2021-06-23';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-06-23',@Price=90.0,@CardID=55,@CustomerID=55,@From='2021-06-23',@To='2021-07-23';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2021-06-23',@Price=252.0,@CardID=26,@CustomerID=26,@From='2021-06-23',@To='2021-09-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-24',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-06-24',@To='2021-06-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-24',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-06-24',@To='2021-06-24';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-06-24',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-06-24',@To='2021-06-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-06-24',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-06-24',@To='2021-06-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-25',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-06-25',@To='2021-06-25';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2021-06-25',@Price=486.0,@CardID=59,@CustomerID=59,@From='2021-06-25',@To='2021-12-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-06-26',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-06-26',@To='2021-06-26';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2021-06-26',@Price=486.0,@CardID=33,@CustomerID=33,@From='2021-06-26',@To='2021-12-23';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-06-26',@Price=56.0,@CardID=22,@CustomerID=22,@From='2021-06-26',@To='2021-07-26';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-06-28',@Price=522.5,@CardID=46,@CustomerID=46,@From='2021-06-28',@To='2021-09-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-28',@Price=4.5,@CardID=1,@CustomerID=1,@From='2021-06-28',@To='2021-06-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-06-28',@Price=9.0,@CardID=9,@CustomerID=9,@From='2021-06-28',@To='2021-06-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-06-29',@Price=20.0,@CardID=24,@CustomerID=24,@From='2021-06-29',@To='2021-06-29';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2021-06-29',@Price=75.0,@CardID=3,@CustomerID=3,@From='2021-06-29',@To='2021-07-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-06-29',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-06-29',@To='2021-06-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-06-29',@Price=4.5,@CardID=2,@CustomerID=2,@From='2021-06-29',@To='2021-06-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-06-29',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-06-29',@To='2021-06-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-06-30',@Price=25.0,@CardID=51,@CustomerID=51,@From='2021-06-30',@To='2021-06-30';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-06-30',@Price=199.5,@CardID=25,@CustomerID=25,@From='2021-06-30',@To='2021-07-30';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-07-01',@Price=168.0,@CardID=16,@CustomerID=16,@From='2021-07-01',@To='2021-07-31';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-07-02',@Price=25.0,@CardID=19,@CustomerID=19,@From='2021-07-02',@To='2021-07-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-07-02',@Price=10.0,@CardID=24,@CustomerID=24,@From='2021-07-02',@To='2021-07-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-07-02',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-07-02',@To='2021-07-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-07-03',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-07-03',@To='2021-07-03';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-07-03',@Price=250.0,@CardID=57,@CustomerID=57,@From='2021-07-03',@To='2021-08-02';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-07-04',@Price=63.0,@CardID=41,@CustomerID=41,@From='2021-07-04',@To='2021-08-03';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-07-04',@Price=90.0,@CardID=56,@CustomerID=56,@From='2021-07-04',@To='2021-08-03';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-07-05',@Price=30.0,@CardID=1,@CustomerID=1,@From='2021-07-05',@To='2021-08-04';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-07-05',@Price=90.0,@CardID=9,@CustomerID=9,@From='2021-07-05',@To='2021-08-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-07-05',@Price=15.0,@CardID=31,@CustomerID=31,@From='2021-07-05',@To='2021-07-05';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-07-06',@Price=56.0,@CardID=32,@CustomerID=32,@From='2021-07-06',@To='2021-08-05';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-07-06',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-07-06',@To='2021-07-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-07-06',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-07-06',@To='2021-07-06';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-07-07',@Price=25.0,@CardID=51,@CustomerID=51,@From='2021-07-07',@To='2021-07-07';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-07-08',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-07-08',@To='2021-07-08';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-07-08',@Price=665.0,@CardID=15,@CustomerID=15,@From='2021-07-08',@To='2021-10-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-07-08',@Price=9.0,@CardID=19,@CustomerID=19,@From='2021-07-08',@To='2021-07-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-07-09',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-07-09',@To='2021-07-09';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-07-09',@Price=30.0,@CardID=2,@CustomerID=2,@From='2021-07-09',@To='2021-08-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-07-09',@Price=12.0,@CardID=24,@CustomerID=24,@From='2021-07-09',@To='2021-07-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-07-10',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-07-10',@To='2021-07-10';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-07-13',@Price=80.0,@CardID=5,@CustomerID=5,@From='2021-07-13',@To='2021-08-12';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-07-14',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-07-14',@To='2021-07-14';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-07-14',@Price=49.0,@CardID=17,@CustomerID=17,@From='2021-07-14',@To='2021-08-13';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-07-14',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-07-14',@To='2021-07-14';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-07-14',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-07-14',@To='2021-07-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-07-15',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-07-15',@To='2021-07-15';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2021-07-15',@Price=237.5,@CardID=44,@CustomerID=44,@From='2021-07-15',@To='2021-08-14';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-07-15',@Price=199.5,@CardID=35,@CustomerID=35,@From='2021-07-15',@To='2021-08-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-07-16',@Price=9.0,@CardID=52,@CustomerID=52,@From='2021-07-16',@To='2021-07-16';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2021-07-16',@Price=84.0,@CardID=4,@CustomerID=4,@From='2021-07-16',@To='2021-10-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-07-16',@Price=12.0,@CardID=24,@CustomerID=24,@From='2021-07-16',@To='2021-07-16';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-07-17',@Price=35.0,@CardID=51,@CustomerID=51,@From='2021-07-17',@To='2021-07-17';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-07-18',@Price=63.0,@CardID=19,@CustomerID=19,@From='2021-07-18',@To='2021-08-17';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-07-18',@Price=440.0,@CardID=7,@CustomerID=7,@From='2021-07-18',@To='2021-10-16';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2021-07-18',@Price=152.0,@CardID=20,@CustomerID=20,@From='2021-07-18',@To='2021-10-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-07-19',@Price=15.0,@CardID=51,@CustomerID=51,@From='2021-07-19',@To='2021-07-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-07-19',@Price=9.0,@CardID=47,@CustomerID=47,@From='2021-07-19',@To='2021-07-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-07-20',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-07-20',@To='2021-07-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-07-20',@Price=70.0,@CardID=10,@CustomerID=10,@From='2021-07-20',@To='2021-08-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-07-21',@Price=35.0,@CardID=50,@CustomerID=50,@From='2021-07-21',@To='2021-07-21';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-07-21',@Price=10.0,@CardID=45,@CustomerID=45,@From='2021-07-21',@To='2021-07-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-07-21',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-07-21',@To='2021-07-21';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-07-22',@Price=63.0,@CardID=52,@CustomerID=52,@From='2021-07-22',@To='2021-08-21';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-07-23',@Price=80.0,@CardID=42,@CustomerID=42,@From='2021-07-23',@To='2021-08-22';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-07-23',@Price=210.0,@CardID=18,@CustomerID=18,@From='2021-07-23',@To='2021-08-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-07-23',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-07-23',@To='2021-07-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-07-23',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-07-23',@To='2021-07-23';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-07-23',@Price=700.0,@CardID=34,@CustomerID=34,@From='2021-07-23',@To='2021-10-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-07-24',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-07-24',@To='2021-07-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-07-24',@Price=20.0,@CardID=45,@CustomerID=45,@From='2021-07-24',@To='2021-07-24';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-07-24',@Price=10.0,@CardID=24,@CustomerID=24,@From='2021-07-24',@To='2021-07-24';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-07-25',@Price=9.0,@CardID=50,@CustomerID=50,@From='2021-07-25',@To='2021-07-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-07-25',@Price=15.0,@CardID=53,@CustomerID=53,@From='2021-07-25',@To='2021-07-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-07-26',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-07-26',@To='2021-07-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-07-27',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-07-27',@To='2021-07-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-07-27',@Price=10.0,@CardID=24,@CustomerID=24,@From='2021-07-27',@To='2021-07-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-07-27',@Price=28.0,@CardID=45,@CustomerID=45,@From='2021-07-27',@To='2021-07-27';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-07-27',@Price=63.0,@CardID=55,@CustomerID=55,@From='2021-07-27',@To='2021-08-26';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-07-27',@Price=49.0,@CardID=29,@CustomerID=29,@From='2021-07-27',@To='2021-08-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-07-27',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-07-27',@To='2021-07-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-07-27',@Price=25.0,@CardID=38,@CustomerID=38,@From='2021-07-27',@To='2021-07-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-07-29',@Price=35.0,@CardID=51,@CustomerID=51,@From='2021-07-29',@To='2021-07-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-07-29',@Price=20.0,@CardID=24,@CustomerID=24,@From='2021-07-29',@To='2021-07-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-07-29',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-07-29',@To='2021-07-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-07-30',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-07-30',@To='2021-07-30';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2021-07-30',@Price=432.0,@CardID=37,@CustomerID=37,@From='2021-07-30',@To='2022-01-26';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-07-30',@Price=90.0,@CardID=50,@CustomerID=50,@From='2021-07-30',@To='2021-08-29';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2021-07-31',@Price=252.0,@CardID=25,@CustomerID=25,@From='2021-07-31',@To='2021-10-29';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-07-31',@Price=90.0,@CardID=53,@CustomerID=53,@From='2021-07-31',@To='2021-08-30';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-07-31',@Price=440.0,@CardID=16,@CustomerID=16,@From='2021-07-31',@To='2021-10-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-08-01',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-08-01',@To='2021-08-01';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-08-01',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-08-01',@To='2021-08-01';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-08-02',@Price=28.0,@CardID=45,@CustomerID=45,@From='2021-08-02',@To='2021-08-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-08-02',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-08-02',@To='2021-08-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-08-03',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-08-03',@To='2021-08-03';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-08-03',@Price=21.0,@CardID=3,@CustomerID=3,@From='2021-08-03',@To='2021-09-02';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2021-08-04',@Price=324.0,@CardID=51,@CustomerID=51,@From='2021-08-04',@To='2022-01-31';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-08-05',@Price=252.0,@CardID=56,@CustomerID=56,@From='2021-08-05',@To='2021-11-03';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-08-05',@Price=210.0,@CardID=57,@CustomerID=57,@From='2021-08-05',@To='2021-09-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-08-06',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-08-06',@To='2021-08-06';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-08-06',@Price=90.0,@CardID=9,@CustomerID=9,@From='2021-08-06',@To='2021-09-05';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-08-06',@Price=210.0,@CardID=32,@CustomerID=32,@From='2021-08-06',@To='2021-09-05';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-08-06',@Price=522.5,@CardID=36,@CustomerID=36,@From='2021-08-06',@To='2021-11-04';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-08-06',@Price=560.0,@CardID=23,@CustomerID=23,@From='2021-08-06',@To='2021-11-04';
EXEC addPurchase @ServiceID=6,@EmployeeID=8,@Date='2021-08-07',@Price=288.0,@CardID=45,@CustomerID=45,@From='2021-08-07',@To='2022-02-03';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-08-07',@Price=168.0,@CardID=39,@CustomerID=39,@From='2021-08-07',@To='2021-09-06';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-08-07',@Price=63.0,@CardID=41,@CustomerID=41,@From='2021-08-07',@To='2021-09-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-08-08',@Price=10.0,@CardID=24,@CustomerID=24,@From='2021-08-08',@To='2021-08-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-08-09',@Price=4.5,@CardID=1,@CustomerID=1,@From='2021-08-09',@To='2021-08-09';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-08-10',@Price=90.0,@CardID=11,@CustomerID=11,@From='2021-08-10',@To='2021-09-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-08-10',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-08-10',@To='2021-08-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-08-10',@Price=9.0,@CardID=47,@CustomerID=47,@From='2021-08-10',@To='2021-08-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-08-11',@Price=3.0,@CardID=2,@CustomerID=2,@From='2021-08-11',@To='2021-08-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-08-12',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-08-12',@To='2021-08-12';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-08-12',@Price=199.5,@CardID=14,@CustomerID=14,@From='2021-08-12',@To='2021-09-11';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-08-12',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-08-12',@To='2021-08-12';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-08-14',@Price=35.0,@CardID=17,@CustomerID=17,@From='2021-08-14',@To='2021-08-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-08-14',@Price=25.0,@CardID=6,@CustomerID=6,@From='2021-08-14',@To='2021-08-14';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-08-14',@Price=199.5,@CardID=35,@CustomerID=35,@From='2021-08-14',@To='2021-09-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-08-15',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-08-15',@To='2021-08-15';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-08-16',@Price=80.0,@CardID=5,@CustomerID=5,@From='2021-08-16',@To='2021-09-15';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2021-08-17',@Price=486.0,@CardID=48,@CustomerID=48,@From='2021-08-17',@To='2022-02-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-08-17',@Price=12.0,@CardID=24,@CustomerID=24,@From='2021-08-17',@To='2021-08-17';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2021-08-17',@Price=171.0,@CardID=19,@CustomerID=19,@From='2021-08-17',@To='2021-11-15';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2021-08-17',@Price=13.5,@CardID=58,@CustomerID=58,@From='2021-08-17',@To='2021-08-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-08-17',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-08-17',@To='2021-08-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-08-18',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-08-18',@To='2021-08-18';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-08-18',@Price=30.0,@CardID=1,@CustomerID=1,@From='2021-08-18',@To='2021-09-17';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-08-19',@Price=199.5,@CardID=44,@CustomerID=44,@From='2021-08-19',@To='2021-09-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-08-19',@Price=25.0,@CardID=31,@CustomerID=31,@From='2021-08-19',@To='2021-08-19';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-08-19',@Price=21.0,@CardID=2,@CustomerID=2,@From='2021-08-19',@To='2021-09-18';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2021-08-19',@Price=378.0,@CardID=17,@CustomerID=17,@From='2021-08-19',@To='2022-02-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-08-20',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-08-20',@To='2021-08-20';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2021-08-21',@Price=171.0,@CardID=47,@CustomerID=47,@From='2021-08-21',@To='2021-11-19';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-08-22',@Price=550.0,@CardID=18,@CustomerID=18,@From='2021-08-22',@To='2021-11-20';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-08-22',@Price=28.0,@CardID=21,@CustomerID=21,@From='2021-08-22',@To='2021-08-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-08-23',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-08-23',@To='2021-08-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-08-23',@Price=10.0,@CardID=10,@CustomerID=10,@From='2021-08-23',@To='2021-08-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-08-23',@Price=9.0,@CardID=52,@CustomerID=52,@From='2021-08-23',@To='2021-08-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-08-24',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-08-24',@To='2021-08-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-08-24',@Price=28.0,@CardID=24,@CustomerID=24,@From='2021-08-24',@To='2021-08-24';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-08-24',@Price=63.0,@CardID=6,@CustomerID=6,@From='2021-08-24',@To='2021-09-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-08-24',@Price=12.0,@CardID=12,@CustomerID=12,@From='2021-08-24',@To='2021-08-24';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-08-25',@Price=80.0,@CardID=22,@CustomerID=22,@From='2021-08-25',@To='2021-09-24';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-08-26',@Price=56.0,@CardID=42,@CustomerID=42,@From='2021-08-26',@To='2021-09-25';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-08-26',@Price=199.5,@CardID=58,@CustomerID=58,@From='2021-08-26',@To='2021-09-25';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-08-27',@Price=440.0,@CardID=54,@CustomerID=54,@From='2021-08-27',@To='2021-11-25';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-08-28',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-08-28',@To='2021-08-28';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-08-29',@Price=90.0,@CardID=55,@CustomerID=55,@From='2021-08-29',@To='2021-09-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-08-30',@Price=9.0,@CardID=52,@CustomerID=52,@From='2021-08-30',@To='2021-08-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-08-30',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-08-30',@To='2021-08-30';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-08-31',@Price=49.0,@CardID=29,@CustomerID=29,@From='2021-08-31',@To='2021-09-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-08-31',@Price=10.0,@CardID=12,@CustomerID=12,@From='2021-08-31',@To='2021-08-31';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-09-01',@Price=70.0,@CardID=10,@CustomerID=10,@From='2021-09-01',@To='2021-10-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-09-01',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-09-01',@To='2021-09-01';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2021-09-01',@Price=133.0,@CardID=30,@CustomerID=30,@From='2021-09-01',@To='2021-11-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-09-02',@Price=10.0,@CardID=24,@CustomerID=24,@From='2021-09-02',@To='2021-09-02';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-09-03',@Price=210.0,@CardID=3,@CustomerID=3,@From='2021-09-03',@To='2021-12-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-09-03',@Price=15.0,@CardID=50,@CustomerID=50,@From='2021-09-03',@To='2021-09-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-09-04',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-09-04',@To='2021-09-04';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-09-04',@Price=237.5,@CardID=43,@CustomerID=43,@From='2021-09-04',@To='2021-10-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-09-05',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-09-05',@To='2021-09-05';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-09-06',@Price=25.0,@CardID=39,@CustomerID=39,@From='2021-09-06',@To='2021-09-06';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-09-06',@Price=63.0,@CardID=9,@CustomerID=9,@From='2021-09-06',@To='2021-10-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-09-07',@Price=15.0,@CardID=31,@CustomerID=31,@From='2021-09-07',@To='2021-09-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-09-07',@Price=9.0,@CardID=41,@CustomerID=41,@From='2021-09-07',@To='2021-09-07';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-09-08',@Price=63.0,@CardID=52,@CustomerID=52,@From='2021-09-08',@To='2021-10-08';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-09-08',@Price=56.0,@CardID=57,@CustomerID=57,@From='2021-09-08',@To='2021-10-08';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-09-08',@Price=250.0,@CardID=24,@CustomerID=24,@From='2021-09-08',@To='2021-10-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-09-09',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-09-09',@To='2021-09-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-09-09',@Price=56.0,@CardID=32,@CustomerID=32,@From='2021-09-09',@To='2021-10-09';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2021-09-10',@Price=171.0,@CardID=11,@CustomerID=11,@From='2021-09-10',@To='2021-12-09';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2021-09-10',@Price=250.0,@CardID=12,@CustomerID=12,@From='2021-09-10',@To='2021-10-10';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2021-09-11',@Price=13.5,@CardID=14,@CustomerID=14,@From='2021-09-11',@To='2021-09-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-09-11',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-09-11',@To='2021-09-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-09-12',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-09-12',@To='2021-09-12';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2021-09-12',@Price=324.0,@CardID=49,@CustomerID=49,@From='2021-09-12',@To='2022-03-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-09-12',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-09-12',@To='2021-09-12';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-09-13',@Price=63.0,@CardID=50,@CustomerID=50,@From='2021-09-13',@To='2021-10-13';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-09-13',@Price=522.5,@CardID=35,@CustomerID=35,@From='2021-09-13',@To='2021-12-12';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-09-14',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-09-14',@To='2021-09-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-09-15',@Price=90.0,@CardID=14,@CustomerID=14,@From='2021-09-15',@To='2021-10-15';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-09-16',@Price=90.0,@CardID=41,@CustomerID=41,@From='2021-09-16',@To='2021-10-16';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-09-16',@Price=210.0,@CardID=28,@CustomerID=28,@From='2021-09-16',@To='2021-10-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-09-16',@Price=9.0,@CardID=38,@CustomerID=38,@From='2021-09-16',@To='2021-09-16';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-09-17',@Price=56.0,@CardID=5,@CustomerID=5,@From='2021-09-17',@To='2021-10-17';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-09-18',@Price=30.0,@CardID=2,@CustomerID=2,@From='2021-09-18',@To='2021-10-18';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-09-18',@Price=30.0,@CardID=1,@CustomerID=1,@From='2021-09-18',@To='2021-10-18';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-09-21',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-09-21',@To='2021-09-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-09-22',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-09-22',@To='2021-09-22';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-09-22',@Price=25.0,@CardID=31,@CustomerID=31,@From='2021-09-22',@To='2021-09-22';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2021-09-22',@Price=486.0,@CardID=26,@CustomerID=26,@From='2021-09-22',@To='2022-03-21';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-09-23',@Price=522.5,@CardID=44,@CustomerID=44,@From='2021-09-23',@To='2021-12-22';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2021-09-24',@Price=13.5,@CardID=38,@CustomerID=38,@From='2021-09-24',@To='2021-09-24';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-09-25',@Price=63.0,@CardID=6,@CustomerID=6,@From='2021-09-25',@To='2021-10-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-09-25',@Price=10.0,@CardID=21,@CustomerID=21,@From='2021-09-25',@To='2021-09-25';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2021-09-26',@Price=250.0,@CardID=42,@CustomerID=42,@From='2021-09-26',@To='2021-10-26';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-09-27',@Price=522.5,@CardID=46,@CustomerID=46,@From='2021-09-27',@To='2021-12-26';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-09-28',@Price=56.0,@CardID=22,@CustomerID=22,@From='2021-09-28',@To='2021-10-28';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-09-29',@Price=522.5,@CardID=58,@CustomerID=58,@From='2021-09-29',@To='2021-12-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-09-29',@Price=12.0,@CardID=21,@CustomerID=21,@From='2021-09-29',@To='2021-09-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-09-30',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-09-30',@To='2021-09-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-10-01',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-10-01',@To='2021-10-01';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2021-10-01',@Price=378.0,@CardID=29,@CustomerID=29,@From='2021-10-01',@To='2022-03-30';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-10-01',@Price=49.0,@CardID=10,@CustomerID=10,@From='2021-10-01',@To='2021-10-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-10-01',@Price=9.0,@CardID=53,@CustomerID=53,@From='2021-10-01',@To='2021-10-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-10-02',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-10-02',@To='2021-10-02';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-10-02',@Price=522.5,@CardID=55,@CustomerID=55,@From='2021-10-02',@To='2021-12-31';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-10-03',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-10-03',@To='2021-10-03';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-10-05',@Price=90.0,@CardID=53,@CustomerID=53,@From='2021-10-05',@To='2021-11-04';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2021-10-07',@Price=237.5,@CardID=8,@CustomerID=8,@From='2021-10-07',@To='2021-11-06';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-10-07',@Price=20.0,@CardID=21,@CustomerID=21,@From='2021-10-07',@To='2021-10-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-10-07',@Price=35.0,@CardID=31,@CustomerID=31,@From='2021-10-07',@To='2021-10-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-10-07',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-10-07',@To='2021-10-07';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-10-08',@Price=63.0,@CardID=52,@CustomerID=52,@From='2021-10-08',@To='2021-11-07';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-10-09',@Price=25.0,@CardID=31,@CustomerID=31,@From='2021-10-09',@To='2021-10-09';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-10-09',@Price=550.0,@CardID=21,@CustomerID=21,@From='2021-10-09',@To='2022-01-07';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2021-10-09',@Price=237.5,@CardID=43,@CustomerID=43,@From='2021-10-09',@To='2021-11-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-10-09',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-10-09',@To='2021-10-09';
EXEC addPurchase @ServiceID=6,@EmployeeID=8,@Date='2021-10-10',@Price=324.0,@CardID=40,@CustomerID=40,@From='2021-10-10',@To='2022-04-08';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-10-10',@Price=665.0,@CardID=15,@CustomerID=15,@From='2021-10-10',@To='2022-01-08';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-10-11',@Price=90.0,@CardID=13,@CustomerID=13,@From='2021-10-11',@To='2021-11-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-10-11',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-10-11',@To='2021-10-11';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-10-11',@Price=80.0,@CardID=57,@CustomerID=57,@From='2021-10-11',@To='2021-11-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-10-11',@Price=9.0,@CardID=9,@CustomerID=9,@From='2021-10-11',@To='2021-10-11';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-10-12',@Price=25.0,@CardID=39,@CustomerID=39,@From='2021-10-12',@To='2021-10-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-10-13',@Price=15.0,@CardID=50,@CustomerID=50,@From='2021-10-13',@To='2021-10-13';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-10-14',@Price=550.0,@CardID=12,@CustomerID=12,@From='2021-10-14',@To='2022-01-12';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-10-15',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-10-15',@To='2021-10-15';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2021-10-18',@Price=63.0,@CardID=4,@CustomerID=4,@From='2021-10-18',@To='2021-11-17';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-10-18',@Price=21.0,@CardID=2,@CustomerID=2,@From='2021-10-18',@To='2021-11-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-10-18',@Price=9.0,@CardID=9,@CustomerID=9,@From='2021-10-18',@To='2021-10-18';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-10-19',@Price=522.5,@CardID=14,@CustomerID=14,@From='2021-10-19',@To='2022-01-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-10-19',@Price=9.0,@CardID=31,@CustomerID=31,@From='2021-10-19',@To='2021-10-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-10-19',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-10-19',@To='2021-10-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-10-20',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-10-20',@To='2021-10-20';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-10-20',@Price=440.0,@CardID=7,@CustomerID=7,@From='2021-10-20',@To='2022-01-18';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-10-20',@Price=15.0,@CardID=41,@CustomerID=41,@From='2021-10-20',@To='2021-10-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2021-10-20',@Price=80.0,@CardID=28,@CustomerID=28,@From='2021-10-20',@To='2021-11-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-10-21',@Price=10.0,@CardID=5,@CustomerID=5,@From='2021-10-21',@To='2021-10-21';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2021-10-21',@Price=432.0,@CardID=20,@CustomerID=20,@From='2021-10-21',@To='2022-04-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-10-22',@Price=9.0,@CardID=50,@CustomerID=50,@From='2021-10-22',@To='2021-10-22';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-10-23',@Price=63.0,@CardID=9,@CustomerID=9,@From='2021-10-23',@To='2021-11-22';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-10-23',@Price=21.0,@CardID=1,@CustomerID=1,@From='2021-10-23',@To='2021-11-22';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-10-25',@Price=63.0,@CardID=6,@CustomerID=6,@From='2021-10-25',@To='2021-11-24';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-10-25',@Price=522.5,@CardID=31,@CustomerID=31,@From='2021-10-25',@To='2022-01-23';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2021-10-25',@Price=152.0,@CardID=34,@CustomerID=34,@From='2021-10-25',@To='2022-01-23';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-10-26',@Price=63.0,@CardID=50,@CustomerID=50,@From='2021-10-26',@To='2021-11-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-10-26',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-10-26',@To='2021-10-26';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2021-10-27',@Price=224.0,@CardID=42,@CustomerID=42,@From='2021-10-27',@To='2022-01-25';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2021-10-29',@Price=522.5,@CardID=25,@CustomerID=25,@From='2021-10-29',@To='2022-01-27';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-10-29',@Price=56.0,@CardID=5,@CustomerID=5,@From='2021-10-29',@To='2021-11-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-10-29',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-10-29',@To='2021-10-29';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2021-10-31',@Price=133.0,@CardID=16,@CustomerID=16,@From='2021-10-31',@To='2022-01-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-10-31',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-10-31',@To='2021-10-31';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-11-02',@Price=49.0,@CardID=10,@CustomerID=10,@From='2021-11-02',@To='2021-12-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-11-05',@Price=12.0,@CardID=32,@CustomerID=32,@From='2021-11-05',@To='2021-11-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-11-06',@Price=10.0,@CardID=22,@CustomerID=22,@From='2021-11-06',@To='2021-11-06';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-11-06',@Price=25.0,@CardID=8,@CustomerID=8,@From='2021-11-06',@To='2021-11-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-11-07',@Price=15.0,@CardID=52,@CustomerID=52,@From='2021-11-07',@To='2021-11-07';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-11-08',@Price=199.5,@CardID=36,@CustomerID=36,@From='2021-11-08',@To='2021-12-08';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2021-11-08',@Price=324.0,@CardID=56,@CustomerID=56,@From='2021-11-08',@To='2022-05-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-11-08',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-11-08',@To='2021-11-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-11-08',@Price=15.0,@CardID=53,@CustomerID=53,@From='2021-11-08',@To='2021-11-08';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2021-11-09',@Price=560.0,@CardID=23,@CustomerID=23,@From='2021-11-09',@To='2022-02-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-11-10',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-11-10',@To='2021-11-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-11-10',@Price=35.0,@CardID=53,@CustomerID=53,@From='2021-11-10',@To='2021-11-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-11-11',@Price=15.0,@CardID=27,@CustomerID=27,@From='2021-11-11',@To='2021-11-11';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-11-12',@Price=63.0,@CardID=53,@CustomerID=53,@From='2021-11-12',@To='2021-12-12';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2021-11-12',@Price=152.0,@CardID=57,@CustomerID=57,@From='2021-11-12',@To='2022-02-10';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-11-12',@Price=665.0,@CardID=43,@CustomerID=43,@From='2021-11-12',@To='2022-02-10';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2021-11-13',@Price=237.5,@CardID=13,@CustomerID=13,@From='2021-11-13',@To='2021-12-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-11-14',@Price=56.0,@CardID=22,@CustomerID=22,@From='2021-11-14',@To='2021-12-14';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-11-14',@Price=49.0,@CardID=27,@CustomerID=27,@From='2021-11-14',@To='2021-12-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-11-15',@Price=9.0,@CardID=8,@CustomerID=8,@From='2021-11-15',@To='2021-11-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-11-15',@Price=56.0,@CardID=32,@CustomerID=32,@From='2021-11-15',@To='2021-12-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-11-15',@Price=9.0,@CardID=52,@CustomerID=52,@From='2021-11-15',@To='2021-11-15';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-11-16',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-11-16',@To='2021-11-16';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-11-18',@Price=35.0,@CardID=38,@CustomerID=38,@From='2021-11-18',@To='2021-11-18';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-11-19',@Price=252.0,@CardID=52,@CustomerID=52,@From='2021-11-19',@To='2022-02-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-11-19',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-11-19',@To='2021-11-19';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2021-11-19',@Price=25.0,@CardID=19,@CustomerID=19,@From='2021-11-19',@To='2021-11-19';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2021-11-20',@Price=63.0,@CardID=4,@CustomerID=4,@From='2021-11-20',@To='2021-12-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-11-20',@Price=15.0,@CardID=39,@CustomerID=39,@From='2021-11-20',@To='2021-11-20';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-11-21',@Price=21.0,@CardID=2,@CustomerID=2,@From='2021-11-21',@To='2021-12-21';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2021-11-21',@Price=700.0,@CardID=18,@CustomerID=18,@From='2021-11-21',@To='2022-02-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-11-21',@Price=35.0,@CardID=8,@CustomerID=8,@From='2021-11-21',@To='2021-11-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-11-23',@Price=15.0,@CardID=19,@CustomerID=19,@From='2021-11-23',@To='2021-11-23';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-11-23',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-11-23',@To='2021-11-23';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2021-11-23',@Price=700.0,@CardID=28,@CustomerID=28,@From='2021-11-23',@To='2022-02-21';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-11-24',@Price=252.0,@CardID=6,@CustomerID=6,@From='2021-11-24',@To='2022-02-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-11-25',@Price=35.0,@CardID=19,@CustomerID=19,@From='2021-11-25',@To='2021-11-25';
EXEC addPurchase @ServiceID=8,@EmployeeID=9,@Date='2021-11-25',@Price=13.5,@CardID=38,@CustomerID=38,@From='2021-11-25',@To='2021-11-25';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-11-26',@Price=90.0,@CardID=9,@CustomerID=9,@From='2021-11-26',@To='2021-12-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-11-26',@Price=9.0,@CardID=41,@CustomerID=41,@From='2021-11-26',@To='2021-11-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-11-27',@Price=3.0,@CardID=1,@CustomerID=1,@From='2021-11-27',@To='2021-11-27';
EXEC addPurchase @ServiceID=8,@EmployeeID=7,@Date='2021-11-28',@Price=13.5,@CardID=8,@CustomerID=8,@From='2021-11-28',@To='2021-11-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-11-28',@Price=25.0,@CardID=39,@CustomerID=39,@From='2021-11-28',@To='2021-11-28';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2021-11-28',@Price=133.0,@CardID=54,@CustomerID=54,@From='2021-11-28',@To='2022-02-26';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2021-11-29',@Price=63.0,@CardID=19,@CustomerID=19,@From='2021-11-29',@To='2021-12-29';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-11-30',@Price=63.0,@CardID=50,@CustomerID=50,@From='2021-11-30',@To='2021-12-30';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-12-01',@Price=21.0,@CardID=1,@CustomerID=1,@From='2021-12-01',@To='2021-12-31';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-12-01',@Price=15.0,@CardID=38,@CustomerID=38,@From='2021-12-01',@To='2021-12-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-12-01',@Price=10.0,@CardID=5,@CustomerID=5,@From='2021-12-01',@To='2021-12-01';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-12-03',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-12-03',@To='2021-12-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-12-03',@Price=15.0,@CardID=10,@CustomerID=10,@From='2021-12-03',@To='2021-12-03';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-12-03',@Price=84.0,@CardID=3,@CustomerID=3,@From='2021-12-03',@To='2022-03-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-12-03',@Price=10.0,@CardID=5,@CustomerID=5,@From='2021-12-03',@To='2021-12-03';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2021-12-05',@Price=133.0,@CardID=30,@CustomerID=30,@From='2021-12-05',@To='2022-03-05';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-12-05',@Price=90.0,@CardID=8,@CustomerID=8,@From='2021-12-05',@To='2022-01-04';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-12-05',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-12-05',@To='2021-12-05';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2021-12-07',@Price=35.0,@CardID=47,@CustomerID=47,@From='2021-12-07',@To='2021-12-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-12-08',@Price=10.0,@CardID=39,@CustomerID=39,@From='2021-12-08',@To='2021-12-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-12-09',@Price=12.0,@CardID=24,@CustomerID=24,@From='2021-12-09',@To='2021-12-09';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2021-12-10',@Price=199.5,@CardID=38,@CustomerID=38,@From='2021-12-10',@To='2022-01-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2021-12-10',@Price=56.0,@CardID=5,@CustomerID=5,@From='2021-12-10',@To='2022-01-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2021-12-11',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-12-11',@To='2021-12-11';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-12-11',@Price=49.0,@CardID=10,@CustomerID=10,@From='2021-12-11',@To='2022-01-10';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-12-12',@Price=252.0,@CardID=11,@CustomerID=11,@From='2021-12-12',@To='2022-03-12';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-12-12',@Price=522.5,@CardID=35,@CustomerID=35,@From='2021-12-12',@To='2022-03-12';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2021-12-13',@Price=522.5,@CardID=13,@CustomerID=13,@From='2021-12-13',@To='2022-03-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-12-13',@Price=10.0,@CardID=24,@CustomerID=24,@From='2021-12-13',@To='2021-12-13';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2021-12-14',@Price=35.0,@CardID=39,@CustomerID=39,@From='2021-12-14',@To='2021-12-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-12-14',@Price=9.0,@CardID=53,@CustomerID=53,@From='2021-12-14',@To='2021-12-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-12-16',@Price=90.0,@CardID=53,@CustomerID=53,@From='2021-12-16',@To='2022-01-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-12-16',@Price=10.0,@CardID=32,@CustomerID=32,@From='2021-12-16',@To='2021-12-16';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-12-17',@Price=20.0,@CardID=24,@CustomerID=24,@From='2021-12-17',@To='2021-12-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2021-12-19',@Price=12.0,@CardID=22,@CustomerID=22,@From='2021-12-19',@To='2021-12-19';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-12-19',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-12-19',@To='2021-12-19';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-12-19',@Price=49.0,@CardID=27,@CustomerID=27,@From='2021-12-19',@To='2022-01-18';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-12-20',@Price=80.0,@CardID=32,@CustomerID=32,@From='2021-12-20',@To='2022-01-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2021-12-20',@Price=28.0,@CardID=24,@CustomerID=24,@From='2021-12-20',@To='2021-12-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-12-21',@Price=15.0,@CardID=47,@CustomerID=47,@From='2021-12-21',@To='2021-12-21';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2021-12-22',@Price=90.0,@CardID=59,@CustomerID=59,@From='2021-12-22',@To='2022-01-21';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-12-23',@Price=665.0,@CardID=44,@CustomerID=44,@From='2021-12-23',@To='2022-03-23';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2021-12-24',@Price=30.0,@CardID=4,@CustomerID=4,@From='2021-12-24',@To='2022-01-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-12-24',@Price=25.0,@CardID=39,@CustomerID=39,@From='2021-12-24',@To='2021-12-24';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2021-12-24',@Price=21.0,@CardID=2,@CustomerID=2,@From='2021-12-24',@To='2022-01-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2021-12-26',@Price=9.0,@CardID=46,@CustomerID=46,@From='2021-12-26',@To='2021-12-26';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2021-12-26',@Price=252.0,@CardID=33,@CustomerID=33,@From='2021-12-26',@To='2022-03-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2021-12-27',@Price=9.0,@CardID=9,@CustomerID=9,@From='2021-12-27',@To='2021-12-27';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2021-12-28',@Price=665.0,@CardID=41,@CustomerID=41,@From='2021-12-28',@To='2022-03-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2021-12-29',@Price=25.0,@CardID=47,@CustomerID=47,@From='2021-12-29',@To='2021-12-29';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2021-12-29',@Price=522.5,@CardID=58,@CustomerID=58,@From='2021-12-29',@To='2022-03-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2021-12-29',@Price=15.0,@CardID=9,@CustomerID=9,@From='2021-12-29',@To='2021-12-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2021-12-30',@Price=20.0,@CardID=24,@CustomerID=24,@From='2021-12-30',@To='2021-12-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2021-12-31',@Price=9.0,@CardID=19,@CustomerID=19,@From='2021-12-31',@To='2021-12-31';
EXEC addPurchase @ServiceID=19,@EmployeeID=8,@Date='2022-01-02',@Price=15.0,@CardID=null,@CustomerID=60,@From='2022-01-02',@To='2022-01-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-01-02',@Price=15.0,@CardID=9,@CustomerID=9,@From='2022-01-02',@To='2022-01-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-01-02',@Price=28.0,@CardID=24,@CustomerID=24,@From='2022-01-02',@To='2022-01-02';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-01-02',@Price=30.0,@CardID=1,@CustomerID=1,@From='2022-01-02',@To='2022-02-01';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-01-03',@Price=90.0,@CardID=50,@CustomerID=50,@From='2022-01-03',@To='2022-02-02';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-01-04',@Price=199.5,@CardID=46,@CustomerID=46,@From='2022-01-04',@To='2022-02-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-01-04',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-01-04',@To='2022-01-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-01-04',@Price=15.0,@CardID=9,@CustomerID=9,@From='2022-01-04',@To='2022-01-04';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-01-04',@Price=665.0,@CardID=36,@CustomerID=36,@From='2022-01-04',@To='2022-04-04';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-01-04',@Price=550.0,@CardID=60,@CustomerID=60,@From='2022-01-04',@To='2022-04-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-01-07',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-01-07',@To='2022-01-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-01-07',@Price=35.0,@CardID=19,@CustomerID=19,@From='2022-01-07',@To='2022-01-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-01-08',@Price=35.0,@CardID=47,@CustomerID=47,@From='2022-01-08',@To='2022-01-08';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-01-08',@Price=9.0,@CardID=9,@CustomerID=9,@From='2022-01-08',@To='2022-01-08';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-01-08',@Price=522.5,@CardID=15,@CustomerID=15,@From='2022-01-08',@To='2022-04-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-01-09',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-01-09',@To='2022-01-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-01-09',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-01-09',@To='2022-01-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-01-10',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-01-10',@To='2022-01-10';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-01-11',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-01-11',@To='2022-01-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-01-13',@Price=10.0,@CardID=21,@CustomerID=21,@From='2022-01-13',@To='2022-01-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-01-13',@Price=56.0,@CardID=5,@CustomerID=5,@From='2022-01-13',@To='2022-02-12';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-01-14',@Price=9.0,@CardID=9,@CustomerID=9,@From='2022-01-14',@To='2022-01-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-01-14',@Price=25.0,@CardID=47,@CustomerID=47,@From='2022-01-14',@To='2022-01-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-01-15',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-01-15',@To='2022-01-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-01-15',@Price=49.0,@CardID=10,@CustomerID=10,@From='2022-01-15',@To='2022-02-14';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2022-01-16',@Price=252.0,@CardID=39,@CustomerID=39,@From='2022-01-16',@To='2022-07-15';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-01-16',@Price=20.0,@CardID=12,@CustomerID=12,@From='2022-01-16',@To='2022-01-16';
EXEC addPurchase @ServiceID=17,@EmployeeID=7,@Date='2022-01-16',@Price=100.0,@CardID=null,@CustomerID=61,@From='2022-01-16',@To='2022-01-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-01-17',@Price=15.0,@CardID=61,@CustomerID=61,@From='2022-01-17',@To='2022-01-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-01-17',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-01-17',@To='2022-01-17';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2022-01-17',@Price=324.0,@CardID=53,@CustomerID=53,@From='2022-01-17',@To='2022-07-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-01-18',@Price=12.0,@CardID=22,@CustomerID=22,@From='2022-01-18',@To='2022-01-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-01-18',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-01-18',@To='2022-01-18';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-01-20',@Price=15.0,@CardID=38,@CustomerID=38,@From='2022-01-20',@To='2022-01-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-01-20',@Price=9.0,@CardID=8,@CustomerID=8,@From='2022-01-20',@To='2022-01-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-01-21',@Price=12.0,@CardID=21,@CustomerID=21,@From='2022-01-21',@To='2022-01-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-01-21',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-01-21',@To='2022-01-21';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2022-01-21',@Price=324.0,@CardID=59,@CustomerID=59,@From='2022-01-21',@To='2022-07-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-01-22',@Price=12.0,@CardID=24,@CustomerID=24,@From='2022-01-22',@To='2022-01-22';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-01-23',@Price=70.0,@CardID=27,@CustomerID=27,@From='2022-01-23',@To='2022-02-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-01-23',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-01-23',@To='2022-01-23';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-01-23',@Price=250.0,@CardID=34,@CustomerID=34,@From='2022-01-23',@To='2022-02-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-01-23',@Price=35.0,@CardID=38,@CustomerID=38,@From='2022-01-23',@To='2022-01-23';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-01-24',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-01-24',@To='2022-01-24';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-01-24',@Price=522.5,@CardID=9,@CustomerID=9,@From='2022-01-24',@To='2022-04-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-01-25',@Price=25.0,@CardID=61,@CustomerID=61,@From='2022-01-25',@To='2022-01-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-01-25',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-01-25',@To='2022-01-25';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-01-25',@Price=56.0,@CardID=22,@CustomerID=22,@From='2022-01-25',@To='2022-02-24';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-01-26',@Price=21.0,@CardID=2,@CustomerID=2,@From='2022-01-26',@To='2022-02-25';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-01-26',@Price=90.0,@CardID=55,@CustomerID=55,@From='2022-01-26',@To='2022-02-25';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-01-26',@Price=21.0,@CardID=4,@CustomerID=4,@From='2022-01-26',@To='2022-02-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-01-27',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-01-27',@To='2022-01-27';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-01-27',@Price=522.5,@CardID=31,@CustomerID=31,@From='2022-01-27',@To='2022-04-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-01-28',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-01-28',@To='2022-01-28';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2022-01-29',@Price=152.0,@CardID=42,@CustomerID=42,@From='2022-01-29',@To='2022-04-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-01-30',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-01-30',@To='2022-01-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-01-30',@Price=15.0,@CardID=38,@CustomerID=38,@From='2022-01-30',@To='2022-01-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-01-31',@Price=12.0,@CardID=24,@CustomerID=24,@From='2022-01-31',@To='2022-01-31';
EXEC addPurchase @ServiceID=16,@EmployeeID=9,@Date='2022-01-31',@Price=15.0,@CardID=null,@CustomerID=62,@From='2022-01-31',@To='2022-01-31';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-02-01',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-02-01',@To='2022-02-01';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-02-01',@Price=199.5,@CardID=25,@CustomerID=25,@From='2022-02-01',@To='2022-03-03';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-02-02',@Price=56.0,@CardID=12,@CustomerID=12,@From='2022-02-02',@To='2022-03-04';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-02-02',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-02-02',@To='2022-02-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-02-03',@Price=28.0,@CardID=45,@CustomerID=45,@From='2022-02-03',@To='2022-02-03';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-02-03',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-02-03',@To='2022-02-03';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-02-03',@Price=522.5,@CardID=62,@CustomerID=62,@From='2022-02-03',@To='2022-05-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-02-03',@Price=25.0,@CardID=16,@CustomerID=16,@From='2022-02-03',@To='2022-02-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-02-03',@Price=15.0,@CardID=38,@CustomerID=38,@From='2022-02-03',@To='2022-02-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-02-03',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-02-03',@To='2022-02-03';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2022-02-03',@Price=15.0,@CardID=null,@CustomerID=63,@From='2022-02-03',@To='2022-02-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-02-05',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-02-05',@To='2022-02-05';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-02-05',@Price=237.5,@CardID=63,@CustomerID=63,@From='2022-02-05',@To='2022-03-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-02-05',@Price=9.0,@CardID=8,@CustomerID=8,@From='2022-02-05',@To='2022-02-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-02-06',@Price=3.0,@CardID=1,@CustomerID=1,@From='2022-02-06',@To='2022-02-06';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-02-07',@Price=199.5,@CardID=46,@CustomerID=46,@From='2022-02-07',@To='2022-03-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-02-07',@Price=10.0,@CardID=45,@CustomerID=45,@From='2022-02-07',@To='2022-02-07';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-02-08',@Price=90.0,@CardID=38,@CustomerID=38,@From='2022-02-08',@To='2022-03-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-02-10',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-02-10',@To='2022-02-10';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-02-10',@Price=250.0,@CardID=57,@CustomerID=57,@From='2022-02-10',@To='2022-03-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-02-10',@Price=12.0,@CardID=24,@CustomerID=24,@From='2022-02-10',@To='2022-02-10';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-02-10',@Price=30.0,@CardID=1,@CustomerID=1,@From='2022-02-10',@To='2022-03-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-02-11',@Price=12.0,@CardID=32,@CustomerID=32,@From='2022-02-11',@To='2022-02-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-02-11',@Price=10.0,@CardID=21,@CustomerID=21,@From='2022-02-11',@To='2022-02-11';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-02-11',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-02-11',@To='2022-02-11';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-02-12',@Price=168.0,@CardID=16,@CustomerID=16,@From='2022-02-12',@To='2022-03-14';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-02-12',@Price=168.0,@CardID=23,@CustomerID=23,@From='2022-02-12',@To='2022-03-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-02-13',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-02-13',@To='2022-02-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-02-13',@Price=15.0,@CardID=47,@CustomerID=47,@From='2022-02-13',@To='2022-02-13';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-02-13',@Price=80.0,@CardID=5,@CustomerID=5,@From='2022-02-13',@To='2022-03-15';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-02-14',@Price=200.0,@CardID=7,@CustomerID=7,@From='2022-02-14',@To='2022-03-16';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-02-14',@Price=522.5,@CardID=43,@CustomerID=43,@From='2022-02-14',@To='2022-05-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-02-14',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-02-14',@To='2022-02-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-02-15',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-02-15',@To='2022-02-15';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-02-16',@Price=20.0,@CardID=24,@CustomerID=24,@From='2022-02-16',@To='2022-02-16';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2022-02-17',@Price=432.0,@CardID=45,@CustomerID=45,@From='2022-02-17',@To='2022-08-16';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-02-17',@Price=237.5,@CardID=14,@CustomerID=14,@From='2022-02-17',@To='2022-03-19';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-02-17',@Price=56.0,@CardID=37,@CustomerID=37,@From='2022-02-17',@To='2022-03-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-02-17',@Price=35.0,@CardID=51,@CustomerID=51,@From='2022-02-17',@To='2022-02-17';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-02-17',@Price=35.0,@CardID=19,@CustomerID=19,@From='2022-02-17',@To='2022-02-17';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-02-18',@Price=80.0,@CardID=32,@CustomerID=32,@From='2022-02-18',@To='2022-03-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-02-18',@Price=90.0,@CardID=47,@CustomerID=47,@From='2022-02-18',@To='2022-03-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-02-18',@Price=15.0,@CardID=52,@CustomerID=52,@From='2022-02-18',@To='2022-02-18';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2022-02-18',@Price=15.0,@CardID=null,@CustomerID=64,@From='2022-02-18',@To='2022-02-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-02-18',@Price=10.0,@CardID=10,@CustomerID=10,@From='2022-02-18',@To='2022-02-18';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-02-18',@Price=90.0,@CardID=48,@CustomerID=48,@From='2022-02-18',@To='2022-03-20';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-02-19',@Price=237.5,@CardID=51,@CustomerID=51,@From='2022-02-19',@To='2022-03-21';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-02-20',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-02-20',@To='2022-02-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-02-20',@Price=12.0,@CardID=21,@CustomerID=21,@From='2022-02-20',@To='2022-02-20';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-02-21',@Price=522.5,@CardID=64,@CustomerID=64,@From='2022-02-21',@To='2022-05-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-02-22',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-02-22',@To='2022-02-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-02-23',@Price=10.0,@CardID=21,@CustomerID=21,@From='2022-02-23',@To='2022-02-23';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2022-02-23',@Price=224.0,@CardID=28,@CustomerID=28,@From='2022-02-23',@To='2022-05-24';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-02-23',@Price=550.0,@CardID=18,@CustomerID=18,@From='2022-02-23',@To='2022-05-24';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-02-23',@Price=250.0,@CardID=34,@CustomerID=34,@From='2022-02-23',@To='2022-03-25';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-02-23',@Price=252.0,@CardID=8,@CustomerID=8,@From='2022-02-23',@To='2022-05-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-02-24',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-02-24',@To='2022-02-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-02-25',@Price=12.0,@CardID=24,@CustomerID=24,@From='2022-02-25',@To='2022-02-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-02-27',@Price=10.0,@CardID=10,@CustomerID=10,@From='2022-02-27',@To='2022-02-27';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2022-02-27',@Price=171.0,@CardID=6,@CustomerID=6,@From='2022-02-27',@To='2022-05-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-02-27',@Price=9.0,@CardID=55,@CustomerID=55,@From='2022-02-27',@To='2022-02-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-02-28',@Price=10.0,@CardID=22,@CustomerID=22,@From='2022-02-28',@To='2022-02-28';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-02-28',@Price=30.0,@CardID=4,@CustomerID=4,@From='2022-02-28',@To='2022-03-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-02-28',@Price=15.0,@CardID=52,@CustomerID=52,@From='2022-02-28',@To='2022-02-28';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-02-28',@Price=90.0,@CardID=50,@CustomerID=50,@From='2022-02-28',@To='2022-03-30';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-02-28',@Price=133.0,@CardID=54,@CustomerID=54,@From='2022-02-28',@To='2022-05-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-03-01',@Price=25.0,@CardID=61,@CustomerID=61,@From='2022-03-01',@To='2022-03-01';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-03-01',@Price=80.0,@CardID=24,@CustomerID=24,@From='2022-03-01',@To='2022-03-31';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-03-01',@Price=4.5,@CardID=2,@CustomerID=2,@From='2022-03-01',@To='2022-03-01';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-03-02',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-03-02',@To='2022-03-02';
EXEC addPurchase @ServiceID=19,@EmployeeID=9,@Date='2022-03-02',@Price=15.0,@CardID=null,@CustomerID=65,@From='2022-03-02',@To='2022-03-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-03-02',@Price=15.0,@CardID=55,@CustomerID=55,@From='2022-03-02',@To='2022-03-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-03-02',@Price=10.0,@CardID=21,@CustomerID=21,@From='2022-03-02',@To='2022-03-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-03-03',@Price=10.0,@CardID=22,@CustomerID=22,@From='2022-03-03',@To='2022-03-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-03-03',@Price=12.0,@CardID=65,@CustomerID=65,@From='2022-03-03',@To='2022-03-03';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-03-04',@Price=165.0,@CardID=3,@CustomerID=3,@From='2022-03-04',@To='2022-06-02';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-03-04',@Price=30.0,@CardID=2,@CustomerID=2,@From='2022-03-04',@To='2022-04-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-03-04',@Price=10.0,@CardID=27,@CustomerID=27,@From='2022-03-04',@To='2022-03-04';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-03-04',@Price=237.5,@CardID=52,@CustomerID=52,@From='2022-03-04',@To='2022-04-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-03-05',@Price=10.0,@CardID=61,@CustomerID=61,@From='2022-03-05',@To='2022-03-05';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-03-05',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-03-05',@To='2022-03-05';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-03-07',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-03-07',@To='2022-03-07';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-03-07',@Price=237.5,@CardID=63,@CustomerID=63,@From='2022-03-07',@To='2022-04-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-03-07',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-03-07',@To='2022-03-07';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-03-07',@Price=80.0,@CardID=22,@CustomerID=22,@From='2022-03-07',@To='2022-04-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-03-08',@Price=15.0,@CardID=55,@CustomerID=55,@From='2022-03-08',@To='2022-03-08';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-03-09',@Price=49.0,@CardID=10,@CustomerID=10,@From='2022-03-09',@To='2022-04-08';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2022-03-10',@Price=378.0,@CardID=30,@CustomerID=30,@From='2022-03-10',@To='2022-09-06';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-03-11',@Price=25.0,@CardID=38,@CustomerID=38,@From='2022-03-11',@To='2022-03-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-03-11',@Price=9.0,@CardID=55,@CustomerID=55,@From='2022-03-11',@To='2022-03-11';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-03-12',@Price=90.0,@CardID=35,@CustomerID=35,@From='2022-03-12',@To='2022-04-11';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-03-12',@Price=90.0,@CardID=11,@CustomerID=11,@From='2022-03-12',@To='2022-04-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-03-13',@Price=3.0,@CardID=1,@CustomerID=1,@From='2022-03-13',@To='2022-03-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-03-13',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-03-13',@To='2022-03-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-03-13',@Price=12.0,@CardID=65,@CustomerID=65,@From='2022-03-13',@To='2022-03-13';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2022-03-13',@Price=378.0,@CardID=17,@CustomerID=17,@From='2022-03-13',@To='2022-09-09';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-03-14',@Price=80.0,@CardID=57,@CustomerID=57,@From='2022-03-14',@To='2022-04-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-03-14',@Price=15.0,@CardID=61,@CustomerID=61,@From='2022-03-14',@To='2022-03-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-03-14',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-03-14',@To='2022-03-14';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-03-15',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-03-15',@To='2022-03-15';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-03-15',@Price=90.0,@CardID=55,@CustomerID=55,@From='2022-03-15',@To='2022-04-14';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-03-16',@Price=560.0,@CardID=23,@CustomerID=23,@From='2022-03-16',@To='2022-06-14';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-03-16',@Price=665.0,@CardID=49,@CustomerID=49,@From='2022-03-16',@To='2022-06-14';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2022-03-18',@Price=133.0,@CardID=16,@CustomerID=16,@From='2022-03-18',@To='2022-06-16';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-03-18',@Price=133.0,@CardID=7,@CustomerID=7,@From='2022-03-18',@To='2022-06-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-03-18',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-03-18',@To='2022-03-18';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-03-19',@Price=56.0,@CardID=5,@CustomerID=5,@From='2022-03-19',@To='2022-04-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-03-20',@Price=3.0,@CardID=1,@CustomerID=1,@From='2022-03-20',@To='2022-03-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-03-20',@Price=80.0,@CardID=37,@CustomerID=37,@From='2022-03-20',@To='2022-04-19';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-03-20',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-03-20',@To='2022-03-20';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-03-21',@Price=152.0,@CardID=65,@CustomerID=65,@From='2022-03-21',@To='2022-06-19';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2022-03-21',@Price=486.0,@CardID=26,@CustomerID=26,@From='2022-03-21',@To='2022-09-17';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2022-03-21',@Price=15.0,@CardID=null,@CustomerID=66,@From='2022-03-21',@To='2022-03-21';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-03-22',@Price=21.0,@CardID=1,@CustomerID=1,@From='2022-03-22',@To='2022-04-21';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-03-22',@Price=237.5,@CardID=14,@CustomerID=14,@From='2022-03-22',@To='2022-04-21';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-03-22',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-03-22',@To='2022-03-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-03-22',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-03-22',@To='2022-03-22';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-03-23',@Price=237.5,@CardID=44,@CustomerID=44,@From='2022-03-23',@To='2022-04-22';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-03-23',@Price=25.0,@CardID=48,@CustomerID=48,@From='2022-03-23',@To='2022-03-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-03-23',@Price=25.0,@CardID=38,@CustomerID=38,@From='2022-03-23',@To='2022-03-23';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-03-23',@Price=49.0,@CardID=27,@CustomerID=27,@From='2022-03-23',@To='2022-04-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-03-24',@Price=35.0,@CardID=66,@CustomerID=66,@From='2022-03-24',@To='2022-03-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-03-24',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-03-24',@To='2022-03-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-03-24',@Price=15.0,@CardID=47,@CustomerID=47,@From='2022-03-24',@To='2022-03-24';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-03-24',@Price=56.0,@CardID=32,@CustomerID=32,@From='2022-03-24',@To='2022-04-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-03-25',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-03-25',@To='2022-03-25';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2022-03-27',@Price=252.0,@CardID=48,@CustomerID=48,@From='2022-03-27',@To='2022-06-25';
EXEC addPurchase @ServiceID=16,@EmployeeID=7,@Date='2022-03-27',@Price=15.0,@CardID=null,@CustomerID=67,@From='2022-03-27',@To='2022-03-27';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-03-28',@Price=252.0,@CardID=33,@CustomerID=33,@From='2022-03-28',@To='2022-06-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-03-29',@Price=9.0,@CardID=67,@CustomerID=67,@From='2022-03-29',@To='2022-03-29';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-03-30',@Price=522.5,@CardID=58,@CustomerID=58,@From='2022-03-30',@To='2022-06-28';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-03-30',@Price=199.5,@CardID=25,@CustomerID=25,@From='2022-03-30',@To='2022-04-29';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-03-30',@Price=80.0,@CardID=34,@CustomerID=34,@From='2022-03-30',@To='2022-04-29';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-03-30',@Price=522.5,@CardID=46,@CustomerID=46,@From='2022-03-30',@To='2022-06-28';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-03-30',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-03-30',@To='2022-03-30';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-03-31',@Price=196.0,@CardID=29,@CustomerID=29,@From='2022-03-31',@To='2022-06-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-03-31',@Price=35.0,@CardID=47,@CustomerID=47,@From='2022-03-31',@To='2022-03-31';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-04-01',@Price=21.0,@CardID=4,@CustomerID=4,@From='2022-04-01',@To='2022-05-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-04-02',@Price=9.0,@CardID=50,@CustomerID=50,@From='2022-04-02',@To='2022-04-02';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-04-02',@Price=25.0,@CardID=38,@CustomerID=38,@From='2022-04-02',@To='2022-04-02';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-04-02',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-04-02',@To='2022-04-02';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-04-03',@Price=63.0,@CardID=67,@CustomerID=67,@From='2022-04-03',@To='2022-05-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-04-03',@Price=15.0,@CardID=52,@CustomerID=52,@From='2022-04-03',@To='2022-04-03';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-04-03',@Price=30.0,@CardID=2,@CustomerID=2,@From='2022-04-03',@To='2022-05-03';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-04-03',@Price=20.0,@CardID=24,@CustomerID=24,@From='2022-04-03',@To='2022-04-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-04-03',@Price=9.0,@CardID=66,@CustomerID=66,@From='2022-04-03',@To='2022-04-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-04-03',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-04-03',@To='2022-04-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-04-04',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-04-04',@To='2022-04-04';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-04-04',@Price=550.0,@CardID=60,@CustomerID=60,@From='2022-04-04',@To='2022-07-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-04-05',@Price=28.0,@CardID=12,@CustomerID=12,@From='2022-04-05',@To='2022-04-05';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-04-06',@Price=522.5,@CardID=36,@CustomerID=36,@From='2022-04-06',@To='2022-07-05';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-04-06',@Price=15.0,@CardID=50,@CustomerID=50,@From='2022-04-06',@To='2022-04-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-04-06',@Price=15.0,@CardID=66,@CustomerID=66,@From='2022-04-06',@To='2022-04-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-04-06',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-04-06',@To='2022-04-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-04-06',@Price=12.0,@CardID=21,@CustomerID=21,@From='2022-04-06',@To='2022-04-06';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-04-08',@Price=56.0,@CardID=22,@CustomerID=22,@From='2022-04-08',@To='2022-05-08';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2022-04-08',@Price=252.0,@CardID=40,@CustomerID=40,@From='2022-04-08',@To='2022-07-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-04-09',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-04-09',@To='2022-04-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-04-09',@Price=9.0,@CardID=52,@CustomerID=52,@From='2022-04-09',@To='2022-04-09';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-04-09',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-04-09',@To='2022-04-09';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-04-10',@Price=665.0,@CardID=15,@CustomerID=15,@From='2022-04-10',@To='2022-07-09';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-04-10',@Price=237.5,@CardID=63,@CustomerID=63,@From='2022-04-10',@To='2022-05-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-04-11',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-04-11',@To='2022-04-11';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-04-11',@Price=49.0,@CardID=10,@CustomerID=10,@From='2022-04-11',@To='2022-05-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-04-12',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-04-12',@To='2022-04-12';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-04-12',@Price=25.0,@CardID=66,@CustomerID=66,@From='2022-04-12',@To='2022-04-12';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-04-12',@Price=90.0,@CardID=11,@CustomerID=11,@From='2022-04-12',@To='2022-05-12';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-04-12',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-04-12',@To='2022-04-12';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-04-13',@Price=237.5,@CardID=13,@CustomerID=13,@From='2022-04-13',@To='2022-05-13';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-04-14',@Price=25.0,@CardID=38,@CustomerID=38,@From='2022-04-14',@To='2022-04-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-04-14',@Price=9.0,@CardID=55,@CustomerID=55,@From='2022-04-14',@To='2022-04-14';
EXEC addPurchase @ServiceID=17,@EmployeeID=7,@Date='2022-04-14',@Price=100.0,@CardID=null,@CustomerID=68,@From='2022-04-14',@To='2022-04-14';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-04-14',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-04-14',@To='2022-04-14';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-04-15',@Price=237.5,@CardID=35,@CustomerID=35,@From='2022-04-15',@To='2022-05-15';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-04-15',@Price=200.0,@CardID=68,@CustomerID=68,@From='2022-04-15',@To='2022-05-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-04-16',@Price=63.0,@CardID=50,@CustomerID=50,@From='2022-04-16',@To='2022-05-16';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-04-16',@Price=20.0,@CardID=24,@CustomerID=24,@From='2022-04-16',@To='2022-04-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-04-17',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-04-17',@To='2022-04-17';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-04-17',@Price=35.0,@CardID=51,@CustomerID=51,@From='2022-04-17',@To='2022-04-17';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-04-17',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-04-17',@To='2022-04-17';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-04-17',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-04-17',@To='2022-04-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-04-17',@Price=9.0,@CardID=52,@CustomerID=52,@From='2022-04-17',@To='2022-04-17';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-04-18',@Price=80.0,@CardID=57,@CustomerID=57,@From='2022-04-18',@To='2022-05-18';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2022-04-18',@Price=432.0,@CardID=5,@CustomerID=5,@From='2022-04-18',@To='2022-10-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-04-19',@Price=15.0,@CardID=61,@CustomerID=61,@From='2022-04-19',@To='2022-04-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-04-20',@Price=15.0,@CardID=41,@CustomerID=41,@From='2022-04-20',@To='2022-04-20';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-04-21',@Price=80.0,@CardID=21,@CustomerID=21,@From='2022-04-21',@To='2022-05-21';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-04-21',@Price=20.0,@CardID=12,@CustomerID=12,@From='2022-04-21',@To='2022-04-21';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-04-21',@Price=199.5,@CardID=14,@CustomerID=14,@From='2022-04-21',@To='2022-05-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-04-22',@Price=28.0,@CardID=24,@CustomerID=24,@From='2022-04-22',@To='2022-04-22';
EXEC addPurchase @ServiceID=19,@EmployeeID=7,@Date='2022-04-22',@Price=15.0,@CardID=null,@CustomerID=69,@From='2022-04-22',@To='2022-04-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-04-22',@Price=9.0,@CardID=66,@CustomerID=66,@From='2022-04-22',@To='2022-04-22';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2022-04-22',@Price=224.0,@CardID=37,@CustomerID=37,@From='2022-04-22',@To='2022-07-21';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-04-23',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-04-23',@To='2022-04-23';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-04-23',@Price=665.0,@CardID=44,@CustomerID=44,@From='2022-04-23',@To='2022-07-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-04-23',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-04-23',@To='2022-04-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-04-23',@Price=12.0,@CardID=32,@CustomerID=32,@From='2022-04-23',@To='2022-04-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-04-23',@Price=25.0,@CardID=61,@CustomerID=61,@From='2022-04-23',@To='2022-04-23';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2022-04-23',@Price=432.0,@CardID=20,@CustomerID=20,@From='2022-04-23',@To='2022-10-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-04-25',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-04-25',@To='2022-04-25';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-04-25',@Price=210.0,@CardID=1,@CustomerID=1,@From='2022-04-25',@To='2022-07-24';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-04-26',@Price=90.0,@CardID=52,@CustomerID=52,@From='2022-04-26',@To='2022-05-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-04-26',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-04-26',@To='2022-04-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-04-27',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-04-27',@To='2022-04-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-04-28',@Price=9.0,@CardID=47,@CustomerID=47,@From='2022-04-28',@To='2022-04-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-04-28',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-04-28',@To='2022-04-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-04-29',@Price=15.0,@CardID=31,@CustomerID=31,@From='2022-04-29',@To='2022-04-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-04-29',@Price=15.0,@CardID=9,@CustomerID=9,@From='2022-04-29',@To='2022-04-29';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-04-30',@Price=35.0,@CardID=41,@CustomerID=41,@From='2022-04-30',@To='2022-04-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-04-30',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-04-30',@To='2022-04-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-05-01',@Price=12.0,@CardID=32,@CustomerID=32,@From='2022-05-01',@To='2022-05-01';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-05-02',@Price=550.0,@CardID=34,@CustomerID=34,@From='2022-05-02',@To='2022-07-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-05-02',@Price=9.0,@CardID=66,@CustomerID=66,@From='2022-05-02',@To='2022-05-02';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-05-02',@Price=700.0,@CardID=42,@CustomerID=42,@From='2022-05-02',@To='2022-07-31';
EXEC addPurchase @ServiceID=16,@EmployeeID=8,@Date='2022-05-02',@Price=15.0,@CardID=null,@CustomerID=70,@From='2022-05-02',@To='2022-05-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-05-03',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-05-03',@To='2022-05-03';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-05-03',@Price=21.0,@CardID=2,@CustomerID=2,@From='2022-05-03',@To='2022-06-02';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-05-03',@Price=25.0,@CardID=47,@CustomerID=47,@From='2022-05-03',@To='2022-05-03';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-05-03',@Price=237.5,@CardID=25,@CustomerID=25,@From='2022-05-03',@To='2022-06-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-05-03',@Price=15.0,@CardID=61,@CustomerID=61,@From='2022-05-03',@To='2022-05-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-05-03',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-05-03',@To='2022-05-03';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-05-04',@Price=665.0,@CardID=62,@CustomerID=62,@From='2022-05-04',@To='2022-08-02';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-05-04',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-05-04',@To='2022-05-04';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-05-04',@Price=56.0,@CardID=32,@CustomerID=32,@From='2022-05-04',@To='2022-06-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-05-04',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-05-04',@To='2022-05-04';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-05-04',@Price=171.0,@CardID=70,@CustomerID=70,@From='2022-05-04',@To='2022-08-02';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-05-05',@Price=63.0,@CardID=4,@CustomerID=4,@From='2022-05-05',@To='2022-06-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-05-05',@Price=9.0,@CardID=66,@CustomerID=66,@From='2022-05-05',@To='2022-05-05';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-05-05',@Price=63.0,@CardID=9,@CustomerID=9,@From='2022-05-05',@To='2022-06-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-05-06',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-05-06',@To='2022-05-06';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-05-06',@Price=252.0,@CardID=31,@CustomerID=31,@From='2022-05-06',@To='2022-08-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-05-07',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-05-07',@To='2022-05-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-05-08',@Price=15.0,@CardID=41,@CustomerID=41,@From='2022-05-08',@To='2022-05-08';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-05-08',@Price=252.0,@CardID=56,@CustomerID=56,@From='2022-05-08',@To='2022-08-06';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-05-08',@Price=90.0,@CardID=67,@CustomerID=67,@From='2022-05-08',@To='2022-06-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-05-09',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-05-09',@To='2022-05-09';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-05-10',@Price=237.5,@CardID=63,@CustomerID=63,@From='2022-05-10',@To='2022-06-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-05-10',@Price=56.0,@CardID=22,@CustomerID=22,@From='2022-05-10',@To='2022-06-09';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-05-11',@Price=35.0,@CardID=19,@CustomerID=19,@From='2022-05-11',@To='2022-05-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-05-11',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-05-11',@To='2022-05-11';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-05-11',@Price=28.0,@CardID=12,@CustomerID=12,@From='2022-05-11',@To='2022-05-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-05-12',@Price=15.0,@CardID=66,@CustomerID=66,@From='2022-05-12',@To='2022-05-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-05-12',@Price=12.0,@CardID=24,@CustomerID=24,@From='2022-05-12',@To='2022-05-12';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-05-13',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-05-13',@To='2022-05-13';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-05-13',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-05-13',@To='2022-05-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-05-13',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-05-13',@To='2022-05-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-05-13',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-05-13',@To='2022-05-13';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-05-13',@Price=90.0,@CardID=41,@CustomerID=41,@From='2022-05-13',@To='2022-06-12';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-05-13',@Price=199.5,@CardID=13,@CustomerID=13,@From='2022-05-13',@To='2022-06-12';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-05-14',@Price=171.0,@CardID=11,@CustomerID=11,@From='2022-05-14',@To='2022-08-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-05-15',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-05-15',@To='2022-05-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-05-15',@Price=9.0,@CardID=55,@CustomerID=55,@From='2022-05-15',@To='2022-05-15';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-05-15',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-05-15',@To='2022-05-15';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-05-16',@Price=171.0,@CardID=38,@CustomerID=38,@From='2022-05-16',@To='2022-08-14';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-05-16',@Price=28.0,@CardID=12,@CustomerID=12,@From='2022-05-16',@To='2022-05-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-05-17',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-05-17',@To='2022-05-17';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-05-17',@Price=171.0,@CardID=55,@CustomerID=55,@From='2022-05-17',@To='2022-08-15';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-05-18',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-05-18',@To='2022-05-18';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-05-18',@Price=522.5,@CardID=50,@CustomerID=50,@From='2022-05-18',@To='2022-08-16';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-05-18',@Price=25.0,@CardID=61,@CustomerID=61,@From='2022-05-18',@To='2022-05-18';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-05-19',@Price=28.0,@CardID=24,@CustomerID=24,@From='2022-05-19',@To='2022-05-19';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2022-05-19',@Price=196.0,@CardID=68,@CustomerID=68,@From='2022-05-19',@To='2022-08-17';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-05-19',@Price=700.0,@CardID=57,@CustomerID=57,@From='2022-05-19',@To='2022-08-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-05-19',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-05-19',@To='2022-05-19';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-05-19',@Price=20.0,@CardID=12,@CustomerID=12,@From='2022-05-19',@To='2022-05-19';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-05-20',@Price=665.0,@CardID=35,@CustomerID=35,@From='2022-05-20',@To='2022-08-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-05-21',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-05-21',@To='2022-05-21';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-05-21',@Price=49.0,@CardID=27,@CustomerID=27,@From='2022-05-21',@To='2022-06-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-05-21',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-05-21',@To='2022-05-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-05-22',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-05-22',@To='2022-05-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-05-23',@Price=10.0,@CardID=69,@CustomerID=69,@From='2022-05-23',@To='2022-05-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-05-23',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-05-23',@To='2022-05-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-05-23',@Price=20.0,@CardID=12,@CustomerID=12,@From='2022-05-23',@To='2022-05-23';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-05-25',@Price=250.0,@CardID=28,@CustomerID=28,@From='2022-05-25',@To='2022-06-24';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-05-25',@Price=210.0,@CardID=18,@CustomerID=18,@From='2022-05-25',@To='2022-06-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-05-25',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-05-25',@To='2022-05-25';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-05-25',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-05-25',@To='2022-05-25';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-05-26',@Price=665.0,@CardID=14,@CustomerID=14,@From='2022-05-26',@To='2022-08-24';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-05-27',@Price=237.5,@CardID=64,@CustomerID=64,@From='2022-05-27',@To='2022-06-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-05-27',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-05-27',@To='2022-05-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-05-28',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-05-28',@To='2022-05-28';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2022-05-28',@Price=486.0,@CardID=6,@CustomerID=6,@From='2022-05-28',@To='2022-11-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-05-28',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-05-28',@To='2022-05-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-05-29',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-05-29',@To='2022-05-29';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-05-30',@Price=90.0,@CardID=52,@CustomerID=52,@From='2022-05-30',@To='2022-06-29';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2022-05-30',@Price=196.0,@CardID=54,@CustomerID=54,@From='2022-05-30',@To='2022-08-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-05-30',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-05-30',@To='2022-05-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-06-01',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-06-01',@To='2022-06-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-06-03',@Price=9.0,@CardID=47,@CustomerID=47,@From='2022-06-03',@To='2022-06-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-06-03',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-06-03',@To='2022-06-03';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-06-03',@Price=199.5,@CardID=25,@CustomerID=25,@From='2022-06-03',@To='2022-07-03';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-06-04',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-06-04',@To='2022-06-04';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-06-05',@Price=63.0,@CardID=9,@CustomerID=9,@From='2022-06-05',@To='2022-07-05';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-06-05',@Price=210.0,@CardID=4,@CustomerID=4,@From='2022-06-05',@To='2022-09-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-06-05',@Price=15.0,@CardID=47,@CustomerID=47,@From='2022-06-05',@To='2022-06-05';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-06-06',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-06-06',@To='2022-06-06';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-06-06',@Price=35.0,@CardID=61,@CustomerID=61,@From='2022-06-06',@To='2022-06-06';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-06-07',@Price=56.0,@CardID=32,@CustomerID=32,@From='2022-06-07',@To='2022-07-07';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-06-07',@Price=63.0,@CardID=67,@CustomerID=67,@From='2022-06-07',@To='2022-07-07';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-06-07',@Price=20.0,@CardID=24,@CustomerID=24,@From='2022-06-07',@To='2022-06-07';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-06-07',@Price=21.0,@CardID=2,@CustomerID=2,@From='2022-06-07',@To='2022-07-07';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-06-07',@Price=57.0,@CardID=3,@CustomerID=3,@From='2022-06-07',@To='2022-09-05';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-06-08',@Price=15.0,@CardID=61,@CustomerID=61,@From='2022-06-08',@To='2022-06-08';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-06-09',@Price=199.5,@CardID=63,@CustomerID=63,@From='2022-06-09',@To='2022-07-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-06-09',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-06-09',@To='2022-06-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-06-10',@Price=12.0,@CardID=22,@CustomerID=22,@From='2022-06-10',@To='2022-06-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-06-11',@Price=9.0,@CardID=66,@CustomerID=66,@From='2022-06-11',@To='2022-06-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-06-11',@Price=15.0,@CardID=10,@CustomerID=10,@From='2022-06-11',@To='2022-06-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-06-11',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-06-11',@To='2022-06-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-06-11',@Price=15.0,@CardID=47,@CustomerID=47,@From='2022-06-11',@To='2022-06-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-06-11',@Price=10.0,@CardID=61,@CustomerID=61,@From='2022-06-11',@To='2022-06-11';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-06-11',@Price=20.0,@CardID=24,@CustomerID=24,@From='2022-06-11',@To='2022-06-11';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-06-11',@Price=199.5,@CardID=43,@CustomerID=43,@From='2022-06-11',@To='2022-07-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-06-13',@Price=10.0,@CardID=61,@CustomerID=61,@From='2022-06-13',@To='2022-06-13';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-06-13',@Price=199.5,@CardID=13,@CustomerID=13,@From='2022-06-13',@To='2022-07-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-06-13',@Price=12.0,@CardID=21,@CustomerID=21,@From='2022-06-13',@To='2022-06-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-06-14',@Price=63.0,@CardID=41,@CustomerID=41,@From='2022-06-14',@To='2022-07-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-06-14',@Price=10.0,@CardID=69,@CustomerID=69,@From='2022-06-14',@To='2022-06-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-06-15',@Price=25.0,@CardID=66,@CustomerID=66,@From='2022-06-15',@To='2022-06-15';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-06-16',@Price=28.0,@CardID=24,@CustomerID=24,@From='2022-06-16',@To='2022-06-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-06-16',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-06-16',@To='2022-06-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-06-16',@Price=12.0,@CardID=21,@CustomerID=21,@From='2022-06-16',@To='2022-06-16';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-06-16',@Price=168.0,@CardID=23,@CustomerID=23,@From='2022-06-16',@To='2022-07-16';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-06-17',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-06-17',@To='2022-06-17';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-06-18',@Price=168.0,@CardID=16,@CustomerID=16,@From='2022-06-18',@To='2022-07-18';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-06-19',@Price=70.0,@CardID=10,@CustomerID=10,@From='2022-06-19',@To='2022-07-19';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-06-19',@Price=522.5,@CardID=49,@CustomerID=49,@From='2022-06-19',@To='2022-09-17';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-06-19',@Price=252.0,@CardID=19,@CustomerID=19,@From='2022-06-19',@To='2022-09-17';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-06-19',@Price=49.0,@CardID=7,@CustomerID=7,@From='2022-06-19',@To='2022-07-19';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-06-19',@Price=80.0,@CardID=22,@CustomerID=22,@From='2022-06-19',@To='2022-07-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-06-20',@Price=15.0,@CardID=61,@CustomerID=61,@From='2022-06-20',@To='2022-06-20';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-06-21',@Price=224.0,@CardID=65,@CustomerID=65,@From='2022-06-21',@To='2022-09-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-06-21',@Price=35.0,@CardID=47,@CustomerID=47,@From='2022-06-21',@To='2022-06-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-06-23',@Price=28.0,@CardID=24,@CustomerID=24,@From='2022-06-23',@To='2022-06-23';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-06-24',@Price=210.0,@CardID=18,@CustomerID=18,@From='2022-06-24',@To='2022-07-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-06-24',@Price=25.0,@CardID=47,@CustomerID=47,@From='2022-06-24',@To='2022-06-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-06-24',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-06-24',@To='2022-06-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-06-25',@Price=35.0,@CardID=66,@CustomerID=66,@From='2022-06-25',@To='2022-06-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-06-25',@Price=9.0,@CardID=8,@CustomerID=8,@From='2022-06-25',@To='2022-06-25';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-06-25',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-06-25',@To='2022-06-25';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2022-06-26',@Price=252.0,@CardID=61,@CustomerID=61,@From='2022-06-26',@To='2022-12-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-06-26',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-06-26',@To='2022-06-26';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-06-26',@Price=250.0,@CardID=28,@CustomerID=28,@From='2022-06-26',@To='2022-07-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-06-26',@Price=10.0,@CardID=21,@CustomerID=21,@From='2022-06-26',@To='2022-06-26';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-06-28',@Price=665.0,@CardID=64,@CustomerID=64,@From='2022-06-28',@To='2022-09-26';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-06-28',@Price=665.0,@CardID=46,@CustomerID=46,@From='2022-06-28',@To='2022-09-26';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-06-28',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-06-28',@To='2022-06-28';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-06-29',@Price=171.0,@CardID=33,@CustomerID=33,@From='2022-06-29',@To='2022-09-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-06-29',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-06-29',@To='2022-06-29';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-06-29',@Price=171.0,@CardID=48,@CustomerID=48,@From='2022-06-29',@To='2022-09-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-06-30',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-06-30',@To='2022-06-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-01',@Price=12.0,@CardID=24,@CustomerID=24,@From='2022-07-01',@To='2022-07-01';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-07-01',@Price=90.0,@CardID=52,@CustomerID=52,@From='2022-07-01',@To='2022-07-31';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-07-02',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-07-02',@To='2022-07-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-07-03',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-07-03',@To='2022-07-03';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-07-03',@Price=700.0,@CardID=60,@CustomerID=60,@From='2022-07-03',@To='2022-10-01';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-07-03',@Price=133.0,@CardID=29,@CustomerID=29,@From='2022-07-03',@To='2022-10-01';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-07-03',@Price=522.5,@CardID=58,@CustomerID=58,@From='2022-07-03',@To='2022-10-01';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-04',@Price=15.0,@CardID=66,@CustomerID=66,@From='2022-07-04',@To='2022-07-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-07-05',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-07-05',@To='2022-07-05';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-07-06',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-07-06',@To='2022-07-06';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-07-07',@Price=237.5,@CardID=25,@CustomerID=25,@From='2022-07-07',@To='2022-08-06';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-07-07',@Price=30.0,@CardID=2,@CustomerID=2,@From='2022-07-07',@To='2022-08-06';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-07-08',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-07-08',@To='2022-07-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-07-08',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-07-08',@To='2022-07-08';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-07-08',@Price=90.0,@CardID=67,@CustomerID=67,@From='2022-07-08',@To='2022-08-07';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-07-09',@Price=10.0,@CardID=69,@CustomerID=69,@From='2022-07-09',@To='2022-07-09';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-07-10',@Price=665.0,@CardID=36,@CustomerID=36,@From='2022-07-10',@To='2022-10-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-10',@Price=15.0,@CardID=9,@CustomerID=9,@From='2022-07-10',@To='2022-07-10';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-07-10',@Price=237.5,@CardID=63,@CustomerID=63,@From='2022-07-10',@To='2022-08-09';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-10',@Price=12.0,@CardID=24,@CustomerID=24,@From='2022-07-10',@To='2022-07-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-07-11',@Price=25.0,@CardID=66,@CustomerID=66,@From='2022-07-11',@To='2022-07-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-07-11',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-07-11',@To='2022-07-11';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-07-11',@Price=90.0,@CardID=40,@CustomerID=40,@From='2022-07-11',@To='2022-08-10';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-07-12',@Price=10.0,@CardID=32,@CustomerID=32,@From='2022-07-12',@To='2022-07-12';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-07-12',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-07-12',@To='2022-07-12';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-07-13',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-07-13',@To='2022-07-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-13',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-07-13',@To='2022-07-13';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-07-13',@Price=63.0,@CardID=15,@CustomerID=15,@From='2022-07-13',@To='2022-08-12';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-07-14',@Price=237.5,@CardID=43,@CustomerID=43,@From='2022-07-14',@To='2022-08-13';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-07-15',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-07-15',@To='2022-07-15';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-07-15',@Price=199.5,@CardID=13,@CustomerID=13,@From='2022-07-15',@To='2022-08-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-07-15',@Price=80.0,@CardID=32,@CustomerID=32,@From='2022-07-15',@To='2022-08-14';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-07-16',@Price=49.0,@CardID=27,@CustomerID=27,@From='2022-07-16',@To='2022-08-15';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-07-16',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-07-16',@To='2022-07-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-07-17',@Price=9.0,@CardID=9,@CustomerID=9,@From='2022-07-17',@To='2022-07-17';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-07-17',@Price=63.0,@CardID=41,@CustomerID=41,@From='2022-07-17',@To='2022-08-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-07-17',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-07-17',@To='2022-07-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-18',@Price=15.0,@CardID=66,@CustomerID=66,@From='2022-07-18',@To='2022-07-18';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-07-18',@Price=440.0,@CardID=23,@CustomerID=23,@From='2022-07-18',@To='2022-10-16';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2022-07-18',@Price=252.0,@CardID=53,@CustomerID=53,@From='2022-07-18',@To='2022-10-16';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-07-19',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-07-19',@To='2022-07-19';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-07-19',@Price=700.0,@CardID=24,@CustomerID=24,@From='2022-07-19',@To='2022-10-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-07-20',@Price=10.0,@CardID=69,@CustomerID=69,@From='2022-07-20',@To='2022-07-20';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-07-20',@Price=200.0,@CardID=16,@CustomerID=16,@From='2022-07-20',@To='2022-08-19';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-07-21',@Price=20.0,@CardID=21,@CustomerID=21,@From='2022-07-21',@To='2022-07-21';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-07-21',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-07-21',@To='2022-07-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-21',@Price=12.0,@CardID=22,@CustomerID=22,@From='2022-07-21',@To='2022-07-21';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2022-07-22',@Price=133.0,@CardID=7,@CustomerID=7,@From='2022-07-22',@To='2022-10-20';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-07-23',@Price=10.0,@CardID=10,@CustomerID=10,@From='2022-07-23',@To='2022-07-23';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-07-23',@Price=250.0,@CardID=37,@CustomerID=37,@From='2022-07-23',@To='2022-08-22';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-07-24',@Price=63.0,@CardID=9,@CustomerID=9,@From='2022-07-24',@To='2022-08-23';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-07-24',@Price=550.0,@CardID=18,@CustomerID=18,@From='2022-07-24',@To='2022-10-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-25',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-07-25',@To='2022-07-25';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-07-25',@Price=56.0,@CardID=22,@CustomerID=22,@From='2022-07-25',@To='2022-08-24';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-07-26',@Price=522.5,@CardID=44,@CustomerID=44,@From='2022-07-26',@To='2022-10-24';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-07-26',@Price=152.0,@CardID=28,@CustomerID=28,@From='2022-07-26',@To='2022-10-24';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-07-27',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-07-27',@To='2022-07-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-07-27',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-07-27',@To='2022-07-27';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-07-27',@Price=12.0,@CardID=21,@CustomerID=21,@From='2022-07-27',@To='2022-07-27';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-07-27',@Price=30.0,@CardID=1,@CustomerID=1,@From='2022-07-27',@To='2022-08-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-28',@Price=15.0,@CardID=66,@CustomerID=66,@From='2022-07-28',@To='2022-07-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-07-28',@Price=15.0,@CardID=10,@CustomerID=10,@From='2022-07-28',@To='2022-07-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-07-29',@Price=12.0,@CardID=21,@CustomerID=21,@From='2022-07-29',@To='2022-07-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-07-30',@Price=10.0,@CardID=69,@CustomerID=69,@From='2022-07-30',@To='2022-07-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-07-31',@Price=70.0,@CardID=10,@CustomerID=10,@From='2022-07-31',@To='2022-08-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-07-31',@Price=9.0,@CardID=66,@CustomerID=66,@From='2022-07-31',@To='2022-07-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-08-01',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-08-01',@To='2022-08-01';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-08-02',@Price=171.0,@CardID=70,@CustomerID=70,@From='2022-08-02',@To='2022-10-31';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-08-02',@Price=210.0,@CardID=34,@CustomerID=34,@From='2022-08-02',@To='2022-09-01';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-08-03',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-08-03',@To='2022-08-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-08-04',@Price=28.0,@CardID=12,@CustomerID=12,@From='2022-08-04',@To='2022-08-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-04',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-08-04',@To='2022-08-04';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-08-04',@Price=56.0,@CardID=42,@CustomerID=42,@From='2022-08-04',@To='2022-09-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-04',@Price=9.0,@CardID=31,@CustomerID=31,@From='2022-08-04',@To='2022-08-04';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-08-04',@Price=199.5,@CardID=62,@CustomerID=62,@From='2022-08-04',@To='2022-09-03';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-08-07',@Price=63.0,@CardID=67,@CustomerID=67,@From='2022-08-07',@To='2022-09-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-07',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-08-07',@To='2022-08-07';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-08-07',@Price=21.0,@CardID=2,@CustomerID=2,@From='2022-08-07',@To='2022-09-06';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-08-08',@Price=199.5,@CardID=25,@CustomerID=25,@From='2022-08-08',@To='2022-09-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-08-09',@Price=15.0,@CardID=66,@CustomerID=66,@From='2022-08-09',@To='2022-08-09';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2022-08-09',@Price=486.0,@CardID=56,@CustomerID=56,@From='2022-08-09',@To='2023-02-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-11',@Price=9.0,@CardID=31,@CustomerID=31,@From='2022-08-11',@To='2022-08-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-08-12',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-08-12',@To='2022-08-12';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-08-12',@Price=90.0,@CardID=11,@CustomerID=11,@From='2022-08-12',@To='2022-09-11';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-08-13',@Price=171.0,@CardID=63,@CustomerID=63,@From='2022-08-13',@To='2022-11-11';
EXEC addPurchase @ServiceID=6,@EmployeeID=7,@Date='2022-08-13',@Price=324.0,@CardID=40,@CustomerID=40,@From='2022-08-13',@To='2023-02-09';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-08-13',@Price=522.5,@CardID=15,@CustomerID=15,@From='2022-08-13',@To='2022-11-11';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-08-13',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-08-13',@To='2022-08-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-08-14',@Price=10.0,@CardID=32,@CustomerID=32,@From='2022-08-14',@To='2022-08-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-08-14',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-08-14',@To='2022-08-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-08-15',@Price=25.0,@CardID=47,@CustomerID=47,@From='2022-08-15',@To='2022-08-15';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-08-15',@Price=237.5,@CardID=43,@CustomerID=43,@From='2022-08-15',@To='2022-09-14';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-08-16',@Price=25.0,@CardID=31,@CustomerID=31,@From='2022-08-16',@To='2022-08-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-08-16',@Price=12.0,@CardID=32,@CustomerID=32,@From='2022-08-16',@To='2022-08-16';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-08-16',@Price=35.0,@CardID=66,@CustomerID=66,@From='2022-08-16',@To='2022-08-16';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2022-08-17',@Price=486.0,@CardID=55,@CustomerID=55,@From='2022-08-17',@To='2023-02-13';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-08-17',@Price=35.0,@CardID=38,@CustomerID=38,@From='2022-08-17',@To='2022-08-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-08-17',@Price=12.0,@CardID=45,@CustomerID=45,@From='2022-08-17',@To='2022-08-17';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-08-18',@Price=665.0,@CardID=13,@CustomerID=13,@From='2022-08-18',@To='2022-11-16';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-18',@Price=9.0,@CardID=8,@CustomerID=8,@From='2022-08-18',@To='2022-08-18';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-08-19',@Price=90.0,@CardID=50,@CustomerID=50,@From='2022-08-19',@To='2022-09-18';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-08-19',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-08-19',@To='2022-08-19';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-08-19',@Price=90.0,@CardID=41,@CustomerID=41,@From='2022-08-19',@To='2022-09-18';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-08-19',@Price=200.0,@CardID=68,@CustomerID=68,@From='2022-08-19',@To='2022-09-18';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2022-08-20',@Price=486.0,@CardID=59,@CustomerID=59,@From='2022-08-20',@To='2023-02-16';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-08-20',@Price=550.0,@CardID=57,@CustomerID=57,@From='2022-08-20',@To='2022-11-18';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-08-20',@Price=28.0,@CardID=45,@CustomerID=45,@From='2022-08-20',@To='2022-08-20';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-08-20',@Price=237.5,@CardID=35,@CustomerID=35,@From='2022-08-20',@To='2022-09-19';
EXEC addPurchase @ServiceID=8,@EmployeeID=8,@Date='2022-08-20',@Price=15.0,@CardID=12,@CustomerID=12,@From='2022-08-20',@To='2022-08-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-08-21',@Price=15.0,@CardID=31,@CustomerID=31,@From='2022-08-21',@To='2022-08-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-08-21',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-08-21',@To='2022-08-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-08-21',@Price=35.0,@CardID=47,@CustomerID=47,@From='2022-08-21',@To='2022-08-21';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-08-22',@Price=12.0,@CardID=32,@CustomerID=32,@From='2022-08-22',@To='2022-08-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-22',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-08-22',@To='2022-08-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-22',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-08-22',@To='2022-08-22';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-08-23',@Price=25.0,@CardID=66,@CustomerID=66,@From='2022-08-23',@To='2022-08-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-08-23',@Price=15.0,@CardID=31,@CustomerID=31,@From='2022-08-23',@To='2022-08-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-08-23',@Price=25.0,@CardID=38,@CustomerID=38,@From='2022-08-23',@To='2022-08-23';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-08-24',@Price=440.0,@CardID=16,@CustomerID=16,@From='2022-08-24',@To='2022-11-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-25',@Price=9.0,@CardID=8,@CustomerID=8,@From='2022-08-25',@To='2022-08-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-08-25',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-08-25',@To='2022-08-25';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-08-25',@Price=90.0,@CardID=9,@CustomerID=9,@From='2022-08-25',@To='2022-09-24';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-08-25',@Price=15.0,@CardID=47,@CustomerID=47,@From='2022-08-25',@To='2022-08-25';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-08-26',@Price=70.0,@CardID=27,@CustomerID=27,@From='2022-08-26',@To='2022-09-25';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-08-26',@Price=171.0,@CardID=38,@CustomerID=38,@From='2022-08-26',@To='2022-11-24';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-08-26',@Price=665.0,@CardID=14,@CustomerID=14,@From='2022-08-26',@To='2022-11-24';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-27',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-08-27',@To='2022-08-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-08-27',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-08-27',@To='2022-08-27';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-08-27',@Price=28.0,@CardID=37,@CustomerID=37,@From='2022-08-27',@To='2022-08-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-08-27',@Price=9.0,@CardID=47,@CustomerID=47,@From='2022-08-27',@To='2022-08-27';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-08-28',@Price=56.0,@CardID=22,@CustomerID=22,@From='2022-08-28',@To='2022-09-27';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-08-28',@Price=9.0,@CardID=8,@CustomerID=8,@From='2022-08-28',@To='2022-08-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-08-29',@Price=12.0,@CardID=45,@CustomerID=45,@From='2022-08-29',@To='2022-08-29';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-08-30',@Price=56.0,@CardID=32,@CustomerID=32,@From='2022-08-30',@To='2022-09-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-08-30',@Price=10.0,@CardID=10,@CustomerID=10,@From='2022-08-30',@To='2022-08-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-08-30',@Price=25.0,@CardID=31,@CustomerID=31,@From='2022-08-30',@To='2022-08-30';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-08-31',@Price=21.0,@CardID=1,@CustomerID=1,@From='2022-08-31',@To='2022-09-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-08-31',@Price=15.0,@CardID=52,@CustomerID=52,@From='2022-08-31',@To='2022-08-31';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-08-31',@Price=28.0,@CardID=21,@CustomerID=21,@From='2022-08-31',@To='2022-08-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-08-31',@Price=10.0,@CardID=45,@CustomerID=45,@From='2022-08-31',@To='2022-08-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-09-01',@Price=10.0,@CardID=10,@CustomerID=10,@From='2022-09-01',@To='2022-09-01';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2022-09-01',@Price=152.0,@CardID=37,@CustomerID=37,@From='2022-09-01',@To='2022-11-30';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2022-09-01',@Price=196.0,@CardID=54,@CustomerID=54,@From='2022-09-01',@To='2022-11-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-09-01',@Price=90.0,@CardID=47,@CustomerID=47,@From='2022-09-01',@To='2022-10-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-09-02',@Price=10.0,@CardID=21,@CustomerID=21,@From='2022-09-02',@To='2022-09-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-09-02',@Price=35.0,@CardID=51,@CustomerID=51,@From='2022-09-02',@To='2022-09-02';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-09-02',@Price=15.0,@CardID=66,@CustomerID=66,@From='2022-09-02',@To='2022-09-02';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-09-02',@Price=250.0,@CardID=34,@CustomerID=34,@From='2022-09-02',@To='2022-10-02';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-09-03',@Price=20.0,@CardID=45,@CustomerID=45,@From='2022-09-03',@To='2022-09-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-09-03',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-09-03',@To='2022-09-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-09-03',@Price=15.0,@CardID=10,@CustomerID=10,@From='2022-09-03',@To='2022-09-03';
EXEC addPurchase @ServiceID=6,@EmployeeID=7,@Date='2022-09-04',@Price=324.0,@CardID=66,@CustomerID=66,@From='2022-09-04',@To='2023-03-03';
EXEC addPurchase @ServiceID=3,@EmployeeID=7,@Date='2022-09-04',@Price=84.0,@CardID=4,@CustomerID=4,@From='2022-09-04',@To='2022-12-03';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-09-04',@Price=665.0,@CardID=62,@CustomerID=62,@From='2022-09-04',@To='2022-12-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-09-04',@Price=10.0,@CardID=69,@CustomerID=69,@From='2022-09-04',@To='2022-09-04';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-09-04',@Price=224.0,@CardID=42,@CustomerID=42,@From='2022-09-04',@To='2022-12-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-09-04',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-09-04',@To='2022-09-04';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-09-05',@Price=10.0,@CardID=21,@CustomerID=21,@From='2022-09-05',@To='2022-09-05';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-09-05',@Price=90.0,@CardID=52,@CustomerID=52,@From='2022-09-05',@To='2022-10-05';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-09-06',@Price=90.0,@CardID=67,@CustomerID=67,@From='2022-09-06',@To='2022-10-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-09-07',@Price=12.0,@CardID=45,@CustomerID=45,@From='2022-09-07',@To='2022-09-07';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-09-08',@Price=75.0,@CardID=3,@CustomerID=3,@From='2022-09-08',@To='2022-10-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-09-08',@Price=35.0,@CardID=31,@CustomerID=31,@From='2022-09-08',@To='2022-09-08';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-09-08',@Price=237.5,@CardID=25,@CustomerID=25,@From='2022-09-08',@To='2022-10-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-09-08',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-09-08',@To='2022-09-08';
EXEC addPurchase @ServiceID=4,@EmployeeID=7,@Date='2022-09-08',@Price=57.0,@CardID=2,@CustomerID=2,@From='2022-09-08',@To='2022-12-07';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-09-10',@Price=49.0,@CardID=10,@CustomerID=10,@From='2022-09-10',@To='2022-10-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-09-10',@Price=35.0,@CardID=39,@CustomerID=39,@From='2022-09-10',@To='2022-09-10';
EXEC addPurchase @ServiceID=5,@EmployeeID=8,@Date='2022-09-11',@Price=378.0,@CardID=17,@CustomerID=17,@From='2022-09-11',@To='2023-03-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-09-11',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-09-11',@To='2022-09-11';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-09-12',@Price=25.0,@CardID=39,@CustomerID=39,@From='2022-09-12',@To='2022-09-12';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-09-12',@Price=700.0,@CardID=21,@CustomerID=21,@From='2022-09-12',@To='2022-12-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-09-13',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-09-13',@To='2022-09-13';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-09-14',@Price=15.0,@CardID=31,@CustomerID=31,@From='2022-09-14',@To='2022-09-14';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-09-14',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-09-14',@To='2022-09-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-09-14',@Price=10.0,@CardID=39,@CustomerID=39,@From='2022-09-14',@To='2022-09-14';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-09-16',@Price=35.0,@CardID=51,@CustomerID=51,@From='2022-09-16',@To='2022-09-16';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-09-16',@Price=90.0,@CardID=11,@CustomerID=11,@From='2022-09-16',@To='2022-10-16';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-09-17',@Price=20.0,@CardID=45,@CustomerID=45,@From='2022-09-17',@To='2022-09-17';
EXEC addPurchase @ServiceID=6,@EmployeeID=8,@Date='2022-09-17',@Price=324.0,@CardID=26,@CustomerID=26,@From='2022-09-17',@To='2023-03-16';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-09-18',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-09-18',@To='2022-09-18';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-09-19',@Price=199.5,@CardID=43,@CustomerID=43,@From='2022-09-19',@To='2022-10-19';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-09-21',@Price=25.0,@CardID=39,@CustomerID=39,@From='2022-09-21',@To='2022-09-21';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-09-21',@Price=28.0,@CardID=12,@CustomerID=12,@From='2022-09-21',@To='2022-09-21';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-09-21',@Price=25.0,@CardID=50,@CustomerID=50,@From='2022-09-21',@To='2022-09-21';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-09-22',@Price=665.0,@CardID=49,@CustomerID=49,@From='2022-09-22',@To='2022-12-21';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-09-22',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-09-22',@To='2022-09-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-09-23',@Price=12.0,@CardID=65,@CustomerID=65,@From='2022-09-23',@To='2022-09-23';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-09-23',@Price=20.0,@CardID=45,@CustomerID=45,@From='2022-09-23',@To='2022-09-23';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-09-23',@Price=237.5,@CardID=35,@CustomerID=35,@From='2022-09-23',@To='2022-10-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-09-23',@Price=15.0,@CardID=50,@CustomerID=50,@From='2022-09-23',@To='2022-09-23';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-09-24',@Price=35.0,@CardID=31,@CustomerID=31,@From='2022-09-24',@To='2022-09-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-09-25',@Price=20.0,@CardID=12,@CustomerID=12,@From='2022-09-25',@To='2022-09-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-09-26',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-09-26',@To='2022-09-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-09-27',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-09-27',@To='2022-09-27';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-09-28',@Price=63.0,@CardID=9,@CustomerID=9,@From='2022-09-28',@To='2022-10-28';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-09-28',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-09-28',@To='2022-09-28';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-09-29',@Price=28.0,@CardID=65,@CustomerID=65,@From='2022-09-29',@To='2022-09-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-09-29',@Price=25.0,@CardID=39,@CustomerID=39,@From='2022-09-29',@To='2022-09-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-09-29',@Price=15.0,@CardID=31,@CustomerID=31,@From='2022-09-29',@To='2022-09-29';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-09-30',@Price=522.5,@CardID=64,@CustomerID=64,@From='2022-09-30',@To='2022-12-29';
EXEC addPurchase @ServiceID=6,@EmployeeID=8,@Date='2022-09-30',@Price=324.0,@CardID=33,@CustomerID=33,@From='2022-09-30',@To='2023-03-29';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-09-30',@Price=90.0,@CardID=50,@CustomerID=50,@From='2022-09-30',@To='2022-10-30';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-09-30',@Price=199.5,@CardID=46,@CustomerID=46,@From='2022-09-30',@To='2022-10-30';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-10-01',@Price=90.0,@CardID=48,@CustomerID=48,@From='2022-10-01',@To='2022-10-31';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-10-01',@Price=12.0,@CardID=12,@CustomerID=12,@From='2022-10-01',@To='2022-10-01';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-10-01',@Price=20.0,@CardID=65,@CustomerID=65,@From='2022-10-01',@To='2022-10-01';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-10-01',@Price=80.0,@CardID=22,@CustomerID=22,@From='2022-10-01',@To='2022-10-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-10-01',@Price=9.0,@CardID=47,@CustomerID=47,@From='2022-10-01',@To='2022-10-01';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-10-02',@Price=700.0,@CardID=34,@CustomerID=34,@From='2022-10-02',@To='2022-12-31';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-10-03',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-10-03',@To='2022-10-03';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-10-04',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-10-04',@To='2022-10-04';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-10-04',@Price=196.0,@CardID=29,@CustomerID=29,@From='2022-10-04',@To='2023-01-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-10-04',@Price=3.0,@CardID=1,@CustomerID=1,@From='2022-10-04',@To='2022-10-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-10-04',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-10-04',@To='2022-10-04';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-10-04',@Price=665.0,@CardID=58,@CustomerID=58,@From='2022-10-04',@To='2023-01-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-10-04',@Price=28.0,@CardID=12,@CustomerID=12,@From='2022-10-04',@To='2022-10-04';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-10-04',@Price=56.0,@CardID=32,@CustomerID=32,@From='2022-10-04',@To='2022-11-03';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-10-05',@Price=700.0,@CardID=60,@CustomerID=60,@From='2022-10-05',@To='2023-01-03';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-10-06',@Price=35.0,@CardID=31,@CustomerID=31,@From='2022-10-06',@To='2022-10-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-10-06',@Price=15.0,@CardID=27,@CustomerID=27,@From='2022-10-06',@To='2022-10-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-10-07',@Price=9.0,@CardID=67,@CustomerID=67,@From='2022-10-07',@To='2022-10-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-10-07',@Price=15.0,@CardID=52,@CustomerID=52,@From='2022-10-07',@To='2022-10-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-10-08',@Price=12.0,@CardID=65,@CustomerID=65,@From='2022-10-08',@To='2022-10-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-10-08',@Price=15.0,@CardID=39,@CustomerID=39,@From='2022-10-08',@To='2022-10-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-10-08',@Price=35.0,@CardID=36,@CustomerID=36,@From='2022-10-08',@To='2022-10-08';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-10-08',@Price=522.5,@CardID=25,@CustomerID=25,@From='2022-10-08',@To='2023-01-06';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-10-09',@Price=237.5,@CardID=47,@CustomerID=47,@From='2022-10-09',@To='2022-11-08';
EXEC addPurchase @ServiceID=1,@EmployeeID=9,@Date='2022-10-09',@Price=70.0,@CardID=30,@CustomerID=30,@From='2022-10-09',@To='2022-11-08';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-10-10',@Price=165.0,@CardID=3,@CustomerID=3,@From='2022-10-10',@To='2023-01-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-10-10',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-10-10',@To='2022-10-10';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-10-10',@Price=49.0,@CardID=27,@CustomerID=27,@From='2022-10-10',@To='2022-11-09';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-10-11',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-10-11',@To='2022-10-11';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-10-11',@Price=21.0,@CardID=1,@CustomerID=1,@From='2022-10-11',@To='2022-11-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-10-11',@Price=35.0,@CardID=39,@CustomerID=39,@From='2022-10-11',@To='2022-10-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-10-13',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-10-13',@To='2022-10-13';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-10-13',@Price=665.0,@CardID=36,@CustomerID=36,@From='2022-10-13',@To='2023-01-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-10-13',@Price=9.0,@CardID=31,@CustomerID=31,@From='2022-10-13',@To='2022-10-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-10-14',@Price=9.0,@CardID=52,@CustomerID=52,@From='2022-10-14',@To='2022-10-14';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-10-14',@Price=70.0,@CardID=10,@CustomerID=10,@From='2022-10-14',@To='2022-11-13';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-10-14',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-10-14',@To='2022-10-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-10-15',@Price=9.0,@CardID=31,@CustomerID=31,@From='2022-10-15',@To='2022-10-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-10-16',@Price=9.0,@CardID=67,@CustomerID=67,@From='2022-10-16',@To='2022-10-16';
EXEC addPurchase @ServiceID=8,@EmployeeID=7,@Date='2022-10-17',@Price=13.5,@CardID=52,@CustomerID=52,@From='2022-10-17',@To='2022-10-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-10-17',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-10-17',@To='2022-10-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-10-18',@Price=10.0,@CardID=65,@CustomerID=65,@From='2022-10-18',@To='2022-10-18';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-10-18',@Price=63.0,@CardID=41,@CustomerID=41,@From='2022-10-18',@To='2022-11-17';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-10-18',@Price=90.0,@CardID=67,@CustomerID=67,@From='2022-10-18',@To='2022-11-17';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-10-18',@Price=171.0,@CardID=11,@CustomerID=11,@From='2022-10-18',@To='2023-01-16';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-10-19',@Price=440.0,@CardID=23,@CustomerID=23,@From='2022-10-19',@To='2023-01-17';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-10-19',@Price=56.0,@CardID=5,@CustomerID=5,@From='2022-10-19',@To='2022-11-18';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-10-20',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-10-20',@To='2022-10-20';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-10-20',@Price=35.0,@CardID=39,@CustomerID=39,@From='2022-10-20',@To='2022-10-20';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-10-20',@Price=20.0,@CardID=12,@CustomerID=12,@From='2022-10-20',@To='2022-10-20';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-10-20',@Price=440.0,@CardID=68,@CustomerID=68,@From='2022-10-20',@To='2023-01-18';
EXEC addPurchase @ServiceID=3,@EmployeeID=8,@Date='2022-10-20',@Price=224.0,@CardID=20,@CustomerID=20,@From='2022-10-20',@To='2023-01-18';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-10-21',@Price=200.0,@CardID=7,@CustomerID=7,@From='2022-10-21',@To='2022-11-20';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-10-21',@Price=20.0,@CardID=65,@CustomerID=65,@From='2022-10-21',@To='2022-10-21';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-10-21',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-10-21',@To='2022-10-21';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-10-21',@Price=56.0,@CardID=24,@CustomerID=24,@From='2022-10-21',@To='2022-11-20';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-10-22',@Price=250.0,@CardID=18,@CustomerID=18,@From='2022-10-22',@To='2022-11-21';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-10-23',@Price=25.0,@CardID=31,@CustomerID=31,@From='2022-10-23',@To='2022-10-23';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-10-24',@Price=199.5,@CardID=44,@CustomerID=44,@From='2022-10-24',@To='2022-11-23';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-10-24',@Price=90.0,@CardID=52,@CustomerID=52,@From='2022-10-24',@To='2022-11-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-10-26',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-10-26',@To='2022-10-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-10-26',@Price=12.0,@CardID=65,@CustomerID=65,@From='2022-10-26',@To='2022-10-26';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-10-28',@Price=15.0,@CardID=39,@CustomerID=39,@From='2022-10-28',@To='2022-10-28';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-10-28',@Price=28.0,@CardID=28,@CustomerID=28,@From='2022-10-28',@To='2022-10-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-10-28',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-10-28',@To='2022-10-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-10-28',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-10-28',@To='2022-10-28';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-10-28',@Price=237.5,@CardID=35,@CustomerID=35,@From='2022-10-28',@To='2022-11-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-10-28',@Price=20.0,@CardID=65,@CustomerID=65,@From='2022-10-28',@To='2022-10-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-10-29',@Price=9.0,@CardID=31,@CustomerID=31,@From='2022-10-29',@To='2022-10-29';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-10-30',@Price=10.0,@CardID=69,@CustomerID=69,@From='2022-10-30',@To='2022-10-30';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-10-30',@Price=35.0,@CardID=39,@CustomerID=39,@From='2022-10-30',@To='2022-10-30';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-10-30',@Price=35.0,@CardID=19,@CustomerID=19,@From='2022-10-30',@To='2022-10-30';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-10-30',@Price=10.0,@CardID=12,@CustomerID=12,@From='2022-10-30',@To='2022-10-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-10-31',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-10-31',@To='2022-10-31';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-10-31',@Price=237.5,@CardID=70,@CustomerID=70,@From='2022-10-31',@To='2022-11-30';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-11-01',@Price=35.0,@CardID=19,@CustomerID=19,@From='2022-11-01',@To='2022-11-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-11-02',@Price=10.0,@CardID=45,@CustomerID=45,@From='2022-11-02',@To='2022-11-02';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-11-02',@Price=199.5,@CardID=46,@CustomerID=46,@From='2022-11-02',@To='2022-12-02';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2022-11-02',@Price=224.0,@CardID=28,@CustomerID=28,@From='2022-11-02',@To='2023-01-31';
EXEC addPurchase @ServiceID=6,@EmployeeID=8,@Date='2022-11-02',@Price=324.0,@CardID=9,@CustomerID=9,@From='2022-11-02',@To='2023-05-01';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-11-02',@Price=210.0,@CardID=12,@CustomerID=12,@From='2022-11-02',@To='2022-12-02';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-11-03',@Price=35.0,@CardID=39,@CustomerID=39,@From='2022-11-03',@To='2022-11-03';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-11-04',@Price=63.0,@CardID=31,@CustomerID=31,@From='2022-11-04',@To='2022-12-04';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-11-04',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-11-04',@To='2022-11-04';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-11-05',@Price=56.0,@CardID=22,@CustomerID=22,@From='2022-11-05',@To='2022-12-05';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-11-05',@Price=10.0,@CardID=39,@CustomerID=39,@From='2022-11-05',@To='2022-11-05';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-11-05',@Price=28.0,@CardID=65,@CustomerID=65,@From='2022-11-05',@To='2022-11-05';
EXEC addPurchase @ServiceID=3,@EmployeeID=9,@Date='2022-11-05',@Price=252.0,@CardID=48,@CustomerID=48,@From='2022-11-05',@To='2023-02-03';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-11-06',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-11-06',@To='2022-11-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-11-07',@Price=15.0,@CardID=8,@CustomerID=8,@From='2022-11-07',@To='2022-11-07';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-11-08',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-11-08',@To='2022-11-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-11-08',@Price=15.0,@CardID=47,@CustomerID=47,@From='2022-11-08',@To='2022-11-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-11-08',@Price=12.0,@CardID=32,@CustomerID=32,@From='2022-11-08',@To='2022-11-08';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-11-09',@Price=133.0,@CardID=30,@CustomerID=30,@From='2022-11-09',@To='2023-02-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-11-10',@Price=15.0,@CardID=47,@CustomerID=47,@From='2022-11-10',@To='2022-11-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-11-11',@Price=25.0,@CardID=39,@CustomerID=39,@From='2022-11-11',@To='2022-11-11';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-11-11',@Price=35.0,@CardID=51,@CustomerID=51,@From='2022-11-11',@To='2022-11-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-11-11',@Price=12.0,@CardID=45,@CustomerID=45,@From='2022-11-11',@To='2022-11-11';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-11-11',@Price=21.0,@CardID=1,@CustomerID=1,@From='2022-11-11',@To='2022-12-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-11-11',@Price=10.0,@CardID=65,@CustomerID=65,@From='2022-11-11',@To='2022-11-11';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-11-12',@Price=9.0,@CardID=53,@CustomerID=53,@From='2022-11-12',@To='2022-11-12';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-11-13',@Price=70.0,@CardID=27,@CustomerID=27,@From='2022-11-13',@To='2022-12-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-11-13',@Price=10.0,@CardID=65,@CustomerID=65,@From='2022-11-13',@To='2022-11-13';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-11-14',@Price=10.0,@CardID=39,@CustomerID=39,@From='2022-11-14',@To='2022-11-14';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-11-15',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-11-15',@To='2022-11-15';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-11-15',@Price=35.0,@CardID=53,@CustomerID=53,@From='2022-11-15',@To='2022-11-15';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-11-15',@Price=25.0,@CardID=47,@CustomerID=47,@From='2022-11-15',@To='2022-11-15';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-11-15',@Price=12.0,@CardID=32,@CustomerID=32,@From='2022-11-15',@To='2022-11-15';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-11-15',@Price=90.0,@CardID=15,@CustomerID=15,@From='2022-11-15',@To='2022-12-15';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-11-16',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-11-16',@To='2022-11-16';
EXEC addPurchase @ServiceID=10,@EmployeeID=9,@Date='2022-11-16',@Price=199.5,@CardID=13,@CustomerID=13,@From='2022-11-16',@To='2022-12-16';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-11-16',@Price=237.5,@CardID=63,@CustomerID=63,@From='2022-11-16',@To='2022-12-16';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-11-16',@Price=28.0,@CardID=65,@CustomerID=65,@From='2022-11-16',@To='2022-11-16';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-11-17',@Price=70.0,@CardID=10,@CustomerID=10,@From='2022-11-17',@To='2022-12-17';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-11-17',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-11-17',@To='2022-11-17';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-11-18',@Price=10.0,@CardID=65,@CustomerID=65,@From='2022-11-18',@To='2022-11-18';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-11-18',@Price=28.0,@CardID=45,@CustomerID=45,@From='2022-11-18',@To='2022-11-18';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-11-19',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-11-19',@To='2022-11-19';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-11-19',@Price=199.5,@CardID=43,@CustomerID=43,@From='2022-11-19',@To='2022-12-19';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-11-20',@Price=56.0,@CardID=57,@CustomerID=57,@From='2022-11-20',@To='2022-12-20';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-11-20',@Price=15.0,@CardID=67,@CustomerID=67,@From='2022-11-20',@To='2022-11-20';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-11-21',@Price=25.0,@CardID=39,@CustomerID=39,@From='2022-11-21',@To='2022-11-21';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-11-21',@Price=210.0,@CardID=18,@CustomerID=18,@From='2022-11-21',@To='2022-12-21';
EXEC addPurchase @ServiceID=6,@EmployeeID=9,@Date='2022-11-21',@Price=324.0,@CardID=47,@CustomerID=47,@From='2022-11-21',@To='2023-05-20';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-11-22',@Price=63.0,@CardID=41,@CustomerID=41,@From='2022-11-22',@To='2022-12-22';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-11-22',@Price=168.0,@CardID=7,@CustomerID=7,@From='2022-11-22',@To='2022-12-22';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-11-22',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-11-22',@To='2022-11-22';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-11-22',@Price=10.0,@CardID=24,@CustomerID=24,@From='2022-11-22',@To='2022-11-22';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-11-22',@Price=80.0,@CardID=5,@CustomerID=5,@From='2022-11-22',@To='2022-12-22';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-11-22',@Price=56.0,@CardID=32,@CustomerID=32,@From='2022-11-22',@To='2022-12-22';
EXEC addPurchase @ServiceID=8,@EmployeeID=9,@Date='2022-11-23',@Price=15.0,@CardID=45,@CustomerID=45,@From='2022-11-23',@To='2022-11-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-11-23',@Price=12.0,@CardID=65,@CustomerID=65,@From='2022-11-23',@To='2022-11-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-11-24',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-11-24',@To='2022-11-24';
EXEC addPurchase @ServiceID=5,@EmployeeID=9,@Date='2022-11-24',@Price=486.0,@CardID=6,@CustomerID=6,@From='2022-11-24',@To='2023-05-23';
EXEC addPurchase @ServiceID=4,@EmployeeID=9,@Date='2022-11-25',@Price=133.0,@CardID=16,@CustomerID=16,@From='2022-11-25',@To='2023-02-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-11-26',@Price=10.0,@CardID=65,@CustomerID=65,@From='2022-11-26',@To='2022-11-26';
EXEC addPurchase @ServiceID=5,@EmployeeID=7,@Date='2022-11-26',@Price=486.0,@CardID=67,@CustomerID=67,@From='2022-11-26',@To='2023-05-25';
EXEC addPurchase @ServiceID=11,@EmployeeID=8,@Date='2022-11-27',@Price=665.0,@CardID=44,@CustomerID=44,@From='2022-11-27',@To='2023-02-25';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-11-27',@Price=15.0,@CardID=50,@CustomerID=50,@From='2022-11-27',@To='2022-11-27';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-11-27',@Price=522.5,@CardID=14,@CustomerID=14,@From='2022-11-27',@To='2023-02-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-11-28',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-11-28',@To='2022-11-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-11-28',@Price=9.0,@CardID=52,@CustomerID=52,@From='2022-11-28',@To='2022-11-28';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-11-28',@Price=9.0,@CardID=38,@CustomerID=38,@From='2022-11-28',@To='2022-11-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-11-28',@Price=25.0,@CardID=8,@CustomerID=8,@From='2022-11-28',@To='2022-11-28';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-11-29',@Price=237.5,@CardID=35,@CustomerID=35,@From='2022-11-29',@To='2022-12-29';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-11-30',@Price=20.0,@CardID=65,@CustomerID=65,@From='2022-11-30',@To='2022-11-30';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-11-30',@Price=152.0,@CardID=37,@CustomerID=37,@From='2022-11-30',@To='2023-02-28';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-11-30',@Price=25.0,@CardID=19,@CustomerID=19,@From='2022-11-30',@To='2022-11-30';
EXEC addPurchase @ServiceID=14,@EmployeeID=9,@Date='2022-11-30',@Price=25.0,@CardID=39,@CustomerID=39,@From='2022-11-30',@To='2022-11-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-12-01',@Price=12.0,@CardID=45,@CustomerID=45,@From='2022-12-01',@To='2022-12-01';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-12-01',@Price=9.0,@CardID=51,@CustomerID=51,@From='2022-12-01',@To='2022-12-01';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-12-02',@Price=15.0,@CardID=39,@CustomerID=39,@From='2022-12-02',@To='2022-12-02';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-12-03',@Price=80.0,@CardID=12,@CustomerID=12,@From='2022-12-03',@To='2023-01-02';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-12-04',@Price=9.0,@CardID=50,@CustomerID=50,@From='2022-12-04',@To='2022-12-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-12-04',@Price=15.0,@CardID=52,@CustomerID=52,@From='2022-12-04',@To='2022-12-04';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-12-04',@Price=237.5,@CardID=46,@CustomerID=46,@From='2022-12-04',@To='2023-01-03';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-12-04',@Price=522.5,@CardID=70,@CustomerID=70,@From='2022-12-04',@To='2023-03-04';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-12-05',@Price=15.0,@CardID=38,@CustomerID=38,@From='2022-12-05',@To='2022-12-05';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-12-06',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-12-06',@To='2022-12-06';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-12-06',@Price=10.0,@CardID=22,@CustomerID=22,@From='2022-12-06',@To='2022-12-06';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-12-07',@Price=4.5,@CardID=2,@CustomerID=2,@From='2022-12-07',@To='2022-12-07';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-12-07',@Price=15.0,@CardID=50,@CustomerID=50,@From='2022-12-07',@To='2022-12-07';
EXEC addPurchase @ServiceID=12,@EmployeeID=7,@Date='2022-12-07',@Price=165.0,@CardID=4,@CustomerID=4,@From='2022-12-07',@To='2023-03-07';
EXEC addPurchase @ServiceID=11,@EmployeeID=9,@Date='2022-12-07',@Price=700.0,@CardID=42,@CustomerID=42,@From='2022-12-07',@To='2023-03-07';
EXEC addPurchase @ServiceID=11,@EmployeeID=7,@Date='2022-12-07',@Price=665.0,@CardID=62,@CustomerID=62,@From='2022-12-07',@To='2023-03-07';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-12-08',@Price=35.0,@CardID=31,@CustomerID=31,@From='2022-12-08',@To='2022-12-08';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-12-09',@Price=20.0,@CardID=65,@CustomerID=65,@From='2022-12-09',@To='2022-12-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=7,@Date='2022-12-09',@Price=63.0,@CardID=50,@CustomerID=50,@From='2022-12-09',@To='2023-01-08';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-12-09',@Price=28.0,@CardID=45,@CustomerID=45,@From='2022-12-09',@To='2022-12-09';
EXEC addPurchase @ServiceID=4,@EmployeeID=8,@Date='2022-12-09',@Price=133.0,@CardID=39,@CustomerID=39,@From='2022-12-09',@To='2023-03-09';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-12-09',@Price=21.0,@CardID=2,@CustomerID=2,@From='2022-12-09',@To='2023-01-08';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-12-10',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-12-10',@To='2022-12-10';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-12-11',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-12-11',@To='2022-12-11';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-12-11',@Price=15.0,@CardID=31,@CustomerID=31,@From='2022-12-11',@To='2022-12-11';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-12-11',@Price=21.0,@CardID=1,@CustomerID=1,@From='2022-12-11',@To='2023-01-10';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-12-12',@Price=35.0,@CardID=51,@CustomerID=51,@From='2022-12-12',@To='2022-12-12';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-12-13',@Price=90.0,@CardID=52,@CustomerID=52,@From='2022-12-13',@To='2023-01-12';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-12-14',@Price=12.0,@CardID=45,@CustomerID=45,@From='2022-12-14',@To='2022-12-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-12-14',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-12-14',@To='2022-12-14';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-12-15',@Price=28.0,@CardID=69,@CustomerID=69,@From='2022-12-15',@To='2022-12-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-12-15',@Price=9.0,@CardID=15,@CustomerID=15,@From='2022-12-15',@To='2022-12-15';
EXEC addPurchase @ServiceID=2,@EmployeeID=8,@Date='2022-12-15',@Price=56.0,@CardID=21,@CustomerID=21,@From='2022-12-15',@To='2023-01-14';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-12-15',@Price=9.0,@CardID=31,@CustomerID=31,@From='2022-12-15',@To='2022-12-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-12-16',@Price=10.0,@CardID=65,@CustomerID=65,@From='2022-12-16',@To='2022-12-16';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-12-16',@Price=250.0,@CardID=22,@CustomerID=22,@From='2022-12-16',@To='2023-01-15';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-12-16',@Price=237.5,@CardID=63,@CustomerID=63,@From='2022-12-16',@To='2023-01-15';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-12-17',@Price=10.0,@CardID=10,@CustomerID=10,@From='2022-12-17',@To='2022-12-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-12-17',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-12-17',@To='2022-12-17';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-12-18',@Price=15.0,@CardID=51,@CustomerID=51,@From='2022-12-18',@To='2022-12-18';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-12-19',@Price=28.0,@CardID=24,@CustomerID=24,@From='2022-12-19',@To='2022-12-19';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-12-19',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-12-19',@To='2022-12-19';
EXEC addPurchase @ServiceID=9,@EmployeeID=7,@Date='2022-12-20',@Price=250.0,@CardID=57,@CustomerID=57,@From='2022-12-20',@To='2023-01-19';
EXEC addPurchase @ServiceID=9,@EmployeeID=8,@Date='2022-12-20',@Price=237.5,@CardID=43,@CustomerID=43,@From='2022-12-20',@To='2023-01-19';
EXEC addPurchase @ServiceID=15,@EmployeeID=9,@Date='2022-12-22',@Price=28.0,@CardID=65,@CustomerID=65,@From='2022-12-22',@To='2022-12-22';
EXEC addPurchase @ServiceID=1,@EmployeeID=8,@Date='2022-12-22',@Price=80.0,@CardID=5,@CustomerID=5,@From='2022-12-22',@To='2023-01-21';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-12-22',@Price=56.0,@CardID=32,@CustomerID=32,@From='2022-12-22',@To='2023-01-21';
EXEC addPurchase @ServiceID=9,@EmployeeID=9,@Date='2022-12-23',@Price=237.5,@CardID=15,@CustomerID=15,@From='2022-12-23',@To='2023-01-22';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-12-23',@Price=15.0,@CardID=53,@CustomerID=53,@From='2022-12-23',@To='2022-12-23';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-12-23',@Price=9.0,@CardID=31,@CustomerID=31,@From='2022-12-23',@To='2022-12-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=8,@Date='2022-12-24',@Price=12.0,@CardID=45,@CustomerID=45,@From='2022-12-24',@To='2022-12-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=7,@Date='2022-12-24',@Price=20.0,@CardID=69,@CustomerID=69,@From='2022-12-24',@To='2022-12-24';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-12-24',@Price=199.5,@CardID=49,@CustomerID=49,@From='2022-12-24',@To='2023-01-23';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-12-24',@Price=15.0,@CardID=19,@CustomerID=19,@From='2022-12-24',@To='2022-12-24';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-12-25',@Price=25.0,@CardID=61,@CustomerID=61,@From='2022-12-25',@To='2022-12-25';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-12-25',@Price=35.0,@CardID=51,@CustomerID=51,@From='2022-12-25',@To='2022-12-25';
EXEC addPurchase @ServiceID=2,@EmployeeID=9,@Date='2022-12-25',@Price=49.0,@CardID=7,@CustomerID=7,@From='2022-12-25',@To='2023-01-24';
EXEC addPurchase @ServiceID=10,@EmployeeID=7,@Date='2022-12-25',@Price=168.0,@CardID=54,@CustomerID=54,@From='2022-12-25',@To='2023-01-24';
EXEC addPurchase @ServiceID=12,@EmployeeID=9,@Date='2022-12-25',@Price=550.0,@CardID=18,@CustomerID=18,@From='2022-12-25',@To='2023-03-25';
EXEC addPurchase @ServiceID=7,@EmployeeID=7,@Date='2022-12-26',@Price=10.0,@CardID=10,@CustomerID=10,@From='2022-12-26',@To='2022-12-26';
EXEC addPurchase @ServiceID=7,@EmployeeID=9,@Date='2022-12-26',@Price=9.0,@CardID=19,@CustomerID=19,@From='2022-12-26',@To='2022-12-26';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-12-27',@Price=25.0,@CardID=61,@CustomerID=61,@From='2022-12-27',@To='2022-12-27';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-12-27',@Price=90.0,@CardID=41,@CustomerID=41,@From='2022-12-27',@To='2023-01-26';
EXEC addPurchase @ServiceID=15,@EmployeeID=8,@Date='2022-12-27',@Price=28.0,@CardID=24,@CustomerID=24,@From='2022-12-27',@To='2022-12-27';
EXEC addPurchase @ServiceID=14,@EmployeeID=8,@Date='2022-12-29',@Price=25.0,@CardID=51,@CustomerID=51,@From='2022-12-29',@To='2022-12-29';
EXEC addPurchase @ServiceID=13,@EmployeeID=9,@Date='2022-12-29',@Price=12.0,@CardID=69,@CustomerID=69,@From='2022-12-29',@To='2022-12-29';
EXEC addPurchase @ServiceID=1,@EmployeeID=7,@Date='2022-12-29',@Price=70.0,@CardID=10,@CustomerID=10,@From='2022-12-29',@To='2023-01-28';
EXEC addPurchase @ServiceID=12,@EmployeeID=8,@Date='2022-12-30',@Price=522.5,@CardID=35,@CustomerID=35,@From='2022-12-30',@To='2023-03-30';
EXEC addPurchase @ServiceID=13,@EmployeeID=7,@Date='2022-12-31',@Price=12.0,@CardID=65,@CustomerID=65,@From='2022-12-31',@To='2022-12-31';
EXEC addPurchase @ServiceID=10,@EmployeeID=8,@Date='2022-12-31',@Price=199.5,@CardID=64,@CustomerID=64,@From='2022-12-31',@To='2023-01-30';
EXEC addPurchase @ServiceID=15,@EmployeeID=7,@Date='2022-12-31',@Price=35.0,@CardID=8,@CustomerID=8,@From='2022-12-31',@To='2022-12-31';
EXEC addPurchase @ServiceID=7,@EmployeeID=8,@Date='2022-12-31',@Price=10.0,@CardID=61,@CustomerID=61,@From='2022-12-31',@To='2022-12-31';

