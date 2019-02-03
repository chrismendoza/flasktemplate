import mysql.connector
import json

from flask import Flask, g

app = Flask(__name__)

def get_db():
    """
        Opens a new database connection if there is none yet for the
        current application context.
    """
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'apatest'
    }

    if not hasattr(g, 'mysql_db'):
        g.mysql_db = mysql.connector.connect(**config)
    return g.mysql_db

def get_cursor():
    db = get_db()
    return db.cursor()

@app.route('/')
def hello():
    cur = get_cursor()
    cur.execute("SELECT * FROM pets")
    row_headers=[x[0] for x in cur.description]

    data = cur.fetchall()

    json_data=[]
    for result in data:
        json_data.append(dict(zip(row_headers,result)))

    return 'Hello, here are a list of pets from the DB: %s' % json.dumps(json_data)

@app.teardown_appcontext
def close_db(error):
    """Closes the database again at the end of the request."""
    if hasattr(g, 'mysql_db'):
        g.mysql_db.close()

if __name__ == '__main__':
    # Only for debugging while developing
    app.run(host="0.0.0.0", debug=True, port=8080)