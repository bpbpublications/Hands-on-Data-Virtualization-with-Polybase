-- Enable PolyBase, Hadoop connectivity and export
EXEC [sp_configure] @configname='polybase enabled', @configvalue=1
GO
RECONFIGURE
GO
EXEC [sp_configure] @configname='hadoop connectivity', @configvalue=7
GO
RECONFIGURE
GO
EXEC [sp_configure] @configname='allow polybase export', @configvalue=1
GO
RECONFIGURE
GO

-- Create database and master key encryption
-- IMPORTANT!!! Use a secure password of your own
CREATE DATABASE [DatabaseA]
GO
USE [DatabaseA]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '@Sq1T3st'
GO

-- Create external data source
CREATE EXTERNAL DATA SOURCE [MyHadoopCluster] WITH (
  TYPE=HADOOP,
  LOCATION='hdfs://f95a8ee5f9b8:9000')
GO

-- Create external file format
CREATE EXTERNAL FILE FORMAT [TextFileFormat] WITH (
  FORMAT_TYPE=DELIMITEDTEXT,
  FORMAT_OPTIONS (
    FIELD_TERMINATOR='|',
    USE_TYPE_DEFAULT=TRUE))
GO

-- Create external table
CREATE EXTERNAL TABLE [dbo].[test] (
  [Content] varchar(128))
WITH (
  LOCATION='/user/pdw_user/input',
  DATA_SOURCE=[MyHadoopCluster],
  FILE_FORMAT=[TextFileFormat])
GO

-- Write to Hadoop
INSERT INTO [test] VALUES ('1'), ('2')
SELECT [Content] FROM [test]
