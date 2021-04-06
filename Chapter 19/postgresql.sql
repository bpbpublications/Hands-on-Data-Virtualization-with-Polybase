-- Switch to database
\connect postgres

-- Create partitioned table
CREATE TABLE "PostgresTable" (
  "PrimaryKey" SERIAL PRIMARY KEY,
  "RandomInt" INTEGER NOT NULL,
  "RandomFloat" REAL NOT NULL)
PARTITION BY RANGE("PrimaryKey");
CREATE TABLE PostgresTablePart1 PARTITION OF "PostgresTable"
  FOR VALUES FROM (1) TO (500001);
CREATE TABLE PostgresTablePart2 PARTITION OF "PostgresTable"
  FOR VALUES FROM (500001) TO (1000001);

-- Populate table
do $$
declare
  NumberOfRows INTEGER := 1000000;
  StartValue INTEGER := 1;
  EndValue INTEGER := 10;
  Range INTEGER := EndValue - StartValue + 1;
begin
  INSERT INTO "PostgresTable" ("RandomInt", "RandomFloat")
  SELECT random()*Range+StartValue, random()*Range+StartValue
    FROM generate_series(1,NumberOfRows) s;
end $$;
