import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:off_top_mobile/components/subnavbar.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class ReportsPage extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}


class _ReportsState extends State<ReportsPage> {
  List<charts.Series<Scores,int>> _seriesLineData;
      _generateData(){

        var linesscoresdata1 = [
          new Scores(0,45),
          new Scores(1,56),
          new Scores(2,55),
          new Scores(3,60),
          new Scores(4,61),
          new Scores(5,70),
        ];

        var linesscoresdata2 = [
          new Scores(0,35),
          new Scores(1,46),
          new Scores(2,45),
          new Scores(3,50),
          new Scores(4,51),
          new Scores(5,60),
        ];

        _seriesLineData.add(
          charts.Series(
            colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
            id: 'Heart beat/Focus',
            data: linesscoresdata1,
            domainFn: (Scores scores,_)=>scores.scoreval,
            measureFn: (Scores scores,_)=>scores.beatsval,
          ),
        );

        _seriesLineData.add(
          charts.Series(
            colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
            id: 'Heart beat/Focus',
            data: linesscoresdata2,
            domainFn: (Scores scores,_)=>scores.scoreval,
            measureFn: (Scores scores,_)=>scores.beatsval,
          ),
        );
      }


  @override
  void initState() {
    super.initState();
    _seriesLineData = List<charts.Series<Scores, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body:
        SafeArea(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Heart beat/Focus',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                    Expanded(
                      child: charts.LineChart(
                        _seriesLineData,
                        defaultRenderer: new charts.LineRendererConfig(
                            includeArea: true, stacked: true),
                        animate: true,
                        animationDuration: Duration(seconds: 5),
                        behaviors: [
                          new charts.ChartTitle(
                            'Time(min)', 
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                          ),
                          new charts.ChartTitle(
                            'Score', 
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}

class Scores{
  int scoreval;
  int beatsval;

  Scores(this.scoreval, this.beatsval);
}