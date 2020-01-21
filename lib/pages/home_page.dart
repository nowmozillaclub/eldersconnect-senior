import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:ec_senior/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'package:permission_handler/permission_handler.dart';

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
            height: 70.0,
          ),
          Hero(
            tag: 'icon',
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(_user.photoUrl),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'EldersConnect Senior',
            style: MyTextStyles.heading,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Connected to: ${_user.connectedToName}',
            style: MyTextStyles.body,
          ),
          SizedBox(
            height: 50.0,
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
                onTap: () async {
                 requestPermission();
                }
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future requestPermission() async {
   var result= await PermissionHandler().requestPermissions([PermissionGroup.phone]);
   if (result[PermissionGroup.contacts] == PermissionStatus.granted)
   {
     android_intent.Intent()
       ..setAction(android_action.Action.ACTION_CALL)
       ..setData(Uri(scheme: "tel", path: "9687723927"))
       ..startActivity().catchError((e) => print(e));
   }
      }
  }

