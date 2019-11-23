import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_app/screens/MainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(title: 'Blätterberg Automation'),
    );
  }
}

