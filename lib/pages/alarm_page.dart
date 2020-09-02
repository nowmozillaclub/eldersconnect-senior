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
    return Row(
      children: [
        FlatButton(
          child: Text("Snooze"),
          onPressed: () async {
            await channel.invokeMethod("snooze");
          },
        ),
        FlatButton(
          child: Text("Dismiss"),
          onPressed: () async {
            await channel.invokeMethod("dismiss");
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Alarm Page"),
        ),
      ),
      bottomNavigationBar: _alarmOptions(),
    );
  }
}
