//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//// https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed
//
//final FirebaseAuth _auth = FirebaseAuth.instance;
//final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//Future<FirebaseUser> signInWithGoogle() async {
//  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//  final GoogleSignInAuthentication googleSignInAuthentication =
//      await googleSignInAccount.authentication;
//
//  final AuthCredential credential = GoogleAuthProvider.getCredential(
//    accessToken: googleSignInAuthentication.accessToken,
//    idToken: googleSignInAuthentication.idToken,
//  );
//
//  final FirebaseUser user = await _auth.signInWithCredential(credential);
//
//  assert(!user.isAnonymous);
//  assert(await user.getIdToken() != null);
//
//  final FirebaseUser currentUser = await _auth.currentUser();
//  assert(user.uid == currentUser.uid);
//
//  print('${user.displayName} logged in');
//  return user;
//}
//
//void signOutGoogle() async {
//  await _googleSignIn.signOut();
//
//  print('User logged out');
//}
