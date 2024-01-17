import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readytostart_base_mvvm_project/core/routes/router.dart' as rtr;
import 'package:readytostart_base_mvvm_project/locator.dart';
import 'package:readytostart_base_mvvm_project/view_models/user_viewmodel.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  bool get isSignedIn => _auth.currentUser != null;

  void listenAuth(BuildContext context){
    UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
    rtr.Router router = locator<rtr.Router>();

    auth.authStateChanges().listen((User? user) async{
      if (user == null) {
        debugPrint("No authenticated user found");
        router.navigateLandingScreen();
      }
      else {
        await onAuthUserFound(userViewModel);
      }
    });
  }

  Future onAuthUserFound(UserViewModel userViewModel) async{
    final router = locator<rtr.Router>();

    var counter = 0;
    await Future.doWhile(() async{
      counter++;
      userViewModel.setUserID(getCurrentUserUID());
      bool success = await userViewModel.fetchUserData().then((userData){
          if (userData == null) {
            router.navigateCreateProfileScreen();
          }
          else {
            router.navigateHomeScreen();
          }
          return true;
      }).catchError((error) {
        debugPrint("Error while fetching userData in landing screen: $error");
        return false;
      });

      if (success){
        return false;
      }

      if (counter == 3){
        debugPrint("Failed to fetch user data 3 times");
        router.navigateLandingScreen();
        return false;
      }

      await Future.delayed(const Duration(seconds: 1));

      return true;
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value)  {
      debugPrint("Signed up with email: $email");
    })
        .catchError((onError) {
      debugPrint("Error while signing up with email: $email, error: $onError");
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((value) {debugPrint("Signed in with email: $email");})
          .catchError((onError) {debugPrint("Error while signing in with email: $email, error: $onError");});
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        debugPrint("invalid email");
      } else if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else{
        debugPrint("Error: ${e.code}, ${e.message}");
      }
    }
  }

  Future<void> updateSignInData({required String email, required String password}) async {
    try {
      await _auth.currentUser!.updateEmail(email);
      await _auth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        debugPrint("invalid email");
      } else if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }else{
        debugPrint("Error: ${e.code}, ${e.message}");
      }
    }
  }

  User getCurrentUser() {
    return _auth.currentUser!;
  }

  String getCurrentUserUID() {
    return _auth.currentUser!.uid;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}