from datetime import datetime

from repo.models import DB, DailyTasks

def create(user_id: int, initiation_date: datetime, frequency: int, recurring: int, completed: bool) -> DailyTasks:
    daily_task = DailyTasks()

    daily_task.user_id = user_id
    daily_task.initiation_date = initiation_date
    daily_task.frequency = frequency
    daily_task.recurring = recurring
    daily_task.completed = completed

    DB.session.add(daily_task)
    DB.session.flush()
    return daily_task

def get_daily_tasks(user_id: int) -> list[DailyTasks]:
    return DB.session.query(DailyTasks).filter(DailyTasks.user_id == user_id).all()

def get_task_by_id(task_id: int) -> DailyTasks:
    return DB.session.query(DailyTasks).filter(DailyTasks.id == task_id).one_or_none()

def get_tasks_by_parent_id(parent_id: int) -> list[DailyTasks]:
    return DB.session.query(DailyTasks).filter(DailyTasks.parent_id == parent_id).all()
