-- Create database scoped credential
-- IMPORTANT!! Use your MySql username and secure password
CREATE DATABASE SCOPED CREDENTIAL [MySqlCredential] WITH
  IDENTITY='root',
  SECRET='@MySq1T3st'

-- Create external data source
-- IMPORTANT!!! Use your MySql IP address
CREATE EXTERNAL DATA SOURCE [MySql] WITH (
  LOCATION='odbc://192.168.1.3:3306',
  CONNECTION_OPTIONS='Driver={MySQL ODBC 8.0 Unicode Driver};',
  CREDENTIAL=[MySqlCredential])

-- Create external table
CREATE EXTERNAL TABLE [MySqlTable] (
  [PrimaryKey] INT,
  [RandomInt] INT NOT NULL,
  [RandomFloat] REAL NOT NULL)
WITH (
  LOCATION='MySqlDb.MySqlTable',
  DATA_SOURCE=[MySql])

-- Count number of records
SELECT COUNT(1) FROM [MySqlTable] OPTION(DISABLE EXTERNALPUSHDOWN)

-- Count number of records in each partition
CREATE PARTITION FUNCTION [PFInt2](INT) AS RANGE RIGHT FOR VALUES(499999)
GO
SELECT $PARTITION.[PFInt2]([PrimaryKey]) [Partition], COUNT(1) [Count]
  FROM [MySqlTable]
 GROUP BY $PARTITION.[PFInt2]([PrimaryKey])
 ORDER BY [Partition]
