import 'package:flutter/material.dart';
import 'package:ec_senior/services/auth.dart';

class Home extends StatelessWidget {
  // AuthService instance.
  AuthService _authService = AuthService();
  // Build Method.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have logged in successfully'),
            FlatButton(
              onPressed: () async {
                return await _authService.signOut();
              },
              child: Text('Log out'),
            )
          ],
        ),
      ),
    );
  }
}

