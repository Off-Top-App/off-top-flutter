import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/reports/reportsGraph.dart';
import 'package:flutter/src/material/ink_well.dart';

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

Widget getTableData(double fontSize, String data, Color dataColor, BuildContext context, String date) {
  return TableRowInkWell(
      child: Container(
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: Column(children: [
        Text(data.toString(),
            style: TextStyle(fontSize: fontSize, color: dataColor)),
      ]),
    ),
    onTap: () {
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SizedBox(height: 600,
    child: ReportsGraph(date)),
  ));
    },
  );
}
