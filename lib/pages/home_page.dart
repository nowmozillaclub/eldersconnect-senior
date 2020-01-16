import 'dart:convert';

import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:ec_senior/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  final SharedPreferences prefs;

  MyHomePage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _user = User.fromJson(json.decode(prefs.getString('user')));
    // gets logged in user

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          Text(
            'EldersConnect Senior',
            style: MyTextStyles.heading,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Connected to: ${_user.connectedToName}',
            style: MyTextStyles.body,
          ),
          SizedBox(
            height: 60.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      'assets/graphics/heart.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () => doNothing(),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      'assets/graphics/man.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () => doNothing(),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      'assets/graphics/moon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () => doNothing(),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      'assets/graphics/emergency.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () => doNothing(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:ec_senior/services/auth_service.dart';
//import 'package:qr_flutter/qr_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//
//class Home extends StatelessWidget {
//  // AuthService instance.
//  final AuthService _authService = AuthService();
//
//  // Build Method.
//  @override
//  Widget build(BuildContext context) {
//
//    // Getting the current Firebase user from Provider Stream.
//    FirebaseUser _currentFirebaseUser = Provider.of<FirebaseUser>(context);
//
//    // Build the Bottom Sheet with the required QR Code.
//    void _buildQrCodeBottomSheet () {
//      showModalBottomSheet(context: context, builder: (context) {
//        return Center(
//          child: QrImage(
//            data: _currentFirebaseUser.uid,
//            version: QrVersions.auto,
//            size: 250.0,
//          ),
//        );
//      });
//    }
//
//    return Scaffold(
//      body: Center(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text('You have logged in successfully'),
//            FlatButton(
//              onPressed: () async {
//                return await _authService.signOut();
//              },
//              child: Text('Log out'),
//            ),
//            FlatButton(
//              onPressed: _buildQrCodeBottomSheet,
//              child: Text('Generate QR Code'),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
