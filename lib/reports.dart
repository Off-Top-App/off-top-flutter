import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:off_top_mobile/components/subnavbar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'components/reports/reportsGraph.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ReportsGraph(),
        ),
      ),
    );
  }
}
