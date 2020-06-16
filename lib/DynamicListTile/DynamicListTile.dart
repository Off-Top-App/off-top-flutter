import 'package:flutter/material.dart';
import 'package:off_top_mobile/DynamicListTile/ListTileBuilder.dart';
import 'package:off_top_mobile/models/ColorModel.dart';
import 'package:off_top_mobile/models/ListTileModel.dart';
import 'package:off_top_mobile/DynamicListTile/ListTileFields.dart';
import 'package:off_top_mobile/themes/ColorFields.dart';

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
    final List<ListTileModel> listTileFields = ListTileFields().fields;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: listTileFields.length,
        itemBuilder: (BuildContext context, int i) {
          return ExpansionTile(
            key: GlobalKey(),
            title: Text(
              listTileFields[i].title,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Column(
                children: _buildExpandableContent(listTileFields[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildExpandableContent(ListTileModel listTileFields) {
    final List<Widget> columnContent = <Widget>[];

    _noColorListTileBuilder(listTileFields, columnContent);
    _hasColorListTileBuilder(listTileFields, columnContent);

    return columnContent;
  }

  void _noColorListTileBuilder(
      ListTileModel fields, List<Widget> columnContent) {
    if (fields.iconColor.isEmpty) {
      for (final String content in fields.dataList) {
        columnContent.add(
          ListTileBuilder(
            text: content,
            icon: fields.icon,
            color: Theme.of(context).secondaryHeaderColor,
            isColor: false,
          ),
        );
      }
    }
  }

  void _hasColorListTileBuilder(
      ListTileModel listModelFields, List<Widget> columnContent) {
    if (listModelFields.iconColor.isNotEmpty) {
      for (int i = 0; i < listModelFields.iconColor.length; i++) {
        columnContent.add(
          ListTileBuilder(
            text: listModelFields.dataList[i],
            icon: listModelFields.icon,
            color: listModelFields.iconColor[i],
            isColor: true,
            index: i,
          ),
        );
      }
    }
  }
}
