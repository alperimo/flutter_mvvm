import 'package:get_it/get_it.dart';
import 'package:readytostart_base_mvvm_project/core/routes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async{
  final _sharedPreferences = await SharedPreferences.getInstance();

  // services
  locator.registerLazySingleton<Router>(() => Router());
  //locator.registerLazySingleton<ExampleAuthService>(() => AuthService());

  // repositories
  //locator.registerLazySingleton<ExampleRepository>(() => ExampleRepository());
}