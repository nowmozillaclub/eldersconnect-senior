import 'package:flutter/material.dart';
import 'package:ec_senior/services/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  // AuthService instance.
  final AuthService _authService = AuthService();

  // Build Method.
  @override
  Widget build(BuildContext context) {

    // Getting the current Firebase user from Provider Stream.
    FirebaseUser _currentFirebaseUser = Provider.of<FirebaseUser>(context);

    // Build the Bottom Sheet with the required QR Code.
    void _buildQrCodeBottomSheet () {
      showModalBottomSheet(context: context, builder: (context) {
        return Center(
          child: QrImage(
            data: _currentFirebaseUser.uid,
            version: QrVersions.auto,
            size: 250.0,
          ),
        );
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have logged in successfully'),
            FlatButton(
              onPressed: () async {
                return await _authService.signOut();
              },
              child: Text('Log out'),
            ),
            FlatButton(
              onPressed: _buildQrCodeBottomSheet,
              child: Text('Generate QR Code'),
            )
          ],
        ),
      ),
    );
  }
}

