import 'package:flutter/material.dart';
import 'package:off_top_mobile/themes/themeProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  bool expanded = false;
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
            key: GlobalKey(),
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
    final ThemeProvider themeChange = Provider.of<ThemeProvider>(context);

    for (final String content in fields.dataList) {
      Color labelColor;
      if (content == 'BLUE') {
        labelColor = const Color(0xFF0074B7);
      } else if (content == 'RED') {
        labelColor = const Color(0xFFef3340);
      } else if (content == 'YELLOW') {
        labelColor = const Color(0xFFffd600);
      } else if (content == 'GREEN') {
        labelColor = const Color(0xFF18A558);
      } else if (content == 'PURPLE') {
        labelColor = const Color(0xFF9505E3);
      }
      columnContent.add(
        ListTile(
          title: Text(
            content,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          leading: Icon(
            fields.icon,
            color: labelColor,
          ),
          onTap: () {
            print(content);
            themeChange.theme = content;
            setState(
              () {
                GlobalKey();
              },
            );
          },
        ),
      );
    }

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
  ),
  Fields(
    'SELECT COLOR',
    <String>[
      'BLUE',
      'RED',
      'YELLOW',
      'GREEN',
      'PURPLE',
    ],
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
