-- Create external data source
-- IMPORTANT!!! Specify correct path and filename
CREATE EXTERNAL DATA SOURCE [Excel] WITH (
  LOCATION='odbc://nohost',
  CONNECTION_OPTIONS='Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)}; DBQ=C:\setup\Book1.xlsx;')

-- Create external table
CREATE EXTERNAL TABLE [ExcelTable] (
  [PrimaryKey] FLOAT(53),
  [RandomInt] FLOAT(53),
  [RandomFloat] FLOAT(53))
WITH (
  LOCATION='[Sheet1$]',
  DATA_SOURCE=[Excel])

-- Count number of records in Excel
SELECT COUNT(1) FROM [ExcelTable]

-- Get all records in Excel
SELECT * FROM [ExcelTable]
