-- Create database scoped credential
-- IMPORTANT!!! Use the secret of your Azure storage
CREATE DATABASE SCOPED CREDENTIAL [AzureStorageCredential] WITH
  IDENTITY='user',
  SECRET='zge . . . 8V/rw=='

-- Create external data source
-- IMPORTANT!!! Use your Azure storage name and container name
CREATE EXTERNAL DATA SOURCE [MyWASB] WITH (
  TYPE=HADOOP,
  LOCATION='wasb://myblob@pabechevb.blob.core.windows.net/',
  CREDENTIAL=[AzureStorageCredential])

-- Create file format
CREATE EXTERNAL FILE FORMAT [TextFileFormat] WITH (
  FORMAT_TYPE=DELIMITEDTEXT,
  FORMAT_OPTIONS (
    FIELD_TERMINATOR='|',
	USE_TYPE_DEFAULT=TRUE))

-- Create external table
CREATE EXTERNAL TABLE [dbo].[testBLOB] (
  [Content] varchar(128))
WITH (
  LOCATION='/Demo',
  DATA_SOURCE=[MyWASB],
  FILE_FORMAT=[TextFileFormat])

-- Write to WASB
INSERT INTO [testBLOB] VALUES ('1'), ('2')
SELECT [Content] FROM [testBLOB]
