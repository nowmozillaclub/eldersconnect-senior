import 'package:ec_senior/utils/wrapper.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().firebaseUser,
      child: MaterialApp(
        title: 'EldersConnect Senior',
        theme: ThemeData(
          primaryColor: MyColors.primary,
          accentColor: MyColors.accent,
          fontFamily: 'LexendDeca',
        ),
        home: Wrapper(),
      ),
    );
  }
}
