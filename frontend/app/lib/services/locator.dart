import 'package:get_it/get_it.dart';

import 'package:app/services/api.dart';
import 'package:app/services/tasks_service.dart';
import 'package:app/services/user_service.dart';
import 'package:app/viewmodels/tasks_model.dart';
import 'package:app/viewmodels/user_model.dart';

GetIt locator = GetIt.instance;

void setupLocator(final String apiUrl) {
  locator.registerLazySingleton(() => Api(apiUrl));
  locator.registerLazySingleton(() => TasksService());
  locator.registerLazySingleton(() => UserService());

  locator.registerFactory(() => TasksModel());
  locator.registerFactory(() => UserModel());
}