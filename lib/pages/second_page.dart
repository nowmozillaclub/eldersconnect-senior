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
    print('Hi ${args.toString()}');
  }

  static final String CHANNEL_ID = 'RESPONSE_CHANNEL';

  @override
  Widget build(BuildContext context) {

    MethodChannel flutterChannel = MethodChannel(CHANNEL_ID);
    flutterChannel.setMethodCallHandler(response);

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          currentSelectedNavBar = 0;
        });
        return true;
      },
      child: Scaffold(
        body: Center(
          child: FlatButton(
            child: Text('Call Native'),
            onPressed: () async {
              try {
                var res = await platform.invokeMethod('helloFromNativeCode');
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
