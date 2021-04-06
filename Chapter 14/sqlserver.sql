-- Create database scoped credential
-- IMPORTANT!!! Use your Teradata password
CREATE DATABASE SCOPED CREDENTIAL [TeradataCred] WITH
  IDENTITY = 'DBC',
  SECRET = '<Password>'
GO

-- Create external data source
-- IMPORTANT!!! Use your Teradata VM public IP address
CREATE EXTERNAL DATA SOURCE [Teradata] WITH (
  LOCATION='teradata://20.46.43.134:1025',
  CREDENTIAL=[TeradataCred])
GO

-- Create external table
CREATE EXTERNAL TABLE [TableC] (
  [MyKey] INT NOT NULL,
  [RandomInt] INT NOT NULL,
  [RandomFloat] DECIMAL(13, 2) NOT NULL)
WITH (
  LOCATION='TD_SERVER_DB.TableC',
  DATA_SOURCE=[Teradata])
GO

-- Query Teradata partitions with UNION ALL
SELECT 1 [Partition], COUNT(1) [Count] FROM [TableC] WHERE [RandomInt] <= 5
 UNION ALL
SELECT 2, COUNT(1) FROM [TableC] WHERE [RandomInt] > 5
GO

-- Query Teradata partitions using a function
CREATE PARTITION FUNCTION [PFInt](INT) AS RANGE RIGHT FOR VALUES(6)
GO
SELECT $PARTITION.[PFInt]([RandomInt]) [Partition], COUNT(1) [Count]
  FROM [TableC]
 GROUP BY $PARTITION.[PFInt]([RandomInt])
 ORDER BY [Partition]
GO

-- Query all Teradata information
SELECT [RandomInt] FROM [TableC]
