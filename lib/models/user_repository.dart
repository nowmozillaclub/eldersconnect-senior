import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository extends ChangeNotifier{

  Future<User> get user => getUser();

  Future<void> saveUser(User user) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString('user', json.encode(user));
    print('${user.name} saved');
  }

  Future<User> getUser() async {
    final _prefs = await SharedPreferences.getInstance();
    try {
      return User.fromJson(json.decode(_prefs.getString('user')));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> updateUser(String _connectedToUid, String _connectedToName,) async {
    User user = await getUser();
//    FirebaseUser _firebaseUser = await AuthService().getUser();

    user = User(
      uid: user.uid,
      name: user.name,
      email: user.email,
      phone: user.phone,
      photoUrl: user.photoUrl,
      connectedToUid: _connectedToUid,
      connectedToName: _connectedToName,
    );

    await saveUser(user);

    final pref = await SharedPreferences.getInstance();
    pref.setBool('isConnected', true);

    await Firestore.instance
        .collection('seniors')
        .document('${user.uid}')
        .setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'photoUrl': user.photoUrl,
      'connectedToUid': user.connectedToUid,
      'connectedToName': user.connectedToName,
    });

    notifyListeners();
  }

  Future<void> createUser(FirebaseUser firebaseUser) async {

    await Firestore.instance.collection('seniors').document('${firebaseUser.uid}').setData({
      'uid': firebaseUser.uid,
      'name': firebaseUser.displayName,
      'email': firebaseUser.email,
      'phone': firebaseUser.phoneNumber,
      'photoUrl': firebaseUser.photoUrl,
      'connectedToName': null,
      'connectedToUid': null,
    });

    User user = User(
      uid: firebaseUser.uid,
      name: firebaseUser.displayName,
      email: firebaseUser.email,
      phone: firebaseUser.phoneNumber,
      photoUrl: firebaseUser.photoUrl,
      connectedToName: null,
      connectedToUid: null,
    );

    saveUser(user);

    final pref = await SharedPreferences.getInstance();
    pref.setBool('isFirstLaunch', false);

    notifyListeners();
  }

  Future<void> clearUser() async {
    User user = await getUser();
    await Firestore.instance.collection('seniors').document('${user.uid}').delete();

    final pref = await SharedPreferences.getInstance();
    pref.setString('user', null);
    pref.setBool('isConnected', false);
    pref.setBool('isFirstLaunch', true);

    notifyListeners();
  }
}
