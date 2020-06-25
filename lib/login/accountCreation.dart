import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/models/User.dart';

import 'package:http/http.dart' as http;
import 'package:off_top_mobile/login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({@required this.email});
  final String email;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool visible = false;
  Future<void> createAccount() async {
    setState(() {
      visible = true;
    });
    debugPrint('Inserting new user: {}');

    final String email = widget.email;
    final String password = 'HoldTheDoor';
    final String deletedAt = 'null';
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String city = cityController.text;
    final String age = ageController.text;
    final String gender = genderController.text;
    final String profession = professionController.text;
    final String username = usernameController.text;
    final DateTime now = DateTime.now();
    final String formatDate =
        '${now.month.toString()}/${now.day.toString()}/${now.year.toString()}';

    // API
    const String address = 'http://localhost:9000/setUser';
    final Map<String, String> headers = <String, String>{
      'Content-type': 'application/json'
    };

    final dynamic userObject = User(age, city, formatDate, deletedAt, email,
        firstName, gender, lastName, password, profession, username);

    //userObject.age = age;

    final http.Response call = await http.post(address,
        headers: headers, body: json.encode(userObject.toJson()));

    final int check = call.statusCode;
    if (check == 200) {
      debugPrint('call accepted');
    } else {
      debugPrint(check.toString());
      throw Exception('Response failed to load');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Welcome'),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => const LoginPage()),
                    (Route<void> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign-Up Page')),
        body: SingleChildScrollView(
            child: Center(
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
              Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: firstNameController,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                        hintText: 'Enter First Name Here'),
                  )),
              Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: lastNameController,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    decoration:
                        const InputDecoration(hintText: 'Enter Last Name Here'),
                  )),
              Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: ageController,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(hintText: 'Enter Age'),
                  )),
              Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: cityController,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    decoration:
                        const InputDecoration(hintText: 'Enter City Here'),
                  )),
              Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: genderController,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(hintText: 'Enter Gender'),
                  )),
              Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: professionController,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    decoration:
                        const InputDecoration(hintText: 'Enter Profession'),
                  )),
              Container(
                  width: 280.0,
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: usernameController,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(hintText: 'Create a username'),
                  )),
              RaisedButton(
                onPressed: createAccount,
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
        )));
  }
}
