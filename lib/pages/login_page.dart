import 'dart:convert';

import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  AuthService _authService = AuthService();
  final SharedPreferences prefs;
  MyLoginPage({Key key, @required this.prefs}) : super(key: key);

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
                  style: MyTextStyles.subtitle,
                ),
                Text(
                  'EldersConnect Senior',
                  style: MyTextStyles.title,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 125.0,
                  width: 125.0,
                  child: Image.asset('assets/icon/icon-legacy.png'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GoogleSignInButton(
                  onPressed: () async {
                    FirebaseUser _firebaseUser =
                        await _authService.signInWithGoogle();

                    final String uuid = Uuid().v4();
                    final String name = _firebaseUser.displayName;
                    final String email = _firebaseUser.email;

                    if (_firebaseUser != null) {
                      print('Login success! $name, $email');

                      User user = User(
                        uuid: uuid,
                        name: name,
                        email: email,
                      );

                      prefs.setBool('isFirstLaunch', false);
                      prefs.setString('user', json.encode(user));

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(prefs: this.prefs);
                      }));
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
