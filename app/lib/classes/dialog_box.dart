import 'package:app/classes/globals.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(text)),
          content: Icon(Icons.check, size: 60, color: custom_colour),
        );
      });
}
