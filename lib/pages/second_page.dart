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
  static final CHANNEL_ID = "ALARM_SERVICE_STARTED";

  Future<void> response(MethodCall call) async {
    switch(call.method) {
      case 'response':
        hiFromFlutter(call.arguments);
        break;
      default:
        print('no corresponding method');
    }
  }

  void hiFromFlutter(dynamic args) {
    print('Thanks ${args.toString()}');
  }

  @override
  Widget build(BuildContext context) {

    MethodChannel flutterChannel = MethodChannel(CHANNEL_ID);
    flutterChannel.setMethodCallHandler(response);
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
                var res = await platform.invokeMethod('schedule_alarm', {"alarmId": Random().nextInt(1000), "hour": 0, "minute": 52, "title": "Alarm Trial", "created": 101, "started": false, "recurring": false, "monday": false, "teusday": false, "wednesday": false, "thursday": false, "friday": false, "saturday": false, "sunday": true});
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
