import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/main.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  static final String CHANNEL_ID = "ALARM_SERVICE_STARTED";
  MethodChannel channel = MethodChannel(CHANNEL_ID);

  Widget _alarmOptions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          OutlineButton(
            borderSide: BorderSide(color: MyColors.primary),
            child: Text("Snooze", style: MyTextStyles.title,),
            onPressed: () async {
              await channel.invokeMethod("snooze");
            },
          ),
          OutlineButton(
            borderSide: BorderSide(color: MyColors.primary),
            child: Text("Dismiss", style: MyTextStyles.title,),
            onPressed: () async {
              await channel.invokeMethod("dismiss");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage( image: AssetImage('assets/graphics/clock.png'), fit: BoxFit.contain)
              ),
            ),
            _alarmOptions()
          ],
        ),
      ),
    );
  }
}
