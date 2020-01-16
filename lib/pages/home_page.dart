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
