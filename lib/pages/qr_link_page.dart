import 'dart:convert';

import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyQRLinkPage extends StatelessWidget {
  final SharedPreferences prefs;

  MyQRLinkPage({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _user = User.fromJson(json.decode(prefs.getString('user')));
    // gets logged in user details

    void _buildQrCodeBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Center(
              child: QrImage(
                data: _user.uuid,
                version: QrVersions.auto,
                size: 250.0,
              ),
            );
          });
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome, ${_user.name}',
            style: MyTextStyles.title,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Please scan the QR code from EC Junior',
            style: MyTextStyles.body,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        foregroundColor: MyColors.white,
        backgroundColor: MyColors.primary,
        onPressed: () {
          _buildQrCodeBottomSheet();
        },
      ),
    );
  }
}
