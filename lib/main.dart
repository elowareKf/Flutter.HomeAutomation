import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_app/screens/MainScreen.dart';
import 'package:home_automation_app/screens/SettingsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.getRoutes,
    );
  }
}

class RouteGenerator{
  static Route<dynamic> getRoutes(RouteSettings settings){
    switch(settings.name){
      case '/settings': return MaterialPageRoute(builder: (_)=>SettingsScreen(ios: settings.arguments,));
      default: return MaterialPageRoute(builder: (_)=>MyHomePage());
    }
  }
}

