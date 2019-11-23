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
      // home: MyHomePage(title: 'Blätterberg Automation'),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.GetRoutes,
    );
  }
}

class RouteGenerator{
  static Route<dynamic> GetRoutes(RouteSettings settings){
    switch(settings.name){
      case '/settings': return MaterialPageRoute(builder: (_)=>SettingsScreen());
      default: return MaterialPageRoute(builder: (_)=>MyHomePage());
    }


  }
}

