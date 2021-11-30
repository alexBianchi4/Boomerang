import 'package:app/classes/form_fields/email_field.dart';
import 'package:app/classes/form_fields/form_field.dart';
import 'package:app/classes/form_fields/password_field.dart';
import 'package:app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:app/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

var _userName;
var _email;
var _password;
var _newPassword;
var _confirmedNewPassword;
var _phone;
var _username;

var emailController = TextEditingController();
var usernameController = TextEditingController();
var passwordController = TextEditingController();
var newPasswordController = TextEditingController();
var confirmNewPasswordController = TextEditingController();
var phoneController = TextEditingController();

final AuthService _auth = new AuthService();

class _ProfileState extends State<Profile> {
  void initState() {
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    var user = await DatabaseService().getUserInfo();
    user['email'] = _auth.getUserEmail();
    //print(_email);

    usernameController.text = user['username'];
    phoneController.text = user['phone_number'];
    emailController.text = user['email'];
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // space between fields
  final double spacer = 20.0;

  // controllers for getting text from fields
  TextEditingController titleController = TextEditingController();

  // stores the assigned tag
  String tag = 'Choose a tag';

  @override
  Widget build(BuildContext context) {
    // put the whole body in a listview so it can scroll
    return ListView(children: [
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
                  SizedBox(height: 3 * spacer),
                  //email
                  EmailFormWidget(
                    controller: emailController,
                  ),
                  SizedBox(height: spacer),
                  //phone number
                  FormWidget(
                      controller: phoneController,
                      obscure: false,
                      text: "Phone Number",
                      prefix: Icon(Icons.phone)),
                  SizedBox(height: 3 * spacer),
                  //password
                  PasswordWidget(
                    controller: passwordController,
                    obscure: true,
                    text: "Current Password",
                  ),
                  SizedBox(height: spacer),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          print(await DatabaseService().getUserInfo());
                        }, //saveChanges(),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        child: Text(
                          "My Listings",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                      onPressed: saveChanges, child: Icon(Icons.save))
                ],
              )))
    ]);
  }

  saveChanges() async {
    //Confirms that a password has been given
    if (passwordController.text != "") {
      //Confirm password is correct
      var credential = await _auth.tryLogin(passwordController.text);
      if (credential != null) {
        DatabaseService()
            .updateUserData(usernameController.text, phoneController.text);

        _auth.updateEmail(emailController.text, credential);
        // await fetchUserData();
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text("Profile Updated"),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text("Invalid password"),
          backgroundColor: Colors.red,
        ));
      }
      passwordController.text = "";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text("Please enter your password to confirm updates"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
