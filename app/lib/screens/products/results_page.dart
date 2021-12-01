// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers, dead_code, prefer_const_literals_to_create_immutables

import 'package:app/classes/globals.dart';
import 'package:app/screens/dashboard/dashboard_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/screens/products/listing_preview.dart';
import 'package:app/classes/user.dart';

List<String> urls = [];
String categoryGlobal = "";

class ResultsWidget extends StatefulWidget {
  ResultsWidget(String category) {
    categoryGlobal = category;
  }

  @override
  _ResultsWidgetState createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  final listings = FirebaseFirestore.instance
      .collection("listing")
      .where("tag", isEqualTo: categoryGlobal);
  @override
  Widget build(BuildContext context) {
    // getURL();
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
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                )),
            preferredSize: Size.fromHeight(30)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.sort))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
          child: StreamBuilder(
              stream: listings.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.separated(
                    itemCount: snapshot.data.docs.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 25);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      var docData = snapshot.data.docs[index].data();
                      var docId = snapshot.data.docs[index].id;
                      return GestureDetector(
                          onTap: () {},
                          child: Container(
                              height: 120,
                              child: Row(
                                children: [
                                  Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            // Radius.circular(20)),
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            // topRight: Radius.circular(20),
                                            // bottomRight: Radius.circular(20)
                                          ),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(docData["url"])))
                                      // color: theme_colour
                                      ,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Text(
                                            //   docData['"title'],
                                            //   style: TextStyle(
                                            //     fontSize: 15,
                                            //     color: Colors.white,
                                            //   ),
                                            // )
                                          ])),
                                  Expanded(
                                      child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(docData['title']),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(docData['price'].toString())
                                      ],
                                    ),
                                  )),
                                ],
                              )));
                    });
              })),
      backgroundColor: Colors.blue[50],
    );
  }

  getURL() async {
    final db = FirebaseFirestore.instance;
    var result = await db.collection('listing').get();
    var docs = result.docs;
    int count = 0;
    for (var doc in docs) {
      final ref = FirebaseStorage.instance.ref("files/${doc.id}");
      String url = await ref.getDownloadURL();
      urls.add(url);
      print(url);
      // print(doc.id);
    }
    print(urls.length);
  }
}
