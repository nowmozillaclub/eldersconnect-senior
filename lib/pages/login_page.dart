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

    final AuthService auth = Provider.of<AuthService>(context, listen: true);

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

                              await auth.signInWithGoogle();

                              if (auth.user != null) {
                                print('Login success! ${auth.user.name}');

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
