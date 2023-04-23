import 'package:flutter/material.dart';
import 'package:'

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator("http://localhost:5000/api/");
  runApp(const DailyTasksApp(startRoute: ));
}