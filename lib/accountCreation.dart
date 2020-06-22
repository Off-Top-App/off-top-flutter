import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:off_top_mobile/lib/login.dart'; // will edit to sign-up page

import 'package:http/http.dart' as http;
import 'package:off_top_mobile/login.dart';

int repoNumber;

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Sign-Up Page')),
            body: Center(child: TransferData())));
  }
}

class TransferData extends StatefulWidget {
  @override
  TransferDataWidget createState() => TransferDataWidget();
}

class TransferDataWidget extends State {
// Getting value from TextField widget.
  //final idController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cityController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final professionalController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  bool visible = false;
  Future makePostRequest() async {
    setState(() {
      visible = true;
    });
    debugPrint('In postrequest');

    // Getting value from Controller
    //String Id = idController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String city = cityController.text;
    String age = ageController.text;
    String gender = genderController.text;
    String professional = professionalController.text;
    String username = usernameController.text;
    String email = emailController.text;

    // API
    String address = 'http://localhost:9000/setUser';
    Map<String, String> headers = {'Content-type': 'application/json'};
    var data = {
      "id": 1,
      "age": age,
      "city": city,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "professional": professional,
      "email": email,
      "username": username,
      "password": "HoldTheDoor",
      "createdAt": "04/17/2011",
      "deletedAt": "05/19/2019",
    };

    // Make respone
    //final http.Response response = await http.get(Uri.encodeFull(url),
    var call = await http.post(address,
        headers: headers, body: json.encode(data)); // webcall

    var message = jsonDecode(call.body); // API response
    int check = call.statusCode;
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
          title: new Text("Welcome"),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
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
        body: SingleChildScrollView(
            child: Center(
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Fill All Information in Form',
                  style: TextStyle(fontSize: 22))),
          Container(
              // will delete, this is for testing
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Enter Email'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: firstNameController,
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Enter First Name Here'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: lastNameController,
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Enter Last Name Here'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: ageController,
                autocorrect: true,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Enter Age'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: cityController,
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Enter City Here'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: genderController,
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Enter Gender'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: professionalController,
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Enter professional'),
              )),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: usernameController,
                autocorrect: true,
                keyboardType: TextInputType.text,
                //textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'Create a username'),
              )),
          RaisedButton(
            onPressed: makePostRequest,
            color: Colors.pink,
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text('Click Here To Submit Data To Server'),
          ),
          Visibility(
              visible: visible,
              child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator())),
        ],
      ),
    )));
  }
}
