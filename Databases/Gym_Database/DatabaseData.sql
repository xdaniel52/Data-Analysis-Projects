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
				 VALUES(2, 'Przemyk', 'Kysiak', 'przemek_krysiak@gym.com', '234567891', '1997-04-21','M', 'Częstochowa','Brett Way',4,14);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(2, 'Rafał', 'Bajer', 'rafal_bajer@gym.com', '345678912', '1990-09-30','M', 'Częstochowa','Albara Place ',37, null);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(2, 'Mateusz', 'Zaręba', 'matesz_zarebak@gym.com', '456789123', '1994-01-09','M', 'Częstochowa','Kurtz Lane',2,63);
INSERT INTO [Employees]([JobID],[FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
				 VALUES(2, 'Sara', 'Garncarz', 'sara_garncarz@gym.com', '567891234', '1989-05-15','F', 'Częstochowa','Nicole Terrace',46,82);

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

INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Ezra', 'Bridges', 'ezra_bridges@random.com', '660953955', '2002-08-04','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Osvaldo', 'Clarke', 'osvaldo_clarke@random.com', '755527030', '1977-02-19','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Adalberto', 'Bass', 'adalberto_bass@random.com', '501338681', '1988-05-23','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Forest', 'Rush', 'forest_rush@random.com', '840185321', '1996-11-23','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Thomas', 'Marshall', 'thomas_marshall@random.com', '378584482', '1992-06-01','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Warner', 'Frederick', 'warner_frederick@random.com', '160989844', '1989-04-13','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Herb', 'Preston', 'herb_preston@random.com', '373686522', '1979-03-16','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Florencio', 'Fleming', 'florencio_fleming@random.com', '984491789', '1999-04-16','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('George', 'Guzman', 'george_guzman@random.com', '931299264', '2003-05-06','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Myles', 'Cervantes', 'myles_cervantes@random.com', '384922528', '1982-05-13','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Tim', 'Wolf', 'tim_wolf@random.com', '340754239', '1997-04-07','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Carlos', 'Donovan', 'carlos_danovan@random.com', '754695878', '1997-04-07','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Modesto', 'Cross', 'modesto_cross@random.com', '143845640', '1977-03-22','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Pierre', 'Dunlap', 'pierre_dunlap@random.com', '936610434', '1971-12-08','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Wally', 'Lopez', 'wally_lopez@random.com', '741273520', '1973-01-18','M', 'Częstochowa','MyStreet',5,25);

INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Teddy', 'Neal', 'teddy_neal@random.com', '832113397', '1980-07-07','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Carlton', 'Stokes', 'carlton_stokes@random.com', '608178813', '1980-07-09','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Jackson', 'Branch', 'jackson_branch@random.com', '286900341', '1987-03-07','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Buddy', 'Pugh', 'buddy_pugh@random.com', '346383570', '1987-02-12','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Sterling', 'Cox', 'sterling_cox@random.com', '274460364', '2002-07-02','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Tommie', 'Cantu', 'tommie_cantu@random.com', '743279549', '1982-11-30','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Loyd', 'House', 'loyd_house@random.com', '262104836', '1997-02-04','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Gerard', 'Rasmussen', 'gerald_rasmussen@random.com', '507710104', '1970-11-27','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Garret', 'Prince', 'garret_prince@random.com', '635471279', '1972-05-18','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Cyrus', 'Berger', 'cyrus_berger@random.com', '105566672', '1981-04-10','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Dan', 'Bond', 'dan_bond@random.com', '520697711', '1993-02-20','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Joshua', 'Osborn', 'jashua_osborn@random.com', '559875579', '2003-09-16','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Tyler', 'One', 'tyler_one@random.com', '365429950', '1997-05-26','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Claud', 'Blackwell', 'claud_blackwell@random.com', '241608933', '1990-04-26','M', 'Częstochowa','MyStreet',5,25);

INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Alfonzo', 'Mejia', 'alfonzo_mejia@random.com', '889937894', '1999-12-19','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Elwood', 'Santiago', 'elwood_santiago@random.com', '335335887', '1982-08-13','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Jake', 'Salinas', 'jake_salinas@random.com', '977582284', '1983-09-26','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Buck', 'Nelson', 'buck_nelson@random.com', '436468639', '1977-02-19','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Giuseppe', 'Caldwell', 'giusepper_caldwell@random.com', '597557239', '2002-08-04','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Gale', 'Ortiz', 'gale_ortiz@random.com', '558580094', '2005-04-01','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Ramiro', 'Huff', 'ramiro_huff@random.com', '928583503', '2005-04-01','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Jere', 'Huber', 'jare_huber@random.com', '644545485', '2001-03-13','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Mathew', 'Oneill', 'mathew_oneill@random.com', '189117337', '2002-08-25','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Garret', 'Parsons', 'garrert_parsons@random.com', '793289897', '1996-11-17','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Vincent', 'Krause', 'vincent_krause@random.com', '678453028', '1999-08-20','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Barney', 'Cameron', 'barney_cameron@random.com', '276482038', '1985-06-14','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Marc', 'Peterson', 'marc_peterson@random.com', '719612790', '1999-10-09','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Frederic', 'Arroyo', 'frederic_arroyo@random.com', '795391337', '1997-03-11','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Rufus', 'Morse', 'rufus_morse@random.com', '483611029', '2004-12-23','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Cyrus', 'Wilcox', 'cyrus_wilcox@random.com', '941333924', '1989-06-12','M', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Branden', 'Ochoa', 'branden_ochoa@random.com', '379129372', '1983-02-12','M', 'Częstochowa','MyStreet',5,25);




INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Rebecca', 'Washington', 'rebecca_washington@random.com', '790351856', '1980-03-25','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Susanna', 'Guerra', 'Susanna_guerra@random.com', '574743464', '1992-10-13','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Patty ', 'Sharp', 'patty_sharp@random.com', '208623272', '1990-05-05','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Helena', 'Whitaker', 'helena_whitaker@random.com', '739534860', '1992-11-10','F', 'Częstochowa','MySreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Juliana', 'Hawkins', 'juliana_hawkins@random.com', '141912652', '1972-05-11','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Rene', 'James', 'rene_james@random.com', '322264429', '1989-06-27','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Tonya', 'Strickland', 'tonya_strickland@random.com', '809176101', '1995-12-02','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Jamie', 'Barker', 'jamie_barker@random.com', '943404561', '1974-10-23','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Alyce', 'Sweeney', 'alyce_sweeney@random.com', '741926860', '2004-09-06','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Kara', 'Booth', 'kara_booth@random.com', '443946061', '1972-03-07','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Elvia', 'Pennington', 'elivia_pannington@random.com', '338339938', '1984-03-21','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Kara', 'Booth', 'kara_booth@random.com', '443946061', '1976-03-21','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Marianne', 'Combs', 'marianne_combs@random.com', '668942041', '1973-09-04','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Isabel', 'Oslon', 'isabel_oslon@random.com', '805292229', '1977-06-02','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Julia', 'Campbell', 'julia_campbell@random.com', '692633901', '1979-08-07','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Elva', 'Griffith', 'elva_griffith@random.com', '225790348', '1997-09-22','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Joanne', 'Mckay', 'joanne_mckay@random.com', '483404466', '1974-11-03','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Marla', 'Vega', 'marla_vega@random.com', '841691621', '1994-12-24','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Frieda', 'Holt', 'frieda_holt@random.com', '971101120', '1977-03-30','F', 'Częstochowa','MyStreet',5,25);
INSERT INTO [Customers]([FirstName],[LastName],[Email],[PhoneNumber],[DateOfBirth],[Sex],[City],[StreetAddress],[HouseNumber],[ApartmentNumber]) 
VALUES('Aisha', 'Nielsen', 'aisha_nielsen@random.com', '853720501', '1973-05-23','F', 'Częstochowa','MyStreet',5,25);
























