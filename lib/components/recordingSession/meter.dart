import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

    return Container(
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
          GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
          GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
          GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
        ], pointers: <GaugePointer>[
          NeedlePointer(value: 90)
        ], annotations: <GaugeAnnotation>[
          // GaugeAnnotation(
          //     widget: Container(
          //         child: Text('90.0',
          //             style: TextStyle(
          //                 fontSize: 25, fontWeight: FontWeight.bold))),
          //     angle: 90,
          //     positionFactor: 0.5)
        ])
      ]),
    );
    // FlutterGauge meter = new FlutterGauge(
    //     circleColor: meterColor,
    //     secondsMarker: SecondsMarker.none,
    //     hand: Hand.short,
    //     number: Number.none,
    //     width: 200,
    //     index: meterScore,
    //     fontFamily: 'Iran',
    //     counterStyle: TextStyle(color: Colors.black, fontSize: 35),
    //     counterAlign: CounterAlign.center,
    //     isDecimal: false);
    // print('------------Accessing meter.index: ' +
    //     meter.index.toString() +
    //     '----------------');
    // return meter;
  }

  @override
  void dispose() {
    print('---------We are disposing (as intended)------------');
    super.dispose();
  }
}
