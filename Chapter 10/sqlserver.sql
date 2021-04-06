-- Create database scoped credential
-- IMPORTANT!!! Use the identity and secret of your Spark instance
CREATE DATABASE SCOPED CREDENTIAL [SparkCredential] WITH
  IDENTITY='admin',
  SECRET='yoursecretkey'

-- Create external data source
-- IMPORTANT!!! Use your Spark name
CREATE EXTERNAL DATA SOURCE [MySpark] WITH (
  LOCATION='odbc://pabechevb.azurehdinsight.net:443',
  CONNECTION_OPTIONS='Driver={Microsoft Spark ODBC Driver}; AuthMech=6;',
  CREDENTIAL=[SparkCredential])

-- Create external table
CREATE EXTERNAL TABLE [dbo].[testSpark] (
  [clientid] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [querytime] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [market] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [deviceplatform] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [devicemake] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [devicemodel] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [state] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [country] CHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [querydwelltime] FLOAT(53),
  [sessionid] BIGINT,
  [sessionpagevieworder] BIGINT)
WITH (
  LOCATION='hivesampletable',
  DATA_SOURCE=[MySpark])

-- Query from Spark
SELECT * FROM [testSpark]
