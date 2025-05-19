CREATE DATABASE FTP

--------------Create Table, Primary, Foreign Keys and Auto Increment------------------
-- 1. Create Table Passenger
CREATE TABLE Passenger
(
	-- 1. Primary key passenger_id
	passenger_id INT PRIMARY KEY IDENTITY(1,1),
	passenger_name VARCHAR(100),
	passenger_email VARCHAR(150),
	passenger_gender VARCHAR(1)
)

-- 2. Create Table Aircraft
CREATE TABLE Aircraft
(
	-- 2. Primary Key aircraft_id
	aircraft_id INT PRIMARY KEY IDENTITY(1,1),
	aircraft_name VARCHAR(50),
)

-- 3. Create Table Country
CREATE TABLE Country
(
	-- 3. Primary Key country_id
	country_id INT PRIMARY KEY IDENTITY(1,1),
	country_name VARCHAR(100)
)

-- 4. Create Table City
CREATE TABLE City
(
	-- 4. Primary Key city_id
	city_id INT PRIMARY KEY IDENTITY(1,1),
	city_name VARCHAR(100),
	-- 1. Foreign Key country
	country INT FOREIGN KEY REFERENCES Country(country_id)
)

-- 5. Create Table Airport
CREATE TABLE Airport
(
	-- 5. Primary Key airport_id
	airport_id INT PRIMARY KEY IDENTITY(1,1),
	airport_name VARCHAR(300),
	-- 2. Foreign Key city
	city INT FOREIGN KEY REFERENCES City(city_id)
)

-- 6. Create Table Flight
CREATE TABLE Flight
(
	-- 1. Auto Increment flight_id
	flight_id INT PRIMARY KEY IDENTITY(1,1),
	-- 3. Foreign Key aircraft
	aircraft INT FOREIGN KEY REFERENCES Aircraft(aircraft_id),
	flight_departure_datetime DATETIME,
	-- 4. Foreign Key flight_departure_airport
	flight_departure_airport INT FOREIGN KEY REFERENCES Airport(airport_id),
	flight_arrival_datetime DATETIME,
	-- 5. Foreign Key flight_arrival_airport
	flight_arrival_airport INT FOREIGN KEY REFERENCES Airport(airport_id)
)

-- 7. Create Table Class
CREATE TABLE Class
(
	-- 2. Auto Increment class_id
	class_id INT PRIMARY KEY IDENTITY(1,1),
	class_name VARCHAR(20)
)

-- 8. Create Table Seat
CREATE TABLE Seat
(
	-- 3. Auto Increment seat_id
	seat_id INT PRIMARY KEY IDENTITY(1,1),
	seat_name VARCHAR(10),
	class INT FOREIGN KEY REFERENCES Class(class_id),
	aircraft INT FOREIGN KEY REFERENCES Aircraft(aircraft_id)
)

-- 9. Create Table Baggage
CREATE TABLE Baggage
(
	-- 4. Auto Increment baggage_id
	baggage_id INT PRIMARY KEY IDENTITY(1,1),
	baggage_detail VARCHAR(500),
	passenger INT FOREIGN KEY REFERENCES Passenger(passenger_id),
	flight INT FOREIGN KEY REFERENCES Flight(flight_id)
)

-- 10. Create Table Reservation
CREATE TABLE Reservation
(
	-- 5. Auto Increment reservation_id
	reservation_id INT PRIMARY KEY IDENTITY(1,1),
	passenger INT FOREIGN KEY REFERENCES Passenger(passenger_id),
	flight INT FOREIGN KEY REFERENCES Flight(flight_id),
	class INT FOREIGN KEY REFERENCES Class(class_id),
	seat INT FOREIGN KEY REFERENCES Seat(seat_id),
	reservation_datetime DATETIME,
)

CREATE TABLE Payment
(
	-- 6. Auto Increment payment_id
	payment_id INT PRIMARY KEY IDENTITY(1,1),
	reservation INT FOREIGN KEY REFERENCES Reservation(reservation_id),
	amount INT,
	payment_method varchar(25)
)

CREATE TABLE CrewRole
(
	-- 7. Auto Increment role_id
	role_id INT PRIMARY KEY IDENTITY(1,1),
	role_name VARCHAR(50)
)

CREATE TABLE Crew
(
	-- 8. Auto Increment crew_id
	crew_id INT PRIMARY KEY IDENTITY(1,1),
	crew_name VARCHAR(100),
	crew_role INT FOREIGN KEY REFERENCES CrewRole(role_id),
	crew_salary INT,
	crew_email VARCHAR(150),
	crew_address VARCHAR(250),
	crew_gender VARCHAR(1)
)

CREATE TABLE Response
(
	-- 9. Auto Increment response_id
	response_id INT PRIMARY KEY IDENTITY(1,1),
	response_detail varchar(500)
)

CREATE TABLE Feedback
(
	-- 10. Auto Increment feedback_id
	feedback_id INT PRIMARY KEY IDENTITY(1,1),
	complete_feedback VARCHAR(1000),
	passenger INT FOREIGN KEY REFERENCES Passenger(passenger_id),
	flight INT FOREIGN KEY REFERENCES Flight(flight_id),
	rating INT CHECK (rating<=10),
	response INT FOREIGN KEY REFERENCES Response(response_id)
)

CREATE TABLE CrewOnFlight
(
	table_id INT PRIMARY KEY IDENTITY(1,1),
	crew INT FOREIGN KEY REFERENCES Crew(crew_id),
	flight INT FOREIGN KEY REFERENCES flight(flight_id)
)

CREATE TABLE TriggersAudit
(
	audit_id INT PRIMARY KEY IDENTITY(1,1),
	audit_message varchar(100),
	trigger_type varchar(20),
	trigger_on_table varchar(20)
)


------ALTER TABLE (ADD Column, MODIFY Datatype, RENAME Column, DROUP Column)---------
-- 1. ADD COLUMN manufacturing_year to Aircraft Table
ALTER TABLE Aircraft ADD manufacturing_year INT DEFAULT NULL
-- 2. ADD COLUMN area to Aiport Table
ALTER TABLE Airport ADD area INT DEFAULT NULL
-- 3. ADD COLUMN checked_by in Baggage Table
ALTER TABLE Baggage ADD checked_status varchar(1)
-- 4. ADD COLUMN city_code
ALTER TABLE City ADD city_code varchar(3) DEFAULT NULL
-- 5. ADD COLUMN class_code to Class Table
ALTER TABLE Class ADD class_code varchar(1) DEFAULT NULL
-- 6. ADD COLUMN country_code to Country table
ALTER TABLE Country ADD country_code varchar(3) DEFAULT NULL
-- 7. ADD COLUMN phone to Crew Table
ALTER TABLE Crew ADD phone varchar(20) DEFAULT NULL
-- 8. ADD COLUMN time_taken to Flight Table
ALTER TABLE Flight ADD time_taken INT DEFAULT NULL
-- 9. ADD COLUMN response_code to Response Table
ALTER TABLE Response ADD response_code varchar(1) DEFAULT NULL
-- 10. ADD COLUMN comfort_level 
ALTER TABLE Seat ADD comfort_level varchar(10) DEFAULT NULL
-- 11. MODIFY data type of manufacturing_year
ALTER TABLE Aircraft ALTER COLUMN manufacturing_year INT
-- 12. MODIFY data type of area
ALTER TABLE Airport ALTER COLUMN area varchar(10)
-- 13. MODIFY data type of checked_by
ALTER TABLE Baggage ALTER COLUMN checked_by BIGINT
-- 14. MODIFY data type of city_code
ALTER TABLE City ALTER COLUMN city_code INT
-- 15. MODIFY data type of class_code
ALTER TABLE Class ALTER COLUMN class_code INT
-- 16. MODIFY data type of country_code
ALTER TABLE Country ADD country_code INT
-- 17. MODIFY data type of phone
ALTER TABLE Crew ALTER COLUMN phone BIGINT
-- 18. MODIFY data type of time_taken
ALTER TABLE Flight ALTER COLUMN time_taken TIME
-- 19. MODIFY data type of response_code
ALTER TABLE Response ALTER COLUMN response_code INT
-- 20. MODIFY data type of comfort_level 
ALTER TABLE Seat ALTER COLUMN comfort_level INT
-- 21. RENAMING Column aircraft_name
EXEC sp_rename 'dbo.Aircraft.aircraft_name','aircraft','COLUMN'
-- 22. RENAMING Column airport_name
EXEC sp_rename 'dbo.Airport.airport_name','airport','COLUMN'
-- 23. RENAMING Column baggage_detail
EXEC sp_rename 'dbo.Baggage.baggage_detail','comments','COLUMN'
-- 24. RENAMING Column country
EXEC sp_rename 'dbo.City.country','country_code','COLUMN'
-- 25. RENAMING Column response_id
EXEC sp_rename 'dbo.Response.response_id','response_code','COLUMN'
-- 26. RENAMING Column aircraft_id
EXEC sp_rename 'dbo.Aircraft.aircraft_id','aircraft_code','COLUMN'
-- 27. RENAMING Column flight_id
EXEC sp_rename 'dbo.Flight.flight_id','f_id','COLUMN'
-- 28. RENAMING Column reservation_id
EXEC sp_rename 'dbo.Reservation.reservation_id','r_id','COLUMN'
-- 29. RENAMING Column city_id
EXEC sp_rename 'dbo.City.city_id','c_id','COLUMN'
-- 30. RENAMING Column seat_id
EXEC sp_rename 'dbo.Seat.seat_id','s_id','COLUMN'
-- 31. RENAMING Column baggage_id
EXEC sp_rename 'dbo.Baggage.baggage_id','b_id','COLUMN'
-- 32. RENAMING Column flight
EXEC sp_rename 'dbo.Baggage.flight','f_id','COLUMN'
-- 33. RENAMING Column flight_departure_time
EXEC sp_rename 'dbo.Flight.flight_departure_time','f_dep_time','COLUMN'
-- 34. RENAMING Column flight_departure_date
EXEC sp_rename 'dbo.Flight.flight_departure_date','f_dep_date','COLUMN'
-- 35. RENAMING Column flight_arrival_time
EXEC sp_rename 'dbo.Flight.flight_arrival_time','f_arr_time','COLUMN'
-- 36. RENAMING Column flight_arrival_date
EXEC sp_rename 'dbo.Flight.flight_arrival_date','f_arr_date','COLUMN'
-- 37. RENAMING Column city_name
EXEC sp_rename 'dbo.City.city_name','c_name','COLUMN'
-- 38. RENAMING Column class
EXEC sp_rename 'dbo.Seat.class','class_id','COLUMN'
-- 39. RENAMING Column flight
EXEC sp_rename 'dbo.Feedback.flight','flight_id','COLUMN'
-- 40. RENAMING Column response
EXEC sp_rename 'dbo.Feedback.response','response_id','COLUMN'
-- 41. DROPING COLUMN manufacturing_year
ALTER TABLE Aircraft DROP COLUMN manufacturing_year
-- 42. DROPPING COLUMN area
ALTER TABLE Airport DROP COLUMN area
-- 43. DROPPING COLUMN checked_status
ALTER TABLE Baggage DROP COLUMN checked_status
-- 44. DROPPING COLUMN city_code
ALTER TABLE City DROP COLUMN city_code
-- 45. DROPPING COLUMN class_code
ALTER TABLE Class DROP COLUMN class_code
-- 46. DROPPING COLUMN country_code
ALTER TABLE Country DROP COLUMN country_code
-- 47. DROPPING COLUMN phone
ALTER TABLE Crew DROP COLUMN phone
-- 48. DROPPING COLUMN time_taken
ALTER TABLE Flight DROP COLUMN time_taken
-- 49. DROPPING COLUMN response_code
ALTER TABLE Response DROP COLUMN response_code
-- 50. DROPPING COLUMN comfort_level 
ALTER TABLE Seat DROP COLUMN comfort_level


--------------------------------INSERT INTO Tables-----------------------------------
-- 1. Insert data into Class table
INSERT INTO Class
VALUES('Economy'),
	('Business'),
	('First')

-- 2. Insert data into Country table
INSERT INTO Country
VALUES('United States'),
	('United Kingdom'),
	('Canada'),
	('Australia'),
	('Germany'),
	('France'),
	('Japan'),
	('Pakistan'),
	('India'),
	('China'),
	('Nepal')

-- 3. Insert data into Response table
INSERT INTO Response
VALUES('Yet to be cosidered'),
	('Under consideration'),
	('Considered')

-- 4. Insert data into City table
INSERT INTO City
VALUES('New York', 1),
	('London', 2),
	('Toronto', 3),
	('Sydney', 4),
	('Berlin', 5),
	('Paris', 6),
	('Tokyo', 7),
	('Islamabad', 8),
	('Mumbai', 9),
	('Beijing', 10),
	('Los Angeles', 1),
	('Manchester', 2),
	('Vancouver', 3),
	('Melbourne', 4),
	('Hamburg', 5),
	('Nice', 6),
	('Osaka', 7),
	('Lahore', 8),
	('Delhi', 9),
	('Shanghai', 10),
	('Chicago', 1),
	('Birmingham', 2),
	('Calgary', 3),
	('Brisbane', 4),
	('Munich', 5),
	('Lyon', 6),
	('Kyoto', 7),
	('Karachi', 8),
	('Kolkata', 9),
	('Guangzhou', 10),
	('Rawalpindi', 8)

-- 5. Insert data into Airport table
INSERT INTO Airport
VALUES('NY Airport', 1),
	('London Airport', 2),
	('Toronto Airport', 3),
	('Sydney Airport', 4),
	('Berlin Airport', 5),
	('Paris Airport', 6),
	('Tokyo Airport', 7),
	('Benazir Airport', 8),
	('Mumbai Airport', 9),
	('Beijing Airport', 10),
	('LA Airport', 11),
	('Manchester Airport', 12),
	('Vancouver Airport', 13),
	('Melbourne Airport', 14),
	('Hamburg Airport', 15),
	('Nice Airport', 16),
	('Osaka Airport', 17),
	('Iqbal Airport', 18),
	('Delhi Airport', 19),
	('Shanghai Airport', 20),
	('Chicago Airport', 21),
	('Birmingham Airport', 22),
	('Calgary Airport', 23),
	('Brisbane Airport', 24),
	('Munich Airport', 25),
	('Lyon Airport', 26),
	('Kyoto Airport', 27),
	('Jinnah Airport', 28),
	('Kolkata Airport', 29),
	('Guangzhou Airport', 30)

-- 6. Insert data into CrewRole table
INSERT INTO CrewRole
VALUES('Pilot'),
	('Air Host'),
	('Air Hostess'),
	('Flight Engineer'),
	('In Flight Chef'),
	('Medical Personnel'),
	('Load Master'),
	('Ground Crew')

INSERT INTO Crew
VALUES('Ali Khan', 1, 150000, 'ali.khan@gmail.com', '123 Main Street, Lahore', 'M'),
	('Sara Ahmed', 4, 55000, 'sara.ahmed@gmail.com', '456 Park Avenue, Karachi', 'F'),
	('Ahmed Malik', 6, 260000, 'ahmed.malik@gmail.com', '789 First Road, Islamabad', 'M'),
	('Ayesha Khan', 1, 52000, 'ayesha.khan@gmail.com', '321 Second Avenue, Lahore', 'F'),
	('Hassan Ali', 7, 148000, 'hassan.ali@gmail.com', '654 Third Street, Karachi', 'M'),
	('Fatima Aziz', 8, 127000, 'fatima.aziz@gmail.com', '987 Fourth Avenue, Kala Shah Kaku', 'O'),
	('Usman Ahmed', 1, 354000, 'usman.ahmed@gmail.com', '123 Fifth Road, Islamabad', 'M'),
	('Sana Khan', 7, 159000, 'sana.khan@gmail.com', '456 Sixth Street, Karachi', 'F'),
	('Bilal Mahmood', 1, 171000, 'bilal.mahmood@gmail.com', '789 Seventh Avenue, Kala Shah Kaku', 'M'),
	('Zara Khan', 8, 153000, 'zara.khan@gmail.com', '321 Eighth Street, Islamabad', 'O'),
	('Naveed Ali', 4, 56000, 'naveed.ali@gmail.com', '654 Ninth Road, Kala Shah Kaku', 'M'),
	('Hina Malik', 3, 58000, 'hina.malik@gmail.com', '987 Tenth Street, Karachi', 'F'),
	('Imran Khan', 1, 49000, 'imran.khan@gmail.com', '123 Eleventh Avenue, Lahore', 'M'),
	('Rabia Ahmed', 3, 53000, 'rabia.ahmed@gmail.com', '456 Twelfth Road, Peshawar', 'F'),
	('Kamran Ali', 8, 85000, 'kamran.ali@gmail.com', '789 Thirteenth Street, Karachi', 'M'),
	('Sadia Aziz', 1, 59000, 'sadia.aziz@gmail.com', '987 Fourteenth Avenue, Lahore', 'O'),
	('Adnan Ahmed', 4, 152000, 'adnan.ahmed@yahoo.com', '321 Fifteenth Road, Peshawar', 'M'),
	('Sara Khan', 6, 54000, 'sara.khan@yahoo.com', '654 Sixteenth Street, Quetta', 'F'),
	('Faisal Mahmood', 7, 50000, 'faisal.mahmood@yahoo.com', '789 Seventeenth Avenue, Lahore', 'M'),
	('Zoya Khan', 5, 56000, 'zoya.khan@yahoo.com', '123 Eighteenth Road, Peshawar', 'O'),
	('Aliya Ahmed', 3, 57000, 'aliya.ahmed@yahoo.com', '456 Nineteenth Street, Quetta', 'F'),
	('Tariq Malik', 1, 54000, 'tariq.malik@yahoo.com', '987 Twentieth Avenue, Lahore', 'M'),
	('Rahat Khan', 6, 52000, 'rahat.khan@yahoo.com', '321 Twenty-First Road, Peshawar', 'M'),
	('Sadia Mahmood', 5, 359000, 'sadia.mahmood@yahoo.com', '654 Twenty-Second Street, Quetta', 'F'),
	('Imran Ahmed', 7, 255000, 'imran.ahmed@yahoo.com', '789 Twenty-Third Avenue, Lahore', 'M'),
	('Sana Malik', 3, 53000, 'sana.malik@yahoo.com', '123 Twenty-Fourth Road, Islamabad', 'F'),
	('Zainab Khan', 8, 58000, 'zainab.khan@yahoo.com', '456 Twenty-Fifth Street, Quetta', 'F'),
	('Khalid Mahmood', 7, 357000, 'khalid.mahmood@yahoo.com', '987 Twenty-Sixth Avenue, Lahore', 'M'),
	('Nimra Ali', 1, 85000, 'nimra.ali@yahoo.com', '321 Twenty-Seventh Road, Islamabad', 'O'),
	('Hassan Khan', 8, 54000, 'hassan.khan@yahoo.com', '654 Twenty-Eighth Street, Quetta', 'M'),
	('Anaya Ahmed', 5, 96000, 'anaya.ahmed@yahoo.com', '789 Twenty-Ninth Avenue, Sui', 'F'),
	('Talha Malik', 6, 53000, 'talha.malik@yahoo.com', '123 Thirtieth Road, Islamabad', 'M'),
	('Sana Mahmood', 5, 99000, 'sana.mahmood@yahoo.com', '456 Thirty-First Street, Karachi', 'O'),
	('Waqar Ahmed', 1, 52000, 'waqar.ahmed@yahoo.com', '987 Thirty-Second Avenue, Sui', 'M'),
	('Sara Khan', 6, 95000, 'sara.khan@yahoo.com', '321 Thirty-Third Road, Islamabad', 'F'),
	('Kashif Malik', 1, 57000, 'kashif.malik@yahoo.com', '654 Thirty-Fourth Street, Karachi', 'M'),
	('Nazia Mahmood', 8, 64000, 'nazia.mahmood@yahoo.com', '789 Thirty-Fifth Avenue, Sui', 'O'),
	('Zahid Ali', 6, 96000, 'zahid.ali@yahoo.com', '123 Thirty-Sixth Road, Islamabad', 'M'),
	('Fatima Khan', 7, 52000, 'fatima.khan@yahoo.com', '456 Thirty-Seventh Street, Karachi', 'F'),
	('Adil Mahmood', 6, 97000, 'adil.mahmood@yahoo.com', '987 Thirty-Eighth Avenue, Sui', 'M')

-- 7. Insert data into Aircraft Table
INSERT INTO Aircraft
VALUES('Boeing 747'),
	('Airbus A320'),
	('Embraer E190'),
	('Bombardier CRJ900'),
	('Boeing 787'),
	('Airbus A380'),
	('Cessna 172');

-- 8. Insert data into Flight Table
INSERT INTO Flight
VALUES(2, '2022-4-5 10:00:00', 18, '2022-4-5 11:30:00', 19),
	(4, '2022-5-5 10:00:00', 13, '2022-5-5 14:00:00', 17),
	(5, '2022-5-10 9:00:00', 18, '2022-5-10 18:20:00', 1),
	(1, '2022-6-19 11:00:00', 5, '2022-6-19 14:30:00', 20),
	(3, '2022-10-10 13:00:00', 20, '2022-10-10 18:00:00', 30),
	(2, '2022-12-30 10:30:00', 1, '2022-12-30 17:30:00', 25),
	(7, '2023-1-5 12:00:00', 14, '2022-1-5 19:00:00', 24),
	(2, '2023-2-17 9:00:00', 18, '2022-2-17 20:30:00', 25),
	(1, '2023-2-20 14:00:00', 2, '2022-2-20 17:00:00', 7),
	(5, '2023-3-15 11:30:00', 10, '2022-3-15 20:40:00', 14),
	(3, '2023-4-5 16:00:00', 11, '2022-4-5 23:10:00', 13)

