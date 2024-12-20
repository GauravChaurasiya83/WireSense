from pymongo import MongoClient

# Replace with your actual connection string
connection_string = "mongodb+srv://betelgeuse715:mBgMGu1VTQgBGu7d@gaurav.pvw5o.mongodb.net/?retryWrites=true&w=majority&appName=GAURAV"

# Connect to the client
client = MongoClient(connection_string)

# Access the database and collection
db = client['TEST']
collection = db['SIH']

# Step 3: Fetch All Data
try:
    # Fetch all documents from the collection
    data = collection.find()
    for document in data:
        print(document)
finally:
    # Step 4: Close the Connection
    client.close()
