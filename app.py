from flask import Flask, jsonify
import sqlite3

app = Flask(__name__)

def get_db_connection():
    """Establish a connection to the SQLite database."""
    conn = sqlite3.connect('db.sqlite3')  # Database file is 'db.sqlite3'
    conn.row_factory = sqlite3.Row  # Fetch rows as dictionaries
    return conn

@app.route('/')
def index():
    """Basic homepage message."""
    return "Welcome to the Prediction Data API"

@app.route('/data', methods=['GET'])
def fetch_data():
    """Fetch all data from the Prediction table."""
    conn = get_db_connection()
    cursor = conn.cursor()

    # Fetch data from the Prediction table
    query = "SELECT * FROM Prediction_prediction"
    cursor.execute(query)

    rows = cursor.fetchall()
    conn.close()

    data = [dict(row) for row in rows]  # Convert rows to a list of dictionaries
    return jsonify(data)  # Return the data as JSON

if __name__ == '__main__':
    app.run(debug=True)
