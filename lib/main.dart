import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() {
  runApp(MaterialApp(
    title: 'Login Page',
    home: LoginPage(),
  ));
}

final offTopTitle = AppBar(
  title: Text(
    'OFF-TOP',
    style: TextStyle(
        color: Colors.black45, fontSize: 30, fontWeight: FontWeight.w600),
    textAlign: TextAlign.center,
  ),
  centerTitle: true,
  backgroundColor: Colors.white,
);

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: offTopTitle,
        body: Center(
            child: Container(
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                usernameField,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(height: 45.0),
                loginButton(context),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      forgotPassword(context),
                      createAccount(context),
                    ]),
              ]))),
        )));
  }

  final usernameField = TextField(
    obscureText: false,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final passwordField = TextField(
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

//temporarily goes to main page
  Widget forgotPassword(BuildContext context) {
    return FlatButton(
      child: Text('forgot password?'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      },
    );
  }

//temporarily goes to main page
  Widget createAccount(BuildContext context) {
    return FlatButton(
      child: Text('create account'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      },
    );
  }

  Widget loginButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      color: Colors.deepPurple,
      child: Text('SIGN IN'),
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          width: 100,
          height: 100,
          child: FittedBox(
              child: FloatingActionButton(
            onPressed: () {
              //
            },
            child: Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white70,
      appBar: offTopTitle,
      body: Column(
        children: <Widget>[
          Image.asset('assets/placeholderWave.gif'),
          Image.asset('assets/placeholderMeter.png'),
        ],
      ),
      bottomNavigationBar:
          new BottomNavigationBar(backgroundColor: Colors.deepPurple, items: [
        new BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Home'),
            backgroundColor: Colors.white),
        new BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Reports'),
            backgroundColor: Colors.white),
        new BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Settings'),
            backgroundColor: Colors.white),
      ]),
    );
  }
}
