import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/services/login_helpers.dart';
import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
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
//                GoogleSignInButton(
//                  onPressed: () {
//                    signInWithGoogle().whenComplete(() {
//                      Navigator.of(context).push(
//                        MaterialPageRoute(
//                          builder: (context) {
//                            return MyHomePage(); // get FirebaseUser here
//                            // somehow
//                          },
//                        ),
//                      );
//                    });
//                  },
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
