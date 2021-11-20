import 'package:flutter/material.dart';
import 'globals.dart';

class FormWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool obscure;
  final String text;
  final Icon prefix;
  const FormWidget({
    Key? key,
    required this.controller,
    required this.obscure,
    required this.text,
    required this.prefix,
  }) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
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
        return null;
      },
      onSaved: (value) {},
    );
  }
}
