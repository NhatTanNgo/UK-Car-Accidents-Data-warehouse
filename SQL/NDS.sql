use master
if DB_ID ('NDS_DATH') is not null
	drop database NDS_DATH
GO

CREATE DATABASE NDS_DATH 
USE NDS_DATH
GO

CREATE TABLE Source_NDS
(
	Source_ID INT IDENTITY(1,1) PRIMARY KEY,
	Source_Name VARCHAR(50)
)

INSERT INTO dbo.Source_NDS
VALUES ('Codebook'), ('Accidents'), ('Casualties'), ('Vehicles'), ('Postcodes')


CREATE TABLE Severity
(
	Severity_ID INT IDENTITY(1,1) PRIMARY KEY,
	CODE_NK  VARCHAR(50),
	LABEL VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Local_Authority_Highway
(
	Local_Authority_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE RoadType
(
	RoadType_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE CasualtiesClass
(
	CasualtiesClass_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE AgeBand
(
	AgeBand_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS 
)

CREATE TABLE VehicleType
(
	VehicleType_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE CasualtyType
(
	CasualtyType INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(100),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE JourneyPurpose
(
	JourneyPurpose_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE PoliceForce
( 
	PoliceForce_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK NVARCHAR(50),
	Label NVARCHAR(150),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Region
(
	Region_ID INT IDENTITY(1,1) PRIMARY KEY,
	Region_NK VARCHAR(50),
	RegionName VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Country
(
	Country_ID INT IDENTITY(1,1) PRIMARY KEY,
	Country_NK VARCHAR(50),
	CountryName VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Postcode
(
	Postcode_ID INT IDENTITY (1,1) PRIMARY KEY,
	Postcode VARCHAR(50),
	LSOA11CD VARCHAR(50),
	Latitude VARCHAR(50),
	Longtitude VARCHAR(50),
	Easting VARCHAR(50),
	Northing VARCHAR(50),
	TownCity VARCHAR(50),
	County VARCHAR(50),
	CountryID INT FOREIGN KEY REFERENCES dbo.Country,
	RegionID INT FOREIGN KEY REFERENCES dbo.Region,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Location
(
	Location_ID INT IDENTITY(1,1) PRIMARY KEY,
	Location_Easting VARCHAR(50),
	Location_Northing VARCHAR(50),
	Location_Longtitude VARCHAR(50),
	Location_Latitude VARCHAR(50),
	Postcode_ID INT FOREIGN KEY REFERENCES dbo.Postcode,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Accidents
(
	Accident_ID INT IDENTITY (1,1) PRIMARY KEY,
	Accident_NK VARCHAR(50),
	Accident_Severity INT FOREIGN KEY REFERENCES dbo.Severity,
	Date DATE,
	Time TIME,
	Local_Authority INT FOREIGN KEY REFERENCES dbo.Local_Authority_Highway,
	RoadType INT FOREIGN KEY REFERENCES dbo.RoadType,
	SpeedLimit INT,
	Build_Up_Road VARCHAR(50),
	Location_ID INT FOREIGN KEY REFERENCES dbo.Location,
	Police_ID INT FOREIGN KEY REFERENCES dbo.PoliceForce,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Casualties
(
	Casualties_ID INT IDENTITY(1,1) PRIMARY KEY,
	Accident_ID INT FOREIGN KEY REFERENCES dbo.Accidents,
	Casualty_Class INT FOREIGN KEY REFERENCES dbo.CasualtiesClass,
	Sex VARCHAR(10),
	Age INT,
	AgeBand INT FOREIGN KEY REFERENCES dbo.AgeBand,
	CasualtyType INT FOREIGN KEY REFERENCES dbo.CasualtyType,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Vehicle
(
	Vehicle_ID INT IDENTITY(1,1) PRIMARY KEY,
	Accident_ID INT FOREIGN KEY REFERENCES dbo.Accidents,
	VehicleType INT FOREIGN KEY REFERENCES dbo.VehicleType,
	JourneyPurpose INT FOREIGN KEY REFERENCES dbo.JourneyPurpose,
	Driver_sex VARCHAR(10),
	Driver_Age INT,
	AgeBand INT FOREIGN KEY REFERENCES dbo.AgeBand,
	EngineCapacity VARCHAR(50),
	VehicleAge INT,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)



