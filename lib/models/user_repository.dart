import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/services/auth_service.dart';
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

  Future<void> updateUser(String _connectedToUid, String _connectedToName, bool _sosStatus) async {
    User user = await AuthService().getUser();

    user = User(
      uid: user.uid,
      name: user.name,
      email: user.email,
      phone: user.phone,
      photoUrl: user.photoUrl,
      connectedToUid: _connectedToUid,
      connectedToName: _connectedToName,
      sosStatus: _sosStatus && user.phone.isNotEmpty?true:false,
    );

    await saveUser(user);

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
      'sosStatus': user.sosStatus,
    });
  }


  Future<void> clearUser() async {
    User user = await getUser();
    await Firestore.instance.collection('seniors').document('${user.uid}').delete();

    final pref = await SharedPreferences.getInstance();
    pref.setString('user', null);
  }

}
