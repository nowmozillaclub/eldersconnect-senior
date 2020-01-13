import 'package:ec_senior/utils/text_styles.dart';
import 'package:ec_senior/utils/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context) {
  showDialog(
    context: context,
    child: AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Text(
        'Alert',
        style: MyTextStyles.title,
      ),
      content: Text(
        'This is an alert',
        style: MyTextStyles.body,
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text('Okay'),
          color: invertColorsTheme(context),
          textColor: invertInvertColorsStrong(context),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
