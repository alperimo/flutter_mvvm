import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:readytostart_base_mvvm_project/locator.dart';
import 'package:readytostart_base_mvvm_project/models/user_model.dart';
import 'package:readytostart_base_mvvm_project/repositories/user_repository.dart';
import 'package:readytostart_base_mvvm_project/services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel({required this.userRepository, required this.userModel});

  final UserRepository userRepository;

  UserModel userModel;

  UserService userService = locator<UserService>();

  void setUserID(String userID) {
    userModel.userID = userID;
  }

  Future<dynamic> fetchUserData() async {
    try {
      var userData = await userRepository.fetchUserData(userModel.userID);
      if (userData == null) {
        return null;
      }

      userModel = userData;

      return userModel;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

}