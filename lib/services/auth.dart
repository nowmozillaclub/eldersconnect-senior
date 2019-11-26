import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google and Firebase Auth Instances.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Setting up Auth Stream to watch for changes.
  Stream<FirebaseUser> get firebaseUser {
    return _firebaseAuth.onAuthStateChanged;
  }

  // Method for signing in users via Google.
  Future<FirebaseUser> signInWithGoogle() async {
    // Handling Exceptions if any.
    try {
      // Sign in with Google with Authentication.
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      // Getting Authentication Credentials for Firebase to use.
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );

      // Saving user to Firebase using AuthCredentials.
      final AuthResult authResult = await _firebaseAuth.signInWithCredential(authCredential);
      final FirebaseUser firebaseUser = authResult.user;

      // Return the corresponding Firebase user.
      return firebaseUser;
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

}