INSERT INTO Passenger
VALUES('Muhammad Ahmed', 'muhammad.ahmed@google.com', 'M'),
	('Ali Hassan', 'ali.hassan@google.com', 'M'),
	('Aisha Khan', 'aisha.khan@google.com', 'F'),
	('Sara Malik', 'sara.malik@google.com', 'F'),
	('Usman Khan', 'usman.khan@google.com', 'M'),
	('Fatima Ahmed', 'fatima.ahmed@google.com', 'F'),
	('Ahmed Raza', 'ahmed.raza@google.com', 'M'),
	('Sana Nasir', 'sana.nasir@google.com', 'F'),
	('Bilal Mahmood', 'bilal.mahmood@google.com', 'M'),
	('Zainab Ali', 'zainab.ali@google.com', 'F'),
	('Hassan Akhtar', 'hassan.akhtar@google.com', 'M'),
	('Sadia Khan', 'sadia.khan@google.com', 'O'),
	('Imran Ali', 'imran.ali@google.com', 'M'),
	('Ayesha Riaz', 'ayesha.riaz@google.com', 'F'),
	('Kamran Iqbal', 'kamran.iqbal@google.com', 'M'),
	('Zara Nasir', 'zara.nasir@google.com', 'F'),
	('Tariq Ahmed', 'tariq.ahmed@google.com', 'M'),
	('Saba Malik', 'saba.malik@google.com', 'O'),
	('Nadeem Khan', 'nadeem.khan@yahoo.com', 'M'),
	('Hina Ahmed', 'hina.ahmed@yahoo.com', 'F'),
	('Fahad Ali', 'fahad.ali@yahoo.com', 'M'),
	('Rabia Shah', 'rabia.shah@yahoo.com', 'F'),
	('Kashif Haider', 'kashif.haider@yahoo.com', 'M'),
	('Sadia Iqbal', 'sadia.iqbal@yahoo.com', 'F'),
	('Salman Ahmed', 'salman.ahmed@yahoo.com', 'M'),
	('Sara Nadeem', 'sara.nadeem@yahoo.com', 'F'),
	('Hassan Siddique', 'hassan.siddique@yahoo.com', 'M'),
	('Zainab Akram', 'zainab.akram@yahoo.com', 'F'),
	('Ahmed Farooq', 'ahmed.farooq@hotmail.com', 'M'),
	('Sana Tariq', 'sana.tariq@hotmail.com', 'F'),
	('Nida Ali', 'nida.ali@hotmail.com', 'O'),
	('Adnan Khan', 'adnan.khan@hotmail.com', 'M'),
	('Saima Malik', 'saima.malik@hotmail.com', 'F'),
	('Farhan Ahmed', 'farhan.ahmed@hotmail.com', 'M'),
	('Zara Siddiqui', 'zara.siddiqui@hotmail.com', 'O'),
	('Arif Khan', 'arif.khan@hotmail.com', 'M'),
	('Rabia Ahmad', 'rabia.ahmad@hotmail.com', 'F'),
	('Asad Malik', 'asad.malik@hotmail.com', 'M'),
	('Maham Iqbal', 'maham.iqbal@hotmail.com', 'F'),
	('Faisal Ahmed', 'faisal.ahmed@hotmail.com', 'M'),
	('Mehreen Khan', 'mehreen.khan@hotmail.com', 'F'),
	('Zubair Ali', 'zubair.ali@hotmail.com', 'M'),
	('Ayesha Rashid', 'ayesha.rashid@hotmail.com', 'O'),
	('Hammad Khan', 'hammad.khan@hotmail.com', 'M'),
	('Sara Azam', 'sara.azam@hotmail.com', 'F'),
	('Usman Siddiqui', 'usman.siddiqui@outlokk.com', 'M'),
	('Maria Riaz', 'maria.riaz@outlokk.com', 'O'),
	('Ali Hamid', 'ali.hamid@outlokk.com', 'M'),
	('Hina Anwar', 'hina.anwar@outlokk.com', 'F'),
	('Kamran Raza', 'kamran.raza@outlokk.com', 'M'),
	('Amna Ahmed', 'amna.ahmed@outlokk.com', 'F'),
	('Shahid Khan', 'shahid.khan@outlokk.com', 'M'),
	('Anam Siddiqui', 'anam.siddiqui@outlokk.com', 'O'),
	('Imran Raza', 'imran.raza@outlokk.com', 'M'),
	('Sadia Iftikhar', 'sadia.iftikhar@outlokk.com', 'F'),
	('Nadeem Siddiqui', 'nadeem.siddiqui@outlokk.com', 'M'),
	('Sara Farooq', 'sara.farooq@outlokk.com', 'O'),
	('Ahmed Nadeem', 'ahmed.nadeem@outlokk.com', 'M'),
	('Aisha Tariq', 'aisha.tariq@outlokk.com', 'F'),
	('Kashif Hussain', 'kashif.hussain@outlokk.com', 'M'),
	('Amir Malik', 'amir.malik@outlokk.com', 'M'),
	('Sadaf Ahmed', 'sadaf.ahmed@outlokk.com', 'F'),
	('Noman Khan', 'noman.khan@outlokk.com', 'M'),
	('Sara Jameel', 'sara.jameel@google.com', 'F'),
	('Usama Ahmed', 'usama.ahmed@google.com', 'M'),
	('Ayesha Zafar', 'ayesha.zafar@google.com', 'F'),
	('Saad Raza', 'saad.raza@google.com', 'M'),
	('Mahnoor Ali', 'mahnoor.ali@google.com', 'F'),
	('Asim Iqbal', 'asim.iqbal@google.com', 'M'),
	('Hira Ahmed', 'hira.ahmed@google.com', 'O'),
	('Omar Khan', 'omar.khan@google.com', 'M'),
	('Sara Yousaf', 'sara.yousaf@google.com', 'F'),
	('Rizwan Ahmed', 'rizwan.ahmed@google.com', 'M'),
	('Saima Arif', 'saima.arif@google.com', 'F'),
	('Kashif Riaz', 'kashif.riaz@google.com', 'M'),
	('Aisha Siddiqui', 'aisha.siddiqui@google.com', 'F'),
	('Farhan Ali', 'farhan.ali@google.com', 'M'),
	('Rabia Hassan', 'rabia.hassan@google.com', 'F'),
	('Asad Ahmed', 'asad.ahmed@google.com', 'M'),
	('Maham Malik', 'maham.malik@google.com', 'F'),
	('Umar Raza', 'umar.raza@google.com', 'M'),
	('Saba Khan', 'saba.khan@google.com', 'F'),
	('Kamran Arif', 'kamran.arif@google.com', 'M'),
	('Ayesha Zahid', 'ayesha.zahid@google.com', 'F'),
	('Zohaib Ahmed', 'zohaib.ahmed@google.com', 'M'),
	('Fiza Nasir', 'fiza.nasir@google.com', 'F'),
	('Bilal Riaz', 'bilal.riaz@google.com', 'M'),
	('Mehak Ali', 'mehak.ali@google.com', 'F'),
	('Ahmed Aslam', 'ahmed.aslam@hotmail.com', 'M'),
	('Sana Zahoor', 'sana.zahoor@hotmail.com', 'O'),
	('Abdullah Malik', 'abdullah.malik@hotmail.com', 'M'),
	('Sadia Qureshi', 'sadia.qureshi@hotmail.com', 'F'),
	('Kamran Khan', 'kamran.khan@hotmail.com', 'M'),
	('Ayesha Haider', 'ayesha.haider@hotmail.com', 'F'),
	('Nasir Ahmed', 'nasir.ahmed@hotmail.com', 'M'),
	('Zainab Rehman', 'zainab.rehman@yahoo.com', 'O'),
	('Ahmed Qureshi', 'ahmed.qureshi@yahoo.com', 'M'),
	('Sara Iqbal', 'sara.iqbal@yahoo.com', 'F'),
	('Asim Malik', 'asim.malik@yahoo.com', 'M'),
	('Hina Raza', 'hina.raza@yahoo.com', 'F'),
	('Saad Ahmed', 'saad.ahmed@yahoo.com', 'M')

INSERT INTO Seat
VALUES('1AA', 1, 1),
	('1BA', 1, 1),
	('1CA', 1, 1),
	('2AA', 1, 1),
	('2BA', 1, 1),
	('2CA', 1, 1),
	('3AA', 1, 1),
	('3BA', 1, 1),
	('4AA', 2, 1),
	('4BA', 2, 1),
	('5AA', 2, 1),
	('5BA', 2, 1),
	('5BA', 2, 1),
	('5BA', 3, 1),
	('5BA', 3, 1),
	('1AB', 1, 2),
	('1BB', 1, 2),
	('2AB', 1, 2),
	('2BB', 1, 2),
	('3AB', 1, 2),
	('3BB', 1, 2),
	('4AB', 1, 2),
	('4BB', 2, 2),
	('5AB', 2, 2),
	('5BB', 2, 2),
	('5BB', 2, 2),
	('5BB', 2, 2),
	('5BB', 3, 2),
	('5BB', 3, 2),
	('5BB', 3, 2),
	('1AC', 1, 3),
	('1BC', 1, 3),
	('2AC', 1, 3),
	('2BC', 1, 3),
	('2BC', 1, 3),
	('2BC', 1, 3),
	('2BC', 1, 3),
	('2BC', 2, 3),
	('2BC', 2, 3),
	('2BC', 2, 3),
	('2BC', 2, 3),
	('2BC', 2, 3),
	('2BC', 2, 3),
	('1AD', 1, 4),
	('1BD', 1, 4),
	('2AD', 1, 4),
	('2BD', 1, 4),
	('2BD', 1, 4),
	('2BD', 1, 4),
	('2BD', 1, 4),
	('2BD', 2, 4),
	('2BD', 2, 4),
	('2BD', 2, 4),
	('2BD', 2, 4),
	('2BD', 2, 4),
	('2BD', 3, 4),
	('1AE', 1, 5),
	('1BE', 1, 5),
	('2AE', 1, 5),
	('2BE', 1, 5),
	('2BE', 1, 5),
	('2BE', 1, 5),
	('2BE', 1, 5),
	('2BE', 1, 5),
	('2BE', 1, 5),
	('2BE', 1, 5),
	('2BE', 2, 5),
	('2BE', 2, 5),
	('2BE', 2, 5),
	('2BE', 2, 5),
	('2BE', 2, 5),
	('1AF', 1, 6),
	('1BF', 1, 6),
	('2AF', 1, 6),
	('2BF', 1, 6),
	('2BF', 1, 6),
	('2BF', 1, 6),
	('2BF', 1, 6),
	('2BF', 1, 6),
	('2BF', 2, 6),
	('2BF', 2, 6),
	('2BF', 2, 6),
	('2BF', 2, 6),
	('2BF', 2, 6),
	('2BF', 2, 6),
	('2BF', 2, 6),
	('1AG', 1, 7),
	('1BG', 1, 7),
	('2AG', 1, 7),
	('2BG', 1, 7),
	('2BG', 1, 7),
	('2BG', 1, 7),
	('2BG', 1, 7),
	('2BG', 2, 7),
	('2BG', 2, 7),
	('2BG', 2, 7),
	('2BG', 2, 7),
	('2BG', 2, 7),
	('2BG', 2, 7),
	('2BG', 3, 7),
	('2BG', 3, 7)

INSERT INTO Reservation
VALUES(1, 1, 1, 16, '2022-4-1 10:06:30'),
	(2, 1, 1, 17, '2022-3-1 11:05:20'),
	(3, 1, 1, 18, '2022-3-15 12:04:50'),
	(4, 1, 1, 19, '2022-3-15 13:30:50'),
	(5, 1, 1, 20, '2022-3-8 05:00:40'),
	(6, 1, 1, 21, '2022-3-15 18:00:50'),
	(7, 1, 1, 22, '2022-3-8 19:30:40'),
	(8, 1, 2, 23, '2022-3-26 13:00:50'),
	(9, 1, 2, 24, '2022-3-7 8:00:50'),
	(10, 1, 2, 25, '2022-3-26 8:00:50'),
	(11, 1, 2, 26, '2022-3-7 13:00:50'),
	(12, 1, 2, 27, '2022-3-7 8:00:50'),
	(13, 1, 3, 28, '2022-3-26 13:00:50'),
	(14, 1, 3, 29, '2022-3-15 8:00:50'),
	(15, 1, 3, 30, '2022-3-26 13:00:50'),
	(16, 2, 1, 44, '2022-5-1 10:00:00'),
	(17, 2, 1, 45, '2022-4-30 5:00:00'),
	(18, 2, 1, 46, '2022-4-27 19:00:00'),
	(19, 2, 1, 47, '2022-5-2 5:10:00'),
	(20, 2, 1, 48, '2022-4-3 19:00:00'),
	(21, 2, 1, 49, '2022-4-16 10:00:00'),
	(22, 2, 1, 50, '2022-4-18 5:10:00'),
	(23, 2, 2, 51, '2022-4-18 5:10:00'),
	(24, 2, 2, 52, '2022-4-18 5:10:00'),
	(25, 2, 2, 53, '2022-4-18 5:10:00'),
	(26, 2, 2, 54, '2022-4-18 5:10:00'),
	(27, 2, 2, 55, '2022-4-18 5:10:00'),
	(28, 2, 3, 56, '2022-4-18 5:10:00'),
	(29, 3, 1, 57, '2022-5-9 15:00:00'),
	(30, 3, 1, 58, '2022-5-8 7:20:00'),
	(31, 3, 1, 59, '2022-5-5 10:00:00'),
	(32, 3, 1, 60, '2022-5-6 7:20:00'),
	(33, 3, 1, 61, '2022-5-2 6:00:00'),
	(34, 3, 1, 61, '2022-4-3 15:20:00'),
	(35, 3, 1, 63, '2022-5-7 6:00:00'),
	(36, 3, 1, 64, '2022-4-30 10:00:00'),
	(37, 3, 1, 66, '2022-4-28 18:00:00'),
	(38, 3, 2, 67, '2022-4-21 7:20:00'),
	(39, 3, 2, 68, '2022-4-18 18:00:00'),
	(40, 3, 2, 69, '2022-4-17 7:20:00'),
	(41, 3, 2, 70, '2022-4-19 18:00:00'),
	(42, 4, 1, 1, '2022-6-18 18:10:00'),
	(43, 4, 1, 2, '2022-6-11 11:00:00'),
	(44, 4, 1, 3, '2022-6-6 9:00:00'),
	(45, 4, 1, 4, '2022-6-11 11:00:00'),
	(46, 4, 1, 5, '2022-6-17 18:00:00'),
	(47, 4, 1, 6, '2022-5-19 9:10:00'),
	(48, 4, 1, 7, '2022-5-29 11:00:00'),
	(49, 4, 2, 9, '2022-5-30 18:00:00'),
	(50, 4, 2, 10, '2022-4-28 11:00:00'),
	(51, 4, 2, 11, '2022-4-26 9:10:00'),
	(52, 4, 3, 14, '2022-4-26 9:10:00'),
	(53, 5, 1, 31, '2022-10-9 9:00:00'),
	(54, 5, 1, 32, '2022-10-8 4:00:00'),
	(55, 5, 1, 33, '2022-10-7 9:10:00'),
	(56, 5, 1, 34, '2022-10-4 3:00:00'),
	(57, 5, 1, 35, '2022-10-6 4:30:00'),
	(58, 5, 2, 38, '2022-10-2 3:10:00'),
	(59, 5, 2, 39, '2022-10-1 4:30:00'),
	(60, 5, 2, 40, '2022-10-5 3:10:00'),
	(60, 5, 2, 41, '2022-10-4 3:00:00'),
	(60, 6, 1, 17, '2022-12-29 3:00:00'),
	(61, 6, 1, 18, '2022-12-28 1:00:00'),
	(62, 6, 1, 19, '2022-12-24 3:00:00'),
	(63, 6, 1, 20, '2022-12-25 1:00:00'),
	(64, 6, 1, 21, '2022-12-27 3:00:00'),
	(65, 6, 1, 22, '2022-12-26 1:00:00'),
	(65, 6, 2, 23, '2022-12-29 3:00:00'),
	(66, 6, 2, 25, '2022-12-21 1:00:00')

-- 9. Insert data into Baggage Table
INSERT INTO Baggage
VALUES('A black breifcase', 1, 1),
	('DELL A10 laptop', 6, 1),
	('Golf clubs', 20, 2),
	('Cricket equipments bag', 47, 4),
	('Guitar', 58, 5)

-- 10. Insert data into Feedback Table
INSERT INTO Feedback
VALUES('Had one of the best experience with this airline.', 6, 1, 10, 3),
	('Food needs improvement.', 19, 2, 7, 1),
	('Lights quality was not good in economy class as compared to other airlines.', 54, 5, 6, 1)

INSERT INTO CrewOnFlight
VALUES(3, 1),
	(14, 1),
	(23, 1),
	(16, 1),
	(27, 1),
	(6, 2),
	(28, 2),
	(23, 2),
	(14, 2),
	(41, 2),
	(15, 3),
	(14, 3),
	(23, 3),
	(41, 3),
	(24, 4),
	(31, 4),
	(28, 4),
	(23, 4),
	(41, 4),
	(31, 5),
	(28, 5),
	(23, 5),
	(27, 5),
	(36, 6),
	(14, 6),
	(16, 6),
	(27, 6)

INSERT INTO Payment
VALUES(1, 40000, 'Cash'),
	(2, 40000, 'Cash'),
	(3, 40000, 'Card'),
	(4, 40000, 'Online'),
	(5, 40000, 'Online'),
	(6, 40000, 'Online'),
	(7, 40000, 'Online'),
	(8, 70000, 'Online'),
	(9, 70000, 'Online'),
	(10, 70000, 'Online'),
	(11, 70000, 'Card'),
	(12, 70000, 'Online'),
	(13, 120000, 'Online'),
	(14, 120000, 'Online'),
	(15, 120000, 'Online'),
	(16, 50000, 'Online'),
	(17, 50000, 'Online'),
	(18, 50000, 'Card'),
	(19, 50000, 'Online'),
	(20, 50000, 'Card'),
	(21, 50000, 'Online'),
	(22, 50000, 'Online'),
	(23, 90000, 'Online'),
	(24, 90000, 'Online'),
	(25, 90000, 'Card'),
	(26, 90000, 'Online'),
	(27, 90000, 'Card'),
	(28, 150000, 'Online'),
	(29, 100000, 'Online'),
	(30, 100000, 'Online'),
	(31, 100000, 'Card'),
	(32, 100000, 'Online'),
	(33, 100000, 'Online'),
	(34, 100000, 'Card'),
	(35, 100000, 'Card'),
	(36, 100000, 'Online'),
	(37, 100000, 'Online'),
	(38, 160000, 'Online'),
	(39, 160000, 'Online'),
	(40, 160000, 'Card'),
	(41, 160000, 'Card'),
	(42, 30000, 'Cash'),
	(43, 30000, 'Cash'),
	(44, 30000, 'Cash'),
	(45, 30000, 'Cash'),
	(46, 30000, 'Card'),
	(47, 30000, 'Card'),
	(48, 30000, 'Card'),
	(49, 70000, 'Card'),
	(50, 70000, 'Card'),
	(51, 70000, 'Online'),
	(52, 130000, 'Online'),
	(53, 110000, 'Online'),
	(54, 110000, 'Online'),
	(55, 110000, 'Online'),
	(56, 110000, 'Card'),
	(57, 110000, 'Online'),
	(58, 150000, 'Online'),
	(59, 150000, 'Online'),
	(60, 150000, 'Card'),
	(61, 150000, 'Online'),
	(62, 50000, 'Cash'),
	(63, 50000, 'Cash'),
	(64, 50000, 'Online'),
	(65, 50000, 'Online'),
	(66, 50000, 'Online'),
	(67, 50000, 'Online'),
	(68, 90000, 'Card'),
	(69, 90000, 'Card')


----------------------SELECT and DISTINCT Statements----------------------------------
-- 1. Selecting all info about Aircraft table
SELECT *
FROM Aircraft
-- 2. Selecting all info about City table
SELECT *
FROM City
-- 3. Selecting all info about Response table
SELECT *
FROM Response
-- 4. Selecting all info about Country table
SELECT *
FROM Country
-- 5. Selecting all info about Seat table
SELECT *
FROM Seat
-- 6. Selecting all info about Baggage table
SELECT *
FROM Baggage
-- 7. Selecting all info about Airport table
SELECT *
FROM Airport
-- 8. Selecting crew id and crew name from Crew table
SELECT crew_id, crew_name
FROM Crew
-- 9. Selecting reservation id and datetime from Reservation table
SELECT reservation_id, reservation_datetime
FROM Reservation
-- 10. Selecting all info about Flight table
SELECT *
FROM Flight
-- 11. Selecting distinct gender from Crew table
SELECT DISTINCT crew_gender
FROM Crew
-- 12. Selecting distinct gender from Passenger table
SELECT DISTINCT passenger_gender
FROM Passenger
-- 13. Selecting distinct arrival airport from Flight table
SELECT DISTINCT flight_arrival_airport
FROM Flight
-- 14. Selecting distinct departure airport from Flight table
SELECT DISTINCT flight_departure_airport
FROM Flight
-- 15. Selecting distinct arrival datetime from Flight table
SELECT DISTINCT flight_arrival_datetime
FROM Flight
-- 16. Selecting distinct departure datetime from Flight table
SELECT DISTINCT flight_departure_datetime
FROM Flight
-- 17. Selecting distinct passenger from Baggage table
SELECT DISTINCT passenger
FROM Baggage
-- 18. Selecting distinct crew salary from Crew table
SELECT DISTINCT crew_salary
FROM Crew
-- 19. Selecting distinct passenger from Feedback table
SELECT DISTINCT passenger
FROM Feedback
-- 20. Selecting distinct rating from Feedback table
SELECT DISTINCT rating
FROM Feedback


-------------------WHERE Clause using AND, OR and NOT Operators------------------------
-- 1. Crew which is not male
SELECT *
FROM Crew
WHERE NOT crew_gender = 'M'
-- 2. Crew which is not female
SELECT *
FROM Crew
WHERE NOT crew_gender = 'F'
-- 3. Crew whose gender is either male or female
SELECT *
FROM Crew
WHERE NOT crew_gender = 'O'
-- 4. Crew whose email is not gmail
SELECT *
FROM Crew
WHERE NOT crew_email LIKE '%gmail.com'
-- 5. Crew whose email is not yahoo
SELECT *
FROM Crew
WHERE NOT crew_email LIKE '%yahoo.com'
-- 6. Crew whose role id not is 1 or 3
SELECT *
FROM Crew
WHERE NOT crew_role = 1 OR crew_role = 3
-- 7. Crew who don't live in Islamabad or Lahore
SELECT *
FROM Crew
WHERE NOT (crew_address LIKE '%Islamabad%' OR crew_address LIKE '%Lahore%')
-- 8. Crew who don't live in Karachi or Peshawar
SELECT *
FROM Crew
WHERE NOT (crew_address LIKE '%Karachi%' OR crew_address LIKE '%Peshawar%')
-- 9. Crew who don't have Khan in their name
SELECT *
FROM Crew
WHERE NOT crew_name LIKE '%Khan%'
-- 10. Crew who don't have Ali in their name
SELECT *
FROM Crew
WHERE NOT crew_name LIKE '%Ali%'
-- 11. Passenger with id not in range 10 and 20
SELECT *
FROM Passenger
WHERE passenger_id NOT BETWEEN 10 AND 20
-- 12. Passenger with id not in range 40 and 50
SELECT *
FROM Passenger
WHERE passenger_id NOT BETWEEN 40 AND 50
-- 13. Passengers whose genders are not M and O
SELECT *
FROM Passenger
WHERE passenger_gender NOT IN ('M', 'O')
-- 14. Passengers whose genders are not F and M
SELECT *
FROM Passenger
WHERE passenger_gender NOT IN ('M', 'F')
-- 15. Countries except India, Pakistan and China
SELECT *
FROM Country
WHERE country_name NOT IN ('India', 'Pakistan', 'China')
-- 16. Countries whose name does not have United in it
SELECT *
FROM Country
WHERE country_name NOT LIKE ('%United%')
-- 17. Countries whose name does not have States in it
SELECT *
FROM Country
WHERE country_name NOT LIKE ('%States%')
-- 18. Cities whose country code is not 1, 3 and 5
SELECT *
FROM City
WHERE country NOT IN (1,3,5)
-- 19. Cities except Lahore and Delhi
SELECT *
FROM City
WHERE city_name NOT IN ('Lahore', 'Delhi')
-- 20. Payments which were not made by cash
SELECT *
FROM Payment
WHERE NOT payment_method = 'Cash'
-- 21. Cash payments less than 50 thousand
SELECT *
FROM Payment
WHERE payment_method = 'Cash' AND amount < 50000
-- 22. Card payments greater than 1 lakh
SELECT *
FROM Payment
WHERE payment_method = 'Card' AND amount > 100000
-- 23. Online payments less than 90 thousand
SELECT *
FROM Payment
WHERE payment_method = 'Online' AND amount < 90000
-- 24. Male crew with salary greater than 50 thousand
SELECT *
FROM Crew
WHERE crew_gender = 'M' AND crew_salary > 50000
-- 25. Crew with salary greater than 50 thousand and less than 1 lakh
SELECT *
FROM Crew
WHERE crew_salary > 50000 and crew_salary < 100000
-- 26. Male crew whose email is gmail
SELECT *
FROM Crew
WHERE crew_email LIKE '%gmail.com' AND crew_gender = 'M'
-- 27. Female crew whose email is yahoo
SELECT *
FROM Crew
WHERE crew_email LIKE '%yahoo.com' AND crew_gender = 'F'
-- 28. Crew with 'Other' gender whose email is gmail
SELECT *
FROM Crew
WHERE crew_email LIKE '%gmail.com' AND crew_gender = 'O'
-- 29. Crew with 'Other' gender whose email is yahoo
SELECT *
FROM Crew
WHERE crew_email LIKE '%yahoo.com' AND crew_gender = 'O'
-- 30. Crew from Lahore whose role id is 1
SELECT *
FROM Crew
WHERE crew_address LIKE '%Lahore%' AND crew_role = 1
-- 31. Crew from Islamabad whose role id is 1
SELECT *
FROM Crew
WHERE crew_address LIKE '%Islamabad%' AND crew_role = 1
-- 32. Crew from Karachi whose role id is 1
SELECT *
FROM Crew
WHERE crew_address LIKE '%Karachi%' AND crew_role = 1
-- 33. Class id 2 reservations after 1st August 2022
SELECT *
FROM Reservation
WHERE reservation_datetime > '2022-8-1' AND class = 2
-- 34. Class id 1 reservations after 1st August 2022
SELECT *
FROM Reservation
WHERE reservation_datetime > '2022-8-1' AND class = 1
-- 35. Class id 3 reservations after 1st March 2022
SELECT *
FROM Reservation
WHERE reservation_datetime > '2022-3-1' AND class = 3
-- 36. Class id 1 reservations of March
SELECT *
FROM Reservation
WHERE MONTH(reservation_datetime) = 3 AND class = 1
-- 37. Class id 2 reservations of April
SELECT *
FROM Reservation
WHERE MONTH(reservation_datetime) = 4 AND class = 2
-- 38. Class id 1 reservations of March
SELECT *
FROM Reservation
WHERE MONTH(reservation_datetime) = 3 AND class = 3
-- 39. Seats of aircraft id 1 in class id 1
SELECT *
FROM Seat
WHERE class = 1 AND aircraft = 1
-- 40. Seats of aircraft id 2 in class id 1
SELECT *
FROM Seat
WHERE class = 1 AND aircraft = 2
-- 41. Cities with country id 2 or 3
SELECT *
FROM City
WHERE country = 2 OR country = 3
-- 42. Cities with country id 4 or 5
SELECT *
FROM City
WHERE country = 4 OR country = 5
-- 43. Cities with country id 6 or 7
SELECT *
FROM City
WHERE country = 6 OR country = 7
-- 44. Crew from Lahore or Islamabad
SELECT *
FROM Crew
WHERE crew_address LIKE '%Lahore%' OR crew_address LIKE '%Islamabad%'
-- 45. Crew from Sui or Kala Shah Kaku
SELECT *
FROM Crew
WHERE crew_address LIKE '%Sui%' OR crew_address LIKE '%Kala Shah Kaku%'
-- 46. Crew whose role id is 1 or salary greater than 1 lakh 
SELECT *
FROM Crew
WHERE crew_role = 1 OR crew_salary >  100000
-- 47. Female crew or crew with salary greater than 1 lakh
SELECT *
FROM Crew
WHERE crew_gender = 'F' OR crew_salary > 100000
-- 48. Payments with payment method card or amount greater than 1 lakh
SELECT *
FROM Payment
WHERE payment_method = 'Card' OR amount > 100000
-- 49. Payments with payment method cash or amount less than 50 thousand
SELECT *
FROM Payment
WHERE payment_method = 'Cash' OR amount < 50000
-- 50. Payments with payment method online or amount greater than 1 lakh
SELECT *
FROM Payment
WHERE payment_method = 'Online' OR amount > 100000


