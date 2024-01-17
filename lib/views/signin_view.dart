import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in Screen'),
      ),
      body: Center(
          child: Text('Sign in')
      ),
    );
  }
}