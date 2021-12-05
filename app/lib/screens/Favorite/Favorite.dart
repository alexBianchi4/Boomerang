// ignore_for_file: file_names

import 'package:app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/services/database.dart';

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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/EBay_logo.svg/1920px-EBay_logo.svg.png',
                width: 100,
              )
            ],
          ),
        ),
        body: MyFavoritesPage());
  }

  getData() async {
    AuthService authService = new AuthService();
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
    favorites.forEach((element) => {
          if (allPosts.contains(element["postId"]))
            {}
          else if (key == element["ref"])
            {currnetFavorites.add(element), allPosts.add(element["postId"])},
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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(images[index]))),
            child: Row(children: [
              Column(children: [
                // Image.asset("assets/Console.PNG", height: 150,width: 150,)
              ]),
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(title[index].toString()),
                      ]),
                  Text(tags[index].toString()),
                  Text(price[index].toString()),
                  Text(description[index].toString()),
                ],
              )
            ]),
          );
        });
  }
}
