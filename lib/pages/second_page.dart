import 'dart:math';

import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/main.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  static final channel = MethodChannel('ec_senior/alarm_service');

  @override
  Widget build(BuildContext context) {

    GlobalKey _key = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          currentSelectedNavBar = 0;
        });
        if(!Navigator.canPop(context))
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
        return true;
      },
      child: Scaffold(
        key: _key,
        body: Center(
          child: InkWell(
            onTap: () {
              channel.invokeMethod('schedule_alarm', {
                "alarmId": Random().nextInt(1000),
                "hour": 18,
                "minute": 32,
                "title": 'trial',
                "created": Random().nextInt(100),
                "started": false,
                "recurring": false,
                "monday": true,
                "tuesday": false,
                "wednesday": false,
                "thursday": false,
                "friday": false,
                "saturday": false,
                "sunday": false
              });
            },
              child: Text("Second Page", style: MyTextStyles.heading,))
        ),
        bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
      ),
    );
  }
}
