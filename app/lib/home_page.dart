import 'package:flutter/material.dart';
import 'package:app/login_page.dart';
import 'create_account_page.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user != null) {
      return DashBoard();
    }
    return Scaffold(
        body: Center(
      child: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text("Sign In")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateAccount()));
              },
              child: const Text("Create Account"))
        ],
      ),
    ));
  }
}
