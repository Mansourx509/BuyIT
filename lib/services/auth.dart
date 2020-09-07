import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<AuthResult> SignUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<AuthResult> SignIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }
  Future<FirebaseUser> getUser()async{
    return await _auth.currentUser();
  }

  Future<void> signOut()async{
    await _auth.signOut();
  }
}
