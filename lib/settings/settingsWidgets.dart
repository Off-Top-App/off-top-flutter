import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';

class SettingsWidgets {
  SettingsWidgets(this.context);
  BuildContext context;

  TextStyle textStyle() {
    return TextStyle(
        fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.w400);
  }

  Visibility createUnderlineBorder(bool visible) {
    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: const Divider(
        color: Colors.black,
        thickness: 1.0,
      ),
    );
  }

  Widget buildProfileForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildField('NAME'),
                  _buildField('LOCATION'),
                  _buildField('EMAIL'),
                  _buildField('PROFESSION'),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              _buildFormButton(context),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildField(String field) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: field,
      ),
    );
  }

  RaisedButton _buildFormButton(BuildContext context) {
    return RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).secondaryHeaderColor,
        splashColor: Theme.of(context).accentColor,
        child: const Text('SAVE'),
        onPressed: () => null);
  }

  Container buildTitle() {
    return Container(
      height: 90.0,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
        ),
        child: offTopSettingsTitle1(context),
      ),
    );
  }

  Container buildImage() {
    return Container(
      color: Colors.transparent,
      height: 100.0,
      width: 100.0,
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/Off-Top_Logo.jpg'),
      ),
    );
  }

  Visibility buildTabs(Widget child, bool visible) {
    return Visibility(
      child: Expanded(
        child: child,
      ),
      visible: visible,
    );
  }
}
