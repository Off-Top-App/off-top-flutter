import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:developer' as deve;

class Meter extends StatefulWidget {
  Meter({Key key}) : super(key: key);

  // State<StatefulWidget> createState() => MeterState();
  MeterState createState() => MeterState();
}

class MeterState extends State<Meter> {
  // double meterScore;
  // Color meterColor;

  @override
  initState() {
    // this.meterScore = 75.0;

    // meterScore = 75.0;

    //bad behavior
    // this.meterScore = 74; //4
    // this.meterScore = 71; //1
    // this.meterScore = 70; //0
    //suddenly it's working fine- try resizing and restarting the emulator if encountering this issue
    //may also be an issue of text size, font, padding etc.

    // this.meterColor = Colors.green;

    super.initState();
  }

  // double meterScore = 75;
  // Color meterColor = Colors.green;
  // bool isOnTop;
  //HERE

  // void updateScore(bool isOnTopic) {
  //   this.setState(() {
  //     meterScore = meterScore + 5;
  //   });
  //   print("Score Updated:");
  //   print("--------" + meterScore.toString() + "--------");

  //   // print("--------------------UPDATING--------------------------");
  //   // setState(() {
  //   //   // this.meterScore = isOnTopic ? this.meterScore + 5 : this.meterScore - 5;
  //   //   if (isOnTopic) {
  //   //     // setState(() {
  //   //     this.meterScore = this.meterScore + 5;
  //   //     // });
  //   //   } else {
  //   //     this.meterScore = this.meterScore - 5;
  //   //   }
  //   //   print("--------------------" +
  //   //       this.meterScore.toString() +
  //   //       "-----------------------");
  //   //   //then update index value/redraw meter? shouldn't setState((){value = newValue}) tell the widgett to update??
  //   //   // this._drawMeter(this.meterColor, this.meterScore);
  //   // });
  // }

//-------

  // void updateMeterColor() {
  //   setState(() {
  //     meterColor = Colors.green;
  //   });
  // }
  // void updateScore(bool isOnTopic) {
  //   this.setState(() {
  //     meterScore = meterScore + 5;
  //   });
  //   print("Score Updated:");
  //   print("--------" + meterScore.toString() + "--------");
  // }
  double meterScore = 75;
  Color meterColor = Colors.green;
  void updateMeterColor() {
    setState(() {
      meterColor = Colors.green;
    });
  }

  void updateScore(bool isOnTopic) {
    this.setState(() {
      this.meterScore = this.meterScore + 5;
    });
    print("Score Updated:");
    print("--------" + meterScore.toString() + "--------");
  }

  @override
  Widget build(BuildContext context) {
    print('+++++++We\'re re-building! meterScore value: ' +
        meterScore.toString() +
        '+++++++');
    // deve.log('We\'re re-building! meterScore value: ' + meterScore.toString());
    // double meterScore = 75;
    // Color meterColor = Colors.green;

    // void updateScore(bool isOnTopic) {
    //   setState(() {
    //     meterScore = meterScore + 5;
    //   });
    //   print("Score Updated:");
    //   print("--------" + meterScore.toString() + "--------");
    // }

    // void updateMeterColor() {
    //   setState(() {
    //     meterColor = Colors.green;
    //   });
    // }

    // double score = this.meterScore;
    // deve.debugger();

    return new Center(
        child: FlutterGauge(
            circleColor: meterColor,
            secondsMarker: SecondsMarker.none,
            hand: Hand.short,
            number: Number.none,
            width: 200,
            index: meterScore, //score, //this.meterScore,
            fontFamily: "Iran",
            counterStyle: TextStyle(color: Colors.black, fontSize: 35),
            counterAlign: CounterAlign.center,
            isDecimal: false));
    // return Center(child: this.meter);
  }

  // FlutterGauge _drawMeter(Color color, double score) {
  //   return FlutterGauge(
  //       circleColor: color,
  //       secondsMarker: SecondsMarker.none,
  //       hand: Hand.short,
  //       number: Number.none,
  //       width: 200,
  //       index: score,
  //       fontFamily: "Iran",
  //       counterStyle: TextStyle(color: Colors.black, fontSize: 35),
  //       counterAlign: CounterAlign.center,
  //       isDecimal: false);
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
