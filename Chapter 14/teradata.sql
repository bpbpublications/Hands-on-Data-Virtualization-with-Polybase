-- View database information
select * from dbc.dbcinfo;

-- Create test table with row partitioning
CREATE TABLE TD_SERVER_DB.TableC (
  MyKey INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (NO CYCLE),
  RandomInt INTEGER NOT NULL,
  RandomFloat DECIMAL(13,2) NOT NULL)
PRIMARY INDEX (MyKey)
PARTITION BY (RandomInt);

-- Create test table with column partitioning
CREATE TABLE TD_SERVER_DB.TableC (
  MyKey INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (NO CYCLE),
  RandomInt INTEGER NOT NULL,
  RandomFloat DECIMAL(13,2) NOT NULL)
PRIMARY INDEX (MyKey)
PARTITION BY COLUMN (RandomInt);

-- Populate test table
INSERT INTO TD_SERVER_DB.TableC (RandomInt, RandomFloat)
SELECT TOP 1000000 RANDOM(1, 10), CAST(RANDOM(0,999999999) AS FLOAT)/1000000000 (FORMAT '9.999999999')
  FROM sys_calendar.CALENDAR c1
 CROSS JOIN sys_calendar.CALENDAR c2;

-- Enable logging of PolyBase commands
BEGIN QUERY LOGGING LIMIT SQLTEXT=10000 ON ALL;

-- View commands executed by PolyBase
-- IMPORTANT!!! Use your host IP address from where SQL Server with PolyBase is querying the data
.SET WIDTH 10000
FLUSH QUERY LOGGING WITH ALL;
SELECT StartTime, QueryText, ElapsedTime, NumResultRows
  FROM DBC.QryLogV
 WHERE UserName='DBC'
   AND ClientAddr='186.151.122.214'
 ORDER BY StartTime;

-- Exit database console
.quit
