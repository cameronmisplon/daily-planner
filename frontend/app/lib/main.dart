import 'package:flutter/material.dart';
import 'package:app/app.dart';
import 'package:app/routes/route_constants.dart';
import 'package:app/services/locator.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator("http://localhost:5000/api/");
  runApp(DailyTasksApp(startRoute: UsersRoute));
}