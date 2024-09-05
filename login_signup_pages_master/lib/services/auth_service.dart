import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Signed in user: ${userCredential.user}');
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // You can add more authentication methods here
}
