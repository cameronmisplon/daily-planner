from repo.models import DB, User

def get_user_by_username(username: str) -> User:
    return DB.session.query(User).filter(User.username == username).one_or_none()