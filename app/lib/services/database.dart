import 'dart:io';
import 'package:app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  // reference for user_info collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_info');

  // reference for products collection
  final CollectionReference listingsCollection =
      FirebaseFirestore.instance.collection('listing');

  // creates a document in the user collection
  Future updateUserData(String username, String phone) async {
    return await userCollection
        .doc(uid)
        .set({'username': username, 'phone_number': phone});
  }

  // this should create a document in the listing collection and an image file in firebase storage
  // with the name of the id of the listing it is a part of
  Future createListing(
    String title,
    String description,
    String tag,
    double price,
    File image,
  ) async {
    AuthService auth = AuthService();
    String uid = auth.getID();
    DocumentReference docref = await listingsCollection.add({
      'uid': uid,
      'title': title,
      'description': description,
      'tag': tag,
      'price': price
    });
    //get the id of the document that was just created in listing
    String id = docref.id;
    try {
      final ref = FirebaseStorage.instance.ref("files/$id");
      return ref.putFile(image);
    } catch (e) {
      return null;
    }
  }

  //a test function to create a listing with no image
  Future createListing2(
    String title,
    String description,
    String tag,
    double price,
  ) async {
    AuthService auth = AuthService();
    String uid = auth.getID();
    DocumentReference docref = await listingsCollection.add({
      'uid': uid,
      'title': title,
      'description': description,
      'tag': tag,
      'price': price
    });
    return docref;
  }
}
