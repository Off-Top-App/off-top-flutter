import 'package:flutter/material.dart';

AppBar offTopTitle(BuildContext context) {
  return AppBar(
    title: Text(
      'OFF-TOP',
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
  );
}

Text offTopSettingsTitle1(BuildContext context) {
  return Text(
    'OFF-TOP',
    style: TextStyle(
      color: Theme.of(context).accentColor,
      fontSize: 40,
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.center,
  );
}
