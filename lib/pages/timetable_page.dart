import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class TimeTablePage extends StatefulWidget {
  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Display Timetable Here', style: MyTextStyles.heading,),
      ),
      bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
    );
  }
}
