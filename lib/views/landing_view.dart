import 'package:flutter/material.dart';
import 'package:readytostart_base_mvvm_project/core/routes/router.dart' as rtr;
import 'package:readytostart_base_mvvm_project/locator.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = locator<rtr.Router>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Landing Page',
            ),
            ElevatedButton(
              onPressed: () => router.navigateSignInScreen(),
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => router.navigateSignUpScreen(),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}