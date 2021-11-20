import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(text));
      });
}
