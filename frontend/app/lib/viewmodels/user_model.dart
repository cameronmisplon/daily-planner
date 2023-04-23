import 'package:app/models/user.dart';
import 'package:app/models/users.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/user_service.dart';
import 'package:app/viewmodels/base_model.dart';

class UserModel extends BaseModel {
  final UserService _userService = locator<UserService>();

  late Users _users;
  User? _chosenUser;

  Users get users => _users;
  User? get chosenUser => _chosenUser;

  Future<bool> getUsers() async {
    try {
      _users = await _userService.getUsers();
      return true;
    } on Exception {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}