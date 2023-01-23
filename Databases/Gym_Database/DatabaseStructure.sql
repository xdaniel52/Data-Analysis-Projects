-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/6EyytZVARCHAR2
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [Customers] (
    [CustomerID] INT IDENTITY(1,1) NOT NULL ,
    [FirstName] VARCHAR(50)  NOT NULL ,
    [LastName] VARCHAR(50)  NOT NULL ,
    [Email] VARCHAR(50)  NOT NULL ,
    [PhoneNumber] VARCHAR(11)  NOT NULL ,
    [DateOfBirth] DATE  NOT NULL ,
    [Sex] CHAR(1)  NOT NULL ,
    [City] VARCHAR(50)  NOT NULL ,
    [StreetAddress] VARCHAR(30)  NOT NULL ,
    [HouseNumber] INT  NOT NULL ,
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
    [CardID] INT  NOT NULL ,
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
    [StreetAddress] VARCHAR(30)  NOT NULL ,
    [HouseNumber] INT  NOT NULL ,
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

COMMIT TRANSACTION QUICKDBD