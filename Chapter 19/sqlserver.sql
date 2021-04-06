-- Create database scoped credential
-- IMPORTANT!!! Use your PostgreSQL username and secure password
CREATE DATABASE SCOPED CREDENTIAL [PostgresCredential] WITH
  IDENTITY='postgres',
  SECRET='@P0s7gr3sT3st'

-- Create external data source
-- IMPORTANT!!! Use your PostgreSQL IP address
CREATE EXTERNAL DATA SOURCE [Postgres] WITH (
  LOCATION='odbc://192.168.1.3:5432',
  CONNECTION_OPTIONS='Driver={PostgreSQL ANSI(x64)};',
  CREDENTIAL=[PostgresCredential])

-- Create external table
CREATE EXTERNAL TABLE [PostgresTable] (
  [PrimaryKey] INT NOT NULL,
  [RandomInt] INT NOT NULL,
  [RandomFloat] REAL NOT NULL)
WITH (
  LOCATION='PostgresTable',
  DATA_SOURCE=[Postgres])

-- Get data from PostgreSQL
SELECT COUNT(1) FROM [PostgresTable]

-- Get PostgreSQL partitioned data
CREATE PARTITION FUNCTION [PFInt2](INT) AS RANGE RIGHT FOR VALUES(499999)
GO
SELECT $PARTITION.[PFInt2]([PrimaryKey]) [Partition], COUNT(1) [Count]
  FROM [PostgresTable]
 GROUP BY $PARTITION.[PFInt2]([PrimaryKey])
 ORDER BY [Partition]
