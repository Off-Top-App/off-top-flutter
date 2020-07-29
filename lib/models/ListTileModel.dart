import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/UserSettings.dart';

class ListTileModel {
  ListTileModel(
      this.dataName,
    this.title,
    this.dataList,
    this.icon,
    this.iconColor,
    //this.dataFromUser,
  );
  String dataName;
  String title;
  List<String> dataList = <String>[];
  IconData icon;
  List<Color> iconColor = <Color>[];
  //List<String> dataFromUser = <String>[];

}
