import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/models/user_repository.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyQRLinkPage extends StatelessWidget {
  final SharedPreferences prefs;
  final User user;
  MyQRLinkPage({Key key, @required this.prefs, @required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserRepository _userRepo = UserRepository();
    Widget _showQrCode() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome, ${user.name}!',
                style: MyTextStyles.title,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Please scan the code using EC Junior',
                style: MyTextStyles.body,
              ),
              SizedBox(
                height: 20.0,
              ),
              Hero(
                tag: 'icon',
                child: QrImage(
                  data: user.uid,
                  version: QrVersions.auto,
                  size: 250.0,
                ),
              ),
            ],
          )
        ],
      );
    }

    return Scaffold(
      body: Container(
        color: MyColors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('juniors').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            List<DocumentSnapshot> _docs = snapshot.data.documents;

            for (int i = 0; i < _docs.length; i++) {
              String juniorConnectedTo = _docs[i].data['connectedToUid'];

              if (juniorConnectedTo == user.uid) {
                String juniorUid = _docs[i].data['uid'];
                String juniorName = _docs[i].data['name'];

                _userRepo.updateUser(juniorUid, juniorName);
                prefs.setBool('isConnected', true);

                return MyHomePage(
                  prefs: prefs,
                  user: user,
                );
              }
            }
            return _showQrCode();
          },
        ),
      ),
    );
  }
}
