import 'package:app/models/daily_task.dart';
import 'package:app/models/daily_tasks.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/tasks_service.dart';
import 'package:app/viewmodels/base_model.dart';

class TasksModel extends BaseModel {
  final TasksService _tasksService = locator<TasksService>();

  late DailyTasks _dailyTasks;
  DateTime? _initiationDate;
  int? _recurring;
  int? _frequency;
  bool _completed = false;

  DailyTasks get dailyTasks => _dailyTasks;
  DateTime? get initiationDate => _initiationDate;
  int? get recurring => _recurring;
  int? get frequency => _frequency;
  bool get completed => _completed;

  void reset() {
    _initiationDate = null;
    _recurring = null;
    _frequency = null;
    _completed = false;
    super.reset();
  }

  void setInitiationDate(DateTime startDate) {
    setDirty(true);
    _initiationDate = startDate;
    notifyListeners();
  }

  void setRecurring(int value) {
    setDirty(true);
    _recurring = value;
    notifyListeners();
  }

  void setFrequency(int value) {
    setDirty(true);
    _frequency = value;
    notifyListeners();
  }

  void setCompleted(bool value) {
    setDirty(true);
    _completed = value;
    notifyListeners();
  }

  Future<bool> getDailyTasks(String username) async {
    try {
      _dailyTasks = await _tasksService.getDailyTasks(username);
      return true;
    } on Exception {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> createDailyTask(String username) async {
    try {
      await _tasksService.createDailyTask(username, _initiationDate!, _recurring!, _frequency!, completed: _completed);
      return true;
    } on Exception {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> markAsComplete(int taskId) async {
    try {
      await _tasksService.markAsCompleted(taskId, _completed);
      return true;
    } on Exception {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> deleteTask(int taskId) async {
    try {
      await _tasksService.deleteTask(taskId);
      return true;
    } on Exception {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}