import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/routes/router.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/viewmodels/user_model.dart';
import 'package:app/viewmodels/tasks_model.dart';

class DailyTasksApp extends StatelessWidget {
  final String startRoute;

  DailyTasksApp({required this.startRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>(
              create: (context) => locator<UserModel>()),
          ChangeNotifierProvider<TasksModel>(
              create: (context) => locator<TasksModel>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            navigatorKey: locator<NavigationService>().navigatorKey,
            onGenerateRoute: generateRoute,
            initialRoute: startRoute),
      ),
    );
  }
}
