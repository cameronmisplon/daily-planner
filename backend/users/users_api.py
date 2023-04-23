from flask import Blueprint, jsonify, request
from jose import jwt

from users import users_service

USERS_API = Blueprint('users_api', 'users_api', url_prefix='/api/user')

USERS_API.route("/get-users", methods=["GET"])
def get_users():
    users = users_service.get_users()

    return {"users": [user.serialize() for user in users]}