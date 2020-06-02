import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/models/user_repository.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQRLinkPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

//    final userRepo = Provider.of<UserRepository>(context, listen: false);//Error

    Widget _showQrCode(User user) {
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
          child: FutureBuilder(
                future: UserRepository().user,
                builder: (context, user) {
                  if(user.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  else
                    return StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('juniors').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      List<DocumentSnapshot> _docs = snapshot.data.documents;

                      for (int i = 0; i < _docs.length; i++) {
                        String juniorConnectedTo = _docs[i].data['connectedToUid'];
                        if (juniorConnectedTo == user.data.uid) {
                          String juniorUid = _docs[i].data['uid'];
                          String juniorName = _docs[i].data['name'];

                          UserRepository().updateUser(juniorUid, juniorName);

                          return MyHomePage();
                        }
                      }
                      return _showQrCode(user.data);
                    },
                  );
                }
              ),
          ),
    );
  }
}
