import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:off_top_mobile/models/ColorModel.dart';
import 'package:off_top_mobile/models/UserSettings.dart';
import 'package:off_top_mobile/themes/ColorFields.dart';
import 'package:off_top_mobile/themes/themeProvider.dart';
import 'package:provider/provider.dart';

class ListTileBuilder extends StatefulWidget {
   ListTileBuilder({
    @required this.text,
    @required this.icon,
    @required this.color,
    @required this.isColor,
    this.index,
    this.userSettings,
     this.typeOfData,
  });

  final String text;
  final IconData icon;
  final Color color;
  final bool isColor;
  final int index;
  UserSettings userSettings;
  String typeOfData;

  @override
  _ListTileBuilderState createState() => _ListTileBuilderState(userSettings);
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  UserSettings settingsFromUser;
  _ListTileBuilderState(this.settingsFromUser);
  ThemeProvider themeChange;
  final List<ColorModel> color = ColorFields().fields;


  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;
    themeChange = Provider.of<ThemeProvider>(context);


    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListTile(
        title: Text(
          widget.text,
          style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          widget.icon,
          color: widget.color,
        ),
        trailing: Checkbox(
            value: checkFromUser(settingsFromUser, widget.text, widget.typeOfData,),
            onChanged: (bool val) {
              setState(() {
                _isChecked = val;
              });
            }),
        ),
        /*
        onTap: (){
          colorSetter();

          setState(
            () {
              GlobalKey();
            },
          );
        },
      ),

         */
    );
  }
  bool checkFromUser(UserSettings user, String textLine, String dataType){
    //print(textLine.toLowerCase());
    //print(dataType);
    //print(user.defaultCategories);
    List<String> dataFromUser = <String>[];
    print(dataType);
    print(textLine);
    if(dataType == 'default_categories'){
      dataFromUser = user.returnDefaultCategories();

      print(dataFromUser.length);
      int l = dataFromUser.length;
      for(int i; i < l != null;i++){
        if(dataFromUser[i] == textLine.toLowerCase()){
          print(dataFromUser[i]);
          return true;
        }
      }
      return false;
    }
    if(dataType == 'app_color'){
      return true;
    }
    if(dataType == 'vibration_type'){
      String data = user.vibrationType;

      print('user vibration type' + data);
      if(data==textLine.toLowerCase()){
        print('TRUE');
        return true;
      }
      else{
        print('FALSE');
        return false;
      }
    }
    if(dataType == 'alert_type'){
      String data = user.alertType;

      print('alert type: ' + data);
      if(data==textLine.toLowerCase()){
        print('TRUE');
        return true;
      }
      else {
        print('FALSE');
        return false;
      }
    }
    return false;



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
