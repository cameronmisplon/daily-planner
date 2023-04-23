from decimal import Decimal
from flask import Flask, g, request
from flask.json import JSONEncoder
from flask_cors import CORS
from flask_log_request_id import RequestID, RequestIDLogFilter, current_request_id

from daily_tasks.daily_tasks_api import DAILY_TASKS_API
from repo.models import DB

def create_app(dbuser, dbpswd, dbhost, dbname):
    app = Flask(__name__)
    RequestID(app)
    app.json_encoder = CustomJSONEncoder

    # Create database resources.
    app.config[
        "SQLALCHEMY_DATABASE_URI"
    ] = f"mysql+pymysql://{dbuser}:{dbpswd}@{dbhost}/{dbname}?charset=utf8mb4"
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    app.config["SQLALCHEMY_ECHO"] = True
    app.config["SQLALCHEMY_POOL_SIZE"] = 5
    app.config[
        "SQLALCHEMY_POOL_RECYCLE"
    ] = 3600  # Number of seconds before retiring a db connection

    # Register blueprint routes.
    register_blueprints_and_setup_app(app)

    return app

def register_blueprints_and_setup_app(app):
    CORS(app)
    app.register_blueprint(DAILY_TASKS_API)
    DB.init_app(app)

class CustomJSONEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            # Convert decimal instances to strings.
            return float(obj)
        return super(CustomJSONEncoder, self).default(obj)
    
app = create_app("root", "cameron16", "localhost", "daily_planner")