import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/userSession.dart';
import 'components/reports/getTableDataWidget.dart';

class UserReportTable extends StatefulWidget {
  @override
  _UserReportTableState createState() => _UserReportTableState();
}

class _UserReportTableState extends State<UserReportTable> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  final List<UserSession> mockData = [
    UserSession('11/11/2020', '20 MIN', 'GOOD'),
    UserSession('11/12/2020', '25 MIN', 'OK'),
    UserSession('11/13/2020', '30 MIN', 'BAD'),
    UserSession('11/14/2020', '35 MIN', 'BAD'),
    UserSession('11/15/2020', '40 MIN', 'OK'),
    UserSession('11/16/2020', '45 MIN', 'GOOD'),
    UserSession('11/17/2020', '20 MIN', 'OK'),
    UserSession('11/18/2020', '25 MIN', 'BAD'),
    UserSession('11/19/2020', '30 MIN', 'GOOD'),
    UserSession('11/20/2020', '35 MIN', 'BAD'),
    UserSession('11/11/2020', '20 MIN', 'GOOD'),
    UserSession('11/12/2020', '25 MIN', 'OK'),
    UserSession('11/13/2020', '30 MIN', 'BAD'),
    UserSession('11/14/2020', '35 MIN', 'BAD'),
    UserSession('11/15/2020', '40 MIN', 'OK'),
    UserSession('11/16/2020', '45 MIN', 'BAD'),
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
          getTableData(19.0, 'Date', Colors.black),
          getTableData(19.0, 'Duration', Colors.black),
          getTableData(19.0, 'Focus', Colors.black),
        ]));
        columnTitles = true;
      }
      rows.add(TableRow(children: [
        getTableData(17.0, rowData.date, Colors.black),
        getTableData(17.0, rowData.duration, Colors.black),
        getTableData(17.0, rowData.focus, getFocusColor(rowData.focus)),
      ]));
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
