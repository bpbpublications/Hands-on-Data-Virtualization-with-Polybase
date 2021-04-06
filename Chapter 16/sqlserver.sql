-- Create external data source
-- IMPORTANT!!! Use your MongoDB IP address
CREATE EXTERNAL DATA SOURCE [MongoDb] WITH (
  LOCATION='mongodb://192.168.1.8:27017',
  CONNECTION_OPTIONS='ssl=false;')

-- Create external table
CREATE EXTERNAL TABLE [MongoDbRandomData](
  [_id] NVARCHAR(24) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [index] INT,
  [guid] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [isActive] BIT,
  [balance] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [picture] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [age] INT,
  [eyeColor] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [name] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [gender] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [company] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [email] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [phone] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [address] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [about] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [registered] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [latitude] FLOAT(53),
  [longitude] FLOAT(53),
  [greeting] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [favoriteFruit] NVARCHAR(MAX)COLLATE SQL_Latin1_General_CP1_CI_AS,
  [RandomData_friends_id] INT,
  [RandomData_friends_name] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [RandomData_tags] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS)
WITH (
  LOCATION='MyDb.RandomData',
  DATA_SOURCE=[MongoDb])

-- Get number of records from MongoDB
SELECT COUNT(1) FROM MongoDbRandomData
