import 'package:flutter/material.dart';
import 'package:app/classes/globals.dart';

class DescriptionWidget extends StatefulWidget {
  final TextEditingController controller;

  final String text;
  final Icon prefix;
  const DescriptionWidget({
    Key? key,
    required this.controller,
    required this.text,
    required this.prefix,
  }) : super(key: key);

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
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
      keyboardType: TextInputType.multiline,
      minLines: 1, //Normal textInputField will be displayed
      maxLines: 5, // when user presses enter it will adapt to it

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
        return null;
      },
      onSaved: (value) {},
    );
  }
}
