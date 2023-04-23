from repo.models import User
from users import users_dao

def get_users() -> list[User]:
    return users_dao.get_users()