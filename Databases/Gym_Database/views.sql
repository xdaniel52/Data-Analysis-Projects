
CREATE OR ALTER VIEW vw_ServicesList AS
--clear view of all services without cards
SELECT [ServiceID]
      ,[Services].[Name] AS ServiceName
	  ,[ServiceTypes].[Name] AS ServiceType
      ,[Duration]
	  ,CASE WHEN [ServiceTypes].DurationInHours = 1 THEN 'hours' ELSE 'days' END AS TimeUnit
      ,[OnlyMorning]
      ,[Price]
  FROM [Gym].[dbo].[Services]
  JOIN [Gym].[dbo].[ServiceTypes] ON ([Services].[ServiceTypeID] = [ServiceTypes].[ServiceTypeID])
  WHERE [Services].[ServiceTypeID] != 5;


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
  FROM [Gym].[dbo].[Discounts] dis
  ) DiscountsQuery  
  JOIN 
  (
	SELECT ser.[Duration] AS CardTypeID
      ,ser.[Price] AS Price
      ,ser.[Name] AS Name
  FROM [Gym].[dbo].[Services] ser
  WHERE ser.[ServiceTypeID] = 5
  ) ServicesQuery
  ON (DiscountsQuery.[CardTypeID] = ServicesQuery.[CardTypeID])
  GROUP BY DiscountsQuery.CardTypeID,ServicesQuery.Name,ServicesQuery.Price;




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
  FROM [Gym].[dbo].[Employees]
  JOIN [Gym].[dbo].[Jobs] ON ([Employees].[JobID] = [Jobs].[JobID])
  JOIN (
	  SELECT [ContractID]
		  ,[EmployeeID]
		  ,[DateSigned]
		  ,[From]
		  ,[To]
		  ,[Salary]
		  ,[WorkingTime]
	  FROM [Gym].[dbo].[Contracts] LatestContractsInner
	  WHERE [From] = (
			SELECT max([From]) 
			FROM [Gym].[dbo].[Contracts] WhereContracts
			WHERE LatestContractsInner.EmployeeID = WhereContracts.EmployeeID
			)
	) LatestContracts ON ([Employees].[EmployeeID] = LatestContracts.[EmployeeID])
  JOIN (
		
		SELECT EmployeeID
			,Min([From]) AS [From]
		FROM [Gym].[dbo].[Contracts] WhereContracts
		GROUP BY EmployeeID
			
	) OldestContracts ON ([Employees].[EmployeeID] = OldestContracts.[EmployeeID])
  ;


CREATE OR ALTER VIEW vw_GymIncomsIn2022byServiceType AS
--incoms in 2022 groped by ServiceType
SELECT [ServiceTypes].[Name] AS "ServiceType"
      ,FORMAT(SUM([PurchasesHistory].[Price]), 'C') AS "Income"
  FROM [Gym].[dbo].[PurchasesHistory] 
  JOIN [Services] ON ([PurchasesHistory].[ServiceID] = [Services].[ServiceID])
  JOIN [ServiceTypes] ON ([Services].[ServiceTypeID] = [ServiceTypes].[ServiceTypeID])
  WHERE Year([PurchaseDate]) = 2022
  GROUP BY [ServiceTypes].[Name]
  ORDER BY SUM([PurchasesHistory].[Price]) DESC;


CREATE OR ALTER VIEW vw_GymIncomsIn2022byCardType AS
--incoms in 2022 groped by CardType
SELECT [CardTypes].[Name] AS "CardType"
      ,FORMAT(SUM([PurchasesHistory].[Price]), 'C') AS "Income in 2022"
  FROM [Gym].[dbo].[PurchasesHistory] 
  JOIN [MembershipCards] ON ([PurchasesHistory].[CardID] = [MembershipCards].[CardID])
  JOIN [CardTypes] ON ([MembershipCards].[CardTypeID] = [CardTypes].[CardTypeID])
  WHERE Year([PurchasesHistory].[PurchaseDate]) = 2022
  GROUP BY [CardTypes].[Name]
  ORDER BY SUM([PurchasesHistory].[Price]) DESC;


CREATE OR ALTER VIEW vw_GymIncomsIn2022byEmployee AS
--incoms in 2022 groped by receptionist
SELECT [Employees].[EmployeeID]
	  ,[Employees].[FirstName] 
	  ,[Employees].[LastName] 
      ,FORMAT(SUM([PurchasesHistory].[Price]), 'C') AS "Income in 2022"
  FROM [Gym].[dbo].[PurchasesHistory] 
  JOIN [Employees] ON ([PurchasesHistory].[EmployeeID] = [Employees].[EmployeeID])
  WHERE Year([PurchasesHistory].[PurchaseDate]) = 2022
  GROUP BY [Employees].[EmployeeID],[Employees].[FirstName],[Employees].[LastName]
  ORDER BY SUM([PurchasesHistory].[Price]) DESC;














