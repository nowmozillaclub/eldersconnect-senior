import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final SharedPreferences prefs;
  UserRepository(this.prefs);

  Future<User> updateUser(
    String _connectedToUid,
    String _connectedToName,
  ) async {
    FirebaseUser _firebaseUser = await AuthService().getUser();

    User user = User(
      uid: _firebaseUser.uid,
      name: _firebaseUser.displayName,
      email: _firebaseUser.email,
      photoUrl: _firebaseUser.photoUrl,
      connectedToUid: _connectedToUid,
      connectedToName: _connectedToName,
    );

    saveUser(user);

    await Firestore.instance
        .collection('seniors')
        .document('${_firebaseUser.uid}')
        .setData({
      'uid': _firebaseUser.uid,
      'name': _firebaseUser.displayName,
      'email': _firebaseUser.email,
      'photoUrl': _firebaseUser.photoUrl,
      'connectedToUid': _connectedToUid,
      'connectedToName': _connectedToName,
    });

    return user;
  }

  void saveUser(User user) {
    prefs.setString('user', json.encode(user));
    print('${user.name} saved');
  }

  User getUser() {
    try {
      return User.fromJson(json.decode(prefs.getString('user')));
    } catch (error) {
      print(error);
      return null;
    }
  }
}
