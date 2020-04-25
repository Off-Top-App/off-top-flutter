import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/recordingSession/meter.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/components/recordingSession/recorder.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';

import 'components/NavBarClass.dart';

class RecordingPage extends StatelessWidget {
  int yes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
            width: this.yes * 10.0,
            child: FittedBox(
                child: FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.white,
            ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        appBar: offTopTitle,
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset('assets/placeholderWave.gif'),
            ),
            Container(
              margin: EdgeInsets.only(top: 45, bottom: 45),
              height: MediaQuery.of(context).size.height / 4,
              child: Meter(),
            ),
            Recorder()
          ],
        ),
        bottomNavigationBar: AppBarBuilder());
  }
}
