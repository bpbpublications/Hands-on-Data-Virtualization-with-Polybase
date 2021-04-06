# Login to Mongo database console
mongo

# Load data into MongoDB database
mongoimport --db MyDb --collection RandomData --file /tmp/json/generated.json --jsonArray

# Run query against MongoDB database
mongo MyDb --eval "db.RandomData.findOne()"
