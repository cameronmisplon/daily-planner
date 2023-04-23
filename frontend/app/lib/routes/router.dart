import 'package:flutter/material.dart';
import 'package:app/routes/fade_route.dart';
import 'package:app/routes/route_constants.dart';
import 'package:app/ui/users_screen.dart';
import 'package:app/ui/tasks_screen.dart';
import 'package:app/ui/create_tasks_screen.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  String word = settings.name!;

  String routeName = settings.name!;

  //remove slash
  if (word.startsWith("/")) {
    routeName = word.substring(1);
  }
  //remove everything after and including "?"
  if (word.contains("?")) {
    routeName = routeName.substring(0, word.indexOf("?") - 1);
  }

  switch (routeName) {
    case UsersRoute:
      return FadeRoute(page: UserScreen(), settings: settings);
    case TasksRoute:
      return FadeRoute(page: TasksScreen(), settings: settings);
    case CreateTaskRoute:
      return FadeRoute(page: CreateTasksScreen(), settings: settings);
    default:
      return FadeRoute(page: UserScreen(), settings: settings);
  }
}