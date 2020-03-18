import 'dart:convert';

import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/pages/qr_link_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  final SharedPreferences prefs;
  AuthService _authService = AuthService();

  MyLoginPage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: MyColors.white,
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
                Hero(
                  tag: 'icon',
                  child: Container(
                    height: 125.0,
                    width: 125.0,
                    child: Image.asset('assets/icon/icon-legacy.png'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GoogleSignInButton(
                  onPressed: () async {
                    FirebaseUser _firebaseUser =
                        await _authService.signInWithGoogle();

                    final String _uid = _firebaseUser.uid + '-senior';
                    final String _name = _firebaseUser.displayName;
                    final String _email = _firebaseUser.email;
                    final String _photoUrl = _firebaseUser.photoUrl;

                    if (_firebaseUser != null) {
                      print('Login success! $_name, $_email, $_uid');

                      User _user = User(
                        uid: _uid,
                        name: _name,
                        email: _email,
                        photoUrl: _photoUrl,
                      );

                      prefs.setBool('isFirstLaunch', false);
                      prefs.setString('user', json.encode(_user));

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyQRLinkPage(prefs: this.prefs)),
                          (Route<dynamic> route) => false);
                    } else {
                      print('Error logging in');
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Error logging in'),
                        ),
                      );
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
