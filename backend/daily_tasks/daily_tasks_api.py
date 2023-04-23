from flask import Blueprint, jsonify, request
from jose import jwt

from daily_tasks import daily_tasks_service

DAILY_TASKS_API = Blueprint('dailytasks_api', 'dailytasks_api', url_prefix='/api/daily-tasks')

@DAILY_TASKS_API.route('/create', methods = ["POST"])
def create_task():
    data = request.json

    try:
        daily_task = daily_tasks_service.create_task(data["username"], data["initiation_date"], data["frequency"], data["recurring"], data["completed"])
    except Exception as e:
        return {}, 400
    
    return {}, 201

@DAILY_TASKS_API.route('/get-tasks/<string:username>', methods = ["GET"])
def get_tasks(username: str):
    try:
        tasks = daily_tasks_service.get_all_tasks(username)
    except Exception as e:
        return {}, 400
    
    return {"tasks": [task.serialize() for task in tasks]}, 200

@DAILY_TASKS_API.route('/mark-as-complete', methods=["POST"])
def mark_as_complete():
    data = request.json
    try:
        daily_tasks_service.mark_task_as_completed(data["id"])
    except Exception:
        return {}, 400
    
    return {}, 200

@DAILY_TASKS_API.route('/delete-task', methods=["POST"])
def delete_task():
    data = request.json
    try:
        daily_tasks_service.delete_task(data["id"])
    except Exception:
        return {}, 400
    
    return {}, 200
