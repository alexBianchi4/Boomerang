// ignore_for_file: file_names

import 'package:app/classes/globals.dart';
import 'package:app/screens/Favorite/Favorite.dart';
import 'package:app/services/geolocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/services/database.dart';
import 'package:app/services/auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

String name = "";
String email = "";
String phone = "";
String distance = "";
String city = "";

class ViewListing extends StatefulWidget {
  String title;
  double price;
  String description;
  String tag;
  String url;
  String postId;
  String userId;
  GeoPoint location;

  ViewListing(this.title, this.price, this.description, this.tag, this.url,
      this.postId, this.userId, this.location);
  @override
  _ViewListingState createState() => _ViewListingState();
}

class _ViewListingState extends State<ViewListing> {
  String currentIcon = "";
  Icon icon1 = Icon(Icons.star_border);
  int count = 0;
  @override
  void initState() {
    super.initState();
    checkFavorite();
    getData(widget.userId, widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [Image.asset("assets/boomerangTxt.png")],
        ),
        actions: <Widget>[
          IconButton(
            icon: icon1,
            onPressed: () async {
              if (currentIcon == "Icons.favorite") {
                currentIcon = "nothing";
              } else {
                currentIcon = "Icons.favorite";
              }

              if (currentIcon == "Icons.favorite") {
                insertFavorite();
              } else if (currentIcon != "Icons.favorite") {
                await deleteFavorite();
              }
              setState(() {
                if (currentIcon == "Icons.favorite") {
                  icon1 = Icon(Icons.star);
                } else {
                  icon1 = Icon(Icons.star_border);
                }
              });
            },
          ),
        ],
      ),
      body: ViewListContent(widget.title, widget.price, widget.description,
          widget.tag, widget.url, widget.userId),
    );
  }

  checkFavorite() async {
    AuthService authService = AuthService();
    var favorites = await DatabaseService().getFavorites();
    var key = authService.getID();
    var listOfPostId = [];

    favorites.forEach((element) => {
          if (element["ref"] == key)
            {
              listOfPostId.add(element["postId"]),
            }
        });
    print(listOfPostId);
    print(widget.postId);
    for (int i = 0; i < listOfPostId.length; i++) {
      if (listOfPostId[i] == widget.postId) {
        icon1 = Icon(Icons.star);
        currentIcon = "Icons.favorite";
      }
    }

    setState(() {});
  }

  getData(String id, GeoPoint location) async {
    var data = await DatabaseService().getUserInfoByID(id);
    name = data['username'];
    phone = data['phone_number'];
    email = data['email'];
    city = await GeolocationService()
        .getPlaceMark(location.latitude, location.longitude);
    double d = await GeolocationService()
        .getDistance(location.latitude, location.longitude);
    distance = (d * 0.001).toStringAsFixed(1);
    setState(() {});
  }

  insertFavorite() async {
    AuthService authService = AuthService();
    var key = authService.getID();

    var favorites = await DatabaseService()
        .insertFavorite({"ref": key, "postId": widget.postId});
  }

  deleteFavorite() async {
    AuthService authService = AuthService();
    var key = authService.getID();
    await DatabaseService()
        .deleteFavorite({"ref": key, "postId": widget.postId});
  }
}

class ViewListContent extends StatefulWidget {
  String title;
  double price;
  String description;
  String tag;
  String url;
  String userId;
  ViewListContent(this.title, this.price, this.description, this.tag, this.url,
      this.userId);

  @override
  _ViewListContentState createState() => _ViewListContentState();
}

class _ViewListContentState extends State<ViewListContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(widget.url))),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Text(widget.tag,
                  style: TextStyle(
                    color: Colors.grey,
                  )),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text((city + ' - ' + distance + ' km'),
                    style: TextStyle(color: custom_colour))),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: Text(("\$" + widget.price.toString()),
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
            Divider(
              thickness: 2.0,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: Text("Description",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Text(widget.description,
                    style: TextStyle(
                      fontSize: 15,
                    ))),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3.0,
                      color: custom_colour,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ("Posted by: " + name),
                            style:
                                TextStyle(color: custom_colour, fontSize: 18),
                          ),
                          Text(
                            ("Phone number: " + phone),
                            style:
                                TextStyle(color: custom_colour, fontSize: 18),
                          ),
                          Text(
                            ("Email: " + email),
                            style:
                                TextStyle(color: custom_colour, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        )
      ],
    );
  }
}
