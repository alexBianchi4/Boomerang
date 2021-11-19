// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'globals.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final double spacer = 20;
  final borderColour = custom_colour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Name:",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: borderColour, width: 2.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cant be null';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(height: spacer),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Email:",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: borderColour, width: 2.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cant be null';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(height: spacer),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Phone Number:",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: borderColour, width: 2.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cant be null';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(height: spacer),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password:",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: borderColour, width: 2.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cant be null';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(height: spacer),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Confirm Password:",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: borderColour, width: 2.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cant be null';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                      SizedBox(height: spacer),
                      Container(
                        padding: EdgeInsets.all(30.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                              label: Text("Create Account"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )))),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
