import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:off_top_mobile/components/subnavbar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'components/reports/reportsGraph.dart';
import 'package:off_top_mobile/userReportTable.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<ReportsPage> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
                child: UserReportTable(),
            ),
        ],
      ),
    )));
  }
}

