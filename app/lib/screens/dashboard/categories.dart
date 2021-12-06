// ignore_for_file: prefer_const_constructors
import 'package:app/classes/globals.dart';
import 'package:app/screens/products/results_page.dart';
import 'package:flutter/material.dart';

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
