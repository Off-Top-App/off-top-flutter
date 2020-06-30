import 'dart:async';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/login.dart';

Future<dynamic> showDialogPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => const LoginPage()),
                  (Route<void> route) => false);
            },
          ),
        ],
      );
    },
  );
}
