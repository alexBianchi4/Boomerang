// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:app/services/auth.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
      ),
      drawer: Drawer(),
      body: ScaffoldBodyContent(),
      bottomNavigationBar: BottomNavBar(),
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
      padding: EdgeInsets.only(top: 10, left: 25, right: 25),
      child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 40,
          mainAxisSpacing: 30,
          children: [
            Category(Icons.car_rental, "Auto"),
            Category(Icons.phone_android, "Phones"),
            Category(Icons.computer, "Computers"),
            Category(Icons.chair, "Furniture"),
            Category(Icons.shop, "Apparel"),
            Category(Icons.watch, "Watches"),
            Category(Icons.pedal_bike, "Bikes"),
            Category(Icons.book, "Books")
          ]),
    );
  }
}

class Category extends StatelessWidget {
  IconData icon;
  String title;

  Category(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, size: 75, color: Colors.white),
              Text(title, style: TextStyle(fontSize: 25, color: Colors.white))
            ],
          ),
        ));
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
