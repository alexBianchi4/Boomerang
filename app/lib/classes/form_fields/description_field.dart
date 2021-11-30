import 'package:flutter/material.dart';
import 'package:app/classes/globals.dart';

class DescriptionWidget extends StatefulWidget {
  final TextEditingController controller;
  const DescriptionWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  FocusNode _focus = FocusNode();
  bool selected = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onListen);
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void onListen() {
    setState(() {});
  }

  void _onFocusChange() {
    selected = !selected;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focus,
      controller: widget.controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Description",
        prefixIcon: const Icon(Icons.text_fields),
        suffixIcon: selected
            ? IconButton(
                onPressed: () {
                  // lower the keyboard
                  // we need an enter button since it was replaced on the keyboard by the newline button
                  _focus.unfocus();
                },
                icon: Icon(Icons.check))
            : Container(
                width: 0,
              ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: custom_colour, width: 2.0)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
