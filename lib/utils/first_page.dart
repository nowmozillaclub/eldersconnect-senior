import 'package:ec_senior/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void firstPageChecker() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
//    String uuid = prefs.getString('uuid') ?? Uuid().v4();
    // generates random uuid as string

//    if (isFirstLaunch) {
//      Navigator.pushAndRemoveUntil(
//          context,
//          MaterialPageRoute(
//              builder: (context) => MyOnboardingPage(
//                    helper: prefs,
//                    flag: isFirstLaunch,
//                    identity: uuid,
//                  )),
//          (Route<dynamic> route) => false);
//      // very first launch since install
//    } else {
//      Navigator.pushAndRemoveUntil(
//          context,
//          MaterialPageRoute(
//              builder: (context) =>
//                  MyMapViewPage(helper: prefs, identity: uuid)),
//          (Route<dynamic> route) => false);
//    }
  }

  @override
  void initState() {
    super.initState();
    firstPageChecker();
  }

  Widget build(BuildContext context) {
    return Container(
      color: invertInvertColorsStrong(context), // blank screen
    );
  }
}