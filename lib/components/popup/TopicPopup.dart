import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:off_top_mobile/components/recordingSession/recorder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTopicDialog extends StatefulWidget {
  final ValueChanged<String> onTopicChanged;

  MyTopicDialog({Key key, this.onTopicChanged}): super(key: key);

  @override
  _MyTopicDialogState createState() => _MyTopicDialogState();
}

class _MyTopicDialogState extends State<MyTopicDialog> {
  final String title = "Select A Topic", buttonText = "Select";
  final tileTitles = ['Computer Science', 'Sports', 'Food'];
  List<bool> listCheck = [];

  @override
  void initState() {
    setState(() {
      for (int i = 0; i < tileTitles.length; i++) {
        listCheck.add(false);
      }
    });
    super.initState();
  }

  void setSessionPreferences(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("session", value);
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
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
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
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                height: 150,
                width: 300,
                child: ListView.builder(
                  itemCount: tileTitles.length,
                  itemBuilder: (context, index) {
                    return new CheckboxListTile(
                      activeColor: Colors.deepPurpleAccent,
                      title: new Text(tileTitles[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)
                      ),
                      value: listCheck[index],
                      onChanged: (value) {
                        widget.onTopicChanged(tileTitles[index]);
                        setState(() {
                          timeDilation = value ? 1.0 : 0.5;
                          _uncheck(listCheck, index);
                          listCheck[index] = !listCheck[index];
                        });
                      }
                    );
                  }
                )
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    setSessionPreferences("In Session");
                    Navigator.of(context).pop();
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

_uncheck(List<bool> listCheck, int index) {
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
