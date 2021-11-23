// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/classes/globals.dart';
import 'package:app/screens/authentication/create_account_page.dart';
import 'package:app/screens/authentication/login_page.dart';
import 'package:app/screens/dashboard/provider_helper.dart';
import 'package:app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:app/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';

import 'package:provider/src/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Widget? decide(int index) {
    if (index == 0) {
      return ScaffoldBodyContent();
    } else if (index == 1) {
      return LoginPage();
    } else if (index == 2) {
      return CreateAccount();
    } else if (index == 3) {
      return Container();
    }
    return null;
  }

  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    ProviderHelper providerHelper = context.watch<ProviderHelper>();
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
        bottom: PreferredSize(
            child: Container(
                padding: EdgeInsets.only(bottom: 7),
                height: 40,
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                )),
            preferredSize: Size.fromHeight(30)),
        actions: [
          /* a button for logging out and adding a test set of data to the db (for testing purposes)
          IconButton(
              onPressed: () {
                auth.signOut();
              },
              icon: Icon(Icons.exit_to_app)),
          IconButton(
              onPressed: () {
                Image.network('https://googleflutter.com/sample_image.jpg');
                DatabaseService("").createListing2(
                  "gamecube",
                  "a gamecube that works really well",
                  "gaming",
                  150,
                );
              },
              icon: Icon(Icons.add))
        */
        ],
      ),
      backgroundColor: Colors.blue[50],
      drawer: Drawer(),
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
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
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
  Category(Icons.car_rental, "Auto",
      'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  Category(Icons.phone_android, "Phones",
      'https://images.pexels.com/photos/887751/pexels-photo-887751.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  Category(Icons.computer, "Laptops",
      'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  Category(Icons.chair, "Furniture",
      'https://images.pexels.com/photos/1866149/pexels-photo-1866149.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  Category(Icons.shop, "Apparel",
      'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  Category(Icons.watch, "Watches",
      'https://images.pexels.com/photos/380782/pexels-photo-380782.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  Category(Icons.pedal_bike, "Bikes",
      'https://images.pexels.com/photos/100582/pexels-photo-100582.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  Category(Icons.book, "Books",
      'https://images.pexels.com/photos/159866/books-book-pages-read-literature-159866.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
];

class Category extends StatelessWidget {
  IconData icon;
  String title;
  String imageLink;

  Category(this.icon, this.title, this.imageLink);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            height: 120,
            child: Row(
              children: [
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: theme_colour),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          )
                        ])),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(imageLink))),
                )),
              ],
            )));
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        // BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "New Post"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Saved"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account")
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

class BottomNavBarCurved extends StatefulWidget {
  const BottomNavBarCurved({Key? key}) : super(key: key);

  @override
  _BottomNavBarCurvedState createState() => _BottomNavBarCurvedState();
}

class _BottomNavBarCurvedState extends State<BottomNavBarCurved> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ProviderHelper providerHelper = context.read<ProviderHelper>();
    return CurvedNavigationBar(
      items: [
        Icon(
          Icons.home,
          semanticLabel: "Home",
        ),
        Icon(Icons.star),
        Icon(Icons.post_add),
        Icon(Icons.person)
      ],
      height: 45,
      animationDuration: Duration(milliseconds: 300),
      color: Colors.white,
      backgroundColor: theme_colour,
      animationCurve: Curves.fastOutSlowIn,
      index: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        providerHelper.changePageIndex(index);
      },
    );
  }
}
