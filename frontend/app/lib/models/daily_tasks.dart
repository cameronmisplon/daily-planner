import 'package:app/models/daily_task.dart';

class DailyTasks {
  late List<DailyTask> dailyTasks;

  DailyTasks.fromJson(Map<String, dynamic> json) {
    dailyTasks = List<DailyTask>.from(
        json['tasks'].map((x) => DailyTask.fromJson(x))
    );
  }
}