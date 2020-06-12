import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/ColorModel.dart';
import 'package:off_top_mobile/themes/ColorFields.dart';
import 'package:off_top_mobile/themes/themeProvider.dart';
import 'package:provider/provider.dart';

class ListTileBuilder extends StatefulWidget {
  const ListTileBuilder({
    @required this.text,
    @required this.icon,
    @required this.color,
    @required this.isColor,
    this.index,
  });

  final String text;
  final IconData icon;
  final Color color;
  final bool isColor;
  final int index;

  @override
  _ListTileBuilderState createState() => _ListTileBuilderState();
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  ThemeProvider themeChange;
  final List<ColorModel> color = ColorFields().fields;

  @override
  Widget build(BuildContext context) {
    themeChange = Provider.of<ThemeProvider>(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListTile(
        title: Text(
          widget.text,
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          widget.icon,
          color: widget.color,
        ),
        onTap: () {
          colorSetter();
          setState(
            () {
              GlobalKey();
            },
          );
        },
      ),
    );
  }

  void colorSetter() {
    if (widget.isColor) {
      themeChange.primaryColor = color[widget.index].color[0];
      themeChange.secondaryColor = color[widget.index].color[1];
      themeChange.accentColor = color[widget.index].color[2];
      themeChange.backgroundColor = color[widget.index].color[3];
    }
  }
}
