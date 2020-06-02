import 'package:ec_senior/models/user_repository.dart';
import 'package:ec_senior/pages/qr_link_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//    final _userRepo = Provider.of<UserRepository>(context, listen: false);//Error
//    final _authService = Provider.of<AuthService>(context, listen: false);//Error

    return Scaffold(
        body: Container(
            color: MyColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              final userRepo = UserRepository();
                              final _authServices = AuthService();
                              final _firebaseUser = await _authServices.signInWithGoogle();

                              if (_firebaseUser != null) {
                                print('Login success! ${_firebaseUser.displayName}');
                                await userRepo.createUser(_firebaseUser);

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyQRLinkPage()),
                                      (Route<dynamic> route) => false);
                              }
                              else {
                                print('Error logging in');
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
