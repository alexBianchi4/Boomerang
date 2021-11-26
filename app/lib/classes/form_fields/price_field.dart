import 'package:flutter/material.dart';
import 'package:app/classes/globals.dart';

class PriceWidget extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final Icon prefix;
  const PriceWidget({
    Key? key,
    required this.controller,
    required this.text,
    required this.prefix,
  }) : super(key: key);

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
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
      keyboardType: TextInputType.number,
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
        } else if (double.tryParse(value) == null) {
          return 'This field must be made of numbers';
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
