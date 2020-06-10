import 'package:flutter/material.dart';
import 'package:off_top_mobile/DynamicListTile/ListTileBuilder.dart';
import 'package:off_top_mobile/models/ListTileModel.dart';
import 'package:off_top_mobile/DynamicListTile/ListTileFields.dart';

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
    final List<ListTileModel> fields = ListTileFields().fields;
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

  List<Widget> _buildExpandableContent(ListTileModel fields) {
    final List<Widget> columnContent = <Widget>[];

    noColorListTileBuilder(fields, columnContent);
    hasColorListTileBuilder(fields, columnContent);

    return columnContent;
  }

  void noColorListTileBuilder(
      ListTileModel fields, List<Widget> columnContent) {
    if (fields.iconColor.isEmpty) {
      for (final String content in fields.dataList) {
        columnContent.add(
          ListTileBuilder(
            text: content,
            icon: fields.icon,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        );
      }
    }
  }

  void hasColorListTileBuilder(
      ListTileModel fields, List<Widget> columnContent) {
    if (fields.iconColor.isNotEmpty) {
      for (int i = 0; i < fields.iconColor.length; i++) {
        final String content = fields.dataList[i];
        final Color color = fields.iconColor[i];
        columnContent.add(
          ListTileBuilder(
            text: content,
            icon: fields.icon,
            color: color,
          ),
        );
      }
    }
  }
}
