class User {
  late int id;
  late int username;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }
}