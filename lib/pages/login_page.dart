import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  AuthService _authService = AuthService();
  final SharedPreferences helper;
  final bool flag;
  final String identity;
  MyLoginPage(
      {Key key,
      @required this.helper,
      @required this.flag,
      @required this.identity})
      : super(key: key);
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
                    if (_firebaseUser != null) {
                      print('Login success! ${_firebaseUser.displayName}, '
                          '${_firebaseUser.email}');
                      helper.setBool('isFirstLaunch', false);
                      helper.setString('uuid', identity);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage();
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
