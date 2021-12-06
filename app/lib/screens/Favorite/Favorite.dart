// ignore_for_file: file_names

import 'package:app/screens/ViewListing/ViewListing_page.dart';
import 'package:app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/services/database.dart';
import 'package:flutter/cupertino.dart';

var currnetFavorites = [];
var allPosts = [];
var currentPosts = [];
var allUserPosts = [];

var price = [];
var description = [];
var title = [];
var tags = [];
var Favoritekeys = [];
var allData = [];
var images = [];
List<GeoPoint> locations = [];
List<String> postId = [];
List<String> userId = [];

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MyFavoritesPage();
  }

  getData() async {
    AuthService authService = AuthService();
    var favorites = await DatabaseService().getFavorites();
    var key = authService.getID();
    currnetFavorites.clear();
    currentPosts.clear();
    price.clear();
    title.clear();
    description.clear();
    tags.clear();
    allPosts.clear();
    images.clear();
    locations.clear();
    postId.clear();
    userId.clear();
    favorites.forEach((element) => {
          if (allPosts.contains(element["postId"]))
            {}
          else if (key == element["ref"])
            {
              currnetFavorites.add(element),
              postId.add(element["postId"]),
              allPosts.add(element["postId"])
            },
        });

    var snapshot1;
    var data;

    try {
      for (int i = 0; i < allPosts.length; i++) {
        snapshot1 = await FirebaseFirestore.instance
            .collection("listing")
            .doc(allPosts[i])
            .get();

        data = snapshot1.data();
        price.add(data["price"]);
        title.add(data["title"]);
        description.add(data["description"]);
        tags.add(data["tag"]);
        images.add(data["url"]);
        locations.add(data["position"]["geopoint"]);
        userId.add(data["uid"]);
      }
    } catch (exception) {}

    setState(() {});
  }
}

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Map<String, dynamic>> allListings = [];
  final Listing = FirebaseFirestore.instance.collection('listing');
  final Favorites = FirebaseFirestore.instance.collection('Favorite');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: price.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  border: Border.all(color: Colors.blue, width: 2)),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewListing(
                              title[index],
                              price[index],
                              description[index],
                              tags[index],
                              images[index],
                              postId[index],
                              userId[index],
                              locations[index]),
                        ));
                  },
                  child: Container(
                      height: 120,
                      child: Row(
                        children: [
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  // topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  // bottomRight: Radius.circular(20)
                                ),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(images[index]))),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 10),
                                height: 120,
                                decoration: BoxDecoration(
                                  // color: custom_colour2,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                                child: Text(
                                              title[index],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                                child: Text(("\$" +
                                                    price[index].toString()))),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ))));
        });
  }
}
