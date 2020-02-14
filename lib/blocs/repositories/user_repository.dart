import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount _googleAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleAuth =
      await _googleAccount.authentication;

      final AuthCredential _auth = GoogleAuthProvider.getCredential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

      await _firebaseAuth.signInWithCredential(_auth);

      return await _firebaseAuth.currentUser();
    } catch(_) {
      print(_);
      return null;
    }
  }

  Future<bool> isSignedIn() async {
    return await _firebaseAuth.currentUser() != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
