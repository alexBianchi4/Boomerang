import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/screens/products/listing_preview.dart';
import 'package:app/classes/user.dart';

class ResultsWidget extends StatefulWidget {
  const ResultsWidget({Key? key}) : super(key: key);

  @override
  _ResultsWidgetState createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  //need to query the data this is returning all of it
  final listings = FirebaseFirestore.instance.collection("listing");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: listings.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListingPreview();
                });
          }),
    );
  }
}
