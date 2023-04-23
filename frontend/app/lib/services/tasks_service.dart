import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/models/daily_tasks.dart';
import 'package:app/services/base_service.dart';

class TasksService extends BaseService {
  final _apiGetTasks = 'daily-tasks/get-tasks';
  final _apiCreateTask = 'daily-tasks/create';
  final _apiMarkCompleted = 'daily-tasks/mark-as-complete';
  final _apiDeleteTask = 'daily-tasks/delete-task';

  Future<DailyTasks> getDailyTasks(String username) async {
    var client = http.Client();

    DailyTasks dailyTasks;
    try {
      var response = await api.get(client, "$_apiGetTasks/$username");
      var responseBody = json.decode(response);
      validateSuccessfulJsonResponse(responseBody);
      dailyTasks = DailyTasks.fromJson(responseBody);
    } on Exception {
      rethrow;
    } finally {
      client.close();
    }

    return dailyTasks;
  }

  Future<void> createDailyTask(String username, DateTime initiationDate, int recurring, int frequency, {bool completed = false}) async {
      var client = http.Client();
      var body = jsonEncode(<String, dynamic>{
        'username': username,
        'initiation_date': initiationDate,
        'frequency': frequency,
        'recurring': recurring,
        'completed': completed
      });
      try {
        var response = await api.post(client, _apiCreateTask, body);
        var responseBody = json.decode(response);
        validateSuccessfulJsonResponse(responseBody);
      } on Exception {
        rethrow;
      } finally {
        client.close();
      }
  }

  Future<void> markAsCompleted(int id, bool completed) async {
    var client = http.Client();
    var body = jsonEncode(<String, dynamic>{
      'id': id,
      'completed': completed
    });
    try {
      var response = await api.post(client, _apiMarkCompleted, body);
      var responseBody = json.decode(response);
      validateSuccessfulJsonResponse(responseBody);
    } on Exception {
      rethrow;
    } finally {
      client.close();
    }
  }

  Future<void> deleteTask(int id) async {
    var client = http.Client();
    var body = jsonEncode(<String, dynamic>{
      'id': id
    });
    try {
      var response = await api.post(client, _apiDeleteTask, body);
      var responseBody = json.decode(response);
      validateSuccessfulJsonResponse(responseBody);
    } on Exception {
      rethrow;
    } finally {
      client.close();
    }
  }
}