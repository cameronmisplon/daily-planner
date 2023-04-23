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
            title: Globals.appTitle,
            theme: theme(),
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            navigatorKey: locator<NavigationService>().navigatorKey,
            onGenerateRoute: router.generateRoute,
            initialRoute: startRoute),
      ),
    );
  }
}
