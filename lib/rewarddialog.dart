import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardDialog extends StatelessWidget {

  String title, description, collection, questArray, field, questName;

  RewardDialog({
    @required this.title,
    @required this.description,
    @required this.collection,
    @required this.questArray,
    @required this.field,
    @required this.questName,
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
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                String gameName = prefs.getString("game");
                                var list = List<String>();
                                list.add(document["name"]);
                                Firestore.instance.collection("quests").document(questName).updateData({questArray: FieldValue.arrayUnion(list)}); //.where("game", isEqualTo: gameName).where("name", isEqualTo: questName).snapshots();
                                Navigator.of(context).pop();
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