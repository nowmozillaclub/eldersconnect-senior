import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQRLinkPage extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ChangeNotifierProvider(
          create: (context)=> AuthService(),
          child: Consumer<AuthService>(
            builder: (context, auth, child) {
                  if(auth.user.connectedToUid == null)
                    return Container(
                      color: MyColors.white,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance.collection('juniors').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return Center(child: CircularProgressIndicator());

                            List<DocumentSnapshot> _docs = snapshot.data.documents;
                            for (int i = 0; i < _docs.length; i++) {
                              String seniorConnectedTo = _docs[i].data['connectedToUid'];
                              if (seniorConnectedTo == auth.user.uid) {
                                String juniorUid = _docs[i].data['uid'];
                                String juniorName = _docs[i].data['name'];
                                String juniorPhone = _docs[i].data['phone'];
                                //TODO: Add with phone Number validation

                                auth.updateUser(juniorUid, juniorName, juniorPhone);
                              }
                            }
                            return _showQrCode(auth.user);
                          }
                          ),
                    );
                  else
                    return MyHomePage();
                  },
          ),
        ),
    );
  }
}
