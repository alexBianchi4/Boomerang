import 'package:app/classes/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/classes/user.dart';
import 'package:app/screens/dashboard/dashboard_page.dart';
import 'login_page.dart';
import 'create_account_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    // if the user logs in or is already logged in from a previous time, go to the dashboard
    if (user != null) {
      return DashBoard();
    }
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: Center(
          child: ListView(
            children: [
              Image.asset("assets/Boomerang_Pan_GIF.gif"),
              Container(
                  padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: const Text("Sign In",
                                style: TextStyle(fontSize: 18.0)),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )))),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateAccount()));
                            },
                            child: const Text(
                              "Create Account",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )))),
                      )
                    ],
                  )),
              SizedBox(
                height: 38,
              ),
              // referred to this website to create the wave widget
              // https://www.fluttercampus.com/guide/32/how-to-create-wave-animation-easily-using-package-flutter-app/
              WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [
                      custom_colour,
                      Colors.yellow,
                      Colors.cyan,
                    ],
                    [Colors.yellow, custom_colour, Colors.red],
                    // [Colors., Color(0xFF00dbde)],
                    // [Color(0xFF396afc), Color(0xFF2948ff)]
                  ],
                  durations: [30000, 90000],
                  heightPercentages: [0.60, 0.7],
                  blur: MaskFilter.blur(BlurStyle.solid, 5),
                  gradientBegin: Alignment.topLeft,
                  gradientEnd: Alignment.bottomRight,
                ),
                waveAmplitude: 16.0,
                // backgroundColor: Colors.white,
                size: Size(double.infinity, 190.0),
              )
            ],
          ),
        ));
  }
}