-------------------------------ORDER BY-----------------------------------------------
-- 1. Sorting by amount
SELECT *
FROM Payment
ORDER BY amount
-- 2. Sorting by reservation id in descending order
SELECT *
FROM Payment
ORDER BY reservation DESC
-- 3. Sorting by payment id in descending order
SELECT *
FROM Payment
ORDER BY payment_id DESC
-- 4. Sorting by crew salary
SELECT *
FROM Crew
ORDER BY crew_salary
-- 5. Sorting by crew salary in descending order
SELECT *
FROM Crew
ORDER BY crew_salary DESC
-- 6. Sorting by crew role id
SELECT *
FROM Crew
ORDER BY crew_role
-- 7. Sorting by crew name in alphabetical order
SELECT *
FROM Crew
ORDER BY crew_name
-- 8. Sorting by crew name in reverse alphabetical order
SELECT *
FROM Crew
ORDER BY crew_name DESC
-- 9. Sorting by passenger id
SELECT *
FROM Feedback
ORDER BY passenger
-- 10. Sorting by rating
SELECT *
FROM Feedback
ORDER BY rating
-- 11. Sorting by country id
SELECT *
FROM City
ORDER BY country
-- 12. Sorting by city name in alphabetical order
SELECT *
FROM City
ORDER BY city_name
-- 13. Sorting by class id
SELECT *
FROM Seat
ORDER BY class
-- 14. Sorting by aircraft id in reverse order
SELECT *
FROM Seat
ORDER BY aircraft DESC
-- 15. Sorting by aircraft name in reverse alphabetical order
SELECT *
FROM Aircraft
ORDER BY aircraft_name DESC
-- 16. Sorting by passenger id in descending order
SELECT *
FROM Passenger
ORDER BY passenger_id DESC
-- 17. Sorting by passenger gender
SELECT *
FROM Passenger
ORDER BY passenger_gender
-- 18. Sorting by passenger name
SELECT *
FROM Passenger
ORDER BY passenger_name
-- 19. Sorting by passenger name in reverse alphabetical order
SELECT *
FROM Passenger
ORDER BY passenger_name DESC
-- 20. Sorting first by passenger name and then by gender
SELECT *
FROM Passenger
ORDER BY passenger_name, passenger_gender
-- 21. Sorting by response detail alphabetically
SELECT *
FROM Response
ORDER BY response_detail
-- 22. Sorting by crew salary
SELECT *
FROM Crew
ORDER BY crew_gender
-- 23. Sorting by passenger id
SELECT *
FROM Baggage
ORDER BY passenger
-- 24. Sorting by flight id in reverse order
SELECT *
FROM Baggage
ORDER BY flight DESC
-- 25. Sorting by baggage id in reverse order
SELECT *
FROM Baggage
ORDER BY baggage_id DESC


----------------------ORDER BY using AND, OR and NOT Operators-------------------------
-- 1. Sorting by amount which is between 1 and 1.5 lakh
SELECT *
FROM Payment
WHERE amount > 100000 AND amount < 150000
ORDER BY amount
-- 2. Sorting by reservation id from 10 to 20 in descending order
SELECT *
FROM Payment
WHERE reservation >= 10 AND reservation <= 20
ORDER BY reservation DESC
-- 3. Sorting by payment id from 30 to 50 in descending order
SELECT *
FROM Payment
WHERE payment_id >= 30 AND payment_id <= 50
ORDER BY payment_id DESC
-- 4. Sorting by crew salary which is greater than 50 thousand and less than 1 lakh
SELECT *
FROM Crew
WHERE crew_salary > 50000 AND crew_salary < 100000
ORDER BY crew_salary
-- 5. Sorting by crew salary of males greater than 1 lakh in descending order
SELECT *
FROM Crew
WHERE crew_gender = 'M' AND crew_salary > 100000
ORDER BY crew_salary DESC
-- 6. Sorting by crew role id of females from Islamabad
SELECT *
FROM Crew
WHERE crew_role = 'F' AND crew_address LIKE '%Islamabad%'
ORDER BY crew_role
-- 7. Sorting by crew name in alphabetical order of role id 1 and from Lahore
SELECT *
FROM Crew
WHERE crew_role = 1 AND crew_address LIKE '%Lahore%'
ORDER BY crew_name
-- 8. Sorting by crew name in reverse alphabetical order of role id 1 and from Lahore
SELECT *
FROM Crew
WHERE crew_role = 1 AND crew_address LIKE '%Lahore%'
ORDER BY crew_name DESC
-- 9. Sorting by passenger id where rating is less than 5
SELECT *
FROM Feedback
WHERE NOT rating > 5
ORDER BY passenger
-- 10. Sorting by rating where passenger id is less than 50
SELECT *
FROM Feedback
WHERE NOT passenger > 50
ORDER BY rating
-- 11. Sorting by country id excluding country id 1
SELECT *
FROM City
WHERE NOT country = 1
ORDER BY country
-- 12. Sorting by city name in alphabetical order excluding Lahore and London
SELECT *
FROM City
WHERE NOT city_name IN ('Lahore', 'London')
ORDER BY city_name
-- 13. Sorting by class id excluding class id 1
SELECT *
FROM Seat
WHERE NOT class = 1
ORDER BY class
-- 14. Sorting by aircraft id in revserse order excluding aircraft idss 1, 5 and 7
SELECT *
FROM Seat
WHERE aircraft NOT IN (1,5,7)
ORDER BY aircraft DESC
-- 15. Sorting by aircraft name in reverse alphabetical order excluding aircraft ids between 3 and 5
SELECT *
FROM Aircraft
WHERE aircraft_id NOT BETWEEN 3 AND 5
ORDER BY aircraft_name DESC
-- 16. Sorting by passenger id in descending order excludinh males and females
SELECT *
FROM Passenger
WHERE passenger_gender NOT IN ('M', 'F')
ORDER BY passenger_id DESC
-- 17. Sorting by passeger gender who don't have email address of yahoo
SELECT *
FROM Passenger
WHERE passenger_email NOT LIKE ('%yahoo.com')
ORDER BY passenger_gender
-- 18. Sorting by passenger name except those having id from 10 to 20
SELECT *
FROM Passenger
WHERE passenger_id NOT BETWEEN 10 and 20
ORDER BY passenger_name
-- 19. Sorting by passenger name in reverse alphabetical order except those who have Khan in their name
SELECT *
FROM Passenger
WHERE passenger_name NOT LIKE '%Khan%'
ORDER BY passenger_name DESC
-- 20. Sorting first by passenger name and then by gender who don't have email address of hotmail
SELECT *
FROM Passenger
WHERE passenger_email NOT LIKE '%hotmail.com'
ORDER BY passenger_name, passenger_gender
-- 21. Sorting by response detail alphabetically which have id greater than 1 or have 'Considered' in their detail
SELECT *
FROM Response
WHERE response_id > 1 OR response_detail LIKE '%Considered%'
ORDER BY response_detail
-- 22. Sorting by crew salary which have id greater than 30 or are female
SELECT *
FROM Crew
WHERE crew_id > 30 OR crew_gender = 'F'
ORDER BY crew_gender
-- 23. Sorting by passenger id with baggage id greater than 2 or flight id greater than 1
SELECT *
FROM Baggage
WHERE baggage_id > 2 OR flight > 1
ORDER BY passenger
-- 24. Sorting by flight id in reverse order which have flight id greater than 2 or have 'DELL' in their detail
SELECT *
FROM Baggage
WHERE baggage_detail LIKE '%DELL%' OR flight > 2
ORDER BY flight DESC
-- 25. Sorting by baggage id in reverse order with passenger id greater than 20 or flight id greater than 2
SELECT *
FROM Baggage
WHERE passenger > 20 OR flight > 2
ORDER BY baggage_id DESC


---------------------------------GROUP BY----------------------------------------------
-- 1. GROUPING BY gender and calculating total occurences of each
SELECT crew_gender, COUNT(crew_id) AS Total
FROM Crew
GROUP BY crew_gender
-- 2. GROUPING BY role id and calculating total occurences of each
SELECT crew_role, COUNT(crew_id) AS Total
FROM Crew
GROUP BY crew_role
-- 3. GROUPING BY salary and calculating total occurences of each
SELECT crew_salary, COUNT(crew_id) AS Total
FROM Crew
GROUP BY crew_salary
-- 4. GROUPING BY country id and calculating total occurences of each
SELECT country, COUNT(country) AS Total
FROM City
GROUP BY country
-- 5. GROUPING BY flight id and calculating total occurences of each
SELECT flight, COUNT(reservation_id) AS Total
FROM Reservation
GROUP BY flight
-- 6. GROUPING BY class id and calculating total occurences of each
SELECT class, COUNT(reservation_id) AS Total
FROM Reservation
GROUP BY class
-- 7. GROUPING BY month number and calculating total occurences of each
SELECT Month(reservation_datetime) AS MonthNumber, COUNT(reservation_id) AS Total
FROM Reservation
GROUP BY Month(reservation_datetime)
-- 8. GROUPING BY day number and calculating total occurences of each
SELECT Day(reservation_datetime) AS DayNumber, COUNT(reservation_id) AS Total
FROM Reservation
GROUP BY Day(reservation_datetime)
-- 9. GROUPING BY year number and calculating total occurences of each
SELECT YEAR(reservation_datetime) AS YearNumber, COUNT(reservation_id) AS Total
FROM Reservation
GROUP BY YEAR(reservation_datetime)
-- 10. GROUPING BY seat id and calculating total occurences of each
SELECT seat, COUNT(reservation_id) AS Total
FROM Reservation
GROUP BY seat
-- 11. GROUPING BY amount and calculating total occurences of each
SELECT amount, COUNT(payment_id) AS Total
FROM Payment
GROUP BY amount
-- 11. GROUPING BY payment method and calculating total occurences of each
SELECT payment_method, COUNT(payment_id) AS Total
FROM Payment
GROUP BY payment_method
-- 12. GROUPING BY city id and calculating total occurences of each
SELECT city, COUNT(airport_id) AS Total
FROM Airport
GROUP BY city
-- 13. GROUPING BY flight id and calculating total occurences of each
SELECT flight, COUNT(table_id) AS Total
FROM CrewOnFlight
GROUP BY flight
-- 14. GROUPING BY crew id and calculating total occurences of each
SELECT crew, COUNT(table_id) AS Total
FROM CrewOnFlight
GROUP BY crew
-- 15. GROUPING BY gender and calculating total occurences of each
SELECT passenger_gender, COUNT(passenger_id) AS Total
FROM Passenger
GROUP BY passenger_gender
-- 16. GROUPING BY gender and taking maximum salary of each gender
SELECT crew_gender, MAX(crew_salary) AS MaxSalary
FROM Crew
GROUP BY crew_gender
-- 17. GROUPING BY gender and taking minimum salary of each gender
SELECT crew_gender, MIN(crew_salary) AS MinSalary
FROM Crew
GROUP BY crew_gender
-- 18. GROUPING BY gender and taking average salary of each gender
SELECT crew_gender, AVG(crew_salary) AS AvgSalary
FROM Crew
GROUP BY crew_gender
-- 19. GROUPING BY role id and taking maximum salary of each role
SELECT crew_role, MAX(crew_salary) AS MaxSalary
FROM Crew
GROUP BY crew_role
-- 20. GROUPING BY role id and taking minimum salary of each role
SELECT crew_role, MIN(crew_salary) AS MinSalary
FROM Crew
GROUP BY crew_role
-- 21. GROUPING BY role id and taking average salary of each role
SELECT crew_role, AVG(crew_salary) AS AvgSalary
FROM Crew
GROUP BY crew_role
-- 22. GROUPING BY rating and calculating total occurences of each
SELECT rating, COUNT(feedback_id) AS Total
FROM Feedback
GROUP BY rating
-- 23. GROUPING BY passenger id and calculating total occurences of each
SELECT passenger, COUNT(feedback_id) AS Total
FROM Feedback
GROUP BY passenger
-- 24. GROUPING BY flight id and calculating total occurences of each
SELECT flight, COUNT(feedback_id) AS Total
FROM Feedback
GROUP BY flight
-- 25. GROUPING BY response and calculating total occurences of each
SELECT rating, COUNT(feedback_id) AS Total
FROM Feedback
GROUP BY response


----------------------GROUP BY using AND, OR, NOT Operators----------------------------
-- 1. GROUPING BY gender and calculating total occurences of each where crew id is greater than 1 and less than 10
SELECT crew_gender, COUNT(crew_id) AS Total
FROM Crew
WHERE crew_id > 1 AND crew_id < 10
GROUP BY crew_gender
-- 2. GROUPING BY role id and calculating total occurences of each where gender is male and female
SELECT crew_role, COUNT(crew_id) AS Total
FROM Crew
WHERE crew_gender = 'M' AND crew_gender = 'F'
GROUP BY crew_role
-- 3. GROUPING BY salary and calculating total occurences of each where crew role id is greater than 5 and less than 8
SELECT crew_salary, COUNT(crew_id) AS Total
FROM Crew
WHERE crew_role > 5 AND crew_role < 8
GROUP BY crew_salary
-- 4. GROUPING BY country id and calculating total occurences of each where country id is greater than 4 and less than 7
SELECT country, COUNT(country) AS Total
FROM City
WHERE country > 4 AND country < 7
GROUP BY country
-- 5. GROUPING BY flight id and calculating total occurences of each where reservation date is greater than 1st March 20222 and flight is greater than 2
SELECT flight, COUNT(reservation_id) AS Total
FROM Reservation
WHERE reservation_datetime > '2022-3-1' AND flight > 2
GROUP BY flight
-- 6. GROUPING BY class id and calculating total occurences of each where reservation date is between 1st March 2022 and 1st December 2022
SELECT class, COUNT(reservation_id) AS Total
FROM Reservation
WHERE reservation_datetime > '2022-3-1' AND reservation_datetime < '2022-12-1'
GROUP BY class
-- 7. GROUPING BY month number and calculating total occurences of each where flight id is 1 and class id is also 1
SELECT Month(reservation_datetime) AS MonthNumber, COUNT(reservation_id) AS Total
FROM Reservation
WHERE flight = 1 and class = 1
GROUP BY Month(reservation_datetime)
-- 8. GROUPING BY day number and calculating total occurences of each where flight id is 2 and class id is 1
SELECT Day(reservation_datetime) AS DayNumber, COUNT(reservation_id) AS Total
FROM Reservation
WHERE flight = 2 and class = 1
GROUP BY Day(reservation_datetime)
-- 9. GROUPING BY year number and calculating total occurences of each where flight id is 1 and class id is 3
SELECT YEAR(reservation_datetime) AS YearNumber, COUNT(reservation_id) AS Total
FROM Reservation
WHERE flight = 1 and class = 3
GROUP BY YEAR(reservation_datetime)
-- 10. GROUPING BY seat id and calculating total occurences of each except flight 1 and 5
SELECT seat, COUNT(reservation_id) AS Total
FROM Reservation
WHERE flight NOT IN (1,5)
GROUP BY seat
-- 11. GROUPING BY amount and calculating total occurences of each except between 50 and 80 thousand
SELECT amount, COUNT(payment_id) AS Total
FROM Payment
WHERE amount NOT BETWEEN 50000 AND 80000
GROUP BY amount
-- 12. GROUPING BY payment method and calculating total occurences of each excluding Cash
SELECT payment_method, COUNT(payment_id) AS Total
FROM Payment
WHERE NOT payment_method = 'Cash'
GROUP BY payment_method
-- 13. GROUPING BY city id and calculating total occurences of each excluding those between airport ids 10 and 17
SELECT city, COUNT(airport_id) AS Total
FROM Airport
WHERE airport_id NOT BETWEEN 10 AND 17
GROUP BY city
-- 14. GROUPING BY flight id and calculating total occurences of each excluding crew ids 3 and 6
SELECT flight, COUNT(table_id) AS Total
FROM CrewOnFlight
WHERE crew NOT IN (3,6)
GROUP BY flight
-- 15. GROUPING BY crew id and calculating total occurences of each excluding flight ids 1 and 3
SELECT crew, COUNT(table_id) AS Total
FROM CrewOnFlight
WHERE flight NOT IN (1,3)
GROUP BY crew
-- 16. GROUPING BY gender and calculating total occurences of each except passenger id between 20 and 30
SELECT passenger_gender, COUNT(passenger_id) AS Total
FROM Passenger
WHERE passenger_id NOT BETWEEN 20 AND 30
GROUP BY passenger_gender
-- 17. GROUPING BY gender and taking maximum salary of each gender except those having crew role id 1 and 4
SELECT crew_gender, MAX(crew_salary) AS MaxSalary
FROM Crew
WHERE crew_role NOT IN (1,4)
GROUP BY crew_gender
-- 18. GROUPING BY gender and taking minimum salary of each gender except those having crew role id 1 and 4
SELECT crew_gender, MIN(crew_salary) AS MinSalary
FROM Crew
WHERE crew_role NOT IN (1,4)
GROUP BY crew_gender
-- 19. GROUPING BY gender and taking average salary of each gender except those having crew role id 1 and 4
SELECT crew_gender, AVG(crew_salary) AS AvgSalary
FROM Crew
WHERE crew_role NOT IN (1,4)
GROUP BY crew_gender
-- 20. GROUPING BY role id and taking maximum salary of each gender excluding males and females
SELECT crew_role, MAX(crew_salary) AS MaxSalary
FROM Crew
WHERE crew_gender NOT IN ('M','F')
GROUP BY crew_role
-- 21. GROUPING BY role id and taking minimum salary of each gender where role id is greater than 5 or address is of Islamabad
SELECT crew_role, MIN(crew_salary) AS MinSalary
FROM Crew
WHERE crew_address LIKE '%Islamabad%' OR crew_role > 5
GROUP BY crew_role
-- 22. GROUPING BY role id and taking average salary of each gender where gender is male and salary is greater than 1 lakh
SELECT crew_role, AVG(crew_salary) AS AvgSalary
FROM Crew
WHERE crew_gender = 'M' OR crew_salary > 100000
GROUP BY crew_role
-- 23. GROUPING BY rating and calculating total occurences of each where passenger id is greater than 5 or rating is 3
SELECT rating, COUNT(feedback_id) AS Total
FROM Feedback
WHERE passenger >= 5 OR rating > 3
GROUP BY rating
-- 24. GROUPING BY passenger id and calculating total occurences of each where flight id is greater than 1 and passenger id is greater than 10
SELECT passenger, COUNT(feedback_id) AS Total
FROM Feedback
WHERE passenger >= 10 OR flight > 1
GROUP BY passenger
-- 25. GROUPING BY flight id and calculating total occurences of each where rating is greater than 8 and feedback id is greater than 1
SELECT flight, COUNT(feedback_id) AS Total
FROM Feedback
WHERE feedback_id > 1 OR rating > 8
GROUP BY flight


--------------------------------Subqueries---------------------------------------------
-- 1. Where crew salary is greater than average salary
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary > (SELECT AVG(crew_salary)
FROM crew)
-- 2. Where salary is greater than highest salary of role id 1
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary > (SELECT MAX(crew_salary)
FROM crew
WHERE crew_role = 1)
-- 3. Who have more salary than Zara Khan
SELECT *
FROM Crew
WHERE crew_salary > (SELECT crew_salary
FROM Crew
WHERE crew_name = 'Zara Khan')
-- 4. Where salary is less than lowest salary of role id 4
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary < (SELECT MIN(crew_salary)
FROM crew
WHERE crew_role = 4)
-- 5. Names of cities from Pakistan
SELECT city_name
FROM City
WHERE country = (SELECT country_id
FROM Country
WHERE country_name = 'Pakistan')
-- 6. Where aircraft is Boeing 747
SELECT flight_id
FROM Flight
WHERE aircraft = (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_name = 'Boeing 747')
-- 7. Where crew role is Pilot
SELECT crew_id, crew_name
FROM Crew
WHERE crew_role = (SELECT crew_id
FROM CrewRole
WHERE role_name = 'Pilot')
-- 8. Where country is India
SELECT city_name
FROM City
WHERE country = (SELECT country_id
FROM Country
WHERE country_name = 'India')
-- 9. Where country is United States
SELECT city_name
FROM City
WHERE country = (SELECT country_id
FROM Country
WHERE country_name = 'United States')
-- 10. Where country is Japan
SELECT city_name
FROM City
WHERE country = (SELECT country_id
FROM Country
WHERE country_name = 'Japan')
-- 11. Where aircraft is Airbus A320
SELECT flight_id
FROM Flight
WHERE aircraft = (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_name = 'Airbus A320')
-- 12. Where aircraft is Boeing 787
SELECT flight_id
FROM Flight
WHERE aircraft = (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_name = 'Boeing 787')
-- 13. Where aircraft is Airbus A380
SELECT flight_id
FROM Flight
WHERE aircraft = (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_name = 'Airbus A380')
-- 14. Where crew salary is less than average salary
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary < (SELECT AVG(crew_salary)
FROM crew)
-- 15. Who have more salary than Ali Khan
SELECT *
FROM Crew
WHERE crew_salary > (SELECT crew_salary
FROM Crew
WHERE crew_name = 'Ali Khan')
-- 16. Who have less salary than Ali Khan
SELECT *
FROM Crew
WHERE crew_salary < (SELECT crew_salary
FROM Crew
WHERE crew_name = 'Ali Khan')
-- 17. Where class is Business
SELECT reservation_id
FROM Reservation
WHERE class = (SELECT class_id
FROM Class
WHERE class_name = 'Business')
-- 18. Where class is Economy
SELECT reservation_id
FROM Reservation
WHERE class = (SELECT class_id
FROM Class
WHERE class_name = 'Economy')
-- 19. Where class is First
SELECT reservation_id
FROM Reservation
WHERE class = (SELECT class_id
FROM Class
WHERE class_name = 'First')
-- 20. Where flight departure airport is 18
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport = 18)
-- 21. Where flight departure airport is 13
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport = 13)
-- 22. Where flight departure airport is 5
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport = 5)
-- 23. Where flight arrival airport is 19
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_arrival_airport = 19)
-- 24. Where flight arrival airport is 17
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_arrival_airport = 17)
-- 25. Where flight arrival airport is 20
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_arrival_airport = 20)
-- 26. Where city name is Lahore
SELECT airport_id, airport_name
FROM Airport
WHERE city = (SELECT city_id
FROM City
WHERE city_name = 'Lahore')
-- 27. Where city name is Karachi
SELECT airport_id, airport_name
FROM Airport
WHERE city = (SELECT city_id
FROM City
WHERE city_name = 'Karachi')
-- 28. Where city name is Islamabad
SELECT airport_id, airport_name
FROM Airport
WHERE city = (SELECT city_id
FROM City
WHERE city_name = 'Islamabad')
-- 29. Where city name is London
SELECT airport_id, airport_name
FROM Airport
WHERE city = (SELECT city_id
FROM City
WHERE city_name = 'London')
-- 30. Where flight departure airport is 18
SELECT baggage_id, baggage_detail
FROM Baggage
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport = 18)


