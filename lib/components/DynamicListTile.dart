import 'package:flutter/material.dart';

class MyDynamicListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tileTitles = [ 'DEFAULT CATEGORY', 'SELECT COLOR', 'ALERT TYPE', 'VIBRATION TYPES' ];
    final iconsList = [ Icons.line_style, Icons.color_lens, Icons.ring_volume, Icons.vibration];

    
    final subTiles1 = [ 'FIELD', 'FIELD', 'FIELD', 'FIELD', 'FIELD' ];



    List<Widget> listTile = getListTileWidget(subTiles1);


    return ListView.builder(
        itemCount: tileTitles.length,
        itemBuilder: (context, index) {
          return new ExpansionTile(
            leading: Icon(iconsList[index]),
            title: new Text(tileTitles[index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            children: <Widget>[
              listTile[index],
              listTile[index],
              listTile[index],
              listTile[index],

              
              ],
          );
        });
  }


List<Widget> getListTileWidget(final subTiles) {
  List<Widget> list = new List<Widget>();
  for (var i = 0; i < subTiles.length; i++) {
    list.add(new ListTile(
        title: Text(subTiles[i],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
            )));
  }
  return list;
}





}
