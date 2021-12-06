// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:app/classes/globals.dart';
import 'package:app/screens/Favorite/Favorite.dart';
import 'package:app/screens/dashboard/profile_page.dart';
import 'package:app/screens/dashboard/provider_helper.dart';
import 'package:app/screens/products/create_listing_page.dart';
import 'package:app/screens/products/results_page.dart';
import 'package:flutter/material.dart';
import 'package:app/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/src/provider.dart';

import 'categories.dart';
import 'navigation_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Widget? decide(int index) {
    //home icon is pressed
    if (index == 0) {
      return ScaffoldBodyContent();
      //favourite icon is pressed
    } else if (index == 1) {
      return Favorites();
      //add listing icon pressed
    } else if (index == 2) {
      return CreateListing();
      //profile icon pressed
    } else if (index == 3) {
      return Profile();
    }
    return null;
  }

  bool sorted = true;

  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    ProviderHelper providerHelper = context.watch<ProviderHelper>();
    return Scaffold(
      appBar: providerHelper.pageIndex == 0
          ? AppBar(
              centerTitle: true,
              title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Image.asset('assets/boomerangTxt.png')),
              bottom: PreferredSize(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 7),
                      height: 40,
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onSubmitted: (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ResultsWidget(value, true),
                              ));
                        },
                      )),
                  preferredSize: Size.fromHeight(30)),
              actions: [
                IconButton(
                    onPressed: () {
                      if (sorted == true) {
                        setState(() {
                          categories.sort((a, b) => b.title.compareTo(a.title));
                          sorted = false;
                        });
                      } else if (sorted == false) {
                        setState(() {
                          categories.sort((a, b) => a.title.compareTo(b.title));
                          sorted = true;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.sort_by_alpha,
                    )),
              ],
            )
          : AppBar(
              centerTitle: true,
              title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Image.asset('assets/boomerangTxt.png')),
            ),
      backgroundColor: Colors.white,
      body: decide(providerHelper.pageIndex),
      bottomNavigationBar: BottomNavBarCurved(),
    );
  }
}

class ScaffoldBodyContent extends StatefulWidget {
  const ScaffoldBodyContent({Key? key}) : super(key: key);

  @override
  _ScaffoldBodyContentState createState() => _ScaffoldBodyContentState();
}

class _ScaffoldBodyContentState extends State<ScaffoldBodyContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return categories[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 25);
        },
        itemCount: categories.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}

var categories = [
  Category(Icons.radio_button_checked, "Apparel", 'assets/apparel.jpeg'),
  Category(Icons.car_rental, "Auto", 'assets/auto.jpeg'),
  Category(Icons.pedal_bike, "Bikes", 'assets/bikes.jpeg'),
  Category(Icons.book, "Books", 'assets/books.jpeg'),
  Category(Icons.collections, "Collectibles", 'assets/collectible.jpg'),
  Category(Icons.chair, "Furniture", 'assets/furniture.jpeg'),
  Category(Icons.gamepad, "Gaming", 'assets/game.jpg'),
  Category(Icons.computer, "Laptops", 'assets/laptop.jpeg'),
  Category(Icons.phone_android, "Phones", 'assets/phone.jpeg'),
  Category(Icons.tv, "TVs", 'assets/tv.jpg'),
  Category(Icons.watch, "Watches", 'assets/watches.jpeg'),
];
