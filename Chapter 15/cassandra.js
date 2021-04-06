// Get help
help

// Create keyspace
CREATE KEYSPACE "MyKeyspace" WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };

// Create data type
CREATE TYPE "MyKeyspace"."Friends" ( id int, name text );

// Create table
CREATE TABLE "MyKeyspace"."RandomData" (
  "_id" text,
  "index" int,
  guid text,
  "isActive" boolean,
  balance text,
  picture text,
  age int,
  "eyeColor" text,
  name text,
  gender text,
  company text,
  email text,
  phone text,
  address text,
  about text,
  registered timestamp,
  latitude decimal,
  longitude decimal,
  tags list<text>,
  friends list<frozen<"MyKeyspace"."Friends">>,
  greeting text,
  "favoriteFruit" text,
  PRIMARY KEY ("index"));

// Get number of records
SELECT COUNT(*) FROM "MyKeyspace"."RandomData";

// Get query stats
SELECT started_at, client, duration, parameters FROM system_traces.sessions;

// Exit console
exit
