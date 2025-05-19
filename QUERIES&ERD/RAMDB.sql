--Create Database RAMDB;
--USE RAMDB

--Create Table Passengers
CREATE TABLE Passenger(
passenger_id INT PRIMARY KEY IDENTITY(1,1),
passenger_name VARCHAR(100),
passenger_email VARCHAR(150),
passenger_gender VARCHAR(1)
)

--Create Table Aircraft
CREATE TABLE Aircraft(
aircraft_id INT PRIMARY KEY IDENTITY(1,1),
aircraft_name VARCHAR(50),
)
--Create Table Country
CREATE TABLE Country(
country_id INT PRIMARY KEY IDENTITY(1,1),
country_name VARCHAR(100)
)

--Create Table City
CREATE TABLE City(
city_id INT PRIMARY KEY IDENTITY(1,1),
city_name VARCHAR(100),
country INT FOREIGN KEY REFERENCES Country(country_id)
)
--Create Table Airport
CREATE TABLE Airport(
airport_id INT PRIMARY KEY IDENTITY(1,1),
airport_name VARCHAR(300),
city INT FOREIGN KEY REFERENCES City(city_id)
)
--Create Table Flight
CREATE TABLE Flight(
flight_id INT PRIMARY KEY IDENTITY(1,1),
aircraft INT FOREIGN KEY REFERENCES Aircraft(aircraft_id),
flight_departure_datetime DATETIME,
flight_departure_airport INT FOREIGN KEY REFERENCES Airport(airport_id),
flight_arrival_datetime DATETIME,
flight_arrival_airport INT FOREIGN KEY REFERENCES Airport(airport_id)
)
--Create Table Class
CREATE TABLE Class(
class_id INT PRIMARY KEY IDENTITY(1,1),
class_name VARCHAR(20)
)


--Create Table Seat
CREATE TABLE Seat(
seat_id INT PRIMARY KEY IDENTITY(1,1),
seat_name VARCHAR(10),
class INT FOREIGN KEY REFERENCES Class(class_id),
aircraft INT FOREIGN KEY REFERENCES Aircraft(aircraft_id)
)

--Create Table Baggage
----------------------------------------------------------------------
CREATE TABLE Baggage(
baggage_id INT PRIMARY KEY IDENTITY(1,1),
baggage_detail VARCHAR(500),
passenger INT FOREIGN KEY REFERENCES Passenger(passenger_id),
flight INT FOREIGN KEY REFERENCES Flight(flight_id))

-----------------------------------------------------------------------------

--Create Table Reservation
CREATE TABLE Reservation(
reservation_id INT PRIMARY KEY IDENTITY(1,1),
passenger INT FOREIGN KEY REFERENCES Passenger(passenger_id),
flight INT FOREIGN KEY REFERENCES Flight(flight_id),
class INT FOREIGN KEY REFERENCES Class(class_id),
seat INT FOREIGN KEY REFERENCES Seat(seat_id),
reservation_datetime DATETIME,)
----------------------
Select * from Baggage,Reservation,Seat,Class,Flight,Airport,Aircraft,City,Country,Passenger;
Select * from Class

---INSERTION

INSERT INTO Class
VALUES('Economy'),('Business'),('First')

INSERT INTO Country
VALUES('United States'), ('United Kingdom'), ('Canada'), ('Australia'), ('Germany'), ('France'), ('Japan'), ('Pakistan'), ('India'), ('China'), ('Nepal')

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO Response
VALUES('Yet to be cosidered'),('Under consideration'),('Considered')
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

INSERT INTO City
VALUES('New York', 1),('London', 2),('Toronto', 3),('Sydney', 4),('Berlin', 5),('Paris', 6),('Tokyo', 7),('Islamabad', 8),('Mumbai', 9),('Beijing', 10),('Los Angeles', 1),('Manchester', 2),('Vancouver', 3),('Melbourne', 4),('Hamburg', 5),('Nice', 6),('Osaka', 7),('Lahore', 8),('Delhi', 9),('Shanghai', 10),('Chicago', 1),('Birmingham', 2),('Calgary', 3),('Brisbane', 4),('Munich', 5),('Lyon', 6),('Kyoto', 7),('Karachi', 8),('Kolkata', 9),('Guangzhou', 10),('Rawalpindi', 8)


INSERT INTO Airport
VALUES('NY Airport', 1),('London Airport', 2),('Toronto Airport',3),('Sydney Airport',4),('Berlin Airport',5),('Paris Airport',6),('Tokyo Airport',7),('Benazir Airport',8),('Mumbai Airport',9),('Beijing Airport',10),('LA Airport',11),('Manchester Airport',12),('Vancouver Airport',13),('Melbourne Airport',14),('Hamburg Airport',15),('Nice Airport',16),('Osaka Airport',17),('Iqbal Airport',18),('Delhi Airport',19),('Shanghai Airport',20),('Chicago Airport',21),('Birmingham Airport',22),('Calgary Airport',23),('Brisbane Airport',24),('Munich Airport',25),('Lyon Airport',26),('Kyoto Airport',27),('Jinnah Airport',28),('Kolkata Airport',29),('Guangzhou Airport',30)

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO CrewRole
VALUES('Pilot'),('Air Host'),('Air Hostess'),('Flight Engineer'),('In Flight Chef'),('Medical Personnel'),('Load Master'),('Ground Crew')
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


INSERT INTO Aircraft
VALUES('Boeing 747'),('Airbus A320'),('Embraer E190'),('Bombardier CRJ900'),('Boeing 787'),('Airbus A380'),('Cessna 172');


INSERT INTO Flight
VALUES(2,'2022-4-5 10:00:00',18,'2022-4-5 11:30:00',19),(4,'2022-5-5 10:00:00',13,'2022-5-5 14:00:00',17),(5,'2022-5-10 9:00:00',18,'2022-5-10 18:20:00',1),(1,'2022-6-19 11:00:00',5,'2022-6-19 14:30:00',20),(3,'2022-10-10 13:00:00',20,'2022-10-10 18:00:00',30),(2,'2022-12-30 10:30:00',1,'2022-12-30 17:30:00',25),(7,'2023-1-5 12:00:00',14,'2022-1-5 19:00:00',24),(2,'2023-2-17 9:00:00',18,'2022-2-17 20:30:00',25),(1,'2023-2-20 14:00:00',2,'2022-2-20 17:00:00',7),(5,'2023-3-15 11:30:00',10,'2022-3-15 20:40:00',14),(3,'2023-4-5 16:00:00',11,'2022-4-5 23:10:00',13)

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO Baggage
VALUES('A black breifcase',1,1),('DELL A10 laptop',6,1),('Golf clubs',20,2),('Cricket equipments bag',47,4),('Guitar',58,5)
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO Feedback
VALUES('Had one of the best experience with this airline.',6,1,10,3),('Food needs improvement.',19,2,7,1),('Lights quality was not good in economy class as compared to other airlines.',54,5,6,1)
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
