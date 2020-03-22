import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'rewarddialog.dart';

class QuestDetailPage extends StatelessWidget {

  DocumentSnapshot quest;

  QuestDetailPage({Key key, @required this.quest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text(quest['title']),
      ),
      body: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            child: FlareActor(
              'assets/${quest['icon']}.flr',
              alignment: Alignment.center,
              // fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Text(
              quest['title'],
              style: TextStyle(fontSize: 35)),
          ),
          Center(
            child: Text(quest['description'],
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
          ),
          Center(
            child: Text(
              "${quest['experience']} XP",
              style: TextStyle(fontSize: 30, color: Colors.lightBlue),
            )
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Belohnungen:",
              style: TextStyle(fontSize: 25)),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: quest['realRewards'].length,
            itemBuilder: (context, index) {
              return
                StreamBuilder(
                  stream: Firestore.instance.collection('realrewards').where("name", isEqualTo: quest['realRewards'][index]).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasError)
                      return new Text("Error: ${snapshot.error}");
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text("Loading...");
                      default:
                        return new Text(snapshot.data.documents[0]['description']);

                    }
                  }
                );
            }
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: quest['digitalItems'].length,
            itemBuilder: (context, index) {
              return
                StreamBuilder(
                  stream: Firestore.instance.collection('digitalitems').where("name", isEqualTo: quest['digitalItems'][index]).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasError)
                      return new Text("Error: ${snapshot.error}");
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text("Loading...");
                      default:
                        return new Text(snapshot.data.documents[0]['icon']);
                    }
                  }
                );
            }
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: "Reale Belohnung hinzufügen",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => RewardDialog(
                  title: "Belohnungen",
                  description: "Suche eine Belohnung aus",
                  collection: "realrewards",
                  field: "description",
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: "Digitale Belohnung hinzufügen",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => RewardDialog(
                  title: "Belohnungen",
                  description: "Suche eine Belohnung aus",
                  collection: "digitalitems",
                  field: "icon",
                ),
              );
            },
          ),
        ],
      ), 
    );
  }
}