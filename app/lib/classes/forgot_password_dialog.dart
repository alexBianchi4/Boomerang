import 'package:app/classes/form_fields/email_field.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';

forgotPasswordDialog(BuildContext context, TextEditingController controller) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Reset Password")),
          content: Column(
            // stop dialog from stretching to the bottom of the screen
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                  key: _formKey,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: EmailFormWidget(
                        controller: controller,
                      ))),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)))),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      String email = controller.text.toString();
                      AuthService().resetPassword(email);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Sent password reset to $email")));
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Request Reset"))
            ],
          ),
        );
      });
}
