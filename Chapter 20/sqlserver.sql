-- Create external data source
-- IMPORTANT!!! Use your own MariaDB IP address, username and secure password
CREATE EXTERNAL DATA SOURCE [MariaDB] WITH (
  LOCATION='odbc://192.168.1.3:3306',
  CONNECTION_OPTIONS='Driver={MariaDB ODBC 3.1 Driver}; UID=MariaDB; PWD=@Mar!aDBT3st;')

-- Create external table
CREATE EXTERNAL TABLE [MariaDBTable] (
  [PrimaryKey] INT,
  [RandomInt] INT NOT NULL,
  [RandomFloat] REAL NOT NULL)
WITH (
  LOCATION='MariaDb.MariaDBTable',
  DATA_SOURCE=[MariaDB])

-- Query MariaDB
SELECT COUNT(1) FROM [MariaDBTable] OPTION(DISABLE EXTERNALPUSHDOWN)

-- Query MariaDB partitioned data
CREATE PARTITION FUNCTION [PFInt2](INT) AS RANGE RIGHT FOR VALUES(499999)
GO
SELECT $PARTITION.[PFInt2]([PrimaryKey]) [Partition], COUNT(1) [Count]
  FROM [MariaDBTable]
 GROUP BY $PARTITION.[PFInt2]([PrimaryKey])
 ORDER BY [Partition]
