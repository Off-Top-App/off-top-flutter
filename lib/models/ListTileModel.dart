import 'package:flutter/material.dart';

class ListTileModel {
  ListTileModel(
    this.title,
    this.dataList,
    this.icon,
    this.iconColor,
  );

  final String title;
  List<String> dataList = <String>[];
  final IconData icon;
  List<Color> iconColor = <Color>[];
}
