import 'dart:math';

import 'package:ec_senior/commons/bottom_nav_bar.dart';
//import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  static final platform = MethodChannel('ec_senior/alarm_service');

  @override
  Widget build(BuildContext context) {

    GlobalKey _key = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          currentSelectedNavBar = 0;
        });
        return true;
      },
      child: Scaffold(
        key: _key,
        body: Center(
          child: FlatButton(
            child: Text('Call Native'),
            onPressed: () async {
              try {
                var res = await platform.invokeMethod('schedule_alarm', {"alarmId": Random().nextInt(1000), "hour": 21, "minute": 02, "title": "Alarm Trial", "created": 101, "started": false, "recurring": false, "monday": true, "tuesday": false, "wednesday": false, "thursday": false, "friday": false, "saturday": false, "sunday": false});
                print(res);
              } on PlatformException catch(e) {
                print('failed, error: $e');
              }
            },
          )
        ),
        bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
      ),
    );
  }
}
