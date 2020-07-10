import 'package:flutter/material.dart';

Color getFocusColor(String focus) {
  if (focus == 'GOOD') {
    return Colors.green;
  }
  if (focus == 'OK') {
    return Colors.orange;
  }
  if (focus == 'BAD') {
    return Colors.red;
  }
  return Colors.black;
}

Widget getTableData(double fontSize, String data, Color dataColor) {
  return Container(
    padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
    child: Column(children: [
      Text(data.toString(),
          style: TextStyle(fontSize: fontSize, color: dataColor)),
    ]),
  );
}
