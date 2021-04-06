-- Create database scoped credential
-- IMPORTANT!!! Use your Cassandra username and password
CREATE DATABASE SCOPED CREDENTIAL [CassandraCred] WITH
  IDENTITY = 'cassandra',
  SECRET = 'cassandra'

-- Create external data source
-- IMPORTANT!!! Use your Cassandra IP address
CREATE EXTERNAL DATA SOURCE [Cassandra] WITH (
  LOCATION='odbc://192.168.1.5:9042',
  CONNECTION_OPTIONS='Driver={DataStax Cassandra ODBC Driver}; Host=192.168.1.5; AuthMech=1;',
  CREDENTIAL=[CassandraCred])

-- Create external table
CREATE EXTERNAL TABLE [RandomData] (
  [index] INT NOT NULL,
  [_id] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [about] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [address] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [age] INT,
  [balance] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [company] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [email] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [eyecolor] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [favoritefruit] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [gender] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [greeting] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [guid] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [isactive] BIT,
  [latitude] REAL,
  [longitude] REAL,
  [name] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [phone] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [picture] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [registered] DATETIME2(6))
WITH (
  LOCATION='Cassandra.MyKeyspace.RandomData',
  DATA_SOURCE=[Cassandra])

-- Get number of records in Cassandra
SELECT COUNT(*) FROM [RandomData]

-- Create external table to monitor "sessions" table
CREATE EXTERNAL TABLE [Sessions] (
  [session_id] UNIQUEIDENTIFIER NOT NULL,
  [client] NVARCHAR(65) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [command] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [coordinator] NVARCHAR(65) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [coordinator_port] INT,
  [duration] INT,
  [request] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [started_at] DATETIME2(6))
WITH (
  LOCATION='Cassandra.system_traces.sessions',
  DATA_SOURCE=[Cassandra])

-- Create external table to monitor "parameters" collection in "sessions" table
CREATE EXTERNAL TABLE [Sessions_vt_parameters] (
  [session_id] UNIQUEIDENTIFIER NOT NULL,
  [parameters_key] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [parameters_value] NVARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL)
WITH (
  LOCATION='Cassandra.system_traces.sessions_vt_parameters',
  DATA_SOURCE=[Cassandra])

-- Get queries executed in Cassandra using monitoring tables, first way
SELECT [s].[session_id], [started_at], [client], [duration], [parameters_key], [parameters_value]
  INTO #TempResults
  FROM [Sessions] [s]
 INNER JOIN [Sessions_vt_parameters] [sp] ON [sp].[session_id] = [s].[session_id] AND [parameters_key] = 'query';
DELETE FROM #TempResults WHERE [parameters_value] IN (
  'SELECT cql_version, release_version FROM system.local',
  'SELECT keyspace_name FROM system_schema.keyspaces',
  'SELECT * FROM system.local WHERE key=''local''',
  'SELECT * FROM system.peers',
  'SELECT * FROM system_schema.aggregates',
  'SELECT * FROM system_schema.columns',
  'SELECT * FROM system_schema.functions',
  'SELECT * FROM system_schema.indexes',
  'SELECT * FROM system_schema.keyspaces',
  'SELECT * FROM system_schema.tables',
  'SELECT * FROM system_schema.types',
  'SELECT * FROM system_schema.views',
  'SELECT started_at, client, duration, parameters FROM system_traces.sessions;')
SELECT * FROM #TempResults ORDER BY [started_at], [session_id];
DROP TABLE #TempResults;

-- Get queries executed in Cassandra using monitoring tables, second way
SELECT [s].[session_id], [started_at], [client], [duration], [parameters_key], [parameters_value]
  INTO #TempResults
  FROM [Sessions] [s]
 INNER JOIN [Sessions_vt_parameters] [sp] ON [sp].[session_id] = [s].[session_id] AND [parameters_key] = 'query'
 WHERE [parameters_value] NOT IN (
  'SELECT cql_version, release_version FROM system.local',
  'SELECT keyspace_name FROM system_schema.keyspaces',
  'SELECT * FROM system.peers',
  'SELECT * FROM system_schema.aggregates',
  'SELECT * FROM system_schema.columns',
  'SELECT * FROM system_schema.functions',
  'SELECT * FROM system_schema.indexes',
  'SELECT * FROM system_schema.keyspaces',
  'SELECT * FROM system_schema.tables',
  'SELECT * FROM system_schema.types',
  'SELECT * FROM system_schema.views');
DELETE FROM #TempResults WHERE [parameters_value] IN (
  'SELECT * FROM system.local WHERE key=''local''',
  'SELECT started_at, client, duration, parameters FROM system_traces.sessions;');
SELECT * FROM #TempResults ORDER BY [started_at], [session_id];
DROP TABLE #TempResults;
