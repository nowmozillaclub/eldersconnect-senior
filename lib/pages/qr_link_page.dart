import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/models/user_repository.dart';
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
    final UserRepository _userRepository = UserRepository(prefs);
    final User _user = _userRepository.getUser();
    final Firestore _instance = Firestore.instance;

    Widget _showQrCode() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          )
        ],
      );
    }

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _instance.collection('juniors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          List<DocumentSnapshot> _docs = snapshot.data.documents;

          for (int i = 0; i < _docs.length; i++) {
            String juniorConnectedTo = _docs[i].data['connectedToUid'];

            if (juniorConnectedTo == _user.uid) {
              String juniorUid = _docs[i].data['uid'];
              String juniorName = _docs[i].data['name'];

              _userRepository.updateUser(juniorUid, juniorName);
              return MyHomePage(prefs: this.prefs);
            }
          }
          return _showQrCode();
        },
      ),
    );
  }
}
