// Create database
use MyDb
db.runCommand({ customAction: "CreateDatabase" })

// Create collection (table)
db.runCommand({ customAction: "CreateCollection", collection: "MyCollection" })

// Insert record manually
try {
  db.MyCollection.insertMany(
    [
      {
        "_id": "5f3ad86053ee23bc33ae2924",
        "index": 0,
        "guid": "40df03d7-8e86-4582-b4d2-f951d9de7476",
        "isActive": false,
        "balance": "$3,874.99",
        "picture": "http://placehold.it/32x32",
        "age": 21,
        "eyeColor": "brown",
        "name": "Jenna Jimenez",
        "gender": "female",
        "company": "MICROLUXE",
        "email": "jennajimenez@microluxe.com",
        "phone": "+1 (825) 414-2943",
        "address": "564 Portal Street, Carlton, Palau, 5668",
        "about": "Esse dolor esse excepteur dolor ex exercitation. Laborum deserunt proident adipisicing nulla dolor est culpa aliquip duis sunt ut. Reprehenderit mollit nulla et aute in consequat occaecat ex. Officia non magna aute esse culpa esse dolor amet.\r\n",
        "registered": "2020-08-09T02:22:41 +06:00",
        "latitude": -27.872643,
        "longitude": 104.415111,
        "tags": [
          "occaecat",
          "eu",
          "elit",
          "est",
          "reprehenderit",
          "in",
          "ex"
        ],
        "friends": [
          {
            "id": 0,
            "name": "Teresa George"
          },
          {
            "id": 1,
            "name": "Salas Cameron"
          },
          {
            "id": 2,
            "name": "Mccormick Wagner"
          }
        ],
        "greeting": "Hello, Jenna Jimenez! You have 5 unread messages.",
        "favoriteFruit": "apple"
      }
    ], { w: "majority", wtimeout: 100 }
  );
} catch (e) {
  print (e);
}

// Query inserted record
db.MyCollection.findOne()

// Query number of records
db.MyCollection.count()
