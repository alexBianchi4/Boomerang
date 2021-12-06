// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:app/classes/globals.dart';
import 'package:app/screens/dashboard/provider_helper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

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
