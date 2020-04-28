import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gauge/flutter_gauge.dart';

class Meter extends StatefulWidget {
  const Meter({Key key}) : super(key: key);

  @override
  MeterState createState() => MeterState();
}

class MeterState extends State<Meter> {
  @override
  void initState() {
    super.initState();
  }

  double meterScore = 75;
  Color meterColor = Colors.green;

  void updateMeterColor() {
    setState(() {
      meterColor = Colors.green;
    });
  }

  void updateScore(bool isOnTopic) {
    //for the purposes of testing we won't use isOnTopic (its a hardcoded true anyway)
    meterScore += 15;

    //moved the setStatback into the parent (RecordingPage)
    // setState(() {
    //   meterScore += 15;
    // });
    print('Score Updated:');
    print('--------' + meterScore.toString() + '--------');
  }

  @override
  Widget build(BuildContext context) {
    print('+++++++We\'re building! Using meterScore value: ' +
        meterScore.toString() +
        '+++++++');

    //Replacing my FlutterGauge and return with the line below as a way to isolate the FlutterGauge widget as the problem
    // return Center(child: Text(meterScore.toString()));

    FlutterGauge meter = new FlutterGauge(
        circleColor: meterColor,
        secondsMarker: SecondsMarker.none,
        hand: Hand.short,
        number: Number.none,
        width: 200,
        index: meterScore,
        fontFamily: 'Iran',
        counterStyle: TextStyle(color: Colors.black, fontSize: 35),
        counterAlign: CounterAlign.center,
        isDecimal: false);
    print('------------Accessing meter.index: ' +
        meter.index.toString() +
        '----------------');
    return meter;
  }

  @override
  void dispose() {
    print('---------We are disposing (as intended)------------');
    super.dispose();
  }
}
