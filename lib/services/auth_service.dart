import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/models/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static User userInfo;

  User get user {
    return userInfo;
  }

  set user(User user) {
    userInfo = user;
  }

  // initialises user to the currently signed in user
  Future<User> loadUser() async {
    try {
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      final DocumentSnapshot userDoc = await _firestore.collection('seniors')
          .document('${firebaseUser.uid}')
          .get();

      User user = User(
          uid: userDoc.data['uid'],
          name: userDoc.data['name'],
          email: userDoc.data['email'],
          phone: userDoc.data['phone'],
          photoUrl: userDoc.data['photoUrl'],
          connectedToUid: userDoc.data['connectedToUid'],
          connectedToName: userDoc.data['connectedToName'],
          connectedToPhone: userDoc.data['connectedToPhone'],
          sosStatus: userDoc.data['sosStatus']
      );

      return user;
    }
    catch (error) {
      print('Error: $error');
      return null;
    }
  }

  // Method for signing in users via Google
  Future<void> signInWithGoogle() async {
    // Handling Exceptions if any.
    try {
      // Sign in with Google with Authentication.
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Getting Authentication Credentials for Firebase to use.
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Saving user to Firebase using AuthCredentials.
      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(authCredential);
      final FirebaseUser firebaseUser = authResult.user;

      await _firestore.collection('seniors').document('${firebaseUser.uid}').setData({
        'uid': firebaseUser.uid,
        'name': firebaseUser.displayName,
        'email': firebaseUser.email,
        'phone': firebaseUser.phoneNumber,
        'photoUrl': firebaseUser.photoUrl,
        'connectedToUid': null,
        'connectedToName': null,
        'connectedToPhone': null,
        'sosStatus': false,
      });

      userInfo = User(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email,
        phone: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoUrl,
        connectedToUid: null,
        connectedToName: null,
        connectedToPhone: null,
        sosStatus: false,
      );

      UserRepository().saveUser(userInfo);
      notifyListeners();
    }
    catch (error) {
      print('Error: $error');
      return null;
    }
  }

  //method to connect to junior
  Future<void> updateUser(String _connectedToUid, String _connectedToName, String _juniorPhone) async {
    // Handling Exceptions if any.
    try {
      user = User(
        uid: userInfo.uid,
        name: userInfo.name,
        email: userInfo.email,
        phone: userInfo.phone,
        photoUrl: userInfo.photoUrl,
        connectedToUid: _connectedToUid,
        connectedToName: _connectedToName,
        connectedToPhone: _juniorPhone,
        sosStatus: _juniorPhone == null && userInfo.phone == null ?false:true,
      );

      await UserRepository().saveUser(userInfo);

      await Firestore.instance
          .collection('seniors')
          .document('${userInfo.uid}')
          .setData({
        'uid': userInfo.uid,
        'name': userInfo.name,
        'email': userInfo.email,
        'phone': userInfo.phone,
        'photoUrl': userInfo.photoUrl,
        'connectedToUid': userInfo.connectedToUid,
        'connectedToName': userInfo.connectedToName,
        'connectedToPhone': userInfo.connectedToPhone,
        'sosStatus': userInfo.sosStatus,
      });
      notifyListeners();
    }
    catch(error) {
      print('Error: $error');
    }
  }

  //method to change phone number
  Future<void> verifyAndChangePhone(String newPhone) async {
    if(newPhone.length == 10) {
      //TODO: Add Phone Number Verification
      try{
        userInfo = User(
          uid: userInfo.uid,
          name: userInfo.name,
          email: userInfo.email,
          phone: newPhone,
          photoUrl: userInfo.photoUrl,
          connectedToUid: userInfo.connectedToUid,
          connectedToName: userInfo.connectedToName,
          sosStatus: userInfo.connectedToPhone!=null?true:false,
        );

        print(userInfo.phone);
        UserRepository().saveUser(userInfo);

        await _firestore.collection('seniors').document('${userInfo.uid}').setData({
          'uid': userInfo.uid,
          'name': userInfo.name,
          'email': userInfo.email,
          'phone': userInfo.phone,
          'photoUrl': userInfo.photoUrl,
          'connectedToUid': userInfo.connectedToUid,
          'connectedToName': userInfo.connectedToName,
          'connectedToPhone': userInfo.connectedToPhone,
          'sosStatus': userInfo.sosStatus,
        });

        notifyListeners();
      }
      catch(err) {
        print('Error: $err');
      }
    }
  }

  // Method for signing out users
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
    } catch (error) {
      print('Error: $error');
    }
  }

}

//jAfvHkIScAsicFGSbt3T