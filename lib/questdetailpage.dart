import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
            child: Text(quest['title']),
          ),
          Center(
            child: Text(quest['description']),
          ),
          Center(
            child: Text(
              "${quest['experience']} XP",
              style: TextStyle(fontSize: 30, color: Colors.lightBlue),
            )
          ),
          Center(
            child: Text("Reale Belohnungen"),
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
          Center(
            child: Text("Digitale Belohnungen"),
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

          // FutureBuilder(
          //   future: quest['reward'].get(),
          //   builder: (context, rewardsSnap) {
          //     if(rewardsSnap.connectionState == ConnectionState.done) {
          //       if(rewardsSnap.hasData){
          //         return ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: rewardsSnap.data['digitalItems'].length,
          //           itemBuilder: (context, index) {
          //             return FutureBuilder(
          //               future: rewardsSnap.data['digitalItems'][0].get(),
          //               builder: (context, digitalItemsSnap) {
          //                 if(digitalItemsSnap.connectionState == ConnectionState.done) {
          //                   if(digitalItemsSnap.hasData){
          //                     return Text(digitalItemsSnap.data['icon'].toString());
          //                   } else {
          //                     return Text("Item has no data");
          //                   }
          //                 } else {
          //                   return CircularProgressIndicator();
          //                 }
          //               }
          //             );
          //           },
          //         );
          //       } else {
          //         return Text("keine String");
          //       } 
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   }
          // ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: "Reale Belohnung hinzufügen",
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: "Digitale Belohnung hinzufügen",
            onTap: () {},
          ),
        ],
      ), 
    );
  }
}