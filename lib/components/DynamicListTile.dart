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
        itemBuilder: (context, i) {
          return new ExpansionTile(
            title: new Text(fields[i].title, style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(fields[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Fields fields) {
    List<Widget> columnContent = [];

    for (String content in fields.dataList)
      columnContent.add(
        new ListTile(
          title: new Text(content, style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
          leading: new Icon(fields.icon),
        ),
      );

    return columnContent;
  }
}


class Fields {
  final String title;
  List<String> dataList = [];
  final IconData icon;

  Fields(this.title, this.dataList, this.icon);
}


List<Fields> fields = [
  new Fields(
    'DEFAULT CATEGORY',
    ['THERAPY', 'WORKOUT', 'STUDYING', 'FOOD','COMPUTER SCIENCE','SPORTS'],
    Icons.line_style,
  ),
  new Fields(
    'SELECT COLOR',
    ['BLUE', 'RED', 'YELLOW','GREEN',"PURPLE"],
    Icons.color_lens,
  ),
  new Fields(
    'ALERT TYPE',
    ['TEXT', 'RINGER', 'EMAIL','NOTIFICATION','EVERYTHING'],
    Icons.ring_volume,
  ),
  new Fields(
    'VIBRATION TYPES',
    ['SIREN', 'PULSE', 'TRIGGER','RAPID','HEARTBEAT'],
    Icons.vibration,
  ),
];
