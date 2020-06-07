import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: fields.length,
        itemBuilder: (BuildContext context, int i) {
          return ExpansionTile(
            title: Text(
              fields[i].title,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Column(
                children: _buildExpandableContent(fields[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildExpandableContent(Fields fields) {
    final List<Widget> columnContent = <Widget>[];

    for (final String content in fields.dataList)
      columnContent.add(
        ListTile(
          title: Text(
            content,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          leading: Icon(fields.icon),
        ),
      );

    return columnContent;
  }
}

class Fields {
  Fields(this.title, this.dataList, this.icon);

  final String title;
  List<String> dataList = <String>[];
  final IconData icon;
}

List<Fields> fields = <Fields>[
  Fields(
    'DEFAULT CATEGORY',
    <String>[
      'THERAPY',
      'WORKOUT',
      'STUDYING',
      'FOOD',
      'COMPUTER SCIENCE',
      'SPORTS'
    ],
    Icons.line_style,
  ),
  Fields(
    'SELECT COLOR',
    <String>['BLUE', 'RED', 'YELLOW', 'GREEN', 'PURPLE'],
    Icons.color_lens,
  ),
  Fields(
    'ALERT TYPE',
    <String>['TEXT', 'RINGER', 'EMAIL', 'NOTIFICATION', 'EVERYTHING'],
    Icons.ring_volume,
  ),
  Fields(
    'VIBRATION TYPES',
    <String>['SIREN', 'PULSE', 'TRIGGER', 'RAPID', 'HEARTBEAT'],
    Icons.vibration,
  ),
];
