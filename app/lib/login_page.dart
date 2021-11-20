import 'package:flutter/material.dart';
import 'globals.dart';
import 'form_field.dart';

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
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                    FormWidget(
                        controller: emailController,
                        obscure: false,
                        text: "Email",
                        prefix: Icon(Icons.email)),
                    const SizedBox(
                      height: 20,
                    ),
                    FormWidget(
                        controller: passwordController,
                        obscure: true,
                        text: "Password",
                        prefix: Icon(Icons.password)),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                          },
                          icon: Icon(Icons.login),
                          label:
                              Text("Sign In", style: TextStyle(fontSize: 16.0)),
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
                        style: TextStyle(color: Colors.blue, fontSize: 16.0)),
                    onTap: () => print("WTF DO WE DO"),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
