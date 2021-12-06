// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers, dead_code, prefer_const_literals_to_create_immutables
import 'package:app/classes/globals.dart';
import 'package:app/screens/ViewListing/ViewListing_page.dart';
import 'package:app/services/geolocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> urls = [];
String categoryGlobal = "";
bool wasSearched = false;

class ResultsWidget extends StatefulWidget {
  ResultsWidget(String category, bool search) {
    categoryGlobal = category;
    wasSearched = search;
  }

  @override
  _ResultsWidgetState createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
              margin: EdgeInsets.only(right: 60),
              child: Image.asset("assets/boomerangTxt.png")),
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
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsWidget(value, true),
                            ));
                      })),
              preferredSize: Size.fromHeight(30)),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
            child: StreamBuilder(
                stream: wasSearched
                    ? FirebaseFirestore.instance
                        .collection("listing")
                        .where("search_cases", arrayContains: categoryGlobal)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("listing")
                        .orderBy('title', descending: false)
                        .where("tag", isEqualTo: categoryGlobal)
                        .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                      itemCount: snapshot.data.docs.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 25);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var docData = snapshot.data.docs[index].data();
                        var docId = snapshot.data.docs[index].id;
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)),
                              border:
                                  Border.all(color: custom_colour, width: 2)),
                          child: GestureDetector(
                              onTap: () {
                                GeoPoint location =
                                    docData["position"]["geopoint"];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewListing(
                                          docData["title"],
                                          docData["price"],
                                          docData["description"],
                                          docData["tag"],
                                          docData["url"],
                                          docId,
                                          docData["uid"],
                                          location),
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
                                                image: NetworkImage(
                                                    docData["url"]))),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color: custom_colour2,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                            child: Text(
                                                          docData['title'],
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                            child: Text(
                                                          ("\$" +
                                                              docData['price']
                                                                  .toString()),
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ))),
                        );
                      });
                })),
        backgroundColor: Colors.white);
  }
}
