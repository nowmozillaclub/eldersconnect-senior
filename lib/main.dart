import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/services/questionnaire.dart';
import 'package:ec_senior/services/time_table_provider.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/first_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, TimeTableProvider>(
          create: (context) => TimeTableProvider(null),
          update: (context, value, prev) => TimeTableProvider(value.user),
        ),
        ChangeNotifierProxyProvider<AuthService, Questionnaire>(
          create: (context) => Questionnaire(user: null),
          update: (context, value, prev) => Questionnaire(user: value.user),
        ),
      ],
      child: MaterialApp(
        title: 'EldersConnect Senior',
        theme: ThemeData(
          primaryColor: MyColors.primary,
          accentColor: MyColors.accent,
          fontFamily: 'LexendDeca',
        ),
        home: FirstPage(),
      ),
    );
  }
}
