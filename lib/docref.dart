import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocRef extends StatelessWidget {

  Future future;
  DocumentReference quest;

  DocRef({Key key, @required this.quest, @required this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData){
              return Column(
                children: [
                  Text(snapshot.data['realItems'].toString()),
                ],
              );
            } else {
              return Text("no data");
            }
          } else {
            return CircularProgressIndicator();
          }
        }
      );
  }
}