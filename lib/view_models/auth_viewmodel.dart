import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readytostart_base_mvvm_project/locator.dart';
import 'package:readytostart_base_mvvm_project/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  AuthService get authService => locator<AuthService>();

  Stream<User?> get onAuthStateChanged => authService.auth.authStateChanges();

  Future<void> signUp(String email, String password) async {
    await authService.signUp(email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await authService.signIn(email: email, password: password);
  }

  bool isSignedIn() {
    return authService.isSignedIn;
  }

  String getUserID() {
    return authService.getCurrentUser().uid;
  }

  Future<void> updateSignInData(String email, String password) async {
    await authService.updateSignInData(email: email, password: password);
  }

  Future<void> signOut() async {
    await authService.signOut();
  }
}