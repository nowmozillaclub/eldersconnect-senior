import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Third Page', style: MyTextStyles.heading,),
      ),
      bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
    );
  }
}
