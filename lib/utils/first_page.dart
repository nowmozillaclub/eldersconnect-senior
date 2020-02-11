import 'package:ec_senior/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ec_senior/blocs/login_bloc/bloc.dart';
import 'package:ec_senior/blocs/repositories/user_repository.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/pages/login_page.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void firstPageChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    Future.delayed(Duration(seconds: 1), () {
      // splash screen kinda thing
      if (isFirstLaunch) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                    create: (context) => LoginBloc(
                        authenticationBloc:
                            BlocProvider.of<AuthenticationBloc>(context),
                        userRepository: UserRepository()),
                    child: MyLoginPage(prefs: prefs))),
            (Route<dynamic> route) => false);
        // very first launch since install
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(prefs: prefs)),
            (Route<dynamic> route) => false);
      }
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
