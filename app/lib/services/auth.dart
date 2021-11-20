import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/classes/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // return a user object
  CustomUser? _returnCustomUser(User? user) {
    if (user == null) {
      return null;
    }
    return CustomUser(user.uid);
  }

  Stream<CustomUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _returnCustomUser(user));
  }

  // sign in with email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      return _returnCustomUser(user);
    } catch (e) {
      return null;
    }
  }

  // register with email and password
  Future register(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      return _returnCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
