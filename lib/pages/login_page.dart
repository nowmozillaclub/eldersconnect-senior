import 'package:ec_senior/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'EldersConnect Senior',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                FlutterLogo(
                  size: 125.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                GoogleSignInButton(
                  onPressed: () async {
                    FirebaseUser _firebaseUser =
                        await _authService.signInWithGoogle();
                    if (_firebaseUser != null) {
                      print(_firebaseUser.displayName);
                      print(_firebaseUser.email);
                    } else {
                      print('Not logged in');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
