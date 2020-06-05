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

  Future<User> get user => getUser();

  // Method for signing in users via Google
  Future<User> signInWithGoogle() async {
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
      });

      User user = User(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email,
        phone: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoUrl,
        connectedToUid: null,
        connectedToName: null,
      );

      UserRepository().saveUser(user);

      return user;

    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  // Method for signing out users
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      print('Error: $error');
    }
  }

  // returns the currently signed in user
  Future<User> getUser() async {
    try {
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

      final DocumentSnapshot userDoc = await _firestore.collection('seniors').document('${firebaseUser.uid}').get();
      User user = User(
        uid: userDoc.data['uid'],
        name: userDoc.data['name'],
        email: userDoc.data['email'],
        phone: userDoc.data['phone'],
        photoUrl: userDoc.data['photoUrl'],
        connectedToUid: userDoc.data['connectedToUid'],
        connectedToName: userDoc.data['connectedToName']
      );
      return user;
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }
}
