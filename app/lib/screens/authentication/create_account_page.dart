import 'package:flutter/material.dart';
import 'package:app/classes/globals.dart';
import 'package:app/classes/form_fields/form_field.dart';
import 'package:app/classes/form_fields/email_field.dart';
import 'package:app/classes/form_fields/password_field.dart';
import 'package:app/services/auth.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final AuthService _auth = new AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //the space between each form field
  final double spacer = 20;
  final borderColour = custom_colour;
  //controllers for the form fields
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();

  var _email;
  var _password;
  var _confirmedPassword;
  var _phone;
  var _username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Center(child: Text("Create Account")),
        actions: [
          ElevatedButton.icon(
              onPressed: () {}, icon: Icon(Icons.person), label: Text("Login"))
        ],
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //username
                      FormWidget(
                          controller: usernameController,
                          obscure: false,
                          text: "Username",
                          prefix: Icon(Icons.person)),
                      SizedBox(height: spacer),
                      //email
                      EmailFormWidget(
                          controller: emailController,
                          obscure: false,
                          text: "Email",
                          prefix: Icon(Icons.email)),
                      SizedBox(height: spacer),
                      //phone number
                      FormWidget(
                          controller: phoneController,
                          obscure: false,
                          text: "Phone Number",
                          prefix: Icon(Icons.phone)),
                      SizedBox(height: spacer),
                      //password
                      PasswordWidget(
                          controller: passwordController,
                          obscure: true,
                          text: "Password",
                          prefix: Icon(Icons.password)),
                      SizedBox(height: spacer),
                      //confirmPassword
                      FormWidget(
                          controller: confirmPasswordController,
                          obscure: true,
                          text: "Confirm Password",
                          prefix: Icon(Icons.password)),
                      SizedBox(height: spacer),
                      Container(
                        padding: EdgeInsets.all(30.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _password =
                                      passwordController.text.toString();
                                  _confirmedPassword =
                                      confirmPasswordController.text.toString();
                                  if (_password != _confirmedPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Passwords do not match")));
                                  } else {
                                    _username =
                                        usernameController.text.toString();
                                    _email = emailController.text.toString();
                                    _password =
                                        passwordController.text.toString();
                                    _phone = phoneController.text.toString();
                                    dynamic result =
                                        await _auth.register(_email, _password);
                                    if (result == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Email already in use")));
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                }
                              },
                              icon: Icon(Icons.add),
                              label: Text(
                                "Create Account",
                                style: TextStyle(fontSize: 16.0),
                              ),
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