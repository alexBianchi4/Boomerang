import 'package:flutter/material.dart';
import 'globals.dart';

class PasswordWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool obscure;
  final String text;
  final Icon prefix;
  const PasswordWidget({
    Key? key,
    required this.controller,
    required this.obscure,
    required this.text,
    required this.prefix,
  }) : super(key: key);

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
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
      obscureText: widget.obscure,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cant be null';
        }
        if (value.length < 6) {
          return 'Enter a password longer than 6 characters';
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
