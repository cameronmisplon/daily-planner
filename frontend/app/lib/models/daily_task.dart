import 'package:jiffy/jiffy.dart';

class DailyTask {
  late int id;
  late int userId;
  late int frequency;
  late int recurring;
  late DateTime initiationDate;
  late bool completed;

  DailyTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    frequency = json['frequency'];
    recurring = json['recurring'];
    initiationDate = Jiffy(json['initiation_date']).dateTime;
    completed = json['completed'];
  }
}