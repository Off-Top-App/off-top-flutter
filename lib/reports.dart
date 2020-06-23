import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/subnavbar.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    bool column_title = false;
    final myRowDataList = List<String>.generate(3, (i) => "Item $i");
    final rows = <TableRow>[];
    for (var rowData in myRowDataList) {
      if (column_title == false) {
        rows.add(TableRow(children: [
          Column(children: [Text('Date')]),
          Column(children: [Text('Duration')]),
          Column(children: [Text('Focus')]),
        ]));
        column_title = true;
      }
      rows.add(TableRow(children: [
        Column(children: [Text('')]),
        Column(children: [Text('')]),
        Column(children: [Text('')]),
      ]));
    }

    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Column(children: <Widget>[
        // Subnavbar(),
        Container(
            margin: EdgeInsets.all(50),
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(1.0),
                1: FlexColumnWidth(2.0),
              },
              border: TableBorder.all(color: Colors.black, width: 2.0),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: rows,
            )),
      ]))),
    );
  }
}
