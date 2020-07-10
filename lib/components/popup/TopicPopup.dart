import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:off_top_mobile/components/recordingSession/recorder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTopicDialog extends StatefulWidget {
  const MyTopicDialog({Key key, this.onTopicChanged}) : super(key: key);

  final ValueChanged<String> onTopicChanged;
  
  @override
  _MyTopicDialogState createState() => _MyTopicDialogState();
}

class _MyTopicDialogState extends State<MyTopicDialog> {
  final String title = 'Select A Topic', buttonText = 'Select';
  final List<String> tileTitles = <String>[
    'Computer Science',
    'Sports',
    'Food'
  ];
  List<bool> listCheck = <bool>[];

  @override
  void initState() {
    super.initState();
    initLengthOfTiles();
  }

  @override
  void dispose(){
    initLengthOfTiles();
    super.dispose();
  }

  void initLengthOfTiles(){
    if(mounted){
      setState(
        () {
          for (int i = 0; i < tileTitles.length; i++) {
            listCheck.add(false);
          }
        },
      );
    }
  }

  static Future<bool> setSessionPreferences(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('session', value);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: const EdgeInsets.only(top: Consts.avatarRadius),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
              const SizedBox(height: 3.0),
              Container(
                  height: 150,
                  width: 300,
                  child: ListView.builder(
                      itemCount: tileTitles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                            activeColor: Theme.of(context).primaryColor,
                            title: Text(
                              tileTitles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            value: listCheck[index],
                            onChanged: (bool value) {
                              widget.onTopicChanged(tileTitles[index]);
                              setState(() {
                                timeDilation = value ? 1.0 : 0.5;
                                _uncheck(listCheck, index);
                                listCheck[index] = !listCheck[index];
                              });
                            });
                      })),
              const SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setSessionPreferences('In Session');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _uncheck(List<bool> listCheck, int index) {
  for (int i = 0; i < listCheck.length; i++) {
    if (listCheck[index] != listCheck[i]) {
      listCheck[i] = false;
    }
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
