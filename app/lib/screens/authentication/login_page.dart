import 'package:app/classes/forgot_password_dialog.dart';
import 'package:app/classes/form_fields/email_field.dart';
import 'package:app/screens/authentication/create_account_page.dart';
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
  // create a connection with the firebase authentication service
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
      appBar: AppBar(
        // remove back button
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Login"),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                // switch the screen to the create account screen
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateAccount()));
              },
              icon: Icon(Icons.add),
              label: Text("Sign Up"))
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
                    //email field
                    EmailFormWidget(
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // password field
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
                      // login button
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _email = emailController.text.toString();
                              _password = passwordController.text.toString();
                              // attempt to login with firebase authenticator
                              dynamic result =
                                  await _auth.signIn(_email, _password);
                              if (result == null) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Could not sign in with those credentials")));
                              } else {
                                // authentication worked, pop this screen and the provider will push the dashboard
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
