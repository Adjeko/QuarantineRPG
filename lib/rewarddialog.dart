import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RewardDialog extends StatelessWidget {

  String title, description, collection, field;

  RewardDialog({
    @required this.title,
    @required this.description,
    @required this.collection,
    @required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
  return Card(
      child: Column(
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 35)),
        Text(description),
        StreamBuilder(
            stream: Firestore.instance.collection(collection).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasError)
                return new Text("Error: ${snapshot.error}");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text("Loading...");
                default:
                  return Expanded(
                    child: new ListView(
                      children: 
                        snapshot.data.documents.map((DocumentSnapshot document) {
                          return new Card(
                            child: ListTile(
                              onTap: () {

                              },
                              title: Container(
                                child: Text(document[field])),
                              ),
                          );
                        }).toList(),
                    ),
                  );
              }
            },
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Schließen"),
        ),
      ],
    ),
  );
}
}