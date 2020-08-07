import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/accountCreation/UserInputContainer.dart';
import 'package:off_top_mobile/models/User.dart';
import 'package:off_top_mobile/components/popup/accountConfirmationPopup.dart';
import 'package:http/http.dart' as http;
import 'package:off_top_mobile/services/userService.dart';

class SignUp extends StatefulWidget {
  const SignUp({@required this.email});
  final String email;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserService userService;
  UserInput input;
  final String deletedAt = null;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool visible = false;

  @override
  void initState() {
    super.initState();
    input = UserInput(context);
    userService = UserService();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void createAccount() {
    setState(() {
      visible = true;
    });
    final DateTime now = DateTime.now();
    final String createdAt = now.toString();
    final User userObject = userService.setUserData(
      ageController.text,
      cityController.text,
      createdAt,
      null,
      widget.email,
      firstNameController.text,
      genderController.text,
      lastNameController.text,
      professionController.text,
      usernameController.text
    );
    userService.insertNewUser(userObject);
    showDialogPopup(context);
  }

  void saveAndSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    createAccount();
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
                input.textForm('Enter your First Name', 'First name required',
                    firstNameController, false, false),
                input.textForm('Enter your Last Name', 'Last name required',
                    lastNameController, false, false),
                input.textForm('Enter your Age', 'Age required', ageController,
                    true, false),
                input.textForm('Enter your City', 'City name required',
                    cityController, false, false),
                input.textForm('Enter your Gender', 'Gender required',
                    genderController, false, false),
                input.textForm('Enter your Profession', 'Profession required',
                    professionController, false, false),
                input.textForm('Enter your Username', 'Username required',
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
