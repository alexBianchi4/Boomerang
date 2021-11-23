import 'package:app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/classes/user.dart';
import 'auth.dart';

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

  //returns the current users UID
  String getID() {
    return _auth.currentUser!.uid;
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
  Future register(
      String email, String password, String username, String phone) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      // create a new document for the user in the user collection of firebase
      await DatabaseService(user!.uid).updateUserData(username, phone);
      return _returnCustomUser(user);
    } catch (e) {
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
