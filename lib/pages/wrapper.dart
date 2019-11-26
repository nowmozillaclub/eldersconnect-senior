import 'package:ec_senior/pages/authentication/register.dart';
import 'package:ec_senior/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Feeding off from AuthStream declared global.
    final _firebaseUser = Provider.of<FirebaseUser>(context);
    // Based on user login status, rendering pages conditionally.
    return _firebaseUser == null ? Register() : Home();
  }
}

