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
