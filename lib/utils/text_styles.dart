import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:ec_senior/utils/size_config.dart';

class MyTextStyles {
  static final heading = TextStyle(
    fontSize: 3.2 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w800,
    color: MyColors.black,
  );

  static final title = TextStyle(
    fontSize: 3.2 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w500,
    color: MyColors.black,
  );

  static final subtitle = TextStyle(
    fontSize: 2.5 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w500,
    color: MyColors.black,
  );

  static final body = TextStyle(
    fontSize: 2.4 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w400,
    color: MyColors.black,
  );
}
