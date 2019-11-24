import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_app/models/Io.dart';
import 'package:home_automation_app/service/HomeServer.dart';

class SettingsScreen extends StatelessWidget {
  final List<Io> ios;

  SettingsScreen({@required this.ios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
        actions: <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: ios.map((io) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: '${io.id}', border: OutlineInputBorder(borderSide: BorderSide())),
                controller: TextEditingController(text: io.name),
                onSubmitted: (value) {
                  io.name = value;
                  HomeServer().updateDescription(io.id, value);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
