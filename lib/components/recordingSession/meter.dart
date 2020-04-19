import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:auto_size_text/auto_size_text.dart';


class Meter extends StatefulWidget {
  Meter({Key key}) : super(key: key);

  _MeterState createState() => _MeterState();
}

class _MeterState extends State<Meter> {
  int meterScore;

  @override
  initState() {
    this.updateScore();
    super.initState();
  }

  double updateScore() {
    setState(() {
      this.meterScore = 37;
    });
  }

  Color updateMeterColor() {
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlutterGauge(
            circleColor: updateMeterColor(), //Colors.green,
            secondsMarker: SecondsMarker.none,
            hand: Hand.short,
            number: Number.none,
            width: 200,
            index: this.meterScore * 1.0,
            fontFamily: "Iran",
            counterStyle: TextStyle(color: Colors.black, fontSize: 35),
            counterAlign: CounterAlign.center,
            isDecimal: false));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
