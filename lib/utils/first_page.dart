import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/pages/login_page.dart';
import 'package:ec_senior/pages/qr_link_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Future<User> _user;


  @override
  void initState() {
    super.initState();
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    _user = auth.loadUser();
  }

  @override
  Widget build(BuildContext context) {

    AuthService auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: _user,
        builder: (context, user) {
          if(user.connectionState == ConnectionState.waiting)
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
          else {
            auth.user = user.data;
            if (user.data == null)
              return MyLoginPage();
            else if (user.data.connectedToUid == null)
              return MyQRLinkPage();
            else {
              return MyHomePage();
            }
          }
        },
      ),
    );
  }
}
//TODO: Improve Navigation