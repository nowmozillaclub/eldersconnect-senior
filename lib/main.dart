import 'package:ec_senior/services/questionnaire_reports.dart';
import 'package:ec_senior/pages/alarm_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/services/questionnaire_provider.dart';
import 'package:ec_senior/services/time_table_provider.dart';
import 'package:ec_senior/services/timetable_report.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/first_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, TimeTableProvider>(
          create: (context) {
            return TimeTableProvider.toLoad(null);
          },
          update: (context, value, prev) {
            return TimeTableProvider.toLoad(value.user);
          },
        ),
        ChangeNotifierProxyProvider<AuthService, Questionnaire>(
          create: (context) => Questionnaire(null),
          update: (context, value, prev) => Questionnaire(value.user),
        ),
        ChangeNotifierProxyProvider<AuthService, QuestionnaireReports>(
          create: (context) => QuestionnaireReports(null),
          update: (context, value, prev) => QuestionnaireReports(value.user),
        ),
        ChangeNotifierProxyProvider<AuthService, TimetableReports>(
          create: (context) => TimetableReports(null),
          update: (context, value, prev) => TimetableReports(value.user),
        ),
      ],
      child: MaterialApp(
        title: 'EldersConnect Senior',
        theme: ThemeData(
          primaryColor: MyColors.primary,
          accentColor: MyColors.accent,
          fontFamily: 'LexendDeca',
        ),
        routes: {
          '/': (context) => FirstPage(),
          '/alarm': (context) => AlarmPage(),
        },
      ),
    );
  }
}
