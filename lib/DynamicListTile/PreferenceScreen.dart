import 'package:flutter/material.dart';
import 'package:off_top_mobile/DynamicListTile/ListTileBuilder.dart';
import 'package:off_top_mobile/models/ColorModel.dart';
import 'package:off_top_mobile/models/ListTileModel.dart';
import 'package:off_top_mobile/DynamicListTile/ListTileFields.dart';
import 'package:off_top_mobile/themes/ColorFields.dart';
import 'package:off_top_mobile/models/UserSettings.dart';
import 'package:off_top_mobile/userSettingsHTTP.dart';

class PreferenceScreen extends StatefulWidget {
  UserSettings userSettings;
  HttpSettings ob;
  String email;


  PreferenceScreen(this.userSettings);

  @override
  State<StatefulWidget> createState() {
    print('color from passed user Settings: '+ userSettings.appColor);
    print(userSettings.userEmail);
    ob = HttpSettings(email);
    //print(ob.email);
    return _PreferenceScreenState(userSettings);
  }
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  UserSettings objectFromUser;
  _PreferenceScreenState(this.objectFromUser);

  @override
  void initState() {
    super.initState();
    //print('passed email' + objectFromUser.email);
  }

  @override
  Widget build(BuildContext context) {
    final List<ListTileModel> listTileFields = ListTileFields(objectFromUser).fields;

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

    _noColorListTileBuilder(listTileFields, columnContent);//when color is not set
    _hasColorListTileBuilder(listTileFields, columnContent);//when color is set

    return columnContent;
  }

  void _noColorListTileBuilder(
      ListTileModel fields, List<Widget> columnContent) {
    if (fields.iconColor.isEmpty) {
      for (final String content in fields.dataList) {
        columnContent.add(
          ListTileBuilder(
            userSettings: objectFromUser,
            text: content,
            icon: fields.icon,
            color: Theme.of(context).secondaryHeaderColor,
            isColor: false,
            typeOfData: fields.dataName,

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
            color: listModelFields.iconColor[i],//builds the color here
            isColor: true,
            index: i,
            typeOfData: listModelFields.dataName,
          ),
        );
      }
    }
  }
  void _buildUserListTile(UserSettings userSettings){


  }





}

//Color[i].toString() == widget.userSettings.appColor.toUpperCase() ?
//            Icons.check:listModelFields.icon
