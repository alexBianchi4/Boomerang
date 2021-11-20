import 'package:flutter/material.dart';
import 'package:app/services/auth.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final AuthService _auth = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dashboard"),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(Icons.remove),
              label: Text("sign out"))
        ],
      ),
      body: Container(),
    );
  }
}
