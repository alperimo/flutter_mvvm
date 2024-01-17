import 'package:readytostart_base_mvvm_project/locator.dart';
import 'package:readytostart_base_mvvm_project/models/user_model.dart';
import 'package:readytostart_base_mvvm_project/services/auth_service.dart';
import 'package:readytostart_base_mvvm_project/services/user_service.dart';

class UserRepository {
  UserService userService = locator<UserService>();
  AuthService authService = locator<AuthService>();

  Future fetchUserData(String userID) async {
    var userData = await userService.getUserData(userID);
    if (userData == null) {
      return null;
    } else {
      return UserModel.fromMap(userData);
    }
  }
}