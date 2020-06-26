import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/User.dart';

import 'package:off_top_mobile/login/login.dart';

Future<dynamic> Show_dialog_Popup(BuildContext context) {
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
