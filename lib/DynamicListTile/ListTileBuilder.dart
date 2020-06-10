import 'package:flutter/material.dart';
import 'package:off_top_mobile/themes/themeProvider.dart';
import 'package:provider/provider.dart';

class ListTileBuilder extends StatefulWidget {
  const ListTileBuilder(
      {@required this.text, @required this.icon, @required this.color});

  final String text;
  final IconData icon;
  final Color color;

  @override
  _ListTileBuilderState createState() => _ListTileBuilderState();
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeChange = Provider.of<ThemeProvider>(context);
    return ListTile(
      title: Text(
        widget.text,
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
      leading: Icon(
        widget.icon,
        color: widget.color,
      ),
      onTap: () {
        themeChange.theme = widget.text;
        setState(
          () {
            GlobalKey();
          },
        );
      },
    );
  }
}
