import 'package:vibration/vibration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // we need this for the vibrations
import 'dart:io'; // we need this for the sleep method


class CustomVibration {

  PatternVibrate() {
    HapticFeedback.mediumImpact();
    sleep(
      const Duration(milliseconds: 400),
    );
    print('Read Low Focus Score');
  }
}
