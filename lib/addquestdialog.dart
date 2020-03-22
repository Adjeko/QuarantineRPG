import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddQuestDialog extends StatelessWidget {

  String title;
  String description;
  int experience;
  String game;
  String icon;
  String name;
  String reason;
  String room;

  // AddQuestDialog({
    
  // });

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
        Text("Aufgabe", style: TextStyle(fontSize: 35)),
        TextField(
          decoration: InputDecoration(
            hintText: "Bitte Name eingeben",
          ),
          onChanged: (text) {
            name = text;
          },
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Bitte Titel eingeben",
          ),
          onChanged: (text) {
            title = text;
          },
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Bitte Beschreibung eingeben",
          ),
          onChanged: (text) {
            description = text;
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Bitte Erfahrung eingeben",
          ),
          onChanged: (text) {
            experience = int.parse(text);
          },
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Bitte Begründung eingeben (optional)",
          ),
          onChanged: (text) {
            reason = text;
          },
        ),  
        TextField(
          decoration: InputDecoration(
            hintText: "Bitte Zimmer eingeben",
          ),
          onChanged: (text) {
            room = text;
          },
        ), 
        Align(
          alignment: Alignment.bottomCenter, 
          child:      
            RaisedButton(
              onPressed: () {
                if(reason == null)
                {
                  reason = "";
                }

                Firestore.instance.collection("quests").document(name).setData({
                  'title': title,
                  'description': description,
                  'experience': experience,
                  'reason': reason,
                  'game': "game1",
                  'icon': "IconDrops",
                  'room': room,
                  'name': name,
                  'digitalItems': new List<String>(),
                  'realRewards': new List<String>(),
                });
                Navigator.of(context).pop();
              },
              child: Text("Speichern"),
              color: Colors.lime,
            ),
        ),
      ],
    ),
  );
}
}