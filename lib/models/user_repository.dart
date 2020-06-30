import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {

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

  Future<void> clearUser() async {
    User user = await getUser();
    await Firestore.instance.collection('seniors').document('${user.uid}').delete();

    final pref = await SharedPreferences.getInstance();
    pref.setString('user', null);
  }

}
