import 'package:firebase_auth/firebase_auth.dart';
class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  //signup method
  Future <String?> signUp(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email, password: password,);
      return null;
    }
    on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn({required String email, required String password
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email, password: password,);
      return null;
    }
    on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


//signouat method
  Future <void> signOut() async {
    await _auth.signOut();
    print('signout');
  }
}