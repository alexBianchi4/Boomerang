import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Creating Your Listing')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
      barrierDismissible: false);
}
