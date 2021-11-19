import 'package:flutter/material.dart';
import 'globals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email = '';
  String? _password = '';
  final borderColour = custom_colour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Email:",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: borderColour, width: 2.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cant be null';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password:",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: borderColour, width: 2.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cant be null';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                  ],
                )),
          ),
          Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.login),
                          label: Text("Sign In"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )))),
                    ),
                  ),
                  GestureDetector(
                    child: Text("Forgot Password?",
                        style: TextStyle(color: Colors.blue)),
                    onTap: () => print("pressed"),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
