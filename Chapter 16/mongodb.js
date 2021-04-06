// Get help
help

// List databases and sizes
show dbs

// Select a database
use MyDb

// Count number of records in a table
db.RandomData.count()

// Enable monitoring of queries being run against the database
db.setProfilingLevel(2)

// Create a view to monitor queries against the database
db.createView("systemprofile","system.profile",[{$project: {op:1,ns:1,command:1,keysExamined:1,docsExamined:1,response Length:1,millis:1,execStats:1,ts:1}}])

// Query the view to find queries run against the database
db.systemprofile.find().sort({ts:1})

// Exit
exit