------------------------Subqueries using logical operators-------------------------
-- 1. Where crew salary is greater than average salary of crew excluding role id 1 and 2
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary > (SELECT AVG(crew_salary)
FROM crew
WHERE crew_role NOT IN (1,2))
-- 2. Where salary is greater than highest salary of role id 1 and 4
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary > (SELECT MAX(crew_salary)
FROM crew
WHERE crew_role = 1 OR crew_role = 4)
-- 3. Who have more salary than Zara Khan and Ali Khan
SELECT *
FROM Crew
WHERE crew_salary > (SELECT MAX(crew_salary)
FROM Crew
WHERE crew_name = 'Zara Khan' OR crew_name = 'Ali Khan')
-- 4. Where salary is less than lowest salary of role id 4 and 2
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary < (SELECT MIN(crew_salary)
FROM crew
WHERE crew_role = 4 OR crew_role = 2)
-- 5. Names of cities from Pakistan and India
SELECT city_name
FROM City
WHERE country IN (SELECT country_id
FROM Country
WHERE country_name = 'Pakistan' OR country_name = 'India')
-- 6. Where aircraft is Boeing 747 and Boeing 787
SELECT flight_id
FROM Flight
WHERE aircraft IN (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_name = 'Boeing 747' OR aircraft_name = 'Boeing 787')
-- 7. Where crew role is Pilot or Air Host
SELECT crew_id, crew_name
FROM Crew
WHERE crew_role IN (SELECT crew_id
FROM CrewRole
WHERE role_name = 'Pilot' OR crew_role = 'Air Host')
-- 8. Where country is India or United Kingdom
SELECT city_name
FROM City
WHERE country IN (SELECT country_id
FROM Country
WHERE country_name = 'India' OR country_name = 'United Kingdom')
-- 9. Where country is United States or United States
SELECT city_name
FROM City
WHERE country IN (SELECT country_id
FROM Country
WHERE country_name = 'United States' OR country_name = 'Canada')
-- 10. Where country is Japan or Nepal
SELECT city_name
FROM City
WHERE country IN (SELECT country_id
FROM Country
WHERE country_name = 'Japan' OR country_name = 'Nepal')
-- 11. Where aircraft is Airbus A320 or Boeing 787
SELECT flight_id
FROM Flight
WHERE aircraft IN (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_name = 'Airbus A320' OR aircraft_name = 'Boeing 787')
-- 12. Where aircraft id is neither 1 and 2
SELECT flight_id
FROM Flight
WHERE aircraft IN (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_id NOT IN (1,2))
-- 13. Where aircraft is Airbus A380 or Airbus A320
SELECT flight_id
FROM Flight
WHERE aircraft IN (SELECT aircraft_id
FROM Aircraft
WHERE aircraft_name = 'Airbus A380' OR aircraft_name = 'Airbus A320')
-- 14. Where crew salary is less than average salary of crew having id greater than 10 and address containing word Lahore
SELECT crew_name, crew_salary
FROM Crew
WHERE crew_salary < (SELECT AVG(crew_salary)
FROM crew
WHERE crew_id > 10 AND crew_address LIKE '%Lahore%')
-- 15. Who have more salary than Ali Khan and Hassan Ali
SELECT *
FROM Crew
WHERE crew_salary > (SELECT MAX(crew_salary)
FROM Crew
WHERE crew_name = 'Ali Khan' OR crew_name = 'Hassan Ali')
-- 16. Who have less salary than Ali Khan and Hassan Ali
SELECT *
FROM Crew
WHERE crew_salary < (SELECT MIN(crew_salary)
FROM Crew
WHERE crew_name = 'Ali Khan' OR crew_name = 'Hassan Ali')
-- 17. Where class is Business or First
SELECT reservation_id
FROM Reservation
WHERE class IN (SELECT class_id
FROM Class
WHERE class_name = 'Business' OR class_name = 'First')
-- 18. Where class is Economy or First
SELECT reservation_id
FROM Reservation
WHERE class IN (SELECT class_id
FROM Class
WHERE class_name = 'Economy' OR class_name = 'First')
-- 19. Where class is Economy or Business
SELECT reservation_id
FROM Reservation
WHERE class IN (SELECT class_id
FROM Class
WHERE class_name = 'Economy' OR class_name = 'Business')
-- 20. Where flight departure airport is not 18, 19 or 20
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport NOT IN (18,19,20))
-- 21. Where flight departure airport is 13 or 18
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport = 13 OR flight_departure_airport = 18)
-- 22. Where flight departure airport is 5 or 18
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport = 5 OR flight_departure_airport = 18)
-- 23. Where flight arrival airport is 19 or departure aiport is 18
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_arrival_airport = 19 OR flight_departure_airport = 18)
-- 24. Where flight arrival airport is 17 or departure aiport is 18
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_arrival_airport = 17 OR flight_departure_airport = 18)
-- 25. Where flight arrival airport is 20 or departure aiport is 18
SELECT crew
FROM CrewOnFlight
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_arrival_airport = 20 OR flight_departure_airport = 18)
-- 26. Where city id is from 5 to 20
SELECT airport_id, airport_name
FROM Airport
WHERE city IN (SELECT city_id
FROM City
WHERE city_id >= 5 AND city_id <= 20)
-- 27. Where city name is Karachi or Lahore
SELECT airport_id, airport_name
FROM Airport
WHERE city IN (SELECT city_id
FROM City
WHERE city_name = 'Karachi' OR city_name = 'Lahore')
-- 28. Where city name is Islamabad or London
SELECT airport_id, airport_name
FROM Airport
WHERE city IN (SELECT city_id
FROM City
WHERE city_name = 'Islamabad' OR city_name = 'London')
-- 29. Where city name is Delhi or Lahore
SELECT airport_id, airport_name
FROM Airport
WHERE city IN (SELECT city_id
FROM City
WHERE city_name = 'Delhi' OR city_name = 'Lahore')
-- 30. Where flight departure airport not in range 10 to 20
SELECT baggage_id, baggage_detail
FROM Baggage
WHERE flight IN (SELECT flight_id
FROM Flight
WHERE flight_departure_airport NOT BETWEEN 10 AND 20)


-----------------------------Aggregate Functions--------------------------------------
-- 1. Taking maximum salary from crew table
SELECT MAX(crew_salary)
FROM Crew
-- 2. Highest crew id from crew table
SELECT MAX(crew_id)
FROM Crew
-- 3. Highest flight id from reservation table
SELECT MAX(flight)
FROM Reservation
-- 4. Highest passenger id from passenger table
SELECT MAX(passenger_id)
FROM Passenger
-- 5. Highest passenger id from reservation table
SELECT MAX(passenger)
FROM Reservation
-- 6. Highest arrival airport id from flight table
SELECT MAX(flight_arrival_airport)
FROM Flight
-- 7. Highest arrival date time from flight table
SELECT MAX(flight_arrival_datetime)
FROM Flight
-- 8. Highest departure date time from flight table
SELECT MIN(flight_departure_datetime)
FROM Flight
-- 9. Taking maximum salary from crew table
SELECT MIN(crew_salary)
FROM Crew
-- 10. Lowest crew id from crew table
SELECT MIN(crew_id)
FROM Crew
-- 11. Lowest flight id from reservation table
SELECT MIN(flight)
FROM Reservation
-- 12. Lowest passenger id from passenger table
SELECT MIN(passenger_id)
FROM Passenger
-- 13. Lowest passenger id from reservation table
SELECT MIN(passenger)
FROM Reservation
-- 14. Lowest arrival airport id from flight table
SELECT MIN(flight_arrival_airport)
FROM Flight
-- 15. Lowest arrival date time from flight table
SELECT MIN(flight_arrival_datetime)
FROM Flight
-- 16. Lowest departure date time from flight table
SELECT MIN(flight_departure_datetime)
FROM Flight
-- 17. Average salary from crew table
SELECT AVG(crew_salary)
FROM Crew
-- 18. Total crew ids in crew table
SELECT COUNT(crew_id)
FROM Crew
-- 19. Sum of crew salaries in crew table
SELECT SUM(crew_salary)
FROM Crew
-- 20. Sum of salaries of male crew
SELECT SUM(crew_salary)
FROM Crew
WHERE crew_gender = 'M'


--------------Aggregate Funtions with Group By and Logical Operators------------------
-- 1. Maximum salary of male and female genders in crew table
SELECT crew_gender, MAX(crew_salary)
FROM Crew
WHERE crew_gender = 'M' OR crew_gender = 'F'
GROUP BY crew_gender
-- 2. Maximum salary of other and female genders in crew table
SELECT crew_gender, MAX(crew_salary)
FROM Crew
WHERE crew_gender = 'O' OR crew_gender = 'F'
GROUP BY crew_gender
-- 3. Average salary of other and female genders in crew table
SELECT crew_gender, AVG(crew_salary)
FROM Crew
WHERE crew_gender = 'O' OR crew_gender = 'F'
GROUP BY crew_gender
-- 4. Average salary of male and female genders in crew table
SELECT crew_gender, AVG(crew_salary)
FROM Crew
WHERE crew_gender = 'M' OR crew_gender = 'F'
GROUP BY crew_gender
-- 5. Minimum salary of male and female genders in crew table
SELECT crew_gender, MIN(crew_salary)
FROM Crew
WHERE crew_gender = 'M' OR crew_gender = 'F'
GROUP BY crew_gender
-- 6. Minimum salary of other and female genders in crew table
SELECT crew_gender, MIN(crew_salary)
FROM Crew
WHERE crew_gender = 'O' OR crew_gender = 'F'
GROUP BY crew_gender
-- 7. Getting total passenger genders having hotmail or outlook emails in passenger table
SELECT passenger_gender, COUNT(passenger_id)
FROM Passenger
WHERE passenger_email LIKE '%hotmail.com' OR passenger_email LIKE '%outlook.com'
GROUP BY passenger_gender
-- 8. Getting total passenger genders having hotmail or outlook emails in passenger table
SELECT passenger_gender, COUNT(passenger_id)
FROM Passenger
WHERE passenger_email LIKE '%gmail.com' OR passenger_email LIKE '%yahoo.com'
GROUP BY passenger_gender
-- 9. Total payments of each amount where reservation id is from 21 to 29
SELECT amount, COUNT(payment_id)
FROM Payment
WHERE reservation > 20 AND reservation < 30
GROUP BY amount
-- 10. Total payments of each payment method where reservation id greater than 30 and amount greater than 50 thousand
SELECT payment_method, COUNT(payment_id)
FROM Payment
WHERE amount > 50000 AND reservation > 30
GROUP BY payment_method
-- 11. Total payments of each payment method where reservation id is from 20 to 30
SELECT payment_method, COUNT(payment_id)
FROM Payment
WHERE reservation >= 20 AND reservation <= 30
GROUP BY payment_method
-- 12. Each country's city where country id is form 4 to 9
SELECT country, COUNT(city_id)
FROM City
WHERE country > 3 AND country < 10
GROUP BY country
-- 13. Total reservations of all flight after 1st May 2022 excluding flight id 1
SELECT flight, COUNT(reservation_id)
FROM Reservation
WHERE reservation_datetime > '2022-5-1' AND flight > 1
GROUP BY flight
-- 14. Total reservations of each class in month of May
SELECT class, COUNT(reservation_id)
FROM Reservation
WHERE reservation_datetime > '2022-4-31' AND reservation_datetime < '2022-6-1'
GROUP BY class
-- 15. Total reservations of each month where class id 2 or flight id 2 
SELECT Month(reservation_datetime), COUNT(reservation_id)
FROM Reservation
WHERE flight = 2 OR class = 2
GROUP BY Month(reservation_datetime)
-- 16. Total reservations with respect to each day where flight id is 3 or class id is 1
SELECT Day(reservation_datetime), COUNT(reservation_id)
FROM Reservation
WHERE flight = 3 AND class = 1
GROUP BY Day(reservation_datetime)
-- 17. Total reservations of each seat excluding flight id 2 and 4
SELECT seat, COUNT(reservation_id)
FROM Reservation
WHERE flight NOT IN (2,4)
GROUP BY seat
-- 18. Total payments with respect to amount where amount is not in range 60 to 90 thousand
SELECT amount, COUNT(payment_id)
FROM Payment
WHERE amount NOT BETWEEN 60000 AND 90000
GROUP BY amount
-- 19. Total payments of each method excluding Cash
SELECT payment_method, COUNT(payment_id)
FROM Payment
WHERE NOT payment_method = 'Cash'
GROUP BY payment_method
-- 20. Total payments of each method excluding Online
SELECT payment_method, COUNT(payment_id)
FROM Payment
WHERE NOT payment_method = 'Online'
GROUP BY payment_method
-- 21. Total payments of each method excluding Card
SELECT payment_method, COUNT(payment_id)
FROM Payment
WHERE NOT payment_method = 'Card'
GROUP BY payment_method
-- 22. Total of each city's airports, excluding airports with airport id in range 20 to 25
SELECT city, COUNT(airport_id)
FROM Airport
WHERE airport_id NOT BETWEEN 20 AND 25
GROUP BY city
-- 23. Total flights crews where excluding those crew having crew id 4 or 5
SELECT flight, COUNT(table_id)
FROM CrewOnFlight
WHERE crew NOT IN (4,5)
GROUP BY flight
-- 24. Total flights of each crew excluding flight id 2 or 4
SELECT crew, COUNT(table_id)
FROM CrewOnFlight
WHERE flight NOT IN (2,4)
GROUP BY crew
-- 25. Sum of each crew gender's salary excluding those having salary in range of 60 to 90 thousand
SELECT crew_gender, SUM(crew_salary)
FROM Crew
WHERE crew_salary NOT BETWEEN 60000 AND 90000
GROUP BY crew_gender
-- 26. Sum of salaries of male and female genders
SELECT crew_gender, SUM(crew_salary)
FROM Crew
WHERE crew_gender = 'M' OR crew_gender = 'F'
GROUP BY crew_gender
-- 27. Sum of salaries of female and other genders
SELECT crew_gender, SUM(crew_salary)
FROM Crew
WHERE crew_gender = 'F' OR crew_gender = 'O'
GROUP BY crew_gender
-- 28. Sum of salaries of male and other genders
SELECT crew_gender, SUM(crew_salary)
FROM Crew
WHERE crew_gender = 'M' OR crew_gender = 'O'
GROUP BY crew_gender
-- 29. Sum of salaries of crew id 1 and 3
SELECT crew_role, SUM(crew_salary)
FROM Crew
WHERE crew_role = 1 OR crew_role = 3
GROUP BY crew_role
-- 30. Sum of salaries of crew id 4 and 3
SELECT crew_role, SUM(crew_salary)
FROM Crew
WHERE crew_role = 4 OR crew_role = 8
GROUP BY crew_role


--------------------------------INNER JOIN--------------------------------------------
-- 1. Class Name of each reservation
SELECT r.reservation_id, c.class_name
FROM Reservation r
	INNER JOIN Class c
	ON c.class_id = r.class
-- 2. Passenger Name of each reservation
SELECT r.reservation_id, p.passenger_name
FROM Reservation r
	INNER JOIN Passenger p
	ON p.passenger_id = r.passenger
-- 3. Seat Name of each reservation
SELECT r.reservation_id, s.seat_name
FROM Reservation r
	INNER JOIN Seat s
	ON s.seat_id = r.seat
-- 4. Aircraft Name of each reservation
SELECT r.reservation_id, a.aircraft_name
FROM Reservation r
	INNER JOIN Aircraft a
	ON a.aircraft_id = r.flight
-- 5. Passenger Name with the baggage id
SELECT b.baggage_id, p.passenger_name
FROM Baggage b
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
-- 6. Passenger Name with the baggage id and detail
SELECT b.baggage_id, b.baggage_detail, p.passenger_name
FROM Baggage b
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
-- 7. Departure date time of each baggage
SELECT b.baggage_id, f.flight_departure_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
-- 8. Departure and arrival date time of each baggage with its detail
SELECT b.baggage_id, b.baggage_detail, f.flight_departure_datetime, f.flight_arrival_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
-- 9. Departure and arrival date time of each baggage with its detail and passenger name
SELECT b.baggage_id, p.passenger_name, b.baggage_detail, f.flight_departure_datetime, f.flight_arrival_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
-- 10. Departure and arrival date time of each baggage with its detail and passenger name and departure airport name
SELECT b.baggage_id, p.passenger_name, b.baggage_detail, a.airport_name AS departure_airport, f.flight_departure_datetime, f.flight_arrival_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
	INNER JOIN Airport a
	ON a.airport_id = f.flight_departure_airport
-- 11. Departure and arrival date time of each baggage with its detail and passenger name and arrival airport name
SELECT b.baggage_id, p.passenger_name, b.baggage_detail, a.airport_name AS arrival_airport, f.flight_departure_datetime, f.flight_arrival_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
	INNER JOIN Airport a
	ON a.airport_id = f.flight_arrival_airport
-- 12. Aircraft name of each flight
SELECT f.flight_id, a.aircraft_name
FROM Flight f
	INNER JOIN Aircraft a
	ON a.aircraft_id = f.aircraft
-- 13. Arrival airport name and date time name of each flight
SELECT f.flight_id, a.airport_name  AS [arrival airport], f.flight_arrival_datetime
FROM Flight f
	INNER JOIN Airport a
	ON a.airport_id = f.flight_arrival_airport
-- 14. Departure airport name and date time name of each flight
SELECT f.flight_id, a.airport_name AS departure_airport, f.flight_departure_datetime
FROM Flight f
	INNER JOIN Airport a
	ON a.airport_id = f.flight_departure_airport
-- 15. Country name of each city and city id
SELECT ci.city_id, ci.city_name, co.country_name
FROM City ci
	INNER JOIN Country co
	ON co.country_id = ci.country
-- 16. City name of each airport 
SELECT a.airport_id, a.airport_name, c.city_name
FROM Airport a
	INNER JOIN City c
	ON c.city_id = a.city
-- 17. City and country name of each airport 
SELECT a.airport_id, a.airport_name, c.city_name, co.country_name
FROM Airport a
	INNER JOIN City c
	ON c.city_id = a.city
	INNER JOIN Country co
	ON co.country_id = c.country
-- 18. Role name of each crew
SELECT c.crew_id, c.crew_name, cr.role_name
FROM Crew c
	INNER JOIN CrewRole cr
	ON cr.role_id = c.crew_role
-- 19. To get which crew member was present on which flight using flight's departure and arrival datetime
SELECT c.crew_name, f.flight_departure_datetime, f.flight_arrival_datetime
FROM CrewOnFlight cof
	INNER JOIN Crew c
	ON c.crew_id = cof.crew
	INNER JOIN Flight f
	ON f.flight_id = cof.flight
-- 20. To get which crew member was present on which flight using flight's departure and arrival datetime and flight's aircraft name 
SELECT c.crew_name, a.aircraft_name, f.flight_departure_datetime, f.flight_arrival_datetime
FROM CrewOnFlight cof
	INNER JOIN Crew c
	ON c.crew_id = cof.crew
	INNER JOIN Flight f
	ON f.flight_id = cof.flight
	INNER JOIN Aircraft a
	ON a.aircraft_id = f.aircraft


-------------INNER Joins using logical Operators, Group by and Order by------------------
-- 1. Total reservations of each class
SELECT c.class_name, COUNT(r.reservation_id) AS total_reservations
FROM Reservation r
	INNER JOIN Class c
	ON c.class_id = r.class
GROUP BY c.class_name
-- 2. Reservation and passenger name and ordering by reservation id in descending order
SELECT r.reservation_id, p.passenger_name
FROM Reservation r
	INNER JOIN Passenger p
	ON p.passenger_id = r.passenger
ORDER BY r.reservation_id DESC
-- 3. Seat Name of each reservation where reservation id is from 20 to 30
SELECT r.reservation_id, s.seat_name
FROM Reservation r
	INNER JOIN Seat s
	ON s.seat_id = r.seat
WHERE reservation_id >= 20 AND reservation_id <=30
-- 4. Total reservations of each aircraft and ordering by total_reservations
SELECT a.aircraft_name, COUNT(r.reservation_id) AS total_resservations
FROM Reservation r
	INNER JOIN Aircraft a
	ON a.aircraft_id = r.flight
GROUP BY a.aircraft_name
ORDER BY total_resservations
-- 5. Passenger Name with the baggage id where baggage id is not 2 and 3
SELECT b.baggage_id, p.passenger_name
FROM Baggage b
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
WHERE b.baggage_id NOT IN (2,3)
-- 6. Passenger Name with the baggage id and detail where baggage detail has 'Guitar' or 'Dell' in it
SELECT b.baggage_id, b.baggage_detail, p.passenger_name
FROM Baggage b
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
WHERE b.baggage_detail LIKE '%Guitar%' OR b.baggage_detail LIKE '%Dell%'
-- 7. Departure date time of each baggage except those baggage where baggage id is 4 or 5
SELECT b.baggage_id, f.flight_departure_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
WHERE b.baggage_id NOT IN (4,5)
-- 8. Departure and arrival date time of each baggage with its detail where baggage id is 2,3 or 4 or date is before 1st June 2022
SELECT b.baggage_id, b.baggage_detail, f.flight_departure_datetime, f.flight_arrival_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
WHERE b.baggage_id IN (2,3,4) OR f.flight_departure_datetime < '2022-6-1'
-- 9. Departure and arrival date time of each baggage with its detail and passenger name where passenger has 'Muhammad' or 'Ahmed' in its name
SELECT b.baggage_id, p.passenger_name, b.baggage_detail, f.flight_departure_datetime, f.flight_arrival_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
	INNER JOIN Passenger p
	ON p.passenger_id = b.passenger
WHERE p.passenger_name LIKE ('%Muhammad%') OR p.passenger_name LIKE ('%Ahmed%')
-- 10. Total baggages at departure airport and ordering by total_baggages column in descending order
SELECT a.airport_name, COUNT(b.baggage_id) AS total_baggages
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
	INNER JOIN Airport a
	ON a.airport_id = f.flight_departure_airport
GROUP BY a.airport_name
ORDER BY total_baggages DESC
-- 11. Total baggages at arrival airports and ordering by total_baggages column in descending order
SELECT a.airport_name, COUNT(b.baggage_id) AS total_baggages
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
	INNER JOIN Airport a
	ON a.airport_id = f.flight_arrival_airport
GROUP BY a.airport_name
ORDER BY total_baggages DESC
-- 12. Total flights of aircrafts
SELECT a.aircraft_name, COUNT(f.flight_id) AS total_flights
FROM Flight f
	INNER JOIN Aircraft a
	ON a.aircraft_id = f.aircraft
GROUP BY a.aircraft_name
-- 13. Total flights at airports
SELECT a.airport_name, COUNT(f.flight_id)
FROM Flight f
	INNER JOIN Airport a
	ON a.airport_id = f.flight_arrival_airport
GROUP BY a.airport_name
-- 14. Departure airport name and date time name of each flight where airport name contains 'Iqbal' or 'Berlin'
SELECT f.flight_id, a.airport_name AS departure_airport, f.flight_departure_datetime
FROM Flight f
	INNER JOIN Airport a
	ON a.airport_id = f.flight_departure_airport
WHERE a.airport_name LIKE ('%Iqbal%') OR a.airport_name LIKE ('%Berlin%')
-- 15. Country name of each city and city id except countries Pakistan, China and India
SELECT ci.city_id, ci.city_name, co.country_name
FROM City ci
	INNER JOIN Country co
	ON co.country_id = ci.country
WHERE co.country_name NOT IN ('Pakistan', 'China', 'India')
-- 16. City name of each airport except cities Manchester and Hamburg
SELECT a.airport_id, a.airport_name, c.city_name
FROM Airport a
	INNER JOIN City c
	ON c.city_id = a.city
WHERE c.city_name NOT IN ('Manchester', 'Hamburg')
-- 17. City and country name of each airport except airports with ids from 5 to 10 and sorting by airport name
SELECT a.airport_id, a.airport_name, c.city_name, co.country_name
FROM Airport a
	INNER JOIN City c
	ON c.city_id = a.city
	INNER JOIN Country co
	ON co.country_id = c.country
WHERE a.airport_id NOT BETWEEN 5 AND 10
ORDER BY a.airport_name
-- 18. Role name of each crew except those having 'Khan' or 'Malik' in their name and ordeing by role_name column
SELECT c.crew_id, c.crew_name, cr.role_name
FROM Crew c
	INNER JOIN CrewRole cr
	ON cr.role_id = c.crew_role
WHERE NOT (c.crew_name LIKE ('%Khan%') OR c.crew_name LIKE ('%Malik%'))
ORDER BY cr.role_name
-- 19. To get which crew member was present on which flight using flight's departure and arrival datetime and sorting by departure date time
SELECT c.crew_name, f.flight_departure_datetime, f.flight_arrival_datetime
FROM CrewOnFlight cof
	INNER JOIN Crew c
	ON c.crew_id = cof.crew
	INNER JOIN Flight f
	ON f.flight_id = cof.flight
