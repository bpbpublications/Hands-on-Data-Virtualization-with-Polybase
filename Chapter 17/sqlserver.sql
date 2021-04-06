-- Create database scoped credential
CREATE DATABASE SCOPED CREDENTIAL [CosmosCredential] WITH
  IDENTITY='localhost',
  SECRET='C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTq obD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw=='

-- Create external data source
-- IMPORTANT!!! Use your CosmosDB IP address or hostname
CREATE EXTERNAL DATA SOURCE [Cosmos] WITH (
  LOCATION='mongodb://172.17.188.209:10255',
  CREDENTIAL=[CosmosCredential])

-- Create external table for CosmosDB emulator
CREATE EXTERNAL TABLE [MyCollection] (
  [_id] NVARCHAR(24) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [index] INT,
  [guid] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [isActive] BIT,
  [balance] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [picture] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [age] INT,
  [eyeColor] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [name] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [gender] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [company] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [email] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [phone] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [address] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [about] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [registered] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [latitude] FLOAT(53),
  [longitude] FLOAT(53),
  [greeting] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [favoriteFruit] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [MyCollection_friends_id] INT,
  [MyCollection_friends_name] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [MyCollection_tags] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS)
WITH (
  LOCATION='MyDb.MyCollection',
  DATA_SOURCE=[Cosmos])

-- Create external table for Azure CosmosDB 3.2
CREATE EXTERNAL TABLE [MyCollection] (
  [_id] NVARCHAR(24) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [index] FLOAT(53),
  [guid] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [isActive] BIT,
  [balance] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [picture] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [age] FLOAT(53),
  [eyeColor] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [name] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [gender] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [company] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [email] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [phone] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [address] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [about] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [registered] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [latitude] FLOAT(53),
  [longitude] FLOAT(53),
  [greeting] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [favoriteFruit] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [MyCollection_friends_id] FLOAT(53),
  [MyCollection_friends_name] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [MyCollection_tags] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS)
WITH (
  LOCATION='MyDb.MyCollection',
  DATA_SOURCE=[Cosmos])

-- Get data from CosmosDB
SELECT * FROM MyCollection
