import 'package:app/classes/forgot_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/classes/globals.dart';
import 'package:app/classes/form_fields/form_field.dart';
import 'package:app/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final borderColour = custom_colour;
  var emailController = TextEditingController();
  // for the forgot password field
  var emailController2 = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Center(child: Text("Login")),
        actions: [
          ElevatedButton.icon(
              onPressed: () {}, icon: Icon(Icons.add), label: Text("Sign Up"))
        ],
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _email = emailController.text.toString();
                              _password = passwordController.text.toString();
                              dynamic result =
                                  await _auth.signIn(_email, _password);
                              if (result == null) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Could not sign in with those credentials")));
                              } else {
                                Navigator.of(context).pop();
                              }
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
                    onTap: () =>
                        forgotPasswordDialog(context, emailController2),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
