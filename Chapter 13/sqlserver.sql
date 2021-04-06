-- Create database scoped credential
-- IMPORTANT!!! Use your Oracle username and password
CREATE DATABASE SCOPED CREDENTIAL [OracleCred] WITH
  IDENTITY='SYSTEM',
  SECRET='Oradoc_db1'

-- Create external data source
-- IMPORTANT!!! Use your Oracle IP address and port
CREATE EXTERNAL DATA SOURCE [Oracle] WITH (
  LOCATION='oracle://192.168.1.4:1521',
  CREDENTIAL=[OracleCred])

-- Create external table
CREATE EXTERNAL TABLE [T1] (
  [KEY] DECIMAL(38) NOT NULL,
  [RANDOM_INT] DECIMAL(38),
  [RANDOM_FLOAT] FLOAT(53))
WITH (
  LOCATION='[ORCLCDB.localdomain].SYS.T1',
  DATA_SOURCE=[Oracle])

-- Query Oracle
SELECT COUNT(1) FROM [T1]
