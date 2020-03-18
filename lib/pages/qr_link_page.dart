import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/pages/home_page.dart';
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
    final Firestore _instance = Firestore.instance;

    Widget _showQrCode() {
      return Column(
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
            'Please scan the code below using EC Junior',
            style: MyTextStyles.body,
          ),
          SizedBox(
            height: 20.0,
          ),
          QrImage(
            data: _user.uid,
            version: QrVersions.auto,
            size: 250.0,
          ),
        ],
      );
    }

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return _showQrCode();
          //TODO: improve code quality
          List<DocumentSnapshot> _docs = snapshot.data.documents;

          for (int i = 0; i < _docs.length; i++) {
            if (_docs[i].data['connectedToUid'] == _user.uid) {
              //TODO: write connection data to DB
              return MyHomePage(prefs: this.prefs);
            }
          }
          return _showQrCode();
        },
      ),
    );
  }
}