ORDER BY f.flight_departure_datetime
-- 20. To get which crew member was present on which flight using flight's departure and arrival datetime and flight's aircraft name and sorting by arrival date time
SELECT c.crew_name, a.aircraft_name, f.flight_departure_datetime, f.flight_arrival_datetime
FROM CrewOnFlight cof
	INNER JOIN Crew c
	ON c.crew_id = cof.crew
	INNER JOIN Flight f
	ON f.flight_id = cof.flight
	INNER JOIN Aircraft a
	ON a.aircraft_id = f.aircraft
ORDER BY f.flight_arrival_datetime
-- 21. City name of each airport except Cities London and Toronto
SELECT a.airport_id, a.airport_name, c.city_name
FROM Airport a
	INNER JOIN City c
	ON c.city_id = a.city
WHERE c.city_name NOT IN ('London', 'Toronto')
-- 22. Role name of each crew except those having 'Khan' or 'Malik' in their name and sorting by role name in descending order 
SELECT c.crew_id, c.crew_name, cr.role_name
FROM Crew c
	INNER JOIN CrewRole cr
	ON cr.role_id = c.crew_role
WHERE NOT (c.crew_name LIKE ('%Khan%') OR c.crew_name LIKE ('%Malik%'))
ORDER BY cr.role_name DESC
-- 23. City and country name of each airport except those airports with id from 5 to 10 and sorting by airport name in descending order
SELECT a.airport_id, a.airport_name, c.city_name, co.country_name
FROM Airport a
	INNER JOIN City c
	ON c.city_id = a.city
	INNER JOIN Country co
	ON co.country_id = c.country
WHERE a.airport_id NOT BETWEEN 5 AND 10
ORDER BY a.airport_name DESC
-- 24. Total reservations of each aircraft and sorting by total reservations in descending order
SELECT a.aircraft_name, COUNT(r.reservation_id) AS total_resservations
FROM Reservation r
	INNER JOIN Aircraft a
	ON a.aircraft_id = r.flight
GROUP BY a.aircraft_name
ORDER BY total_resservations DESC
-- 25. Total cities of each country
SELECT co.country_name, COUNT(ci.city_name) AS total_cities
FROM City ci
	INNER JOIN Country co
	ON co.country_id = ci.country
GROUP BY co.country_name
-- 26. Baggage details with departure and arrival date time where baggage id is from 1 to 3 or baggage date is before  1st May 2022
SELECT b.baggage_id, b.baggage_detail, f.flight_departure_datetime, f.flight_arrival_datetime
FROM Baggage b
	INNER JOIN Flight f
	ON f.flight_id = b.flight
WHERE b.baggage_id IN (1,3) OR f.flight_departure_datetime < '2022-5-1'
--27. Departure and arrival date time of each crew on flight and sorting by departure date time in descending order
SELECT c.crew_name, f.flight_departure_datetime, f.flight_arrival_datetime
FROM CrewOnFlight cof
	INNER JOIN Crew c
	ON c.crew_id = cof.crew
	INNER JOIN Flight f
	ON f.flight_id = cof.flight
ORDER BY f.flight_departure_datetime DESC
-- 28. Total reservations of each class and sorting by class name
SELECT c.class_name, COUNT(r.reservation_id) AS total_reservations
FROM Reservation r
	INNER JOIN Class c
	ON c.class_id = r.class
GROUP BY c.class_name
ORDER BY c.class_name
-- 29. Airports with city and country name except those having airport id form 3 to 5
SELECT a.airport_id, a.airport_name, c.city_name, co.country_name
FROM Airport a
	INNER JOIN City c
	ON c.city_id = a.city
	INNER JOIN Country co
	ON co.country_id = c.country
WHERE a.airport_id NOT BETWEEN 3 AND 5
ORDER BY a.airport_name
-- 30. Total reservations of each aircraft and ordering by total_reservations column
SELECT a.aircraft_name, COUNT(r.reservation_id) AS total_resservations
FROM Reservation r
	INNER JOIN Aircraft a
	ON a.aircraft_id = r.flight
GROUP BY a.aircraft_name
ORDER BY total_resservations


-------------------------------LEFT JOIN-------------------------------------------
-- 1. All passengers with or without baggage
SELECT b.baggage_id, b.baggage_detail, p.passenger_name
FROM Passenger p
	LEFT JOIN Baggage b
	ON p.passenger_id = b.passenger
-- 2. All flights with or without baggage
SELECT b.baggage_id, b.baggage_detail, f.flight_id
FROM Flight f
	LEFT JOIN Baggage b
	ON f.flight_id = b.flight
-- 3. Aircrafts with or without flights
SELECT a.aircraft_id, a.aircraft_name, f.flight_id
FROM Aircraft a
	LEFT JOIN Flight f
	ON a.aircraft_id = f.aircraft
-- 4. Airports with or without departures
SELECT a.airport_id, a.airport_name, f.flight_id AS flight_departure_id
FROM Airport a
	LEFT JOIN Flight f
	ON a.airport_id = f.flight_departure_airport
-- 5. Airports with or without arrivals
SELECT a.airport_id, a.airport_name, f.flight_id AS flight_arrival_id
FROM Airport a
	LEFT JOIN Flight f
	ON a.airport_id = f.flight_arrival_airport
-- 6. Passengers with or without feedback
SELECT p.passenger_id, p.passenger_name, f.feedback_id, f.complete_feedback
FROM Passenger p
	LEFT JOIN Feedback f
	ON p.passenger_id = f.passenger
-- 7. Passengers with or without rating
SELECT p.passenger_id, p.passenger_name, f.rating
FROM Passenger p
	LEFT JOIN Feedback f
	ON p.passenger_id = f.passenger
-- 8. Crew with a flight or without a flight
SELECT c.crew_id, c.crew_name, cof.flight
FROM Crew c
	LEFT JOIN CrewOnFlight cof
	ON c.crew_id = cof.crew
-- 9. All passengers with or without a reservation
SELECT r.reservation_id, p.passenger_name
FROM Passenger p
	LEFT JOIN Reservation r
	ON p.passenger_id = r.passenger
-- 10. Country with or without a city in City table
SELECT ci.city_name, co.country_name
FROM Country co
	LEFT JOIN City ci
	ON co.country_id = ci.country
-- 11. Response whether it is in feedback or not
SELECT f.feedback_id, f.complete_feedback, f.passenger, r.response_detail
FROM Response r
	LEFT JOIN Feedback f
	ON r.response_id = f.response
-- 12. Flights whether they have a feedback or not
SELECT fb.feedback_id, fb.complete_feedback, f.flight_id
FROM Flight f
	LEFT JOIN Feedback fb
	ON f.flight_id = fb.flight
-- 13. City whether it has an airport or not
SELECT a.airport_id, a.airport_name, c.city_name
FROM City c
	LEFT JOIN Airport a
	ON c.city_id = a.airport_id
-- 14. Class whether it has a seat or not
SELECT s.seat_id, s.seat_name, c.class_name
FROM Class c
	LEFT JOIN Seat s
	ON c.class_id = s.class
-- 15. Reservations whether payment of it has been made or not 
SELECT r.reservation_id, p.amount
FROM Reservation r
	LEFT JOIN Payment p
	ON r.reservation_id = p.reservation
-- 16. Class whether there is any reservation of it or not
SELECT r.reservation_id, c.class_name
FROM Class c
	LEFT JOIN Reservation r
	ON c.class_id = r.class
-- 17. Seat whether there is any reservation of it or not
SELECT r.reservation_id, s.seat_id, s.seat_name
FROM Seat s
	LEFT JOIN Reservation r
	ON s.seat_id = r.seat
-- 18. Flight whether it has any crew as of now or not
SELECT cof.crew, f.flight_id
FROM Flight f
	LEFT JOIN CrewOnFlight cof
	ON f.flight_id = cof.flight
-- 19. Flights whether they have a rating or not
SELECT fb.feedback_id, f.flight_id, fb.rating
FROM Flight f
	LEFT JOIN Feedback fb
	ON f.flight_id = fb.flight
-- 20. Crew Roles whether there is a crew matching that role or not
SELECT c.crew_id, c.crew_name, cr.role_name
FROM CrewRole cr
	LEFT JOIN Crew c
	ON cr.role_id = c.crew_role


-------------------------------RIGHT JOIN------------------------------------------
-- 1. All passengers with or without baggage
SELECT b.baggage_id, b.baggage_detail, p.passenger_name
FROM Baggage b
	RIGHT JOIN Passenger p
	ON p.passenger_id = b.passenger
-- 2. All flights with or without baggage
SELECT b.baggage_id, b.baggage_detail, f.flight_id
FROM Baggage b
	RIGHT JOIN Flight f
	ON f.flight_id = b.flight
-- 3. Aircrafts with or without flights
SELECT a.aircraft_id, a.aircraft_name, f.flight_id
FROM Flight f
	RIGHT JOIN Aircraft a
	ON a.aircraft_id = f.aircraft
-- 4. Airports with or without departures
SELECT a.airport_id, a.airport_name, f.flight_id AS flight_departure_id
FROM Flight f
	RIGHT JOIN Airport a
	ON a.airport_id = f.flight_departure_airport
-- 5. Airports with or without arrivals
SELECT a.airport_id, a.airport_name, f.flight_id AS flight_arrival_id
FROM Flight f
	RIGHT JOIN Airport a
	ON a.airport_id = f.flight_arrival_airport
-- 6. Passengers with or without feedback
SELECT p.passenger_id, p.passenger_name, f.feedback_id, f.complete_feedback
FROM Feedback f
	RIGHT JOIN Passenger p
	ON p.passenger_id = f.passenger
-- 7. Passengers with or without rating
SELECT p.passenger_id, p.passenger_name, f.rating
FROM Feedback f
	RIGHT JOIN Passenger p
	ON p.passenger_id = f.passenger
-- 8. Crew with a flight or without a flight
SELECT c.crew_id, c.crew_name, cof.flight
FROM CrewOnFlight cof
	RIGHT JOIN Crew c
	ON c.crew_id = cof.crew
-- 9. All passengers with or without a reservation
SELECT r.reservation_id, p.passenger_name
FROM Reservation r
	RIGHT JOIN Passenger p
	ON p.passenger_id = r.passenger
-- 10. Country with or without a city in City table
SELECT ci.city_name, co.country_name
FROM City ci
	RIGHT JOIN Country co
	ON co.country_id = ci.country
-- 11. Response whether it is in feedback or not
SELECT f.feedback_id, f.complete_feedback, f.passenger, r.response_detail
FROM Feedback f
	RIGHT JOIN Response r
	ON r.response_id = f.response
-- 12. Flights whether they have a feedback or not
SELECT fb.feedback_id, fb.complete_feedback, f.flight_id
FROM Feedback fb
	RIGHT JOIN Flight f
	ON f.flight_id = fb.flight
-- 13. City whether it has an airport or not
SELECT a.airport_id, a.airport_name, c.city_name
FROM Airport a
	RIGHT JOIN City c
	ON c.city_id = a.airport_id
-- 14. Class whether it has a seat or not
SELECT s.seat_id, s.seat_name, c.class_name
FROM Seat s
	RIGHT JOIN Class c
	ON c.class_id = s.class
-- 15. Reservations whether payment of it has been made or not 
SELECT r.reservation_id, p.amount
FROM Payment p
	RIGHT JOIN Reservation r
	ON r.reservation_id = p.reservation
-- 16. Class whether there is any reservation of it or not
SELECT r.reservation_id, c.class_name
FROM Reservation r
	RIGHT JOIN Class c
	ON c.class_id = r.class
-- 17. Seat whether there is any reservation of it or not
SELECT r.reservation_id, s.seat_id, s.seat_name
FROM Reservation r
	RIGHT JOIN Seat s
	ON s.seat_id = r.seat
-- 18. Flight whether it has any crew as of now or not
SELECT cof.crew, f.flight_id
FROM CrewOnFlight cof
	RIGHT JOIN Flight f
	ON f.flight_id = cof.flight
-- 19. Flights whether they have a rating or not
SELECT fb.feedback_id, f.flight_id, fb.rating
FROM Feedback fb
	RIGHT JOIN Flight f
	ON f.flight_id = fb.flight
-- 20. Crew Roles whether there is a crew matching that role or not
SELECT c.crew_id, c.crew_name, cr.role_name
FROM Crew c
	RIGHT JOIN CrewRole cr
	ON cr.role_id = c.crew_role


-----------------------------FULL OUTER JOIN-----------------------------------------
-- 1. All passengers and baggage
SELECT b.baggage_id, b.baggage_detail, p.passenger_name
FROM Passenger p
	FULL OUTER JOIN Baggage b
	ON p.passenger_id = b.passenger
-- 2. All flights and baggage
SELECT b.baggage_id, b.baggage_detail, f.flight_id
FROM Flight f
	FULL OUTER JOIN Baggage b
	ON f.flight_id = b.flight
-- 3. All aircrafts and flights
SELECT a.aircraft_id, a.aircraft_name, f.flight_id
FROM Aircraft a
	FULL OUTER JOIN Flight f
	ON a.aircraft_id = f.aircraft
-- 4. All airports and flights (with its departure)
SELECT a.airport_id, a.airport_name, f.flight_id AS flight_departure_id
FROM Airport a
	FULL OUTER JOIN Flight f
	ON a.airport_id = f.flight_departure_airport
-- 5. All airports and flights (with its arrival)
SELECT a.airport_id, a.airport_name, f.flight_id AS flight_arrival_id
FROM Airport a
	FULL OUTER JOIN Flight f
	ON a.airport_id = f.flight_arrival_airport
-- 6. All feedbacks and passengers with their complete feedback
SELECT p.passenger_id, p.passenger_name, f.feedback_id, f.complete_feedback
FROM Passenger p
	FULL OUTER JOIN Feedback f
	ON p.passenger_id = f.passenger
-- 7. All feedbacks and passengers with their ratings
SELECT p.passenger_id, p.passenger_name, f.rating
FROM Passenger p
	FULL OUTER JOIN Feedback f
	ON p.passenger_id = f.passenger
-- 8. All crew and flights
SELECT c.crew_id, c.crew_name, cof.flight
FROM Crew c
	FULL OUTER JOIN CrewOnFlight cof
	ON c.crew_id = cof.crew
-- 9. All passengers and reservations
SELECT r.reservation_id, p.passenger_name
FROM Passenger p
	FULL OUTER JOIN Reservation r
	ON p.passenger_id = r.passenger
-- 10. All cities and countries
SELECT ci.city_name, co.country_name
FROM Country co
	FULL OUTER JOIN City ci
	ON co.country_id = ci.country
-- 11. All response and feedbacks
SELECT f.feedback_id, f.complete_feedback, f.passenger, r.response_detail
FROM Response r
	FULL OUTER JOIN Feedback f
	ON r.response_id = f.response
-- 12. All feedbacks and flight their complete feedback
SELECT fb.feedback_id, fb.complete_feedback, f.flight_id
FROM Flight f
	FULL OUTER JOIN Feedback fb
	ON f.flight_id = fb.flight
-- 13. All cities and airports
SELECT a.airport_id, a.airport_name, c.city_name
FROM City c
	FULL OUTER JOIN Airport a
	ON c.city_id = a.airport_id
-- 14. All classes and seats
SELECT s.seat_id, s.seat_name, c.class_name
FROM Class c
	FULL OUTER JOIN Seat s
	ON c.class_id = s.class
-- 15. All reservations and payments
SELECT r.reservation_id, p.amount
FROM Reservation r
	FULL OUTER JOIN Payment p
	ON r.reservation_id = p.reservation
-- 16. All classes and reservations
SELECT r.reservation_id, c.class_name
FROM Class c
	FULL OUTER JOIN Reservation r
	ON c.class_id = r.class
-- 17. All seats and reservations
SELECT r.reservation_id, s.seat_id, s.seat_name
FROM Seat s
	FULL OUTER JOIN Reservation r
	ON s.seat_id = r.seat
-- 18. All flights and crew in CrewOnFlight table
SELECT cof.crew, f.flight_id
FROM Flight f
	FULL OUTER JOIN CrewOnFlight cof
	ON f.flight_id = cof.flight
-- 19. All feedbacks and flights with their ratings
SELECT fb.feedback_id, f.flight_id, fb.rating
FROM Flight f
	FULL OUTER JOIN Feedback fb
	ON f.flight_id = fb.flight
-- 20. All crew and crew roles
SELECT c.crew_id, c.crew_name, cr.role_name
FROM CrewRole cr
	FULL OUTER JOIN Crew c
	ON cr.role_id = c.crew_role


----------------------Stored Procedures without parameter--------------------------
-- 1. Stored Procedure to view crew table
GO
CREATE PROCEDURE view_crew_table
AS
BEGIN
	SELECT *
	FROM Crew
END
EXEC view_crew_table
-- 2. Stored Procedure to view aircraft table
GO
CREATE PROCEDURE view_aircraft_table
AS
BEGIN
	SELECT *
	FROM Aircraft
END
EXEC view_aircraft_table
-- 3. Stored Procedure to view passenger table
GO
CREATE PROCEDURE view_passenger_table
AS
BEGIN
	SELECT *
	FROM Passenger
END
EXEC view_passenger_table
-- 4. Stored Procedure to view airport table
GO
CREATE PROCEDURE view_airport_table
AS
BEGIN
	SELECT *
	FROM Airport
END
EXEC view_airport_table
-- 5. Stored Procedure to view baggage table
GO
CREATE PROCEDURE view_baggage_table
AS
BEGIN
	SELECT *
	FROM Baggage
END
EXEC view_baggage_table
-- 6. Stored Procedure to view city table
GO
CREATE PROCEDURE view_city_table
AS
BEGIN
	SELECT *
	FROM City
END
EXEC view_city_table
-- 7. Stored Procedure to view class table
GO
CREATE PROCEDURE view_class_table
AS
BEGIN
	SELECT *
	FROM Class
END
EXEC view_class_table
-- 8. Stored Procedure to view country table
GO
CREATE PROCEDURE view_country_table
AS
BEGIN
	SELECT *
	FROM Country
END
EXEC view_country_table
-- 9. Stored Procedure to view crew on flight table
GO
CREATE PROCEDURE view_crew_on_flight_table
AS
BEGIN
	SELECT *
	FROM CrewOnFlight
END
EXEC view_crew_on_flight_table
-- 10. Stored Procedure to view crew role table
GO
CREATE PROCEDURE view_crew_role_table
AS
BEGIN
	SELECT *
	FROM CrewRole
END
EXEC view_crew_role_table
-- 11. Stored Procedure to view feedback table
GO
CREATE PROCEDURE view_feedback_table
AS
BEGIN
	SELECT *
	FROM Feedback
END
EXEC view_feedback_table
-- 12. Stored Procedure to view flight table
GO
CREATE PROCEDURE view_flight_table
AS
BEGIN
	SELECT *
	FROM Flight
END
EXEC view_flight_table
-- 13. Stored Procedure to view payment table
GO
CREATE PROCEDURE view_payment_table
AS
BEGIN
	SELECT *
	FROM Payment
END
EXEC view_payment_table
-- 14. Stored Procedure to view reservation table
GO
CREATE PROCEDURE view_reservation_table
AS
BEGIN
	SELECT *
	FROM Reservation
END
EXEC view_reservation_table
-- 15. Stored Procedure to view response table
GO
CREATE PROCEDURE view_response_table
AS
BEGIN
	SELECT *
	FROM Response
END
EXEC view_response_table
-- 16. Stored Procedure to view seat table
GO
CREATE PROCEDURE view_seat_table
AS
BEGIN
	SELECT *
	FROM Seat
END
EXEC view_seat_table
-- 17. Stored Procedure to view city with country name
GO
CREATE PROCEDURE view_city_with_country_name
AS
BEGIN
	SELECT ci.city_id, ci.city_name, co.country_name
	FROM City ci
		INNER JOIN Country co
		ON co.country_id = ci.country
END
EXEC view_city_with_country_name
-- 18. Stored Procedure to view airport with city name
GO
CREATE PROCEDURE view_airport_with_city_name
AS
BEGIN
	SELECT a.airport_id, a.airport_name, c.city_name
	FROM Airport a
		INNER JOIN City c
		ON c.city_id = a.city
END
EXEC view_airport_with_city_name
-- 19. Stored Procedure to view reservation with passenger name
GO
CREATE PROCEDURE view_reservation_with_passenger_name
AS
BEGIN
	SELECT r.reservation_id, p.passenger_name, r.reservation_datetime
	FROM Reservation r
		INNER JOIN Passenger p
		ON p.passenger_id = r.passenger
END
EXEC view_reservation_with_passenger_name
-- 20. Stored Procedure to view reservation with seat name
GO
CREATE PROCEDURE view_reservation_with_seat_name
AS
BEGIN
	SELECT r.reservation_id, s.seat_name, r.flight, r.reservation_datetime
	FROM Reservation r
		INNER JOIN Seat s
		ON s.seat_id = r.seat
END
EXEC view_reservation_with_passenger_name
-- 21. Stored Procedure to view feedback with passenger name
GO
CREATE PROCEDURE feedback_with_passenger_name
AS
BEGIN
	SELECT f.feedback_id, f.complete_feedback, f.passenger, p.passenger_name
	FROM Feedback f
		INNER JOIN Passenger p
		ON p.passenger_id = f.passenger
END
EXEC feedback_with_passenger_name
-- 22. Stored Procedure to view flight with aircraft name
GO
CREATE PROCEDURE flight_with_aircraft_name
AS
BEGIN
	SELECT f.flight_id, a.aircraft_name, f.flight_departure_datetime, f.flight_arrival_datetime
	FROM Flight f
		INNER JOIN Aircraft a
		ON a.aircraft_id = f.aircraft
END
EXEC flight_with_aircraft_name
-- 23. Stored Procedure to view baggage with passenger name
GO
CREATE PROCEDURE baggage_with_passenger_name
AS
BEGIN
	SELECT b.baggage_id, b.baggage_detail, b.passenger, p.passenger_name
	FROM Baggage b
		INNER JOIN Passenger p
		ON p.passenger_id = b.passenger
END
EXEC feedback_with_passenger_name
-- 24. Stored Procedure to view feedback with response
GO
CREATE PROCEDURE feedback_with_response
AS
BEGIN
	SELECT f.feedback_id, f.complete_feedback, f.flight, f.passenger, r.response_detail
	FROM Feedback f
		INNER JOIN Response r
		ON r.response_id = f.response
END
EXEC feedback_with_passenger_name
-- 25. Stored Procedure to view airport with city and country name
GO
CREATE PROCEDURE airport_with_city_and_country_name
AS
BEGIN
	SELECT a.airport_id, a.airport_name, c.city_name, co.country_name
	FROM Airport a
		INNER JOIN City c
		ON c.city_id = a.city
		INNER JOIN Country co
		ON co.country_id = c.country
END
EXEC airport_with_city_and_country_name


------------------------Stored Procedures with parameter--------------------------
-- 1. Stored Procedure to view city by giving its id
GO
CREATE PROCEDURE specific_city_id
	@c_id int
AS
BEGIN
	SELECT *
	FROM City
	WHERE city_id = @c_id
END
EXEC specific_city_id 2
-- 2. Stored Procedure to view city by giving its name
GO
CREATE PROCEDURE specific_city_name
	@c_name varchar(100)
AS
BEGIN
	SELECT *
	FROM City
	WHERE city_name = @c_name
END
EXEC specific_city_name 'Lahore'
-- 3. Stored Procedure to view country by giving its id
GO
CREATE PROCEDURE specific_country_id
	@c_id int
AS
BEGIN
	SELECT *
	FROM Country
	WHERE country_id = @c_id
END
EXEC specific_country_id 2
-- 4. Stored Procedure to view country by giving its name
GO
CREATE PROCEDURE specific_country_name
	@c_name varchar(100)
AS
BEGIN
	SELECT *
	FROM Country
	WHERE country_name = @c_name
END
EXEC specific_country_name 'Pakistan'
-- 5. Stored Procedure to view baggage by giving passenger id
GO
CREATE PROCEDURE baggage_of_passenger
	@p_id int
AS
BEGIN
	SELECT *
	FROM Baggage
	WHERE passenger = @p_id
END
EXEC baggage_of_passenger 20
-- 6. Stored Procedure to view specific flight using flight id
GO
CREATE PROCEDURE specific_flight_id
	@f_id int
AS
BEGIN
	SELECT *
	FROM Flight
	WHERE flight_id = @f_id
