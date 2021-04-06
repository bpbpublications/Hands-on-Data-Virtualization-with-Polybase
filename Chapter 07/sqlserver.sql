-- Enable PolyBase
EXEC sp_configure @configname='polybase enabled', @configvalue=1
GO
RECONFIGURE
GO

-- Enable PolyBase export
EXEC [sp_configure] @configname='allow polybase export', @configvalue=1
GO
RECONFIGURE
GO

-- Verify PolyBase is enabled
SELECT CAST(SERVERPROPERTY('IsPolyBaseInstalled') AS INT) [IsPolyBaseInstalled]
GO

-- Create new database and switch to it
CREATE DATABASE [DatabaseA]
GO
USE [DatabaseA]
GO

-- Create master key encryption
-- IMPORTANT!!! Change the password to a secure one of your own
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '@Sq1T3st'
GO

-- Create database scoped credential
-- IMPORTANT!!! Use your own secure SaPwd
CREATE DATABASE SCOPED CREDENTIAL [SqlServer] WITH IDENTITY = 'sa', SECRET = '@Sq1T3st'
GO

-- Create external data source
CREATE EXTERNAL DATA SOURCE [ServerA] WITH (
  LOCATION='sqlserver://127.0.0.1',
  CREDENTIAL=[SqlServer])
GO

-- Create external table
CREATE EXTERNAL TABLE [databases_external] (
  [name] NVARCHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS)
WITH (
  LOCATION='master.sys.databases',
  DATA_SOURCE=[ServerA])
GO

-- Query the extenal table
SELECT * FROM [databases_external]
GO

-- Save the execution plan while querying the external table: doesn't include the remote query
-- IMPORTANT!!! Specify a valid file location and a unique filename
SET NOCOUNT ON
GO
SET STATISTICS XML ON
GO
:OUT C:\setup\databases_external.xmlplan
SELECT * FROM [databases_external]
GO
:OUT STDOUT
SET STATISTICS XML OFF
GO
SET NOCOUNT OFF
GO

-- Save the event session while querying the external table: includes the remote query
-- IMPORTANT!!! Specify a valid file location and a unique filename
CREATE EVENT SESSION databases_external ON SERVER
ADD EVENT sqlserver.query_post_execution_showplan(ACTION(sqlserver.database_name, package0.event_sequence,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.session_id,sqlserver.sql_text,sqlserver.tsql_frame,sqlserver.tsql_stack))
ADD TARGET package0.event_file(SET filename=N'C:\setup\databases_external.xel')
GO
ALTER EVENT SESSION databases_external ON SERVER STATE=START
GO
SELECT * FROM [databases_external]
GO
ALTER EVENT SESSION databases_external ON SERVER STATE=STOP
GO
DROP EVENT SESSION databases_external ON SERVER
GO

-- ServerC: Create database with partitioned table and populate
CREATE DATABASE [DatabaseC] ON PRIMARY (
  NAME='DatabaseC', FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DatabaseC.mdf', SIZE=8MB, FILEGROWTH=64MB),
FILEGROUP [FG1] (
  NAME='DatabaseCFG1', FILENAME='C:\setup\DatabaseCFG1.ndf', SIZE=8MB, FILEGROWTH=64MB),
FILEGROUP [FG2] (
  NAME='DatabaseCFG2', FILENAME='C:\setup\DatabaseCFG2.ndf', SIZE=8MB, FILEGROWTH=64MB)
LOG ON (
  NAME='DatabaseC_log', FILENAME='C:\setup\DatabaseC_log.ldf', SIZE=8MB, FILEGROWTH=64MB)
GO
ALTER DATABASE [DatabaseC] SET RECOVERY SIMPLE
GO
CREATE PARTITION FUNCTION [PFInt](INT) AS RANGE RIGHT FOR VALUES(6)
GO
CREATE PARTITION SCHEME [PSInt] AS PARTITION [PFInt] TO ([FG1], [FG2])
GO
CREATE TABLE [dbo].[TableC](
  [Key] INT NOT NULL IDENTITY(1, 1),
  [RandomInt] INT NOT NULL,
  [RandomFloat] FLOAT(53) NOT NULL)
ON [PSInt]([RandomInt])
GO
DECLARE @NumberOfRows INT,
        @StartValue INT,
        @EndValue INT,
        @Range INT
SELECT @NumberOfRows = 10000000,
       @StartValue = 1,
       @EndValue = 10,
       @Range = @EndValue - @StartValue + 1
INSERT [dbo].[TableC]([RandomInt], [RandomFloat])
SELECT TOP (@NumberOfRows) ABS(CHECKSUM(NEWID())) % @Range + @StartValue, RAND(CHECKSUM(NEWID())) * @Range + @StartValue
  FROM [sys].[all_columns] [ac1]
 CROSS JOIN [sys].[all_columns] [ac2]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_TableC_RandomIntKey] ON [dbo].[TableC]([RandomInt], [Key]) ON [PSInt]([RandomInt])
GO
DBCC SHRINKFILE (N'DatabaseC_log', 8)
GO
SELECT $PARTITION.[PFInt]([RandomInt]) [Partition], COUNT(1) [Count]
  FROM [TableC]
 GROUP BY $PARTITION.[PFInt]([RandomInt])
 ORDER BY [Partition]
GO

-- Create partition function in ServerA to retrieve data from external table in ServerC
CREATE PARTITION FUNCTION [PFInt](INT) AS RANGE RIGHT FOR VALUES(6)
GO
SELECT $PARTITION.[PFInt]([RandomInt]) [Partition], COUNT(1) [Count]
  FROM [TableC]
 GROUP BY $PARTITION.[PFInt]([RandomInt])
 ORDER BY [Partition]
GO

-- Count records from external table partitions using UNION ALL
SELECT 1 [Partition], COUNT(1) [Count] FROM [TableC] WHERE [RandomInt] <= 5
 UNION ALL
SELECT 2, COUNT(1) FROM [TableC] WHERE [RandomInt] > 5

-- Count records from external table partitions using inline query
SELECT
(SELECT COUNT(1) FROM [TableC] WHERE [RandomInt] <= 5) [Partition1Count],
(SELECT COUNT(1) FROM [TableC] WHERE [RandomInt] > 5) [Partition2Count]

-- Get all data from external table partitions
SELECT * INTO [TableCCopy]
  FROM [TableC]
 WHERE [RandomInt] <= 5
 UNION ALL
SELECT *
  FROM [TableC]
 WHERE [RandomInt] > 5
