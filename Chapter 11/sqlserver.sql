-- Create master key encryption
-- IMPORTANT!!! Use your own secure password
CREATE MASTER KEY ENCRYPTION BY PASSWORD='<password>'

-- Create external file format
CREATE EXTERNAL FILE FORMAT [TextFileFormat] WITH (
  FORMAT_TYPE=DELIMITEDTEXT,
  FORMAT_OPTIONS (
    FIELD_TERMINATOR='|',
	USE_TYPE_DEFAULT=TRUE))

-- Create ADLS Gen1 credential
-- IMPORTANT!!! Use your ADLS Gen1 ClientID, OAuth2 and secret
CREATE DATABASE SCOPED CREDENTIAL [MyADLSCred] WITH
  IDENTITY='<ClientID>@<OAuth2>',
  SECRET='<key>'

-- Create ADLS Gen1 external data source
CREATE EXTERNAL DATA SOURCE [MyADLS] WITH (
  TYPE=HADOOP,
  LOCATION='adl://<ADLSGen1>.azuredatalakestore.net',
  CREDENTIAL=[MyADLSCred])

-- Create ADLS Gen1 external table
CREATE EXTERNAL TABLE [dbo].[ADLS] (
  [Content] varchar(128))
WITH (
  LOCATION='/',
  DATA_SOURCE=[MyADLS],
  FILE_FORMAT=[TextFileFormat])

-- Query ADLS Gen1
SELECT * FROM [ADLS]

-- Create ADLS Gen2 credential
-- IMPORTANT!!! Use your ADLS Gen2 secret
CREATE DATABASE SCOPED CREDENTIAL [MyADLSGen2Cred] WITH
  IDENTITY='user',
  SECRET='zge . . . 8V/rw=='

-- Create ADLS Gen2 external data source
-- IMPORTANT!!! Use your ADLS Gen2 account name and container name
CREATE EXTERNAL DATA SOURCE [MyADLSGen2] WITH (
  TYPE=HADOOP,
  LOCATION='abfs://myblob@pabechevb.dfs.core.windows.net',
  CREDENTIAL=[MyADLSGen2Cred])

-- Create ADLS Gen2 external table
CREATE EXTERNAL TABLE [dbo].[ADLSGen2] (
  [Content] varchar(128))
WITH (
  LOCATION='/',
  DATA_SOURCE=[MyADLSGen2],
  FILE_FORMAT=[TextFileFormat])

-- Query ADLS Gen2
SELECT * FROM [ADLSGen2]

