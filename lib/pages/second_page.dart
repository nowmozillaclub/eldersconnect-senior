import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Second Page', style: MyTextStyles.heading,),
      ),
      bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
    );
  }
}
