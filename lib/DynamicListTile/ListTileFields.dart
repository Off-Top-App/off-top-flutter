import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/ListTileModel.dart';

class ListTileFields {

  List<ListTileModel> fields = <ListTileModel>[
    ListTileModel(
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
      'SELECT COLOR',
      <String>[
        'BLUE',
        'RED',
        'YELLOW',
        'GREEN',
        'PURPLE',
      ],
      Icons.color_lens,
      <Color>[
        const Color(0xFF0074B7),
        const Color(0xFFef3340),
        const Color(0xFFffd600),
        const Color(0xFF18A558),
        const Color(0xFF9505E3)
      ],
    ),
    ListTileModel(
      'ALERT TYPE',
      <String>['TEXT', 'RINGER', 'EMAIL', 'NOTIFICATION', 'EVERYTHING'],
      Icons.ring_volume,
      <Color>[],
    ),
    ListTileModel(
      'VIBRATION TYPES',
      <String>['SIREN', 'PULSE', 'TRIGGER', 'RAPID', 'HEARTBEAT'],
      Icons.vibration,
      <Color>[],
    ),
  ];

}
