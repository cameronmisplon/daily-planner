import 'package:app/models/user.dart';

class Users {
  late List<User> dailyTasks;

  Users.fromJson(Map<String, dynamic> json) {
    dailyTasks = List<User>.from(
        json['users'].map((x) => User.fromJson(x))
    );
  }
}