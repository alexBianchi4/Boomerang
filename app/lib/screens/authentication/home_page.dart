import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/classes/user.dart';
import 'package:app/screens/dashboard/dashboard_page.dart';
import 'login_page.dart';
import 'create_account_page.dart';

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
