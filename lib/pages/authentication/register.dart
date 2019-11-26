import 'package:flutter/material.dart';
import 'package:ec_senior/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatelessWidget {
  // AuthService instance.
  AuthService _authService = AuthService();
  // Build Method.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () async {
            FirebaseUser _firebaseUser = await _authService.signInWithGoogle();
            if(_firebaseUser != null) {
              print(_firebaseUser.email);
            } else {
              print('Did not sign in');
            }
          },
          child: Text('Register with Google'),
        ),
      ),
    );
  }
}

