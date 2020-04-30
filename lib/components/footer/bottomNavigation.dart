import 'package:flutter/material.dart';

final footer = new BottomNavigationBar(
  showSelectedLabels: true,
  backgroundColor: Colors.deepPurple,
  items: [
    new BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Colors.white,
        size: 30.0,
      ),
      title: Text('Home'),
      backgroundColor: Colors.white
    ),
    new BottomNavigationBarItem(
      icon: Icon(
        Icons.receipt,
        color: Colors.white,
        size: 30.0,
      ),
      title: Text('Reports'),
      backgroundColor: Colors.white
    ),
    new BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
        color: Colors.white,
        size: 30.0,
      ),
      title: Text('Settings'),
      backgroundColor: Colors.white
    ),
  ]
);
