import 'dart:convert';

import 'package:ec_senior/blocs/login_bloc/bloc.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/pages/qr_link_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  final SharedPreferences prefs;
  AuthService _authService = AuthService();

  MyLoginPage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Container(
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

                      final String uuid = Uuid().v4();
                      final String name = _firebaseUser.displayName;
                      final String email = _firebaseUser.email;
                      final String photoUrl = _firebaseUser.photoUrl;

                      if (_firebaseUser != null) {
                        print('Login success! $name, $email');

                        User user = User(
                          uuid: uuid,
                          name: name,
                          email: email,
                          photoUrl: photoUrl,
                        );

                        prefs.setBool('isFirstLaunch', false);
                        prefs.setString('user', json.encode(user));

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyQRLinkPage(prefs: this.prefs)),
                            (Route<dynamic> route) => false);
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
      ),
    );
  }
}
