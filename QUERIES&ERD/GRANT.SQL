-- Create the database AMS
CREATE DATABASE AMS;
GO

-- Create SQL Server login 'RAM' with SQL Authentication
CREATE LOGIN RAM WITH PASSWORD = 'your_secure_password';
GO

-- Switch to the AMS database
USE AMS;
GO

-- Create a user in the AMS database for the 'RAM' login
CREATE USER RAM FOR LOGIN RAM;
GO

-- Grant full access by adding the 'RAM' user to the db_owner role
ALTER ROLE db_owner ADD MEMBER RAM;
GO
