use master
if DB_ID ('Stage') is not null
	drop database Stage

create database Stage
go
use Stage

CREATE TABLE METADATA
(
	TABLE_NAME VARCHAR(100),
	LSET DATETIME
)

INSERT METADATA
VALUES
('Accidents',NULL),
('Casualties', NULL),
('Vehicles', NULL),
('PCD', NULL),
('Postcodes', NULL)