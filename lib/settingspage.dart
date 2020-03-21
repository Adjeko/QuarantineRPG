import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SettingsPage extends StatelessWidget {

  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Hier kommt krasses Zeug"),
      ),
    );
  }
}