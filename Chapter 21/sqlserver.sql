-- Create database scoped credential
-- IMPORTANT!!! Use your own username and secure password
CREATE DATABASE SCOPED CREDENTIAL [SapCredential] WITH
  IDENTITY = 'SYSTEM',
  SECRET = '@S4pH4n4T3st'

-- Create external data source
-- IMPORTANT!!! Use your own SAP HANA IP address
CREATE EXTERNAL DATA SOURCE [Sap] WITH (
  LOCATION='odbc://40.123.224.129:39015',
  CONNECTION_OPTIONS='Driver={HDBODBC}; SERVERNODE=40.123.224.129:39015;',
  CREDENTIAL=[SapCredential])

-- Create external table
CREATE EXTERNAL TABLE [SapTable] (
   [PrimaryKey] INT NOT NULL,
   [RandomInt] INT NOT NULL,
   [RandomFloat] REAL)
WITH (
  LOCATION='HXE.SapSchema.SapTable',
  DATA_SOURCE=[Sap])

-- Count number of records
SELECT COUNT(1) FROM [SapTable]

-- Get partitioned data
CREATE PARTITION FUNCTION [PFInt](INT) AS RANGE RIGHT FOR VALUES(6)
GO
SELECT $PARTITION.[PFInt]([RandomInt]) [Partition], COUNT(1) [Count]
  FROM [SapTable]
 GROUP BY $PARTITION.[PFInt]([RandomInt])
 ORDER BY [Partition]
