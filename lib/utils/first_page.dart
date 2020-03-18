import 'package:ec_senior/models/user_repository.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/pages/login_page.dart';
import 'package:ec_senior/pages/qr_link_page.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void firstPageChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _user = UserRepository(prefs).getUser();
    bool _isConnected = prefs.getBool('isConnected' ?? false);

    Future.delayed(Duration(seconds: 1), () {
      // splash screen kinda thing
      if (_user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyLoginPage(prefs: prefs)),
            (Route<dynamic> route) => false);
        // user hasn't signed in yet
      } else if (_isConnected == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyQRLinkPage(prefs: prefs)),
            (Route<dynamic> route) => false);
        // user hasn't scanned the QR yet
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(prefs: prefs)),
            (Route<dynamic> route) => false);
      } // when setup is complete
    });
  }

  @override
  void initState() {
    super.initState();
    firstPageChecker();
  }

  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Center(
        child: Hero(
          tag: 'icon',
          child: Container(
            height: 200.0,
            width: 200.0,
            child: Image.asset('assets/icon/icon-legacy.png'),
          ),
        ),
      ),
    );
  }
}
