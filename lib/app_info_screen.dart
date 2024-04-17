// app_info_screen.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        title: Text('App Info'),
      ),
      body: Center(
        child: Text(
          'Information about the app goes here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
