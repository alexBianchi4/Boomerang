import 'package:app/classes/form_fields/email_field.dart';
import 'package:app/classes/form_fields/form_field.dart';
import 'package:app/classes/form_fields/password_field.dart';
import 'package:app/classes/globals.dart';
import 'package:app/services/database.dart';
import 'package:app/services/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:app/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

var emailController = TextEditingController();
var usernameController = TextEditingController();
var passwordController = TextEditingController();
var newPasswordController = TextEditingController();
var confirmNewPasswordController = TextEditingController();
var phoneController = TextEditingController();

final AuthService _auth = AuthService();

class _ProfileState extends State<Profile> {
  void initState() {
    super.initState();
    fetchUserData();
    GeolocationService geo = GeolocationService();
  }

  fetchUserData() async {
    var user = await DatabaseService().getUserInfo();
    user['email'] = _auth.getUserEmail();
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
          child: Column(
                children: [
                  
                  SizedBox(height: spacer),
                  //username
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: spacer),
                      Align(
                  alignment: Alignment.centerLeft,
                  child: Text(usernameController.text,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: custom_colour,)),
                  ),]),
                  //email
                     SizedBox(height:1.5* spacer),
                  
                      Align(
                  alignment: Alignment.center,
                  child:Row(
                    children: [
                      SizedBox(child: Icon(Icons.mail)),
                      SizedBox(width: spacer),
                  Text(emailController.text,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))])),

                  SizedBox(height: 2 * spacer),
                  
                      Align(
                  alignment: Alignment.center,
                  child:Row(
                    children: [
                      SizedBox(child: Icon(Icons.phone)),
                      SizedBox(width: spacer),
                  Text(phoneController.text,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))])),
                  SizedBox(height: 8 * spacer),
                  //phone number
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          backgroundColor: custom_colour,
                          onPressed: () {
                            editorPopup();
                          },
                          child: Icon(Icons.edit)),

                          FloatingActionButton(
                          backgroundColor: custom_colour,
                          onPressed: () {
                             AuthService().signOut();
                          },
                          child: Icon(Icons.logout))
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: ()  {
                          passwordEditorPopup();
                        }, //saveChanges(),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        child: 
                        Text(
                          "Change Password",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ))
    ]);
  }

  editorPopup() {
    showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:
                     Column(
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
                  ),
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
                    text: "Current Password",
                  ),
                  SizedBox(height: spacer),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          backgroundColor: custom_colour,
                          onPressed: saveChanges,
                          child: Icon(Icons.save)),
                    ],
                  ),
                ],
              )
                  );
                }).then((val) {
                  passwordController.text = "";
                  setState(() {  });
                });
  }

  passwordEditorPopup(){
    showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      children: [
                        PasswordWidget(
                    controller: newPasswordController,
                    obscure: true,
                    text: "New Password",
                  ),
                   SizedBox(height: spacer),
                  PasswordWidget(
                    controller: confirmNewPasswordController,
                    obscure: true,
                    text: "Confirm New Password",
                  ),
                   SizedBox(height: spacer),
                        PasswordWidget(
                    controller: passwordController,
                    obscure: true,
                    text: "Old Password",
                  ),
                   SizedBox(height: spacer),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          backgroundColor: custom_colour,
                          onPressed: savePassword,
                          child: Icon(Icons.save)),
                    ],
                  )
                      ],
                    )
                  );
                }).then((val) {
                  passwordController.text = "";
                  newPasswordController.text = "";
                  confirmNewPasswordController.text = "";
                  setState(() {  });
                });
  }

  savePassword() async {
    //Confirms that a password has been given
    if (passwordController.text != "") {
      //Confirm password is correct
      var credential = await _auth.tryLogin(passwordController.text);
      if (credential != null) {
        if (newPasswordController.text == confirmNewPasswordController.text){
         _auth.updatePassword(newPasswordController.text, credential);
         passwordController.text = "";
        newPasswordController.text = "";
        confirmNewPasswordController.text = "";
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text("Password Updated"),
          backgroundColor: Colors.green,
        ));
        }
        else{
          passwordController.text = "";
          newPasswordController.text = "";
          confirmNewPasswordController.text = "";
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ));
        }
      } else {
        passwordController.text = "";
        newPasswordController.text = "";
        confirmNewPasswordController.text = "";
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text("Invalid password"),
          backgroundColor: Colors.red,
        ));
      }
      passwordController.text = "";
    } else {
      passwordController.text = "";
      newPasswordController.text = "";
      confirmNewPasswordController.text = "";
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text("Please enter your password to confirm updates"),
        backgroundColor: Colors.red,
      ));
    }
    Navigator.pop(context);
  }

  saveChanges() async {
    
    //Confirms that a password has been given
    if (passwordController.text != "") {
      //Confirm password is correct
      var credential = await _auth.tryLogin(passwordController.text);
      if (credential != null) {
        DatabaseService().updateUserData(usernameController.text,
            phoneController.text, emailController.text);

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
    Navigator.pop(context);
  }
}
