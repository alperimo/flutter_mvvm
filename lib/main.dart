import 'package:firebase_core/firebase_core.dart';
import 'package:readytostart_base_mvvm_project/core/routes/routing_constants.dart';
import 'package:readytostart_base_mvvm_project/models/user_model.dart';
import 'package:readytostart_base_mvvm_project/repositories/user_repository.dart';
import 'package:readytostart_base_mvvm_project/services/firebase_options.dart';
import 'package:readytostart_base_mvvm_project/view_models/auth_viewmodel.dart';
import 'package:readytostart_base_mvvm_project/view_models/user_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

import 'core/routes/router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
          ChangeNotifierProvider(create: (context) => UserViewModel(userRepository: locator<UserRepository>(), userModel: UserModel(userID: ""))),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'A Ready To Start MVVM Project',
          initialRoute: starterRoute,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: locator<router.Router>().onGenerateRoute,
        )
    );
  }
}

