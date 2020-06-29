import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/User.dart';
import 'package:off_top_mobile/components/popup/accountConfirmationPopup.dart';

import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({@required this.email});
  final String email;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final String password = 'HoldTheDoor';
  final String deletedAt = null;
  String firstName;
  String lastName;
  String city;
  String email;
  String gender;
  String professional;
  String username;
  String age;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController professionalController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool visible = false;
  Future<void> createAccount() async {
    setState(() {
      visible = true;
    });
    debugPrint('Inserting new user: {}');
    firstName = firstNameController.text;
    lastName = lastNameController.text;
    city = cityController.text;
    age = ageController.text;
    gender = genderController.text;
    professional = professionalController.text;
    username = usernameController.text;
    email = widget.email;
    final DateTime now = DateTime.now();
    final String createdAt =
        '${now.month.toString()}/${now.day.toString()}/${now.year.toString()}';

    // API
    const String address = 'http://localhost:9000/setUser';
    final Map<String, String> headers = <String, String>{
      'Content-type': 'application/json'
    };

    final dynamic userObject = User(age, city, createdAt, deletedAt, email,
        firstName, gender, lastName, password, professional, username);

    final http.Response call = await http.post(address,
        headers: headers, body: json.encode(userObject.toJson()));

    final int check = call.statusCode;
    if (check == 200) {
      debugPrint('call accepted');
    } else {
      debugPrint(check.toString());
      throw Exception('Response failed to load');
    }

    showDialogPopup(context);
  }

  String check(String value, String hintText) {
    if (value.isEmpty) {
      return hintText;
    }
    return null;
  }

  Container textForm(String hintText, String requiredText,
      TextEditingController userValue, bool keyBoardtype, bool finalField) {
    return Container(
        width: 280.0,
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: userValue,
          autocorrect: true,
          keyboardType:
              keyBoardtype == false ? TextInputType.text : TextInputType.number,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(hintText: hintText),
          validator: (String value) {
            return check(value, hintText);
          },
          onFieldSubmitted: finalField == false
              ? (_) => FocusScope.of(context).nextFocus()
              : (_) => saveAndSubmit(),
        ));
  }

  Future<void> saveAndSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    await createAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign-Up Page')),
        body: SingleChildScrollView(
            child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Create OFF-TOP Account',
                        style: TextStyle(fontSize: 22))),
                Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Welcome: ' + widget.email,
                      style: const TextStyle(fontSize: 15.0)),
                ),
                textForm('Enter your First Name', 'First name required',
                    firstNameController, false, false),
                textForm('Enter your Last Name', 'Last name required',
                    lastNameController, false, false),
                textForm('Enter your Age', 'Age required', ageController, true,
                    false),
                textForm('Enter your City', 'City name required',
                    cityController, false, false),
                textForm('Enter your Gender', 'Gender required',
                    genderController, false, false),
                textForm('Enter your Profession', 'Profession required',
                    professionalController, false, false),
                textForm('Enter your Username', 'Username required',
                    usernameController, false, true),
                RaisedButton(
                  onPressed: saveAndSubmit,
                  color: Colors.purple,
                  textColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: const Text('Create Account'),
                ),
                Visibility(
                    visible: visible,
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: const CircularProgressIndicator())),
              ],
            ),
          ),
        )));
  }
}
