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

  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    ProviderHelper providerHelper = context.watch<ProviderHelper>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [Image.asset('assets/boomerangTxt.png')],
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
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onSubmitted: (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsWidget(value, true),
                        ));
                  },
                )),
            preferredSize: Size.fromHeight(30)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  categories.sort((a, b) => a.title.compareTo(b.title));
                });
              },
              icon: Icon(
                Icons.sort_by_alpha,
              )),
        ],
      ),
      backgroundColor: Colors.blue[50],
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
  Category(Icons.watch, "Apparel", 'assets/apparel.jpeg'),
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

class Category extends StatelessWidget {
  IconData icon;
  String title;
  String imageLink;

  Category(this.icon, this.title, this.imageLink);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultsWidget(title, false)));
        },
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
                          Icon(icon, color: Colors.white),
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
                          fit: BoxFit.fitWidth, image: AssetImage(imageLink))),
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
    //providerHelper.changePageIndex(0);
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
      index: providerHelper.pageIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        providerHelper.changePageIndex(index);
      },
    );
  }
}
