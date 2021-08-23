import 'package:ecom_user_app/db/db_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<User?> loginUser(String email, String password) async {
    final credentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credentials.user;
  }

  static Future<User?> registerUser(String email, String password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credentials.user;
  }

  static bool isEmailVerified() => _auth.currentUser!.emailVerified;

  static Future<void> sendVerificationMail() {
    return _auth.currentUser!.sendEmailVerification();
  }

  static Future<void> logout() {
    return _auth.signOut();
  }
}
