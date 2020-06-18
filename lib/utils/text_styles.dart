import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/material.dart';

class MyTextStyles {
  static const heading = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    color: MyColors.black,
  );

  static const title = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: MyColors.black,
  );

  static const subtitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: MyColors.black,
  );

  static const body = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: MyColors.black,
  );

  TextStyle variationOfExisting({TextStyle existing, Color newColor, FontWeight newFontWeight, double newFontSize}) {
    return TextStyle(
      color: newColor ?? existing.color,
      fontWeight: newFontWeight ?? existing.fontWeight,
      fontSize: newFontSize ?? existing.fontSize,
    );
  }

}
