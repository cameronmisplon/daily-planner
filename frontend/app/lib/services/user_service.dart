import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/models/users.dart';
import 'package:app/services/base_service.dart';

class UserService extends BaseService {
  final _apiGetUsers = 'user/get-users';

  Future<Users> getUsers() async {
    var client = http.Client();

    Users users;
    try {
      var response = await api.get(client, _apiGetUsers);
      var responseBody = json.decode(response);
      validateSuccessfulJsonResponse(responseBody);
      users = Users.fromJson(responseBody);
    } on Exception {
      rethrow;
    } finally {
      client.close();
    }

    return users;
  }
}