END
EXEC specific_flight_id 5
-- 7. Stored Procedure to view baggage by giving flight id
GO
CREATE PROCEDURE baggage_of_flight
	@f_id int
AS
BEGIN
	SELECT *
	FROM Baggage
	WHERE flight = @f_id
END
EXEC baggages_of_flight 1
-- 8. Stored Procedure to view specific flight using departure airport id
GO
CREATE PROCEDURE flight_departure_airport
	@fd_id int
AS
BEGIN
	SELECT *
	FROM Flight
	WHERE flight_departure_airport = @fd_id
END
EXEC flight_departure_airport 20
-- 9. Stored Procedure to view specific flight using flight arrival airport id
GO
CREATE PROCEDURE flight_arrival_airport
	@fa_id int
AS
BEGIN
	SELECT *
	FROM Flight
	WHERE flight_arrival_airport = @fa_id
END
EXEC flight_arrival_airport 30
-- 10. Stored Procedure to view specific flights of a aircraft using aircraft id
GO
CREATE PROCEDURE flights_of_aircraft
	@a_id int
AS
BEGIN
	SELECT *
	FROM Flight
	WHERE aircraft = @a_id
END
EXEC flights_of_aircraft 2
-- 11. Stored Procedure to view specific aircraft using aircraft id
GO
CREATE PROCEDURE specific_aircraft_id
	@a_id int
AS
BEGIN
	SELECT *
	FROM Aircraft a
	WHERE aircraft_id = @a_id
END
EXEC specific_aircraft_id 2
-- 12. Stored Procedure to view specific aircraft using aircraft name
GO
CREATE PROCEDURE specific_aircraft_name
	@a_name varchar(50)
AS
BEGIN
	SELECT *
	FROM Aircraft
	WHERE aircraft_name = @a_name
END
EXEC specific_aircraft_name 'Airbus A320'
-- 13. Stored Procedure to view specific airport using airport id
GO
CREATE PROCEDURE specific_airport_id
	@a_id int
AS
BEGIN
	SELECT *
	FROM Airport
	WHERE airport_id = @a_id
END
EXEC specific_airport_id 3
-- 14. Stored Procedure to view specific airport of a city
GO
CREATE PROCEDURE specific_city_airport_id
	@c_id int
AS
BEGIN
	SELECT *
	FROM Airport
	WHERE city = @c_id
END
EXEC specific_city_airport_id 4
-- 15. Stored Procedure to view specific airport using its name
GO
CREATE PROCEDURE specific_airport_name
	@a_name varchar(300)
AS
BEGIN
	SELECT *
	FROM Airport
	WHERE airport_name = @a_name
END
EXEC specific_airport_name 'Iqbal Airport'

-- 16. Stored Procedure to view specific crew using crew id
GO
CREATE PROCEDURE specific_crew_id
	@c_id int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_id = @c_id
END
EXEC specific_crew_id 5
-- 17. Stored Procedure to view specific crew using crew name
GO
CREATE PROCEDURE specific_crew_name
	@c_name varchar(100)
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_name = @c_name
END
EXEC specific_crew_name 'Ahmed Malik'
-- 18. Stored Procedure to view specific crew using crew role id
GO
CREATE PROCEDURE specific_crew_role
	@cr_id int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_role = @cr_id
END
EXEC specific_crew_role 6
-- 19. Stored Procedure to view specific crew using crew email
GO
CREATE PROCEDURE specific_crew_email
	@c_email varchar(150)
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_email = @c_email
END
EXEC specific_crew_email 'zahid.ali@yahoo.com'
-- 20. Stored Procedure to view specific crew using crew gender
GO
CREATE PROCEDURE specific_crew_gender
	@c_gender varchar(1)
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_gender = @c_gender
END
EXEC specific_crew_gender 'O'
-- 21. Stored Procedure to view crew on a specific flight
GO
CREATE PROCEDURE specific_flight_crew
	@f_id int
AS
BEGIN
	SELECT *
	FROM CrewOnFlight
	WHERE flight = @f_id
END
EXEC specific_flight_crew 5
-- 22. Stored Procedure to crew's flights
GO
CREATE PROCEDURE specific_crew_flight
	@c_id int
AS
BEGIN
	SELECT *
	FROM CrewOnFlight
	WHERE crew = @c_id
END
EXEC specific_crew_flight 14
-- 23. Stored Procedure to view passenger's feedback using passenger id
GO
CREATE PROCEDURE passenger_feedback
	@p_id int
AS
BEGIN
	SELECT *
	FROM Feedback
	WHERE passenger = @p_id
END
EXEC passenger_feedback 6
-- 24. Stored Procedure to view feedback using flight id
GO
CREATE PROCEDURE flight_feedback
	@f_id int
AS
BEGIN
	SELECT *
	FROM Feedback
	WHERE flight = @f_id
END
EXEC flight_feedback 1
-- 25. Stored Procedure to view feedback using response id
GO
CREATE PROCEDURE response_feedback
	@r_id int
AS
BEGIN
	SELECT *
	FROM Feedback
	WHERE response = @r_id
END
EXEC response_feedback 3


-------Stored Procedures with parameter using logical Operators and Group by------
-- 1. Stored Procedure to view crew with a specified gender and role
GO
CREATE PROCEDURE crew_gender_and_role
	@gender varchar(1),
	@r_id int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_gender = @gender AND crew_role = @r_id
END
EXEC crew_gender_and_role 'M', 1
-- 2. Stored Procedure to get crew in a salary range
GO
CREATE PROCEDURE crew_salary_range
	@min_salary int,
	@max_salary int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_salary >= @min_salary AND crew_salary <= @max_salary
END
EXEC crew_salary_range 50000, 100000
-- 3. Stored Procedure to get rew with a specific role or lives in a particular city
GO
CREATE PROCEDURE crew_role_or_city
	@role int,
	@city varchar(100)
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_role = @role OR crew_address LIKE ('%' + @city + '%')
END
EXEC crew_role_or_city 5, 'Lahore'
-- 4. Stored Procedure to get crew with a specific email host or having salary less than a specific amount
GO
CREATE PROCEDURE crew_email_or_salary
	@email_host varchar(20),
	@salary int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_email LIKE ('%' + @email_host + '%') OR crew_salary < @salary
END
EXEC crew_email_or_salary 'yahoo', 50000
-- 5. Stored Procedure to exclude two roles from crew table
GO
CREATE PROCEDURE exclude_roles
	@role_one int,
	@role_two int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_role NOT IN (@role_one, @role_two)
END
EXEC exclude_roles 4, 7
-- 6. Stored Procedure to exclude three roles from crew table
GO
CREATE PROCEDURE exclude_three_roles
	@role_one int,
	@role_two int,
	@role_three int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_role NOT IN (@role_one, @role_two, @role_three)
END
EXEC exclude_three_roles 4, 5, 7
-- 7. Stored Procedure to exclude two flights from flight table
GO
CREATE PROCEDURE exclude_flights
	@flight_one int,
	@flight_two int
AS
BEGIN
	SELECT *
	FROM Flight
	WHERE flight_id NOT IN (@flight_one, @flight_two)
END
EXEC exclude_flights 2,4
-- 8. Stored Procedure to exclude salary from a range
GO
CREATE PROCEDURE exclude_salary_range
	@s1 int,
	@s2 int
AS
BEGIN
	SELECT *
	FROM Crew
	WHERE crew_salary  NOT BETWEEN @s1 AND @s2
END
EXEC exclude_salary_range 50000, 80000
-- 9. Stored Procedure to set passengers with specific email host and gender
GO
CREATE PROCEDURE passenger_email_host_and_gender
	@e_host varchar(20),
	@gender varchar(1)
AS
BEGIN
	SELECT *
	FROM Passenger
	WHERE passenger_gender = @gender AND passenger_email LIKE ('%' + @e_host + '%')
END
EXEC passenger_email_host_and_gender 'google', 'M'
-- 10. Stored Procedure to set passengers with specific email host or gender
GO
CREATE PROCEDURE passenger_email_host_or_gender
	@e_host varchar(20),
	@gender varchar(1)
AS
BEGIN
	SELECT *
	FROM Passenger
	WHERE passenger_gender = @gender OR passenger_email LIKE ('%' + @e_host + '%')
END
EXEC passenger_email_host_or_gender 'google', 'M'
-- 11. Stored Procedure to get total salary of a specified role
GO
CREATE PROCEDURE total_salary_of_role
	@r_id int
AS
BEGIN
	SELECT crew_role, SUM(crew_salary) AS total_salary
	FROM Crew
	WHERE crew_role = @r_id
	GROUP BY crew_role
END
EXEC total_salary_of_role 5
-- 12. Stored Procedure to get total salary of a specified gender
GO
CREATE PROCEDURE total_salary_of_gender
	@gender varchar(1)
AS
BEGIN
	SELECT crew_gender, SUM(crew_salary) AS total_salary
	FROM Crew
	WHERE crew_gender = @gender
	GROUP BY crew_gender
END
EXEC total_salary_of_gender 'M'
-- 13. Stored Procedure to get total passengers wrt to pass
GO
CREATE PROCEDURE total_passengers_wrt_gender
	@gender varchar(1)
AS
BEGIN
	SELECT passenger_gender, COUNT(*) AS total_passengers
	FROM Passenger
	WHERE passenger_gender = @gender
	GROUP BY passenger_gender
END
EXEC total_passengers_wrt_gender 'M'
-- 14. Stored Procedure to get reservations of a specific class
GO
CREATE PROCEDURE total_class_reservations
	@class int
AS
BEGIN
	SELECT class, COUNT(*) AS total_reservations
	FROM Reservation
	WHERE class = @class
	GROUP BY class
END
EXEC total_class_reservations 2
-- 15. Stored Procedure to get total crew on a flight
GO
CREATE PROCEDURE total_flight_crew
	@f_id int
AS
BEGIN
	SELECT flight, COUNT(*) AS total_crew
	FROM CrewOnFlight
	WHERE flight = @f_id
	GROUP BY flight
END
EXEC total_flight_crew 1
-- 16. Stored Procedure to get total flights of a crew
GO
CREATE PROCEDURE total_crew_flights
	@c_id int
AS
BEGIN
	SELECT crew, COUNT(*) AS total_flights
	FROM CrewOnFlight
	WHERE crew = @c_id
	GROUP BY crew
END
EXEC total_crew_flights 14
-- 17. Stored Procedure to get total cities of a country
GO
CREATE PROCEDURE total_cities_of_country
	@c_id int
AS
BEGIN
	SELECT country, COUNT(*) AS total_cities
	FROM City
	WHERE country = @c_id
	GROUP BY country
END
EXEC total_cities_of_country 5
-- 18. Stored Procedure to get total airports of a city
GO
CREATE PROCEDURE total_airports_of_city
	@c_id int
AS
BEGIN
	SELECT city, COUNT(*) AS total_airports
	FROM Airport
	WHERE city = @c_id
	GROUP BY city
END
EXEC total_airports_of_city 5
-- 19. Stored Procedure to get total baggages of a passenger
GO
CREATE PROCEDURE total_baggages_of_a_passenger
	@p_id int
AS
BEGIN
	SELECT passenger, COUNT(*) AS total_baggages
	FROM Baggage
	WHERE passenger = @p_id
	GROUP BY passenger
END
EXEC total_baggages_of_a_passenger 20
-- 20. Stored Procedure to get total feedbacks of a flight
GO
CREATE PROCEDURE total_feedbacks_of_a_flight
	@f_id int
AS
BEGIN
	SELECT flight, COUNT(*) AS total_feedbacks
	FROM Feedback
	WHERE flight = @f_id
	GROUP BY flight
END
EXEC total_feedbacks_of_a_flight 2
-- 21. Stored Procedure to get total salary of a specified role where crew id is greater than 5
GO
CREATE PROCEDURE total_salary_of_role_cid_gt_five
	@r_id int
AS
BEGIN
	SELECT crew_role, SUM(crew_salary) AS total_salary
	FROM Crew
	WHERE crew_role = @r_id AND crew_id > 5
	GROUP BY crew_role
END
EXEC total_salary_of_role_cid_gt_five 6
-- 22. Stored Procedure to get total salary of a specified gender having a specfic role
GO
CREATE PROCEDURE total_salary_of_gender_specific_role
	@gender varchar(1),
	@r_id int
AS
BEGIN
	SELECT crew_gender, SUM(crew_salary) AS total_salary
	FROM Crew
	WHERE crew_gender = @gender AND crew_role = @r_id
	GROUP BY crew_gender
END
EXEC total_salary_of_gender_specific_role 'M', 1
-- 23. Stored Procedure to get total passengers wrt to passenger gender and those having a specific email host
GO
CREATE PROCEDURE total_passengers_wrt_gender_with_email_host
	@gender varchar(1),
	@e_host varchar(20)
AS
BEGIN
	SELECT passenger_gender, COUNT(*) AS total_passengers
	FROM Passenger
	WHERE passenger_gender = @gender AND passenger_email LIKE ('%' + @e_host + '%')
	GROUP BY passenger_gender
END
EXEC total_passengers_wrt_gender_with_email_host 'M', 'yahoo'
-- 24. Stored Procedure to get reservations of a specific class in a flight
GO
CREATE PROCEDURE total_class_reservations_of_a_flight
	@c_id int,
	@f_id int
AS
BEGIN
	SELECT class, COUNT(*) AS total_reservations
	FROM Reservation
	WHERE class = @c_id AND flight = @f_id
	GROUP BY class
END
EXEC total_class_reservations_of_a_flight 2, 3
-- 25. Stored Procedure to get total crew on a flight where crew id should be greater than 3
GO
CREATE PROCEDURE total_flight_crew_excluding_also
	@f_id int
AS
BEGIN
	SELECT flight, COUNT(*) AS total_crew
	FROM CrewOnFlight
	WHERE flight = @f_id AND crew > 3
	GROUP BY flight
END
EXEC total_flight_crew_excluding_also 1
-- 26. Stored Procedure to get total flights of a crew excluding flight 1
GO
CREATE PROCEDURE total_crew_flights_excluding_one_flight
	@c_id int
AS
BEGIN
	SELECT crew, COUNT(*) AS total_flights
	FROM CrewOnFlight
	WHERE crew = @c_id AND flight > 1
	GROUP BY crew
END
EXEC total_crew_flights_excluding_one_flight 14
-- 27. Stored Procedure to get total cities of a country and excluding cities with city id 2, 5 and 7
GO
CREATE PROCEDURE total_cities_of_country_excluding_also
	@c_id int
AS
BEGIN
	SELECT country, COUNT(*) AS total_cities
	FROM City
	WHERE country = @c_id AND city_id NOT IN (2, 5, 7)
	GROUP BY country
END
EXEC total_cities_of_country_excluding_also 5
-- 28. Stored Procedure to get total airports of a city and excluding airports with id 1, 5 and 8
GO
CREATE PROCEDURE total_airports_of_city_excluding
	@c_id int
AS
BEGIN
	SELECT city, COUNT(*) AS total_airports
	FROM Airport
	WHERE city = @c_id AND airport_id NOT IN (1, 5, 8)
	GROUP BY city
END
EXEC total_airports_of_city_excluding 6
-- 29. Stored Procedure to get total baggage of a passenger where flight id is greater than 2
GO
CREATE PROCEDURE total_baggages_of_a_passenger_fgt_two
	@p_id int
AS
BEGIN
	SELECT passenger, COUNT(*) AS total_baggages
	FROM Baggage
	WHERE passenger = @p_id AND flight > 2
	GROUP BY passenger
END
EXEC total_baggages_of_a_passenger_fgt_two 58
-- 30. Stored Procedure to get total considered feedbacks of a flight
GO
CREATE PROCEDURE total_considered_feedbacks_of_a_flight
	@f_id int
AS
BEGIN
	SELECT flight, COUNT(*) AS total_feedbacks
	FROM Feedback
	WHERE flight = @f_id AND response = 3
	GROUP BY flight
END
EXEC total_feedbacks_of_a_flight 1


------------------------------DML Triggers INSERT----------------------------------
-- 1. Trigger when a row is inserted in Aircraft table
GO
CREATE TRIGGER trigger_insert_aircraft
ON Aircraft
FOR INSERT
AS BEGIN
	DECLARE @a_id int
	SELECT @a_id = aircraft_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Aircraft Id ' + CAST(@a_id AS varchar(5)) + ' has been inserted in Aircraft table.', 'Insert', 'Aircraft')
END
-- 2. Trigger when a row is inserted in Airport table
GO
CREATE TRIGGER trigger_insert_airport
ON Airport
FOR INSERT
AS BEGIN
	DECLARE @a_id int
	SELECT @a_id = airport_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Airport Id ' + CAST(@a_id AS varchar(5)) + ' has been inserted in Airport table.', 'Insert', 'Airport')
END
-- 3. Trigger when a row is inserted in Baggage table
GO
CREATE TRIGGER trigger_insert_baggage
ON Baggage
FOR INSERT
AS BEGIN
	DECLARE @b_id int
	SELECT @b_id = baggage_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Baggage Id ' + CAST(@b_id AS varchar(5)) + ' has been inserted in Baggage table.', 'Insert', 'Baggage')
END
-- 4. Trigger when a row is inserted in City table
GO
CREATE TRIGGER trigger_insert_city
ON City
FOR INSERT
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = city_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('City Id ' + CAST(@c_id AS varchar(5)) + ' has been inserted in City table.', 'Insert', 'City')
END
-- 5. Trigger when a row is inserted in Class table
GO
CREATE TRIGGER trigger_insert_class
ON Class
FOR INSERT
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = class_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Class Id ' + CAST(@c_id AS varchar(5)) + ' has been inserted in Class table.', 'Insert', 'Class')
END
-- 6. Trigger when a row is inserted in Country table
GO
CREATE TRIGGER trigger_insert_country
ON Country
FOR INSERT
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = country_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Country Id ' + CAST(@c_id AS varchar(5)) + ' has been inserted in Country table.', 'Insert', 'Country')
END
-- 7. Trigger when a row is inserted in Crew table
GO
CREATE TRIGGER trigger_insert_crew
ON Crew
FOR INSERT
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = crew_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Crew Id ' + CAST(@c_id AS varchar(5)) + ' has been inserted in Crew table.', 'Insert', 'Crew')
END
-- 8. Trigger when a row is inserted in CrewOnFlight table
GO
CREATE TRIGGER trigger_insert_crew_on_flight
ON CrewOnFlight
FOR INSERT
AS BEGIN
	DECLARE @t_id int
	SELECT @t_id = table_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Table Id ' + CAST(@t_id AS varchar(5)) + ' has been inserted in CrewOnFlight table.', 'Insert', 'CrewOnFlight')
END
-- 9. Trigger when a row is inserted in CrewRole table
GO
CREATE TRIGGER trigger_insert_crew_role
ON CrewRole
FOR INSERT
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = role_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('CrewRole Id ' + CAST(@r_id AS varchar(5)) + ' has been inserted in CrewRole table.', 'Insert', 'CrewRole')
END
-- 10. Trigger when a row is inserted in Feedback table
GO
CREATE TRIGGER trigger_insert_feedback
ON Feedback
FOR INSERT
AS BEGIN
	DECLARE @f_id int
	SELECT @f_id = feedback_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Feedback Id ' + CAST(@f_id AS varchar(5)) + ' has been inserted in Feedback table.', 'Insert', 'Feedback')
END
-- 11. Trigger when a row is inserted in Flight table
GO
CREATE TRIGGER trigger_insert_flight
ON Flight
FOR INSERT
AS BEGIN
	DECLARE @f_id int
	SELECT @f_id = flight_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Flight Id ' + CAST(@f_id AS varchar(5)) + ' has been inserted in Flight table.', 'Insert', 'Flight')
END
-- 12. Trigger when a row is inserted in Passenger table
GO
CREATE TRIGGER trigger_insert_passenger
ON Passenger
FOR INSERT
AS BEGIN
	DECLARE @p_id int
	SELECT @p_id = passenger_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Passenger Id ' + CAST(@p_id AS varchar(5)) + ' has been inserted in Passenger table.', 'Insert', 'Passenger')
END
-- 13. Trigger when a row is inserted in Payment table
GO
CREATE TRIGGER trigger_insert_payment
ON Payment
FOR INSERT
AS BEGIN
	DECLARE @p_id int
	SELECT @p_id = payment_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Payment Id ' + CAST(@p_id AS varchar(5)) + ' has been inserted in Payment table.', 'Insert', 'Payment')
END
-- 14. Trigger when a row is inserted in Reservation table
GO
CREATE TRIGGER trigger_insert_reservation
ON Reservation
FOR INSERT
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = reservation_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Reservation Id ' + CAST(@r_id AS varchar(5)) + ' has been inserted in Reservation table.', 'Insert', 'Reservation')
END
-- 15. Trigger when a row is inserted in Response table
GO
CREATE TRIGGER trigger_insert_response
ON Response
FOR INSERT
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = response_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Response Id ' + CAST(@r_id AS varchar(5)) + ' has been inserted in Response table.', 'Insert', 'Response')
END
-- 16. Trigger when a row is inserted in Seat table
GO
CREATE TRIGGER trigger_insert_Seat
ON Seat
FOR INSERT
AS BEGIN
	DECLARE @s_id int
	SELECT @s_id = seat_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Seat Id ' + CAST(@s_id AS varchar(5)) + ' has been inserted in Seat table.', 'Insert', 'Seat')
END
-- 17. Trigger when a row is inserted in Aircraft table with trigger message also displaying aircraft name
GO
CREATE TRIGGER trigger_insert_aircraft_with_name
ON Aircraft
FOR INSERT
AS BEGIN
	DECLARE @a_id int, @a_name varchar(50)
	SELECT @a_id = aircraft_id, @a_name = aircraft_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Aircraft Id ' + CAST(@a_id AS varchar(5)) + ' of name ' + @a_name + ' has been inserted in Aircraft table.', 'Insert', 'Aircraft')
END
-- 18. Trigger when a row is inserted in city table with trigger message also displaying city name
GO
CREATE TRIGGER trigger_insert_city_with_name
ON City
FOR INSERT
AS BEGIN
	DECLARE @c_id int, @c_name varchar(100)
	SELECT @c_id = city_id, @c_name = city_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('City Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been inserted in City table.', 'Insert', 'City')
END
-- 19. Trigger when a row is inserted in Country table with trigger message also displaying country name
GO
CREATE TRIGGER trigger_insert_country_with_name
ON Country
FOR INSERT
AS BEGIN
	DECLARE @c_id int, @c_name varchar(100)
	SELECT @c_id = country_id, @c_name = country_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Country Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been inserted in Country table.', 'Insert', 'Country')
END
-- 20. Trigger when a row is inserted in Class table with trigger message also displaying class name
GO
CREATE TRIGGER trigger_insert_class_with_name
ON Class
FOR INSERT
AS BEGIN
	DECLARE @c_id int, @c_name varchar(20)
	SELECT @c_id = class_id, @c_name = class_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Class Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been inserted in Class table.', 'Insert', 'Class')
END


------------------------------DML Triggers UPDATE----------------------------------
-- 1. Trigger when a row is updated in Aircraft table
GO
CREATE TRIGGER trigger_update_aircraft
ON Aircraft
AFTER UPDATE
AS BEGIN
	DECLARE @a_id int
	SELECT @a_id = aircraft_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Aircraft Id ' + CAST(@a_id AS varchar(5)) + ' has been updated in Aircraft table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Aircraft')
END
-- 2. Trigger when a row is updated in Airport table
GO
CREATE TRIGGER trigger_update_airport
ON Airport
AFTER UPDATE
AS BEGIN
	DECLARE @a_id int
	SELECT @a_id = airport_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Airport Id ' + CAST(@a_id AS varchar(5)) + ' has been updated in Airport table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Airport')
END
-- 3. Trigger when a row is updated in Baggage table
GO
CREATE TRIGGER trigger_update_baggage
ON Baggage
AFTER UPDATE
AS BEGIN
	DECLARE @b_id int
	SELECT @b_id = baggage_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Baggage Id ' + CAST(@b_id AS varchar(5)) + ' has been updated in Baggage table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Baggage')
