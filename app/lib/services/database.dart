import 'dart:io';
import 'package:app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app/services/geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DatabaseService {
  // reference for user_info collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_info');

  // reference for products collection
  final CollectionReference listingsCollection =
      FirebaseFirestore.instance.collection('listing');

  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('Favorite');

  // creates / updates a document in the user collection
  Future updateUserData(String username, String phone, String email) async {
    String uid = AuthService().getID();
    return await userCollection
        .doc(uid)
        .set({'username': username, 'phone_number': phone, 'email': email});
  }

  // creates a document in the listing collection and an image file in firebase storage
  // with the name of the id of the listing it is a part of
  Future createListing(
    String title,
    String description,
    String tag,
    double price,
    File image,
  ) async {
    // creating a list of possible search terms related to the listing title
    List<String> cases = title.split(' ');
    cases.add(title);
    // get the users ID
    String uid = AuthService().getID();
    // add a new document to the listing collection
    DocumentReference docref = await listingsCollection.add({
      'uid': uid,
      'title': title,
      'description': description,
      'tag': tag,
      'price': price,
      'search_cases': cases
    });
    // get the id of the document that was just created in listing
    String id = docref.id;

    await listingsCollection.doc(docref.id).update({
      'postId': id,
    });

    // use that id as the name for the image we are putting in firestore
    try {
      final ref = FirebaseStorage.instance.ref("files/$id");
      await ref.putFile(image);
      var url = await ref.getDownloadURL();
      await listingsCollection.doc(id).update({'url': url});
    } catch (e) {
      // if the image doesn't get stored delete the listing from the database
      await listingsCollection.doc(id).delete();
      return null;
    }

    try {
      // get the users latitude and longitude
      Position? position = await GeolocationService().getPosition();
      if (position == null) {
        return null;
      }
      // create a geoFirePoint so that we can store the coordiantes in firebase with the listing
      Geoflutterfire geo = Geoflutterfire();
      GeoFirePoint point =
          geo.point(latitude: position.latitude, longitude: position.longitude);
      await listingsCollection.doc(id).update({'position': point.data});
      return true;
    } catch (e) {
      return null;
    }
  }

  // returns a map that contains the information of a document with the ID of the user in the user_info collection
  getUserInfo() async {
    // get the users ID
    String uid = AuthService().getID();
    // get a snapshot of the document that coresponds to the users ID
    var snapshot =
        await FirebaseFirestore.instance.collection('user_info').doc(uid).get();
    // return the data from that document as a map
    return snapshot.data();
  }

  // returns a map that contains the information of a document with the ID of the user passed to the function
  // in the user_info collection
  getUserInfoByID(String id) async {
    // get a snapshot of the document that coresponds to the users ID
    var snapshot =
        await FirebaseFirestore.instance.collection('user_info').doc(id).get();
    // return the data from that document as a map
    return snapshot.data();
  }

  // returns a list of maps, each map is a document in the Favorite collection
  getFavorites() async {
    // get the list of snapshots from the Favorite collectoiob
    var snapshots =
        await FirebaseFirestore.instance.collection('Favorite').get();
    var docs = snapshots.docs;
    // use the map function to turn all of the snapshots into maps
    // returns as a list of maps
    List<Map<String, dynamic>> mapped = [];
    docs.forEach((element) {
      mapped.add({
        "postId": element["postId"],
        "ref": element["ref"],
        "name": element.id
      });
    });
    return mapped;
  }

  // returns a map that has all the listings information in it,
  // including the download url for the image
  // you can display the image from this url with Image.network(imageURL);
  getListing(String id) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('listing').doc(id).get();
    // return the data from that document as a map
    final mapped = snapshot.data();
    final ref = FirebaseStorage.instance.ref("files/$id");
    // no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    mapped!["imageURL"] = url;
    return mapped;
  }

  Future insertFavorite(Map<String, dynamic> row) async {
    DocumentReference docref = await favoritesCollection.add({
      'ref': row["ref"],
      'postId': row["postId"],
    });
    print(docref.id);
    await favoritesCollection
        .doc(docref.id)
        .set({'ref': row["ref"], 'postId': row["postId"], 'id': docref.id});
  }

  Future deleteFavorite(Map<String, dynamic> row) async {
    var data = await FirebaseFirestore.instance
        .collection("Favorite")
        .where("postId", isEqualTo: row["postId"])
        .where("ref", isEqualTo: row["ref"]);
    var currendtdata;

    try {
      await for (final value in data.snapshots()) {
        currendtdata = value.docs.first.data();
        print(currendtdata);
        print(currendtdata['id']);
        FirebaseFirestore.instance
            .collection('Favorite')
            .doc(currendtdata['id'])
            .delete();
      }
    } catch (exception) {
      print("this is error");
    }
  }
}
