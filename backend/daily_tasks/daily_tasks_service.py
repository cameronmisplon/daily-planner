from datetime import datetime
from dateutil.relativedelta import relativedelta

from daily_tasks import daily_tasks_dao
from repo.models import DailyTasks, DB, User
from users import users_dao

RECURRING_ENUM = ["Once-off", "Repeat once", "Repeat always"]
FREQUENCY_ENUM = ["Daily", "Weekly", "Monthly"]

def create_task(username: str, initiation_date: datetime, frequency: int, recurring: int, completed: bool) -> DailyTasks:
    valid: bool = verify_conditions(frequency, recurring)
    user: User = users_dao.get_user_by_username(username)

    if not valid or user is None:
        raise Exception()
    
    task = daily_tasks_dao.create(user.id, initiation_date, frequency, recurring, completed)
    if task.recurring != RECURRING_ENUM.index("Once-off"):
        if task.recurring == RECURRING_ENUM.index("Repeat once"):
            secondary_task = generate_next_task(task, task.id)
            DB.session.add(secondary_task)
            
        elif task.recurring == RECURRING_ENUM.index("Repeat always"):
            secondary_task = task
            for i in range(2000):
                secondary_task = generate_next_task(secondary_task, task.id)
                DB.session.add(secondary_task)
    
    DB.session.commit()
    return task

def get_all_tasks(username: str) -> list[DailyTasks]:
    user: User = users_dao.get_user_by_username(username)

    if user is None:
        raise Exception()
    
    return daily_tasks_dao.get_daily_tasks(user.id)

def mark_task_as_completed(task_id: int, completed: bool) -> None:
    task: DailyTasks = daily_tasks_dao.get_task_by_id(task_id)

    if task is None:
        raise Exception()
    
    task.completed = completed
    DB.session.commit()

def delete_task(task_id: int) -> None:
    task: DailyTasks = daily_tasks_dao.get_task_by_id(task_id)

    if task is None:
        raise Exception()
    
    deleted_tasks: list[DailyTasks] = []
    
    if task.parent_id is None:
        deleted_tasks.append(task)
        tasks = daily_tasks_dao.get_tasks_by_parent_id(task.id)
    else:
        task: DailyTasks = daily_tasks_dao.get_task_by_id(task.parent_id)
        if task is None:
            raise Exception()
        
        deleted_tasks.append(task)
        tasks = daily_tasks_dao.get_tasks_by_parent_id(task.id)
    
    deleted_tasks.extend(tasks)

    for deleted_task in deleted_tasks:
        DB.session.delete(deleted_task)
    DB.session.commit()                 

def verify_conditions(frequency: int, recurring: int) -> bool:
    if (type(frequency) == int and type(recurring) == int):
        if (frequency >= 0 and frequency < len(FREQUENCY_ENUM)):
            if (recurring >= 0 and recurring < len(RECURRING_ENUM)):
                return True
        
    return False

def generate_next_task(task: DailyTasks, parent_id: int) -> DailyTasks:
    if type(task.initiation_date) == str:
        initiation_date: datetime = datetime.strptime(task.initiation_date, "%Y-%m-%d %H:%M:%S")
    else:
        initiation_date: datetime = task.initiation_date
    
    updated_date: datetime
    if task.frequency == FREQUENCY_ENUM.index("Daily"):
        updated_date = (initiation_date + relativedelta(days=1))
        secondary_task = DailyTasks(user_id = task.user_id, initiation_date = updated_date, recurring = RECURRING_ENUM.index("Once-off"), frequency = task.frequency, completed = False, parent_id = parent_id)
    elif task.frequency == FREQUENCY_ENUM.index("Weekly"):
        updated_date = (initiation_date + relativedelta(weeks=1))
        secondary_task = DailyTasks(user_id = task.user_id, initiation_date = updated_date, recurring = RECURRING_ENUM.index("Once-off"), frequency = task.frequency, completed = False, parent_id = parent_id)
    elif task.frequency == FREQUENCY_ENUM.index("Monthly"):
        updated_date = (initiation_date + relativedelta(months=1))
        secondary_task = DailyTasks(user_id = task.user_id, initiation_date = updated_date, recurring = RECURRING_ENUM.index("Once-off"), frequency = task.frequency, completed = False, parent_id = parent_id)

    return secondary_task