END
-- 4. Trigger when a row is updated in City table
GO
CREATE TRIGGER trigger_update_city
ON City
AFTER UPDATE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = city_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('City Id ' + CAST(@c_id AS varchar(5)) + ' has been updated in City table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'City')
END
-- 5. Trigger when a row is updated in Class table
GO
CREATE TRIGGER trigger_update_class
ON Class
AFTER UPDATE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = class_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Class Id ' + CAST(@c_id AS varchar(5)) + ' has been updated in Class table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Class')
END
-- 6. Trigger when a row is updated in Country table
GO
CREATE TRIGGER trigger_update_country
ON Country
AFTER UPDATE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = country_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Country Id ' + CAST(@c_id AS varchar(5)) + ' has been updated in Country table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Country')
END
-- 7. Trigger when a row is updated in Crew table
GO
CREATE TRIGGER trigger_update_crew
ON Crew
AFTER UPDATE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = crew_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Crew Id ' + CAST(@c_id AS varchar(5)) + ' has been updated in Crew table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Crew')
END
-- 8. Trigger when a row is updated in CrewOnFlight table
GO
CREATE TRIGGER trigger_update_crew_on_flight
ON CrewOnFlight
AFTER UPDATE
AS BEGIN
	DECLARE @t_id int
	SELECT @t_id = table_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Table Id ' + CAST(@t_id AS varchar(5)) + ' has been updated in CrewOnFlight table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'CrewOnFlight')
