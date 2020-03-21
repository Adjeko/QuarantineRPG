import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class QuestDetailPage extends StatelessWidget {

  String content;

  QuestDetailPage({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text(content),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(content),
      ),
    );
  }
}