import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/userReportTable.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: UserReportTable(),
    );
  }
}