END
-- 9. Trigger when a row is updated in CrewRole table
GO
CREATE TRIGGER trigger_update_crew_role
ON CrewRole
AFTER UPDATE
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = role_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('CrewRole Id ' + CAST(@r_id AS varchar(5)) + ' has been updated in CrewRole table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'CrewRole')
END
-- 10. Trigger when a row is updated in Feedback table
GO
CREATE TRIGGER trigger_update_feedback
ON Feedback
AFTER UPDATE
AS BEGIN
	DECLARE @f_id int
	SELECT @f_id = feedback_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Feedback Id ' + CAST(@f_id AS varchar(5)) + ' has been updated in Feedback table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Feedback')
END
-- 11. Trigger when a row is updated in Flight table
GO
CREATE TRIGGER trigger_update_flight
ON Flight
AFTER UPDATE
AS BEGIN
	DECLARE @f_id int
	SELECT @f_id = flight_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Flight Id ' + CAST(@f_id AS varchar(5)) + ' has been updated in Flight table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Flight')
END
-- 12. Trigger when a row is updated in Passenger table
GO
CREATE TRIGGER trigger_update_passenger
ON Passenger
AFTER UPDATE
AS BEGIN
	DECLARE @p_id int
	SELECT @p_id = passenger_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Passenger Id ' + CAST(@p_id AS varchar(5)) + ' has been updated in Passenger table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Passenger')
END
-- 13. Trigger when a row is updated in Payment table
GO
CREATE TRIGGER trigger_update_payment
ON Payment
AFTER UPDATE
AS BEGIN
	DECLARE @p_id int
	SELECT @p_id = payment_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Payment Id ' + CAST(@p_id AS varchar(5)) + ' has been updated in Payment table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Payment')
END
-- 14. Trigger when a row is updated in Reservation table
GO
CREATE TRIGGER trigger_update_reservation
ON Reservation
AFTER UPDATE
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = reservation_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Reservation Id ' + CAST(@r_id AS varchar(5)) + ' has been updated in Reservation table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Reservation')
END
-- 15. Trigger when a row is updated in Response table
GO
CREATE TRIGGER trigger_update_response
ON Response
AFTER UPDATE
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = response_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Response Id ' + CAST(@r_id AS varchar(5)) + ' has been updated in Response table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Response')
END
-- 16. Trigger when a row is updated in Seat table
GO
CREATE TRIGGER trigger_update_Seat
ON Seat
AFTER UPDATE
AS BEGIN
	DECLARE @s_id int
	SELECT @s_id = seat_id
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Seat Id ' + CAST(@s_id AS varchar(5)) + ' has been updated in Seat table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Seat')
END
-- 17. Trigger when a row is updated in Aircraft table with trigger message also displaying aircraft name
GO
CREATE TRIGGER trigger_update_aircraft_with_name
ON Aircraft
AFTER UPDATE
AS BEGIN
	DECLARE @a_id int, @a_name varchar(50)
	SELECT @a_id = aircraft_id, @a_name = aircraft_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Aircraft Id ' + CAST(@a_id AS varchar(5)) + ' of name ' + @a_name + ' has been updated in Aircraft table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Aircraft')
END
-- 18. Trigger when a row is updated in city table with trigger message also displaying city name
GO
CREATE TRIGGER trigger_update_city_with_name
ON City
AFTER UPDATE
AS BEGIN
	DECLARE @c_id int, @c_name varchar(100)
	SELECT @c_id = city_id, @c_name = city_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('City Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been updated in City table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'City')
END
-- 19. Trigger when a row is updated in Country table with trigger message also displaying country name
GO
CREATE TRIGGER trigger_update_country_with_name
ON Country
AFTER UPDATE
AS BEGIN
	DECLARE @c_id int, @c_name varchar(100)
	SELECT @c_id = country_id, @c_name = country_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Country Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been updated in Country table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Country')
END
-- 20. Trigger when a row is updated in Class table with trigger message also displaying class name
GO
CREATE TRIGGER trigger_update_class_with_name
ON Class
AFTER UPDATE
AS BEGIN
	DECLARE @c_id int, @c_name varchar(20)
	SELECT @c_id = class_id, @c_name = class_name
	FROM inserted

	INSERT INTO TriggersAudit
	VALUES('Class Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been updated in Class table at ' + CAST(GETDATE() as varchar(30)) + '.', 'Update', 'Class')
END


---------------------------DML Triggers DELETE------------------------------------
-- 1. Trigger when a row is deleted from Aircraft table
GO
CREATE TRIGGER trigger_delete_aircraft
ON Aircraft
FOR DELETE
AS BEGIN
	DECLARE @a_id int
	SELECT @a_id = aircraft_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Aircraft Id ' + CAST(@a_id AS varchar(5)) + ' has been deleted from Aircraft table.', 'Delete', 'Aircraft')
END
-- 2. Trigger when a row is deleted from Airport table
GO
CREATE TRIGGER trigger_delete_airport
ON Airport
FOR DELETE
AS BEGIN
	DECLARE @a_id int
	SELECT @a_id = airport_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Airport Id ' + CAST(@a_id AS varchar(5)) + ' has been deleted from Airport table.', 'Delete', 'Airport')
END
-- 3. Trigger when a row is deleted from Baggage table
GO
CREATE TRIGGER trigger_delete_baggage
ON Baggage
FOR DELETE
AS BEGIN
	DECLARE @b_id int
	SELECT @b_id = baggage_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Baggage Id ' + CAST(@b_id AS varchar(5)) + ' has been deleted from Baggage table.', 'Delete', 'Baggage')
END
-- 4. Trigger when a row is deleted from City table
GO
CREATE TRIGGER trigger_delete_city
ON City
FOR DELETE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = city_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('City Id ' + CAST(@c_id AS varchar(5)) + ' has been deleted from City table.', 'Delete', 'City')
END
-- 5. Trigger when a row is deleted from Class table
GO
CREATE TRIGGER trigger_delete_class
ON Class
FOR DELETE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = class_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Class Id ' + CAST(@c_id AS varchar(5)) + ' has been deleted from Class table.', 'Delete', 'Class')
END
-- 6. Trigger when a row is deleted from Country table
GO
CREATE TRIGGER trigger_delete_country
ON Country
FOR DELETE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = country_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Country Id ' + CAST(@c_id AS varchar(5)) + ' has been deleted from Country table.', 'Delete', 'Country')
END
-- 7. Trigger when a row is deleted from Crew table
GO
CREATE TRIGGER trigger_delete_crew
ON Crew
FOR DELETE
AS BEGIN
	DECLARE @c_id int
	SELECT @c_id = crew_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Crew Id ' + CAST(@c_id AS varchar(5)) + ' has been deleted from Crew table.', 'Delete', 'Crew')
END
-- 8. Trigger when a row is deleted from CrewOnFlight table
GO
CREATE TRIGGER trigger_delete_crew_on_flight
ON CrewOnFlight
FOR DELETE
AS BEGIN
	DECLARE @t_id int
	SELECT @t_id = table_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Table Id ' + CAST(@t_id AS varchar(5)) + ' has been deleted from CrewOnFlight table.', 'Delete', 'CrewOnFlight')
END
-- 9. Trigger when a row is deleted from CrewRole table
GO
CREATE TRIGGER trigger_delete_crew_role
ON CrewRole
FOR DELETE
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = role_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('CrewRole Id ' + CAST(@r_id AS varchar(5)) + ' has been deleted from CrewRole table.', 'Delete', 'CrewRole')
END
-- 10. Trigger when a row is deleted from Feedback table
GO
CREATE TRIGGER trigger_delete_feedback
ON Feedback
FOR DELETE
AS BEGIN
	DECLARE @f_id int
	SELECT @f_id = feedback_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Feedback Id ' + CAST(@f_id AS varchar(5)) + ' has been deleted from Feedback table.', 'Delete', 'Feedback')
END
-- 11. Trigger when a row is deleted from Flight table
GO
CREATE TRIGGER trigger_delete_flight
ON Flight
FOR DELETE
AS BEGIN
	DECLARE @f_id int
	SELECT @f_id = flight_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Flight Id ' + CAST(@f_id AS varchar(5)) + ' has been deleted from Flight table.', 'Delete', 'Flight')
END
-- 12. Trigger when a row is deleted from Passenger table
GO
CREATE TRIGGER trigger_delete_passenger
ON Passenger
FOR DELETE
AS BEGIN
	DECLARE @p_id int
	SELECT @p_id = passenger_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Passenger Id ' + CAST(@p_id AS varchar(5)) + ' has been deleted from Passenger table.', 'Delete', 'Passenger')
END
-- 13. Trigger when a row is deleted from Payment table
GO
CREATE TRIGGER trigger_delete_payment
ON Payment
FOR DELETE
AS BEGIN
	DECLARE @p_id int
	SELECT @p_id = payment_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Payment Id ' + CAST(@p_id AS varchar(5)) + ' has been deleted from Payment table.', 'Delete', 'Payment')
END
-- 14. Trigger when a row is deleted from Reservation table
GO
CREATE TRIGGER trigger_delete_reservation
ON Reservation
FOR DELETE
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = reservation_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Reservation Id ' + CAST(@r_id AS varchar(5)) + ' has been deleted from Reservation table.', 'Delete', 'Reservation')
END
-- 15. Trigger when a row is deleted from Response table
GO
CREATE TRIGGER trigger_delete_response
ON Response
FOR DELETE
AS BEGIN
	DECLARE @r_id int
	SELECT @r_id = response_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Response Id ' + CAST(@r_id AS varchar(5)) + ' has been deleted from Response table.', 'Delete', 'Response')
END
-- 16. Trigger when a row is deleted from Seat table
GO
CREATE TRIGGER trigger_delete_Seat
ON Seat
FOR DELETE
AS BEGIN
	DECLARE @s_id int
	SELECT @s_id = seat_id
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Seat Id ' + CAST(@s_id AS varchar(5)) + ' has been deleted from Seat table.', 'Delete', 'Seat')
END
-- 17. Trigger when a row is deleted from Aircraft table with trigger message also displaying aircraft name
GO
CREATE TRIGGER trigger_delete_aircraft_with_name
ON Aircraft
FOR DELETE
AS BEGIN
	DECLARE @a_id int, @a_name varchar(50)
	SELECT @a_id = aircraft_id, @a_name = aircraft_name
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Aircraft Id ' + CAST(@a_id AS varchar(5)) + ' of name ' + @a_name + ' has been deleted from Aircraft table.', 'Delete', 'Aircraft')
END
-- 18. Trigger when a row is deleted from city table with trigger message also displaying city name
GO
CREATE TRIGGER trigger_delete_city_with_name
ON City
FOR DELETE
AS BEGIN
	DECLARE @c_id int, @c_name varchar(100)
	SELECT @c_id = city_id, @c_name = city_name
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('City Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been deleted from City table.', 'Delete', 'City')
END
-- 19. Trigger when a row is deleted from Country table with trigger message also displaying country name
GO
CREATE TRIGGER trigger_delete_country_with_name
ON Country
FOR DELETE
AS BEGIN
	DECLARE @c_id int, @c_name varchar(100)
	SELECT @c_id = country_id, @c_name = country_name
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Country Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been deleted from Country table.', 'Delete', 'Country')
END
-- 20. Trigger when a row is deleted from Class table with trigger message also displaying class name
GO
CREATE TRIGGER trigger_delete_class_with_name
ON Class
FOR DELETE
AS BEGIN
	DECLARE @c_id int, @c_name varchar(20)
	SELECT @c_id = class_id, @c_name = class_name
	FROM deleted

	INSERT INTO TriggersAudit
	VALUES('Class Id ' + CAST(@c_id AS varchar(5)) + ' of name ' + @c_name + ' has been deleted from Class table.', 'Delete', 'Class')
END

INSERT INTO Class
VALUES('Special')

UPDATE Class SET class_name = 'VIP'
WHERE class_id = 4

DELETE FROM Class
WHERE class_id = 4


------------------------------VIEW Statement---------------------------------------
-- 1. View for specific column of airport table
GO
CREATE VIEW view_airport
AS
	SELECT airport_name
	FROM Airport
-- 2. View for specific column of city table
GO
CREATE VIEW view_cities
AS
	SELECT city_name
	FROM City
-- 3. View for specific column of country table
GO
CREATE VIEW view_countries
AS
	SELECT country_name
	FROM Country
-- 4. View for specific column of aircraft table
GO
CREATE VIEW view_aircrafts
AS
	SELECT aircraft_name
	FROM Aircraft
-- 5. View for specific column of baggage table
GO
CREATE VIEW view_baggages
AS
	SELECT baggage_detail
	FROM Baggage
-- 6. View for specific columns of crew table
GO
CREATE VIEW view_crew
AS
	SELECT crew_name, crew_email
	FROM Crew
-- 7. View for specific column of CrewRole table
GO
CREATE VIEW view_crew_roles
AS
	SELECT role_name
	FROM CrewRole
-- 8. View for specific columns of feedback table
GO
CREATE VIEW view_feedbacks
AS
	SELECT complete_feedback, rating
	FROM Feedback
-- 9. View for specific column(=s of passenger table
GO
CREATE VIEW view_passengers
AS
	SELECT passenger_id, passenger_email
	FROM Passenger
-- 10. View for specific columns of Seat table
GO
CREATE VIEW view_seats
AS
	SELECT seat_name, class
	FROM Seat


-----------------------VIEW Statement using logical Operators----------------------
-- 1. View for all airports except those having airport id 2 and 10
GO
CREATE VIEW view_specific_aiports_itt
AS
	SELECT airport_id, airport_name
	FROM Airport
	WHERE airport_id NOT IN (2,10)
-- 2. View for all airports except those having airport id 5 and 6
GO
CREATE VIEW view_specific_aiports_ifs
AS
	SELECT airport_id, airport_name
	FROM Airport
	WHERE airport_id NOT IN (5,6)
-- 3. View for all airports except those having airport id 9 and 10
GO
CREATE VIEW view_specific_aiports_int
AS
	SELECT airport_id, airport_name
	FROM Airport
	WHERE airport_id NOT IN (9,10)
-- 4. View for all airports except those having airport id between 10 and 20
GO
CREATE VIEW view_specific_aiports_btt
AS
	SELECT airport_id, airport_name
	FROM Airport
	WHERE airport_id NOT BETWEEN 10 AND 20
-- 5. View for all airports except those having airport id between 5 and 15
GO
CREATE VIEW view_specific_aiports_bff
AS
	SELECT airport_id, airport_name
	FROM Airport
	WHERE airport_id NOT BETWEEN 5 AND 15
-- 6. View for all airports except those having airport id between 20 and 30
GO
CREATE VIEW view_specific_aiports_nbtt
AS
	SELECT airport_id, airport_name
	FROM Airport
	WHERE airport_id NOT BETWEEN 20 AND 30
-- 7. View for all cities having country id 1 or 3
GO
CREATE VIEW view_specific_city_ot
AS
	SELECT city_id, city_name
	FROM City
	WHERE country = 1 OR country = 3
-- 8. View for all cities having country id 4 or 5
GO
CREATE VIEW view_specific_city_ff
AS
	SELECT city_id, city_name
	FROM City
	WHERE country = 4 OR country = 5
-- 9. View for all cities having country id 7 or 9
GO
CREATE VIEW view_specific_city_sn
AS
	SELECT city_id, city_name
	FROM City
	WHERE country = 7 OR country = 9
-- 10. View for all cities having country id 4 or 6
GO
CREATE VIEW view_specific_city_fs
AS
	SELECT city_id, city_name
	FROM City
	WHERE country = 4 OR country = 6
-- 11. View for crew which is male and has gmail email
GO
CREATE VIEW view_specific_crew_mg
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'M' AND crew_email LIKE '%gmail.com'
-- 12. View for crew which is male and has yahoo email
GO
CREATE VIEW view_specific_crew_my
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'M' AND crew_email LIKE '%yahoo.com'
-- 13. View for crew which is female and has gmail email
GO
CREATE VIEW view_specific_crew_fg
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'F' AND crew_email LIKE '%gmail.com'
-- 14. View for crew which is female and has gmail email
GO
CREATE VIEW view_specific_crew_fy
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'F' AND crew_email LIKE '%yahoo.com'
-- 15. View for crew which has other gender and has gmail email
GO
CREATE VIEW view_specific_crew_og
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'O' AND crew_email LIKE '%gmail.com'
-- 16. View for crew which has other gender and has yahoo email
GO
CREATE VIEW view_specific_crew_oy
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'O' AND crew_email LIKE '%yahoo.com'
-- 17. View for crew whose gender is male or other
GO
CREATE VIEW view_specific_crew_om
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'O' OR crew_gender = 'M'
-- 18. View for crew whose gender is female or other
GO
CREATE VIEW view_specific_crew_of
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'O' OR crew_gender = 'F'
-- 19. View for crew whose gender is male or female
GO
CREATE VIEW view_specific_crew_fm
AS
	SELECT crew_id, crew_name, crew_email
	FROM Crew
	WHERE crew_gender = 'F' OR crew_gender = 'M'
-- 20. View for crew role where role name is Pilot or Air Host
GO
CREATE VIEW view_specific_crew_role_pahm
AS
	SELECT role_id, role_name
	FROM CrewRole
	WHERE role_name = 'Pilot' OR role_name = 'Air Host'
-- 21. View for crew role where role name is Air Hostess or Air Host
GO
CREATE VIEW view_specific_crew_role_ahmahf
AS
	SELECT role_id, role_name
	FROM CrewRole
	WHERE role_name = 'Air Hostess' OR role_name = 'Air Host'
-- 22. View for crew which is pilot or air hostess
GO
CREATE VIEW view_crew_wrt_role_pahm
AS
	SELECT c.crew_name, c.crew_email, c.crew_salary, cr.role_name
	FROM Crew c
		INNER JOIN CrewRole cr
		ON cr.role_id = c.crew_role
	WHERE cr.role_name = 'Pilot' OR role_name = 'Air Hostess'
-- 23. View for crew which is pilot or load master
GO
CREATE VIEW view_crew_wrt_role_plm
AS
	SELECT c.crew_name, c.crew_email, c.crew_salary, cr.role_name
	FROM Crew c
		INNER JOIN CrewRole cr
		ON cr.role_id = c.crew_role
	WHERE cr.role_name = 'Pilot' OR role_name = 'Load Master'
-- 24. View for seats of aircraft id 1 and 3
GO
CREATE VIEW view_seat_ot
AS
	SELECT seat_name, class, aircraft
	FROM Seat
	WHERE aircraft = 1 OR aircraft = 3
-- 25. View for seats of aircraft id 4 and 2
GO
CREATE VIEW view_seat_ft
AS
	SELECT seat_name, class, aircraft
	FROM Seat
	WHERE aircraft = 4 OR aircraft = 2
-- 26. View for seats not in class 1 and 3
GO
CREATE VIEW view_seat_not
AS
	SELECT seat_name, class, aircraft
	FROM Seat
	WHERE class NOT IN (1,3)
-- 27. View for seats not in class 2 and 3
GO
CREATE VIEW view_seat_ntt
AS
	SELECT seat_name, class, aircraft
	FROM Seat
	WHERE class NOT IN (2,3)
-- 28. View for reservations except of those passengers having ids between 20 and 30
GO
CREATE VIEW view_res_ntt
AS
	SELECT reservation_id, passenger, flight
	FROM Reservation
	WHERE passenger NOT BETWEEN 20 AND 30
-- 29. View for reservations except of those passengers having ids between 10 and 18
GO
CREATE VIEW view_res_nte
AS
	SELECT reservation_id, passenger, flight
	FROM Reservation
	WHERE passenger NOT BETWEEN 10 AND 18
-- 30. View for specific reservation and flight details where flight id is not 1 and 4
GO
CREATE VIEW view_res_flight_nof
AS
	SELECT r.reservation_id, r.passenger, f.flight_departure_airport, f.flight_arrival_airport
	FROM Reservation r
		INNER JOIN Flight f
		ON f.flight_id = r.flight
	WHERE flight NOT IN (1,4)


--------Single Row Functions UPPER, LOWER, INITCAP, CONCAT, LENGTH, SUBSTR --------
--------------------------using logical operators----------------------------------
-- 1. Passenger name in upper case where passenger id from 5 to 20
SELECT UPPER(passenger_name)
FROM Passenger
WHERE passenger_id >= 5 and passenger_id <= 20
-- 2. Passenger name in lower case where passenger id from 5 to 20
SELECT LOWER(passenger_name)
FROM Passenger
WHERE passenger_id >= 5 and passenger_id <= 20
-- 3. Crew name in upper case where crew id from 5 to 20
SELECT UPPER(crew_name)
FROM Crew
WHERE crew_id >= 5 and crew_id <= 20
-- 4. Crew name in lower case where crew id from 5 to 20
SELECT LOWER(crew_name)
FROM Crew
WHERE crew_id >= 5 and crew_id <= 20
-- 5. Passenger name and its length where passenger id from 5 to 20
SELECT passenger_name, LEN(passenger_name)
FROM Passenger
WHERE passenger_id >= 5 and passenger_id <= 20
-- 6. Crew name and its length where crew id from 5 to 20
SELECT crew_name, LEN(crew_name)
FROM Crew
WHERE crew_id >= 5 and crew_id <= 20
-- 7. Baggage detail in upper case where id greater than 1 and less than 5
SELECT baggage_id, UPPER(baggage_detail)
FROM Baggage
WHERE baggage_id > 1 AND baggage_id < 5
-- 8. Baggage detail in lower case where id greater than 1 and less than 5
SELECT baggage_id, LOWER(baggage_detail)
FROM Baggage
WHERE baggage_id > 1 AND baggage_id < 5
-- 9. Baggage detail and its length where id greater than 1 and less than 5
SELECT baggage_id, baggage_detail, LEN(baggage_detail)
FROM Baggage
WHERE baggage_id > 1 AND baggage_id < 5
-- 10. Passenger email in upper case where passenger id from 5 to 20
SELECT UPPER(passenger_email)
FROM Passenger
WHERE passenger_id >= 5 and passenger_id <= 20
-- 11. Crew email in upper case where crew id from 5 to 20
SELECT UPPER(crew_email)
FROM Crew
WHERE crew_id >= 5 and crew_id <= 20
-- 12. City names in upper case except those having id 1, 10 and 20
SELECT city_id, UPPER(city_name)
FROM City
WHERE city_id NOT IN (1,10,20)
-- 13. City names in lower case except those having id id 1, 10 and 20
SELECT city_id, LOWER(city_name)
FROM City
WHERE city_id NOT IN (1,10,20)
-- 14. Country names in upper case except those having id 1 and 5
SELECT country_id, UPPER(country_name)
FROM Country
WHERE country_id NOT IN (1,5)
-- 15. Country names in lower case except those having id 1 and 5
SELECT country_id, LOWER(country_name)
FROM Country
WHERE country_id NOT IN (1,5)
-- 16. Role names in upper case except those having id 1 and 5
SELECT role_id, UPPER(role_name)
FROM CrewRole
WHERE role_id NOT IN (1,5)
-- 17. Role names in lower case except those having id 1 and 5
SELECT role_id, LOWER(role_name)
FROM CrewRole
WHERE role_id NOT IN (1,5)
-- 18. Passenger email and its length where passenger id from 5 to 20
SELECT passenger_email, LEN(passenger_email)
FROM Passenger
WHERE passenger_id >= 5 and passenger_id <= 20
-- 19. Crew email and its length where crew id from 5 to 20
SELECT crew_email, LEN(crew_email)
FROM Crew
WHERE crew_id >= 5 and crew_id <= 20
-- 20. City name and its length except those having id 1, 10 and 20
SELECT city_name, LEN(city_name)
FROM City
WHERE city_id NOT IN (1,10,20)
-- 21. City name and its length except those having id 1, 10 and 20
SELECT city_name, LEN(city_name)
FROM City
WHERE city_id NOT IN (1,10,20)
-- 22. Country name and its length except those having id 1 and 5
SELECT country_name, LEN(country_name)
FROM Country
WHERE country_id NOT IN (1,5)
-- 23. Country name and its length except those having id 1 and 5
SELECT country_name, LEN(country_name)
FROM Country
WHERE country_id NOT IN (1,5)
-- 24. Role name and its length except those having id 1 and 5
SELECT role_name, LEN(role_name)
FROM CrewRole
WHERE role_id NOT IN (1,5)
-- 25. Role name and its length except those having id 1 and 5
SELECT role_name, LEN(role_name)
FROM CrewRole
WHERE role_id NOT IN (1,5)
-- 26. Airport name in default and upper case except those in city id 2 and 3
SELECT airport_name, UPPER(airport_name)
FROM Airport
WHERE city NOT IN (2,3)
-- 27. Airport name in default and lower case except those in city id 2 and 3
SELECT airport_name, LOWER(airport_name)
FROM Airport
WHERE city NOT IN (2,3)
-- 28. Airport name and its length except those in city id 2 and 3
SELECT airport_name, LEN(airport_name)
FROM Airport
WHERE city NOT IN (2,3)
-- 29. Response detail in normal and upper case where it has 'consideration' and 'considered'
SELECT response_detail, UPPER(response_detail)
FROM Response
WHERE response_detail LIKE '%consideration%' OR response_detail LIKE '%considered%'
-- 30. Response detail in normal and lower case where it has 'consideration' and 'considered'
SELECT response_detail, LOWER(response_detail)
FROM Response
WHERE response_detail LIKE '%consideration%' OR response_detail LIKE '%considered%'
-- 31. Response detail and its length where it has 'consideration' and 'considered'
SELECT response_detail, LEN(response_detail)
FROM Response
WHERE response_detail LIKE '%consideration%' OR response_detail LIKE '%considered%'
-- 32. Substring of city name except Lahore and Delhi
SELECT city_name, SUBSTRING(city_name, 1, 3) AS SubName
FROM City
WHERE city_name NOT IN ('Lahore', 'Delhi')
-- 33. Substring of country name except US and Canada
SELECT country_name, SUBSTRING(country_name, 1, 3) AS SubName
FROM Country
WHERE country_name NOT IN ('United States', 'Canada')
-- 34. Substring of crew name except those having id 2, 4 and 6
SELECT crew_name, SUBSTRING(crew_name, 1, 3) AS SubName
FROM Crew
WHERE crew_id NOT IN (2, 4, 6)
-- 35. Substring of crew email except those having id 2, 4 and 6
SELECT crew_email, SUBSTRING(crew_email, 1, 3) AS SubEmail
FROM Crew
WHERE crew_id NOT IN (2, 4, 6)
-- 36. Substring of crew address except those having id 2, 4 and 6
SELECT crew_address, SUBSTRING(crew_address, 1, 5) AS SubEmail
FROM Crew
WHERE crew_id NOT IN (2, 4, 6)
-- 37. Substring of passenger name which are male and female
SELECT passenger_name, SUBSTRING(passenger_name, 1, 4)
FROM Passenger
WHERE passenger_gender = 'M' OR passenger_gender = 'F'
-- 38. Substring of passenger name which are male and others
SELECT passenger_name, SUBSTRING(passenger_name, 1, 4)
FROM Passenger
WHERE passenger_gender = 'M' OR passenger_gender = 'O'
-- 39. Substring of passenger name which are female and others
SELECT passenger_name, SUBSTRING(passenger_name, 1, 4)
FROM Passenger
WHERE passenger_gender = 'F' OR passenger_gender = 'O'
-- 40. Substring of passenger email which are female and others
SELECT passenger_email, SUBSTRING(passenger_email, 1, 4)
FROM Passenger
WHERE passenger_gender = 'F' OR passenger_gender = 'O'
-- 41. Substring of passenger email which are female and male
SELECT passenger_email, SUBSTRING(passenger_email, 1, 4)
FROM Passenger
WHERE passenger_gender = 'F' OR passenger_gender = 'M'
-- 42. Substring of passenger email which are male and others
SELECT passenger_email, SUBSTRING(passenger_email, 1, 4)
FROM Passenger
WHERE passenger_gender = 'M' OR passenger_gender = 'O'
-- 43. Concatinating crew name and email except those having crew id 3 or 4
SELECT crew_id, CONCAT(crew_name, ' having email ', crew_email)
FROM Crew
WHERE crew_id NOT IN (3,4)
-- 44. Concatinating crew name and salary except those having crew id 3 or 4
SELECT crew_id, CONCAT(crew_name, ' is earning ', CAST(crew_salary as varchar(7)))
FROM Crew
WHERE crew_id NOT IN (3,4)
-- 45. Concatinating crew name and address except those having crew id 3 or 4
SELECT crew_id, CONCAT(crew_name, ' lives at ', crew_address)
FROM Crew
WHERE crew_id NOT IN (3,4)
-- 46. Concatinating crew name and gender except those having crew id 3 or 4
SELECT crew_id, CONCAT(crew_name, ' is of gender ', crew_gender)
FROM Crew
WHERE crew_id NOT IN (3,4)
-- 47. Concatinating crew name and role name from CrewRole table except those having crew id 3 or 4
SELECT crew_id, CONCAT(crew_name, ' is ', cr.role_name)
FROM Crew c
	INNER JOIN CrewRole cr
	ON cr.role_id = c.crew_role
WHERE c.crew_id NOT IN (3,4)
-- 48. Concatinating city name from city table and country name from country table except those cities having id 4 and 5
SELECT city_id, CONCAT(ci.city_name, ' ', co.country_name)
FROM City ci
	INNER JOIN Country co
	ON co.country_id = ci.country
WHERE ci.city_id NOT IN (4,5)
-- 49. Concatinating passenger name and gender where passenger id is not in range 5 and 10
SELECT passenger_id, CONCAT(passenger_name, ' of gender ', passenger_gender)
FROM Passenger
WHERE passenger_id NOT BETWEEN 5 AND 10
-- 50. Concatinating passenger name and email where passenger id is not in range 5 and 10
SELECT passenger_id, CONCAT(passenger_name, ' having email ', passenger_email)
FROM Passenger
WHERE passenger_id NOT BETWEEN 5 AND 10


---------------Single-Row Functions INSTR, TRIM, REPLACE, ROUND, TRUNC-------------
---------------------------using logical operators---------------------------------
-- 1. Replacing google with gmail in passenger emails where emails were not of yahoo
SELECT passenger_id, REPLACE(passenger_email, 'google', 'gmail')
FROM Passenger
WHERE passenger_email NOT LIKE '%yahoo.com'
-- 2. Replacing yahoo with outlook in passenger emails where emails were not of google
SELECT passenger_id, REPLACE(passenger_email, 'yahoo', 'outlook')
FROM Passenger
WHERE passenger_email NOT LIKE '%google.com'
-- 3. Replacing yahoo with outlook in passenger emails where emails were not of hotmail
SELECT passenger_id, REPLACE(passenger_email, 'yahoo', 'outlook')
FROM Passenger
WHERE passenger_email NOT LIKE '%hotmail.com'
-- 4. Index of google in passenger email where passenger id greater than 3 and passenger email has google in it
SELECT passenger_id, CHARINDEX('google', passenger_email)
FROM Passenger
WHERE passenger_id > 3 AND passenger_email LIKE '%google%'
-- 5. Index of yahoo in passenger email where passenger id greater than 3 and passenger email has yahoo in it
SELECT passenger_id, CHARINDEX('yahoo', passenger_email)
FROM Passenger
WHERE passenger_id > 3 AND passenger_email LIKE '%yahoo%'
-- 6. Index of hotmail in passenger email where passenger id greater than 3 and passenger email has hotmail in it
SELECT passenger_id, CHARINDEX('hotmail', passenger_email)
FROM Passenger
WHERE passenger_id > 3 AND passenger_email LIKE '%hotmail%'
-- 7. Index of Lahore in crew address where crew id greater than 3 and crew address has Lahore in it
SELECT crew_id, CHARINDEX('Lahore', crew_address)
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Lahore%'
-- 8. Index of Karachi in crew address where crew id greater than 3 and crew address has Karachi in it
SELECT crew_id, CHARINDEX('Karachi', crew_address)
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Karachi%'
-- 9. Index of Islamabad in crew address where crew id greater than 3 and crew address has Islamabad in it
SELECT crew_id, CHARINDEX('Islamabad', crew_address)
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Islamabad%'
-- 10. Index of Kala Shah Kaku in crew address where crew id greater than 3 and crew address has Kala Shah Kaku in it
SELECT crew_id, CHARINDEX('Kala Shah Kaku', crew_address)
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Kala Shah Kaku%'
-- 11. Index of Quetta in crew address where crew id greater than 3 and crew address has Quetta in it
SELECT crew_id, CHARINDEX('Quetta', crew_address)
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Quetta%'
-- 12. Index of Peshawar in crew address where crew id greater than 3 and crew address has Peshawar in it
SELECT crew_id, CHARINDEX('Peshawar', crew_address)
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Peshawar%'
-- 13. Index of Sui in crew address where crew id greater than 3 and crew address has Sui in it
SELECT crew_id, CHARINDEX('Sui', crew_address)
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Sui%'
-- 14. Replacing Lahore with LAH in crew address where crew id greater than 3 and crew address has Lahore in it
SELECT crew_id, REPLACE(crew_address, 'Lahore', 'LAH')
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Lahore%'
-- 15. Replacing Islamabad with ISL in crew address where crew id greater than 3 and crew address has Islamabad in it
SELECT crew_id, REPLACE(crew_address, 'Islamabad', 'ISL')
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Islamabad%'
-- 16. Replacing Karachi with KAR in crew address where crew id greater than 3 and crew address has Karachi in it
SELECT crew_id, REPLACE(crew_address, 'Karachi', 'KAR')
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Karachi%'
-- 17. Replacing Quetta with QUE in crew address where crew id greater than 3 and crew address has Quetta in it
SELECT crew_id, REPLACE(crew_address, 'Quetta', 'QUE')
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Quetta%'
-- 18. Replacing Peshawar with PES in crew address where crew id greater than 3 and crew address has Peshawar in it
SELECT crew_id, REPLACE(crew_address, 'Peshawar', 'PES')
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Peshawar%'
-- 19. Replacing Sui with SUI in crew address where crew id greater than 3 and crew address has Sui in it
SELECT crew_id, REPLACE(crew_address, 'Sui', 'SUI')
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Sui%'
-- 20. Replacing Kala Shah Kaku with KSK in crew address where crew id greater than 3 and crew address has Kala Shah Kaku in it
SELECT crew_id, REPLACE(crew_address, 'Kala Shah Kaku', 'KSK')
FROM Crew
WHERE crew_id > 3 AND crew_address LIKE '%Kala Shah Kaku%'
-- 21. Index of Airport in airport name where airport id not in range of 5 to 10
SELECT airport_id, airport_name, CHARINDEX('Airport', airport_name)
FROM Airport
WHERE airport_id NOT BETWEEN 5 AND 10
-- 22. Trimming passenger name if it has useless spaces where passenger is a male or passenger id is greater than 2
SELECT passenger_id, TRIM(passenger_name)
FROM Passenger
WHERE passenger_gender = 'M' OR passenger_id > 2
-- 23. Trimming crew name if it has useless spaces where crew gender is male or crew id is greater than 5
SELECT crew_id, TRIM(crew_name)
FROM Crew
WHERE crew_gender = 'M' OR crew_id > 10
-- 24. Trimming passenger email if it has useless spaces where passenger is a male or passenger id is greater than 2
SELECT passenger_id, TRIM(passenger_email)
FROM Passenger
WHERE passenger_gender = 'M' OR passenger_id > 2
-- 25. Trimming crew email if it has useless spaces where crew gender is male or crew id is greater than 5
SELECT crew_id, TRIM(crew_email)
FROM Crew
WHERE crew_gender = 'M' OR crew_id > 10
-- 26. Trimming aircraft name if it has useless spaces where aircraft id is greater than 1 and less than 7
SELECT aircraft_id, TRIM(aircraft_name)
FROM Aircraft
WHERE aircraft_id > 1 AND aircraft_id < 7
-- 27. Trimming baggage detail if it has useless spaces where flight id is 1 and passenger id is greater than 40
SELECT baggage_id, TRIM(baggage_detail)
FROM Baggage
WHERE flight = 1 OR passenger > 40
-- 28. Trimming city name if it has useless spaces where city name is neither Islamabad nor Toronto
SELECT city_id, TRIM(city_name)
FROM City
WHERE city_name NOT IN ('Islamabad', 'Toronto')
-- 29. Trimming country name if it has useless spaces where country name is neither Canada nor Japan
SELECT country_id, TRIM(country_name)
FROM Country
WHERE country_name NOT IN ('Japan', 'Canada')
-- 30. Trimming role name if it has useless spaces where role name is neither Pilot nor Air Host
SELECT role_id, TRIM(role_name)
FROM CrewRole
WHERE role_name NOT IN ('Pilot', 'Air Host')
-- 31. Trimming feedback if it has useless spaces where feedback id is neither 1 nor 2
SELECT feedback_id, TRIM(complete_feedback)
FROM Feedback
WHERE feedback_id NOT IN (1, 2)
-- 32. Trimming feedback if it has useless spaces where feedback id is neither 1 nor 3
SELECT feedback_id, TRIM(complete_feedback)
FROM Feedback
WHERE feedback_id NOT IN (1, 3)
-- 33. Trimming feedback if it has useless spaces where feedback id is neither 2 nor 3
SELECT feedback_id, TRIM(complete_feedback)
FROM Feedback
WHERE feedback_id NOT IN (2, 3)
-- 34. Trimming response detail if it has useless spaces where response id is neither 1 nor 3
SELECT response_id, TRIM(response_detail)
FROM Response
WHERE response_id NOT IN (1, 3)
-- 35. Trimming response detail if it has useless spaces where response id is neither 1 nor 2
SELECT response_id, TRIM(response_detail)
FROM Response
WHERE response_id NOT IN (1, 2)
-- 36. Trimming response detail if it has useless spaces where response id is neither 2 nor 3
SELECT response_id, TRIM(response_detail)
FROM Response
WHERE response_id NOT IN (2, 3)
-- 37. Trimming seat name if it has useless spaces where seat id is not 5, 10 and 20
SELECT seat_id, TRIM(seat_name)
FROM Seat
WHERE seat_id NOT IN (5, 10, 20)
-- 38. Trimming seat name if it has useless spaces where seat id is not in range 20 to 30
SELECT seat_id, TRIM(seat_name)
FROM Seat
WHERE seat_id NOT BETWEEN 20 AND 30
-- 39. Trimming seat name if it has useless spaces where seat id is less than 20 or greater than 50
SELECT seat_id, TRIM(seat_name)
FROM Seat
WHERE seat_id < 20 OR seat_id > 50
-- 40. Trimming seat name if it has useless spaces where seat id is less not than 20 and not greater than 50
SELECT seat_id, TRIM(seat_name)
FROM Seat
WHERE NOT (seat_id < 20 OR seat_id > 50)
-- 41. Truncating arrival date time to Year precision where flight id is neither 1 nor 3
SELECT flight_id, DATETRUNC(YEAR, flight_arrival_datetime)
FROM Flight
WHERE flight_id NOT IN (1, 3)
-- 42. Truncating arrival date time to Month precision where flight id is neither 1 nor 3
SELECT flight_id, DATETRUNC(MONTH, flight_arrival_datetime)
FROM Flight
WHERE flight_id NOT IN (1, 3)
-- 43. Truncating arrival date time to Day precision where flight id is neither 1 nor 3
SELECT flight_id, DATETRUNC(DAY, flight_arrival_datetime)
FROM Flight
WHERE flight_id NOT IN (1, 3)
-- 44. Truncating arrival date time to Hour precision where flight id is neither 1 nor 3
SELECT flight_id, DATETRUNC(HOUR, flight_arrival_datetime)
FROM Flight
WHERE flight_id NOT IN (1, 3)
-- 45. Truncating arrival date time to Minute precision where flight id is neither 1 nor 3
SELECT flight_id, DATETRUNC(MINUTE, flight_arrival_datetime)
FROM Flight
WHERE flight_id NOT IN (1, 3)
-- 46. Truncating arrival date time to Second precision where flight id is neither 1 nor 3
SELECT flight_id, DATETRUNC(SECOND, flight_arrival_datetime)
FROM Flight
WHERE flight_id NOT IN (1, 3)
-- Working of ROUND operator
SELECT ROUND(3.14267, 2)
-- 47. Rounding crew salary to two decimal places where crew gender is male or crew address has Lahore in it
SELECT crew_id, ROUND(CONVERT(DECIMAL(10,4), crew_salary), 2)
FROM Crew
WHERE crew_gender = 'M' OR crew_address LIKE '%Lahore%'
-- 48. Rounding crew salary to two decimal places where crew gender is female or crew address has Lahore in it
SELECT crew_id, ROUND(CONVERT(DECIMAL(10,4), crew_salary), 2)
FROM Crew
WHERE crew_gender = 'F' OR crew_address LIKE '%Lahore%'
-- 49. Rounding crew salary to two decimal places where crew gender is other or crew address has Lahore in it
SELECT crew_id, ROUND(CONVERT(DECIMAL(10,4), crew_salary), 2)
FROM Crew
WHERE crew_gender = 'O' OR crew_address LIKE '%Lahore%'
-- 50. Rounding crew salary to two decimal places where crew gender is male or other
SELECT crew_id, ROUND(CONVERT(DECIMAL(10,4), crew_salary), 2)
FROM Crew
WHERE crew_gender = 'M' OR crew_gender = 'O'


-------------------------Transaction COMMIT and ROLLBACK---------------------------
-- 1. Transaction on inserting a new city
BEGIN TRANSACTION
INSERT INTO City
VALUES('Chennai', 9)
COMMIT TRAN
ROLLBACK TRAN
-- 2. Transaction on inserting a new country
BEGIN TRANSACTION
INSERT INTO Country
VALUES('Bangladesh')
COMMIT TRAN
ROLLBACK TRAN
-- 3. Transaction on inserting a new class
BEGIN TRANSACTION
INSERT INTO Class
VALUES('VIP')
COMMIT TRAN
ROLLBACK TRAN
-- 4. Transaction on inserting a new aircraft
BEGIN TRANSACTION
INSERT INTO Aircraft
VALUES('Boeing 345')
COMMIT TRAN
ROLLBACK TRAN
-- 5. Transaction on inserting a new airport
BEGIN TRANSACTION
INSERT INTO Airport
VALUES('Lahore Airport', 18)
COMMIT TRAN
ROLLBACK TRAN
-- 6. Transaction on inserting a new baggage
BEGIN TRANSACTION
INSERT INTO Baggage
VALUES('Computers', 5, 3)
COMMIT TRAN
ROLLBACK TRAN
-- 7. Transaction on inserting a new crew
BEGIN TRANSACTION
INSERT INTO Crew
VALUES('Saleem Khan', 1, 200000, 'saleem.khan@gmail.com', '684 Main Town Lahore', 'M')
COMMIT TRAN
ROLLBACK TRAN
-- 8. Transaction on inserting a CrewOnFlight
BEGIN TRANSACTION
INSERT INTO CrewOnFlight
VALUES(6, 1)
COMMIT TRAN
ROLLBACK TRAN
-- 9. Transaction on inserting a CrewRole
BEGIN TRANSACTION
INSERT INTO CrewRole
VALUES('Cleaner')
COMMIT TRAN
ROLLBACK TRAN
-- 10. Transaction on inserting a Feedback
BEGIN TRANSACTION
INSERT INTO Feedback
VALUES('Good Airline', 7, 2, 9, 1)
COMMIT TRAN
ROLLBACK TRAN
-- 11. Transaction on inserting a Flight
BEGIN TRANSACTION
INSERT INTO Feedback
VALUES(2, '2022-9-12 9:15:00', 15, '2022-9-12 15:20:00', 10)
COMMIT TRAN
ROLLBACK TRAN
-- 12. Transaction on inserting a Passenger
BEGIN TRANSACTION
INSERT INTO Passenger
VALUES('Adeel Sarfaraz', 'adeel.sarfaraz@gmail.com', 'M')
COMMIT TRAN
ROLLBACK TRAN
-- 13. Transaction on inserting a Payment
BEGIN TRANSACTION
INSERT INTO Passenger
VALUES(70, 90000, 'Online')
COMMIT TRAN
ROLLBACK TRAN
-- 14. Transaction on inserting a Reservation
BEGIN TRANSACTION
INSERT INTO Reservation
VALUES(70, 7, 1, 18, '2022-9-10 6:00:00')
COMMIT TRAN
ROLLBACK TRAN
-- 15. Transaction on inserting a Response
BEGIN TRANSACTION
INSERT INTO Passenger
VALUES('Action underway')
COMMIT TRAN
ROLLBACK TRAN
-- 16. Transaction on inserting a Seat
BEGIN TRANSACTION
INSERT INTO Passenger
VALUES('AB45', 3, 7)
COMMIT TRAN
ROLLBACK TRAN
-- 17. Transaction on updating aircraft name
BEGIN TRANSACTION
UPDATE Aircraft SET aircraft_name = 'Airbus T56'
WHERE aircraft_id = 6
COMMIT TRAN
ROLLBACK TRAN
-- 18. Transaction on updating city name
BEGIN TRANSACTION
UPDATE City SET city_name = 'NY'
WHERE city_id = 6
COMMIT TRAN
ROLLBACK TRAN
-- 19. Transaction on updating country name
BEGIN TRANSACTION
UPDATE Country SET country_name = 'USA'
WHERE country_id = 1
COMMIT TRAN
ROLLBACK TRAN
-- 20. Transaction on deleting country name
BEGIN TRANSACTION
DELETE FROM Country
WHERE country_id = 11
COMMIT TRAN
ROLLBACK TRAN


--------------------------Exception handling - Try Catch---------------------------
-- 1. Trying to cast aircraft name as int
BEGIN TRY
	SELECT CAST(aircraft_name AS INT)
FROM Aircraft
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 2. Trying to cast city name as int
BEGIN TRY
	SELECT CAST(city_name AS INT)
FROM City
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 3. Trying to divide salary by zero
BEGIN TRY
	SELECT crew_salary / 0 AS custom_column
FROM Crew
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 4. Trying to set country id 25 (which is not present in country table)
BEGIN TRY
	UPDATE City SET country = 25
	WHERE city_id = 5
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 5. Trying to update a table which does not exist
BEGIN TRY
	UPDATE MyTable SET country = 25
	WHERE city_id = 5
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 6. Trying to set aircraft id 25 (which is not present in aircraft table)
BEGIN TRY
	UPDATE Flight SET aircraft = 25
	WHERE flight_id = 5
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 7. Trying to set response id 50 (which is not present in response table)
BEGIN TRY
	UPDATE Feedback SET response = 50
	WHERE feedback_id = 2
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 8. Trying to cast country name as int
BEGIN TRY
	SELECT CAST(country_name AS INT)
FROM Country
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 9. Trying to cast complete feedback as datetime
BEGIN TRY
	SELECT CAST(complete_feedback AS DATETIME)
FROM Feedback
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 10. Trying to cast complete feedback as decimal
BEGIN TRY
	SELECT CAST(complete_feedback AS DECIMAL(20, 7))
FROM Feedback
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 11. Trying to cast complete feedback as int
BEGIN TRY
	SELECT CAST(complete_feedback AS INT)
FROM Feedback
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 12. Trying to cast complete feedback as bit
BEGIN TRY
	SELECT CAST(complete_feedback AS BIT)
FROM Feedback
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 13. Trying to cast complete feedback as time
BEGIN TRY
	SELECT CAST(complete_feedback AS TIME)
FROM Feedback
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 14. Trying to cast complete feedback as small date time
BEGIN TRY
	SELECT CAST(complete_feedback AS SMALLDATETIME)
FROM Feedback
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 15. Trying to divide sum of country ids by zero
BEGIN TRY
	SELECT SUM(country_id) / 0
FROM Country
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 16. Trying to divide average of city ids by zero
BEGIN TRY
	SELECT AVG(city_id) / 0
FROM City
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 17. Trying to divide minimum of city ids by zero
BEGIN TRY
	SELECT MIN(city_id) / 0
FROM City
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 18. Trying to divide maximum of city ids by zero
BEGIN TRY
	SELECT MAX(city_id) / 0
FROM City
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 19. Trying to cast seat name as int
BEGIN TRY
	SELECT CAST(seat_name AS INT)
FROM Seat
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
-- 20. Trying to cast crew gender as int
BEGIN TRY
	SELECT CAST(crew_gender AS INT)
FROM Crew
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrMessage
END CATCH
