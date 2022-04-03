from flask import Flask
from datetime import datetime
import json

app = Flask(__name__)

@app.route("/")

# Get Today's Date in ISO 8601 format
def get_date():
    my_date = datetime.now()
    today = my_date.strftime('%Y-%m-%d')
    data = {"Today": today}

    return json.dumps(data)




