import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/userSession.dart';

class UserReportTable extends StatefulWidget {
  @override
  _UserReportTableState createState() => _UserReportTableState();
}

class _UserReportTableState extends State<UserReportTable> {
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

  final List<UserSession> mockData = [
    UserSession('11/11/2020', '20 MIN', 'GOOD'),
    UserSession('11/12/2020', '25 MIN', 'OK'),
    UserSession('11/13/2020', '30 MIN', 'BAD'),
    UserSession('11/14/2020', '35 MIN', 'BAD'),
    UserSession('11/15/2020', '40 MIN', 'OK'),
    UserSession('11/16/2020', '45 MIN', 'OK'),
    UserSession('11/17/2020', '20 MIN', 'OK'),
    UserSession('11/18/2020', '25 MIN', 'BAD'),
    UserSession('11/19/2020', '30 MIN', 'GOOD'),
    UserSession('11/20/2020', '35 MIN', 'GOOD'),
    UserSession('11/11/2020', '20 MIN', 'GOOD'),
    UserSession('11/12/2020', '25 MIN', 'OK'),
    UserSession('11/13/2020', '30 MIN', 'BAD'),
    UserSession('11/14/2020', '35 MIN', 'BAD'),
    UserSession('11/15/2020', '40 MIN', 'OK'),
    UserSession('11/16/2020', '45 MIN', 'OK'),
    UserSession('11/17/2020', '20 MIN', 'OK'),
    UserSession('11/18/2020', '25 MIN', 'BAD'),
    UserSession('11/21/2020', '40 MIN', 'GOOD')
  ];

  @override
  Widget build(BuildContext context) {
    bool columnTitles = false;
    final List<TableRow> rows = <TableRow>[];
    for (final UserSession rowData in mockData) {
      if (columnTitles == false) {
        rows.add(TableRow(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Column(children: [
              const Text(
                'Date',
                style: TextStyle(fontSize: 19, color: Colors.black),
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Column(children: [
              Text(
                'Duration',
                style: const TextStyle(fontSize: 19, color: Colors.black),
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Column(children: [
              const Text('Focus',
                  style: TextStyle(fontSize: 19, color: Colors.black)),
            ]),
          ),
        ]));
        columnTitles = true;
      }

      rows.add(
        TableRow(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Column(children: [
              Text(rowData.date,
                  style: const TextStyle(fontSize: 17, color: Colors.black)),
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Column(children: [
              Text(rowData.duration,
                  style: const TextStyle(fontSize: 17, color: Colors.black)),
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Column(children: [
              Text(rowData.focus,
                  style: TextStyle(
                      fontSize: 17, color: getFocusColor(rowData.focus))),
            ]),
          ),
        ]),
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'REPORTS',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  columnWidths: {
                    0: const FlexColumnWidth(1.0),
                    1: const FlexColumnWidth(1.0),
                    2: const FlexColumnWidth(1.0),
                  },
                  border: TableBorder.all(color: Colors.black, width: 2.0),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: rows,
                )
              ]),
            )),
      ),
    );
  }
}
