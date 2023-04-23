import datetime

from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import (
    Column,
    Integer,
    DateTime,
    String,
    ForeignKey,
    Boolean
)
from sqlalchemy.dialects import mysql

DB = SQLAlchemy()

class User(DB.Model):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    username = Column(String, nullable=False)

    def serialize(self):
        return {c.name: getattr(self, c.name) for c in self.__table__.columns}

class DailyTasks(DB.Model):
    __tablename__ = "daily_entries"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable = False)
    initiation_date = Column(DateTime, nullable=False)
    frequency = Column(Integer, nullable=False)
    recurring = Column(Integer, nullable=False)
    completed = Column(Boolean, default=False)
    parent_id = Column(Integer)

    def serialize(self):
        return {c.name: getattr(self, c.name) for c in self.__table__.columns}



