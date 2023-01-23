INSERT INTO [Jobs](Name) VALUES('Manager');
INSERT INTO [Jobs](Name) VALUES('Personal trainer');
INSERT INTO [Jobs](Name) VALUES('Receptionist');
INSERT INTO [Jobs](Name) VALUES('Cleaning lady');
INSERT INTO [Jobs](Name) VALUES('Caretaker');
INSERT INTO [Jobs](Name) VALUES('Lifeguard');
INSERT INTO [Jobs](Name) VALUES('Other');


INSERT INTO [CardTypes](Name) VALUES('Basic');
INSERT INTO [CardTypes](Name) VALUES('Premium');
INSERT INTO [CardTypes](Name) VALUES('Employee');
INSERT INTO [CardTypes](Name) VALUES('University');


INSERT INTO [ServiceTypes](Name, DurationInHours) VALUES('Gym membership', 0);
INSERT INTO [ServiceTypes](Name, DurationInHours) VALUES('Gym ticket', 1);
INSERT INTO [ServiceTypes](Name, DurationInHours) VALUES('Pool membership', 0);
INSERT INTO [ServiceTypes](Name, DurationInHours) VALUES('Pool ticket', 1);
INSERT INTO [ServiceTypes](Name, DurationInHours) VALUES('Membership cards', 0);

INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Monthly gym membership OPEN',1,30, 0, 100.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Monthly gym membership MORNING',1,30, 1, 70.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Three-month gym membership OPEN',1,90, 0, 280.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Three-month gym membership MORNING',1,90, 1, 190.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Half-year gym membership OPEN',1,180, 0, 540.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Half-year gym membership MORNING',1,180, 1, 360.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('One-time gym ticket 2h',2,2, 0, 10.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('One-time gym ticket 5h',2,5, 0, 15.00);

INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Monthly pool membership OPEN',3,30, 0, 250.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Monthly pool membership MORNING',3,30, 1, 210.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Three-month pool membership OPEN',3,90, 0, 700.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Three-month pool membership MORNING',3,90, 1, 550.00);

INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Swimming pool ticket 1h',4,1, 0, 15.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Swimming pool ticket 2h',4,2, 0, 25.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Swimming pool ticket 4h',4,4, 0, 35.00);

INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Basic card',5,null, null, 15.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Premium card',5,null, null, 100.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('Employee card',5,null, null, 5.00);
INSERT INTO [Services](Name, ServiceTypeID,Duration,OnlyMorning,Price) VALUES('University card',5,null, null, 15.00);


INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Emploee discount gym membership', 3, 1, 0.7);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Emploee discount gym ticket', 3, 2, 0.7);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Emploee discount pool membership', 3, 3, 0.7);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Emploee discount pool ticket', 3, 4, 0.7);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('University discount gym membership', 4, 1, 0.2);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('University discount pool ticket', 4, 4, 0.2);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Premium cards discount gym membership', 2, 1, 0.30);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Premium cards discount pool membership', 2, 3, 0.20);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Basic cards discount gym membership', 1, 1, 0.10);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Basic cards discount gym ticket', 1, 2, 0.10);
INSERT INTO [Discounts](Name, CardTypeID, ServiceTypeID, Fraction) VALUES('Basic cards discount pool membership', 1, 3, 0.05);


INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(1, 'Daniel', 'Kucharski', 'xdaniel@onet.eu', '123456789', '2001-03-23','M', 'Częstochowa','MyStreet',5,25);

INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(2, 'Przemyk', 'Kysiak', 'przemek_krysiak@gym.com', '234567891', '2001-04-21','M', 'Częstochowa','Brett Way',4,14);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(2, 'Rafał', 'Bajer', 'rafal_bajer@gym.com', '345678912', '2000-09-30','M', 'Częstochowa','Albara Place ',37, null);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(2, 'Mateusz', 'Zaręba', 'matesz_zarebak@gym.com', '456789123', '1999-01-09','M', 'Częstochowa','Kurtz Lane',2,63);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(2, 'Sara', 'Garncarz', 'sara_garncarz@gym.com', '567891234', '2001-05-15','F', 'Częstochowa','Nicole Terrace',46,82);

INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(3, 'Isabelle', 'Cain', 'isabelle _cain@gym.com', '678912345', '1989-09-01','F', 'Częstochowa','Liberty Way',10,12);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(3, 'Katerina', 'Downs', 'katerina_downs@gym.com', '789123456', '1985-02-12','F', 'Częstochowa','Lake Lane',3,null);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(3, 'Pamela', 'Brady', 'pamela_brady@gym.com', '891234567', '1977-08-23','F', 'Częstochowa','Lilypad Boulevard',245,34);

INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(4, 'Emmy', 'Dale', 'emmy_dale@gym.com', '987654321', '1964-12-29','F', 'Częstochowa','Serenity Way',22,10);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(4, 'Farrah', 'Gray', 'farrah_gray@gym.com', '876543219', '1971-07-19','F', 'Częstochowa','Senna Route',84,94);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(4, 'Samara', 'Beltran', 'samara_beltran@gym.com', '765432198', '1965-06-11','F', 'Częstochowa','Congress Boulevard',134,null);

INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(5, 'Darius', 'Lamb', 'darius_lamb@gym.com', '654321987', '1960-04-21','M', 'Częstochowa','Aviation Row',1,45);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(5, 'Jaden', 'Campbell', 'jaden_campbell@gym.com', '543219876', '1968-03-07','M', 'Częstochowa','Albara Place',82, 111);

INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(6, 'Aled', 'Baldwin', 'aled_baldwin@gym.com', '432198765', '1996-08-18','M', 'Częstochowa','Ashland Street',64,null);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(6, 'Nabil', 'Slater', 'nabil_slater@gym.com', '321987654', '1999-04-07','M', 'Częstochowa','Pebble Lane',168, null);

INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(6, 'Jamal', 'Barton', 'jamal_barton@gym.com', '219876543', '1987-11-14','M', 'Częstochowa','Anchor Route',32, 67);


INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(1, '2020-01-02', '2020-01-02', '9999-12-31',15000,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(2, '2020-01-02', '2020-01-02', '9999-12-31',6000,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(3, '2022-01-02', '2020-01-02', '9999-12-31',5000,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(4, '2020-01-02', '2020-01-02', '9999-12-31',2000,0.5);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(5, '2020-01-02', '2020-01-02', '2020-03-31',1000,0.2);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(5, '2020-04-01', '2020-04-01', '2020-10-01',2000,0.5);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(5, '2020-10-02', '2020-10-02', '9999-12-31',5500,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(6, '2020-01-02', '2020-01-02', '9999-12-31',2000,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(7, '2020-01-02', '2020-01-02', '9999-12-31',2200,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(8, '2020-03-02', '2020-03-02', '2020-08-31',1900,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(8, '2020-09-02', '2020-09-01', '9999-12-31',2100,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(9, '2020-01-02', '2020-01-02', '2021-11-30',1400,0.8);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(10, '2021-04-01', '2021-04-01', '9999-12-31',1600,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(11, '2022-01-02', '2020-01-02', '2022-08-31',1700,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(12, '2020-01-02', '2020-01-02', '2022-11-30',1200,0.5);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(13, '2023-01-02', '2023-01-02', '9999-12-31',2500,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(14, '2020-06-01', '2020-06-01', '9999-12-31',1800,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(15, '2020-06-01', '2021-06-01', '9999-12-31',1800,1.0);
INSERT INTO [Contracts]([EmployeeID], [DateSigned], [From], [To], [Salary], [WorkingTime]) VALUES(16, '2022-08-01', '2022-08-01', '9999-12-31',3000,1.0);

INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES('Daniel', 'Kucharski', 'xdaniel@onet.eu', '123456789', '2001-03-23','M', 'Częstochowa','MyStreet',5,25);








