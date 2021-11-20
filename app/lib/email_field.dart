import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'globals.dart';

class EmailFormWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool obscure;
  final String text;
  final Icon prefix;
  const EmailFormWidget({
    Key? key,
    required this.controller,
    required this.obscure,
    required this.text,
    required this.prefix,
  }) : super(key: key);

  @override
  _EmailFormWidgetState createState() => _EmailFormWidgetState();
}

class _EmailFormWidgetState extends State<EmailFormWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: widget.obscure,
      decoration: InputDecoration(
        labelText: widget.text,
        prefixIcon: widget.prefix,
        suffixIcon: widget.controller.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                onPressed: () {
                  widget.controller.clear();
                },
                icon: Icon(Icons.close)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: custom_colour, width: 2.0)),
      ),
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? "Enter a valid email"
          : null,
      onSaved: (value) {},
    );
  }
}
