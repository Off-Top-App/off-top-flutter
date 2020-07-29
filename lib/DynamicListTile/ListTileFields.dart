import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/ListTileModel.dart';
import 'package:off_top_mobile/models/UserSettings.dart';
import 'package:off_top_mobile/userSettingsHTTP.dart';

class ListTileFields {

  UserSettings settingsFromData;
  ListTileFields(this.settingsFromData);

  List<String> returnAppColor(){
    HttpSettings ob = HttpSettings(settingsFromData.userEmail);
    ob.getUserData(settingsFromData);
    settingsFromData.returnAppCollor();
  }
  List<ListTileModel> fields = <ListTileModel>[
    ListTileModel(
      'default_categories',
      'DEFAULT TOPIC',
      <String>[
        'THERAPY',
        'WORKOUT',
        'STUDYING',
        'FOOD',
        'COMPUTER SCIENCE',
        'SPORTS'
      ],
      Icons.line_style,
      <Color>[],
    ),
    ListTileModel(
      'app_color',
      'SELECT COLOR',
      <String>['BLUE', 'RED', 'YELLOW', 'GREEN', 'PURPLE', 'DARK'],
      Icons.color_lens,
      <Color>[
        const Color(0xFF0074B7),
        const Color(0xFFef3340),
        const Color(0xFFffd600),
        const Color(0xFF18A558),
        const Color(0xFF9505E3),
      ],

    ),
    ListTileModel(
      'alert_type',
      'ALERT TYPE',
      <String>['TEXT', 'RINGER', 'EMAIL', 'NOTIFICATION', 'EVERYTHING'],
      Icons.ring_volume,
      <Color>[],
    ),
    ListTileModel(
      'vibration_type',
      'VIBRATION TYPES',
      <String>['SIREN', 'PULSE', 'TRIGGER', 'RAPID', 'HEARTBEAT'],
      Icons.vibration,
      <Color>[],
    ),
  ];



}
