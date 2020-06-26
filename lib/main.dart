import 'package:ec_senior/pages/firebase.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/pages/qr_link_page.dart';
import 'package:ec_senior/pages/questionnaire.dart';

import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/first_page.dart';
import 'package:ec_senior/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:ec_senior/utils/size_config.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context,orientation){
         SizeConfig().init(constraints , orientation);
         return  MaterialApp(
      title: 'EldersConnect Senior',
      theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        fontFamily: 'LexendDeca',
      ),
      home: MyCarousell()
    );
        });
      });
    
  }
}
